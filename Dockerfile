# docker build -t="scoutapp/scoutd" .
FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y wget
RUN wget -q -O - https://archive.scoutapp.com/scout-archive.key | apt-key add -
RUN echo 'deb http://archive.scoutapp.com ubuntu main' | tee /etc/apt/sources.list.d/scout.list
RUN apt-get update

## RUBY
RUN apt-get install -y -q ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 irb1.9.1 build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev

## Install scoutd
RUN apt-get install scoutd=0.4.15-1ubuntu1

RUN gem install excon # a dependency of the docker_monitor plugin

CMD ["/usr/bin/scoutd", "start"]
