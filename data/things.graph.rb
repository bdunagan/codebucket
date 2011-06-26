# Require libraries
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'time'

# Use Nokogiri and Xpath magic.
doc = Nokogiri::XML(open(File.expand_path("~/Library/Application Support/Cultured Code/Things/Database.xml")))
dates = doc.xpath("//object/attribute[@name='datecreated']").collect {|item| (Time.utc(2001,1,1) + item.content.to_f).strftime("%Y-%m-01") }
# Add up months and separate years (for gray/red bars).
counts_hash = {}
counts_months = []
counts_years = []
dates.each do |date|
  counts_hash[date] = 0 if !counts_hash.include?(date)
  counts_hash[date] += 1
end
counts_hash.keys.sort.each do |date_key|
  date = Time.parse(date_key)
  counts_months << ((date.month == 1) ? 0 : counts_hash[date_key])
  counts_years << ((date.month == 1) ? counts_hash[date_key] : 0)
end

# Write out the HTML and Javascript to make it work.
html = <<EOF
<html><head>
<script type='text/javascript' src='raphael-min.js'></script> 
<script type='text/javascript' src='g.raphael-min.js'></script> 
<script type='text/javascript' src='g.bar-min.js'></script> 
</head><body>
<script type="text/javascript">
window.onload = function () {
// Add hover functions.
var things_fin = function () { this.flag = things_r.g.popup(this.bar.x, this.bar.y, this.bar.value || "0").insertBefore(this); };
var things_fout = function () { this.flag.animate({opacity: 0}, 60, function () {this.remove();}); };
// Graph with gRaphael.
var things_r = Raphael("things_data");
var things_chart = things_r.g.barchart(10, 10, 450, 100, [#{counts_months}, #{counts_years}], {stacked: true});
things_chart.bars[0].attr({"fill": "#666"});
things_chart.bars[1].attr({"fill": "#CD0000"});
things_chart.hover(things_fin, things_fout);
}
</script>
<div id="things_data"></div>
</body></html>
EOF
f=File.new("things.html","w")
f.write(html)
f.close
