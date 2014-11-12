# Scout Dockerfile

This is the start of a Dockerfile to run the [Scout](https://scoutapp.com) monitoring agent via a Docker container. The implementation isn't complete.

## Quick Start

Build the image:

<pre>
docker build -t="scoutapp/scoutd" .
</pre>

Run it:

<pre>
docker run --name scout-agent \
-v /proc:/host/proc:ro \
-e KEY=YOURSCOUTKEY scoutapp/scoutd
docker exec -i -t 68973c0a1348 /bin/bash
</pre>

## What's left

### Reading host metrics

We want to look at resources on this host, not this container.

The `server_metrics` Ruby gem used by the scout agent primarily looks at the `/proc` directory. The [docker_support](https://github.com/scoutapp/server_metrics/tree/docker_support) branch will look to read from `/host/proc`, which is expected to be shared from the host when running the container (see the above command sample).

I've verified this works for reading process data. I haven't tested against CPU, or Memory (need to limit those resources on the container). I'm not sure if it will be possible for disks (we also read from `mount`, which will have different output). Network will likely need the `--privileged` flag.

### scoutd config options

Currently only the host key is set from the environment variables. We'll want to make it possible to set all of the config options from the environment variables. 

## Questions? Using Docker?

Shoot us an email at support@scoutapp.com or open an issue.

