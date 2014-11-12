# docker build -t="scoutapp/scoutd" .
FROM ubuntu:12.04

RUN apt-get update

## RUBY
RUN apt-get install -y -q ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 irb1.9.1 build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev
#RUN apt-get install -y -q python-software-properties
#RUN apt-add-repository ppa:brightbox/ruby-ng
#RUN apt-get update
#RUN apt-get install -y -q ruby2.1

## App repo isn't up yet - add from directory.
ADD scoutd_0.4.2-1.lucid.x86_64.deb scoutd_0.4.2-1.lucid.x86_64.deb
# placeholder key - will be updated when container started. using this so a config file is created.
RUN env SCOUT_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX dpkg -i scoutd_0.4.2-1.lucid.x86_64.deb

# script is used to run multiple commands (set key from env var, start scoutd)
ADD run-scoutd.sh /usr/local/bin/run-scoutd.sh
RUN chmod +x /usr/local/bin/run-scoutd.sh
CMD ["/usr/local/bin/run-scoutd.sh"]

