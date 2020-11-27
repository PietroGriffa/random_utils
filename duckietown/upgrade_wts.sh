#!/bin/bash

__master_ip="172.31.168.2"

__ros_name="ros"
__core_name="dt-core"

__ros_image="duckietown/dt-ros-commons:daffy-arm32v7"
__core_image="duckietown/$__core_name:daffy-arm32v7"

for i in 118 119
do
  echo "Setting up WATCHOWER$i"

  docker -H watchtower$i.local stop $__ros_name
  docker -H watchtower$i.local container rm $__ros_name
  docker -H watchtower$i.local pull $__ros_image
  docker -H watchtower$i.local run --name $__ros_name -v /data:/data --privileged --network=host -dit --restart unless-stopped -e ROBOT_TYPE=watchtower $__ros_image

  docker -H watchtower$i.local stop $__core_name
  docker -H watchtower$i.local container rm $__core_name
  docker -H watchtower$i.local pull $__core_image
  docker -H watchtower$i.local run --name $__core_name -v /data:/data --privileged --network=host -dit -e ROBOT_TYPE=watchtower  $__core_image
done
