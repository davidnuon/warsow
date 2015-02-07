#!/usr/bin/env ruby
# encoding: utf-8

$:.unshift File.dirname(__FILE__) + '/../library'
require 'warsow'

Warsow.connect '10.0.0.20', 44400, rcon: '1234' do |server| 
  puts (server.get_players)
end
