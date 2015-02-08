 require 'sinatra'

$:.unshift File.dirname(__FILE__) + '/../library'
require 'warsow'

before do
    headers "Content-Type" => "application/json; charset=utf8"
end


 get '/status' do
 	result = ''
	Warsow.connect '10.0.0.20', 44400, rcon: '1234' do |server| 
		result = server.get_players
	end
	return result
 end

