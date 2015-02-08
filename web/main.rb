 require 'sinatra'

$:.unshift File.dirname(__FILE__) + '/../library'
require 'warsow'

Warsow.connect '10.0.0.20', 44400, rcon: '1234' do |server| 
  puts server.change_map('wbomb6')
end

before do
    headers "Content-Type" => "application/json; charset=utf8"
end


 get '/hi' do
 	result = ''
	Warsow.connect '10.0.0.20', 44400, rcon: '1234' do |server| 
		result = server.get_players
	end
	return result
 end

