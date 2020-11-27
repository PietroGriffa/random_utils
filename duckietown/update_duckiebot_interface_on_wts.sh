#!/bin/bash

for i in 128 129 130 131
do
  docker -H watchtower$i.local stop duckiebot-interface
  docker -H watchtower$i.local container rm duckiebot-interface
  docker -H watchtower$i.local pull duckietown/dt-duckiebot-interface:daffy-arm32v7
  docker -H watchtower$i.local run --name duckiebot-interface -v /data:/data --privileged --network=host -dit --restart unless-stopped -e ROBOT_TYPE=watchtower duckietown/dt-duckiebot-interface:daffy-arm32v7
done
