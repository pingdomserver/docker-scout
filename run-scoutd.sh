#!/bin/bash

if [[ $KEY ]]; then
	sed -i -e "s/^.*account_key:.*$/account_key: ${KEY}/" /etc/scout/scoutd.yml
else
	echo "Set the KEY environment variable to run the Scout container"
	exit 1
fi

exec /usr/bin/scoutd start