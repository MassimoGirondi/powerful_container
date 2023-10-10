#!/bin/bash
source .env
docker build . -t girondi/super_container_tvm:latest \
	-f tvm.Dockerfile \
	$@ \
	--build-arg DOCKERUSER=$DOCKERUSER \
	--build-arg USERID=$USERID \
	--build-arg PASSWORD=$PASSWORD \
	--build-arg ROOTPASSWORD=$ROOTPASSWORD \
