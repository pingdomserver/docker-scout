![scout logo](https://dl.dropboxusercontent.com/u/468982/docker_registry/scout_logo.png)

Scout is server monitoring for the modern dev team: automatic monitoring of key metrics, 80+ plugins to monitor your apps, real-time (every second) streaming dashboards, and flexibile alerting.

[Learn more](https://scoutapp.com).

## Overview

This a Docker container that runs the [Scout](https://scoutapp.com) monitoring agent, monitoring the host. Full help documentation is available on our [help site](http://help.scoutapp.com/v1.2/docs/docker).

![docker screenshot](https://dl.dropboxusercontent.com/u/468982/plugin_urls/docker_screenshot.png)

## Quick Start


### 1. Create a configuration file

Create a file called `scoutd.yml` (or copy our [template](https://github.com/scoutapp/docker-scout/blob/master/scoutd.yml)).
__Your account_key is required__, all other values are optional.
For a list of options, see our [scoutd help page](http://help.scoutapp.com/v1.2/docs/scoutd-beta#configuration).

    account_key: YOUR_SCOUT_ACCOUNT_KEY

### 2. Run the docker image

Run the scout image, mounting the `scoutd.yml` file. Running the image will first download the image, if it is not already locally available.
Run the following command in the directory containing your `scoutd.yml` file: 

    docker run -d --name scout-agent \
		-v /proc:/host/proc:ro \
		-v /etc/mtab:/host/etc/mtab:ro \
		-v /var/run/docker.sock:/host/var/run/docker.sock:ro \
		-v `pwd`/scoutd.yml:/etc/scout/scoutd.yml \
		--restart=always \
		--net=host --privileged scoutapp/docker-scout

### Reading host metrics

We want to look at resources on this host, not this container.

The `server_metrics` Ruby gem used by the scout agent primarily looks at the `/proc` directory, but, if available, will instead read from `/host/proc`, which is expected to be shared from the host when running the container (see the above command sample).

The `server_metrics` gem will also default to reading from `/host/etc/mtab` (also mounted above), if it exists, to determine the drives mounted on the host. It will recognize theses hosts inside the container if they are mounted by UUID (`/dev/disk/by-uuid/XXXXX`).

The `--net=host` flag will allow gathering network metrics from the host.

The `--privileged` flag will allow gathering the disk capacity metrics from the host.

### scoutd config options

Any option may be set in the provided scoutd.yml file. This file must be world-readable and mounted to `/etc/scout/scoutd.yml` (see above command).
For a list of options, see our [scoutd help page](http://help.scoutapp.com/v1.2/docs/scoutd-beta#configuration).

## Monitoring Docker Containers

Monitor the resource usage of your running containers with our [__Docker Monitoring Plugin__](https://scoutapp.com/plugin_urls/19761-docker-monitoring). 

The plugin requires reading from `/host/sys/fs/cgroup` (mounted above). This mounting is unnecessary if the docker plugin will not be in use. 

## Questions? Using Docker?

Shoot us an email at support@scoutapp.com or [open an issue](https://github.com/scoutapp/docker-scout/issues). Full help documentation is available on our [help site](http://help.scoutapp.com/v1.2/docs/docker).
