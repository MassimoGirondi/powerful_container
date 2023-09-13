#!/bin/bash
source .env
docker build . -t girondi/super_container:latest \
	--build-arg DOCKERUSER=$DOCKERUSER \
	--build-arg USERID=$USERID \
	--build-arg PASSWORD=$PASSWORD \
	--build-arg ROOTPASSWORD=$ROOTPASSWORD \
