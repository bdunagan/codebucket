# Require libraries.
require 'rubygems'
require 'active_support'
require 'oauth'
require 'garb'
require 'json'

# Setup OAuth. (See http://everburning.com/news/google-analytics-oauth-and-ruby-oh-my/.)
# Register a domain: https://www.google.com/accounts/ManageDomains.
oauth_consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => 'https://www.google.com', :request_token_path => '/accounts/OAuthGetRequestToken', :access_token_path => '/accounts/OAuthGetAccessToken', :authorize_path => '/accounts/OAuthAuthorizeToken'})
session = Garb::Session.new
session.access_token = OAuth::AccessToken.new(oauth_consumer, request_token, request_secret)
profile = nil
Garb::Management::Profile.all(session).each |current_profile|
  profile = current_profile if current_profile.title == site_name
end

# Visits/day over last week: bar chart
class RecentVisits
    extend Garb::Model
    metrics :visits
    dimensions :date
end

stop = Time.now
start = stop - 60*60*24*30
start_date = Time.utc(start.year, start.month, start.day - 1)
stop_date = Time.utc(stop.year, stop.month, stop.day - 1)
results = RecentVisits.results(profile, :start_date => start_date, :end_date => stop_date, :sort => :date)
visits = {}
results.each {|result| visits[result.date] = result.visits}
# Save to a file.
f = File.new("ga.txt","w")
f.write(visits.to_json)
f.close