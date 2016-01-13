require 'sinatra'
require 'pony'
require 'json'
require 'rack/throttle'

use Rack::Throttle::Interval, :min => 10.0
use Rack::Throttle::Hourly, :max => 20
use Rack::Throttle::Daily, :max => 50

set :port, 6789

post '/email-form' do 
  @payload = JSON.parse(request.body.read)
  Pony.mail(
    :to => @payload['email'],
    :from => @payload['sender'],
    :subject => @payload['subject'],
    :body => @payload['body'])
  "email sent to #{@payload['email']}"
end
