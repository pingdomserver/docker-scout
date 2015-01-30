# Scout Dockerfile

This a Dockerfile to run the [Scout](https://scoutapp.com) monitoring agent via a Docker container.

## Quick Start

Build the image:

<pre>
docker build -t scoutapp/scoutd .
</pre>

Set your configuration:

edit scoutd.yml
your account_key is required, all other values are optional

Run it:

<pre>
docker run -d --name scout-agent \
-v /proc:/host/proc:ro \
-v /etc/mtab:/host/etc/mtab:ro \
-v /sys/fs/cgroup:/host/sys/fs/cgroup:ro \
-v `pwd`/scoutd.yml:/etc/scout/scoutd.yml \
--net=host --privileged scoutapp/scoutd
</pre>

### Reading host metrics

We want to look at resources on this host, not this container.

The `server_metrics` Ruby gem used by the scout agent primarily looks at the `/proc` directory, but, if available, will instead read from `/host/proc`, which is expected to be shared from the host when running the container (see the above command sample).

The `server_metrics` gem will also default to reading from `/host/etc/mtab` (also mounted above), if it exists, to determine the drives mounted on the host. It will recognize theses hosts inside the container if they are mounted by UUID (`/dev/disk/by-uuid/XXXXX`).

The `--net=host` flag will allow gathering network metrics from the host.

The `--privileged` flag will allow gathering the disk capacity metrics from the host.

The [docker plugin](https://scoutapp.com/plugin_urls/10591-docker-monitoring) requires reading from the `/host/sys/fs/cgroup` (mounted above). This mounting is unnecessary if the docker plugin will not be in use.

### scoutd config options

Any option may be set in the provided scoutd.yml file. This file must be world-readable and mounted to `/etc/scout/scoutd.yml` (see above command).

## Questions? Using Docker?

Shoot us an email at support@scoutapp.com or open an issue.

