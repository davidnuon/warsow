# encoding: utf-8

require 'json'


module Warsow
  class Server
    attr_accessor :attributes, :rcon_password

    def self.attr name, value; define_method(name) { @attributes["#{value}"] } end

    attr :map,         :mapname
    attr :type,        :gametype
    attr :players,     :clients
    attr :hostname,    :sv_hostname
    attr :max_players, :sv_maxclients

    def initialize host, port = 44400, opts = {}
      @host, @port, @options = host, port, opts

      @connection = Connection.new host, port
    end

    def connect
      @connection.establish
      @attributes = retrieve_attributes
    end

    def rcon command
      @connection.transmit "rcon #{@options[:rcon]} #{command}"
      return @connection.read
    end

    def get_players
      status_out = (rcon 'status').split("\n")
      player_list = status_out.slice(5, status_out.length).map do |x|
        first_part = x[0..35].strip!.split(' ')
        second_part = x[35..x.length].strip!.split(' ')
         {
          :id => first_part[0],
          :score => first_part[1],
          :ping => first_part[2],
          :name => first_part[3],

          :lastmsg => second_part[0],
          :address => second_part[1],
          :port => second_part[2],
          :rate => second_part[3]
        }
      end

      return player_list.to_json
    end

  private

    def retrieve_attributes
      @connection.transmit "getinfo \x0A\x0D\x0F"
      @connection.read[18..-1].tap do |response|
        return Hash[*response.split('\\')]
      end
    end
  end
end
