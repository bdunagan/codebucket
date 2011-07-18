# Require libraries
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'time'
require 'json'

# Handy extension
class Object
  def valid?
    !self.nil? && self.length > 0
  end
end

# Simple object for Tracks
class Track
  attr_accessor :title
  attr_accessor :artist
  attr_accessor :album
  attr_accessor :play_count
  attr_accessor :length
  
  def valid?
    self.title.valid? && self.play_count.valid? && self.length.valid?
  end

  def to_s
    puts "[#{self.artist}] '#{self.title}' in '#{self.album}': #{self.play_count} (#{self.length.to_i / 1000})"
  end

  def total_seconds_played
    (self.play_count.to_i * self.length.to_i) / 1000
  end
end

# Handler for XML SAX callbacks
class TrackXMLHandler < Nokogiri::XML::SAX::Document
  attr_accessor :previous_item
  attr_accessor :track
  attr_accessor :tracks

  # Nokogiri delegate hook
  def characters(string)
    # Store previous valid Track.
    if self.previous_item == "Track ID"
      puts "#{self.track.to_s}" if self.track.valid?
      (self.tracks << self.track) if self.track.valid?
      self.track = Track.new
    end
    # Process Track attributes.
    self.track.title = string if self.previous_item == "Name"
    self.track.artist = string if self.previous_item == "Artist"
    self.track.album = string if self.previous_item == "Album"
    self.track.play_count = string if self.previous_item == "Play Count"
    self.track.length = string if self.previous_item == "Total Time"
    self.previous_item = string
  end
end

# Process iTunes library into Tracks.
trackHandler = TrackXMLHandler.new
trackHandler.tracks = []
parser = Nokogiri::XML::SAX::Parser.new(trackHandler)
# We only read the iTunes XML file, but still, run at your own risk. :)
parser.parse_file(File.expand_path("~/Music/iTunes/iTunes\ Music\ Library.xml"))

# Iterate over Tracks.
total_time = 0
total_plays = 0
hash = {}
artist_hash = {}
trackHandler.tracks.each do |track|
  # Convert Track objects into JSON for d3 treemap (artist => album => title => total length).
  hash[track.artist] = {} if !hash.keys.include?(track.artist)
  hash[track.artist][track.album] = {} if !hash[track.artist].keys.include?(track.album)
  hash[track.artist][track.album][track.title] = track.total_seconds_played
  # Aggregate artist play time.
  artist_hash[track.artist] = 0 if !artist_hash.keys.include?(track.artist)
  artist_hash[track.artist] += track.total_seconds_played
  # Aggregate total time and plays.
  total_time += track.total_seconds_played
  total_plays += track.play_count.to_i
end

# Display basic stats.
artist_hash.keys.sort_by{|key| artist_hash[key]}.each {|artist| puts "#{(artist_hash[artist] / 60).to_s.rjust(6)} minutes: #{artist}"}
puts "=> #{trackHandler.tracks.count} tracks"
puts "=> #{total_plays} plays"
puts "=> #{total_time / 60} minutes"

# Write out JSON file for d3 Javascript in HTML file to read.
f = File.new("itunes.json","w")
f.write(JSON.pretty_generate({"itunes"=>hash}))
f.close

# Write out the HTML to make it work.
html = <<EOF
<html>
	<!-- HTML copied from mbostock's http://bl.ocks.org/972398 -->
  <head>
    <script type="text/javascript" src="d3.js"></script>
    <script type="text/javascript" src="d3.layout.js"></script>
    <style type="text/css">
      rect {
        fill: none;
        stroke: #fff;
      }
      text {
        font: 10px sans-serif;
      }
    </style>
  </head>
  <body>
    <script type="text/javascript">

// Increase the size for large libraries (2k+)
var w = 520,
    h = 520,
    color = d3.scale.category20c();

var treemap = d3.layout.treemap()
    .size([w + 1, h + 1])
    .children(function(d) { return isNaN(d.value) ? d3.entries(d.value) : null; })
    .value(function(d) { return d.value; })
    .sticky(true);

var svg = d3.select("body").append("svg:svg")
    .style("width", w)
    .style("height", h)
  .append("svg:g")
    .attr("transform", "translate(-.5,-.5)");

d3.json("itunes.json", function(json) {
  var cell = svg.data(d3.entries(json)).selectAll("g")
      .data(treemap)
    .enter().append("svg:g")
      .attr("class", "cell")
      .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });

  cell.append("svg:rect")
      .attr("width", function(d) { return d.dx; })
      .attr("height", function(d) { return d.dy; })
      .style("fill", function(d) { return d.children ? color(d.data.key) : null; });
  
//   cell.append("svg:text")
//       .attr("x", function(d) { return d.dx / 2; })
//       .attr("y", function(d) { return d.dy / 2; })
//       .attr("dy", ".35em")
//       .attr("text-anchor", "middle")
//       .text(function(d) { return d.children ? null : d.data.key; });
});
    </script>
  </body>
</html>
EOF
f=File.new("itunes.html","w")
f.write(html)
f.close
