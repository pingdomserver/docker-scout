#!/usr/bin/env ruby

require 'docker'
require 'statsd-ruby'

# Setup
Docker.url = "unix:///host/var/run/docker.sock"
statsd = Statsd.new('172.17.42.1', 8125)

begin 
  Docker::Event.stream do |event|
    statsd.increment("docker.#{event.status.gsub(/:.+/,"")}")
  end
rescue Docker::Error::TimeoutError
  retry
rescue Excon::Errors::SocketError
  retry
end