# docker build -t="scoutapp/docker-scout" .
FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y wget
RUN wget -q -O - https://archive.server.pingdom.com/scout-archive.key | apt-key add -
RUN echo 'deb http://archive.server.pingdom.com ubuntu main' | tee /etc/apt/sources.list.d/scout.list
RUN apt-get update

## RUBY
RUN apt-get install -y -q ruby

## Install scoutd
RUN apt-get install scoutd=0.5.33-1ubuntu1

RUN gem install docker-api
RUN gem install statsd-ruby

USER root
COPY docker_events.rb start.sh /
RUN chmod 777 /start.sh
RUN chmod 777 /docker_events.rb

CMD ["sh", "start.sh"]
