# Require libraries.
require 'rubygems'
require 'time'
require 'net/http'
require 'net/https'
require 'json'

class Time
  def to_short_date
    self.utc.strftime("%Y-%m-%d")
  end

  def to_js_date
    # Safari Javascript doesn't parse to_short_date format.
    self.utc.strftime("%Y/%m/%d")
  end
end

# Set up environment.
rml_key = 'app_id'
dc_key = 'app_id'
rml_data = {}
dc_data = {}
af_response = nil
day_length = 86400
stop = Time.now
start = stop - 60*60*24*30
start_date = Time.utc(start.year, start.month, start.day - 1)
stop_date = Time.utc(stop.year, stop.month, stop.day - 1)

# Prepopulate dates to ensure range. Appfigures's API is not great about including every day.
current_date = start_date
while current_date <= stop_date
  rml_data[current_date.to_js_date] = 0
  current_date += day_length
end
current_date = start_date
while current_date <= stop_date
  dc_data[current_date.to_js_date] = 0
  current_date += day_length
end

# Fetch data from Appfigures.
http=Net::HTTP.new('api.appfigures.com', 443)
http.use_ssl = true
http.start() {|http|
	req = Net::HTTP::Get.new("/v1/sales/apps+dates/#{start_date.to_short_date}/#{stop_date.to_short_date}/")
	req.basic_auth 'username', 'password'
	response = http.request(req)
	af_response = response.body
}
af_data = JSON.parse(af_response)

# Parse data.
af_data[dc_key].keys.sort.each { |date| dc_data[Time.parse(date).to_js_date] = af_data[dc_key][date]['app_downloads'] }
af_data[rml_key].keys.sort.each { |date| rml_data[Time.parse(date).to_js_date] = af_data[rml_key][date]['app_downloads'] }

# Write to files.
f = File.new('dc.txt','w')
f.write(dc_data.to_json)
f.close
f = File.new('rml.txt','w')
f.write(rml_data.to_json)
f.close
