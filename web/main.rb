require 'sinatra'
require "json"

$:.unshift File.dirname(__FILE__) + '/../library'
require 'warsow'

get '/' do
    erb :index
end

post '/map' do
	headers "Content-Type" => "application/json; charset=utf8"
    {:message => "POST Map", 
     :r => request.body.map}.to_json
end

get '/map' do
    headers "Content-Type" => "application/json; charset=utf8"
    {:message => "GET Map"}.to_json
end

get '/status' do
    headers "Content-Type" => "application/json; charset=utf8"
    result = ''
    Warsow.connect '10.0.0.20', 44400, rcon: '1234' do |server| 
        result = server.get_players
    end
    return result
end

