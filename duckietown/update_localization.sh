#!/bin/bash

__master_ip="172.31.168.2"

__interface_name="duckiebot-interface"
__localization_name="acquisition-bridge"

__interface_image="duckietown/dt-$__interface_name:daffy-arm32v7"
__localization_image="courchesnea/$__localization_name:daffy-arm32v7"

for i in 123 124 125
do
  echo "Setting up WATCHOWER$i"

  docker -H watchtower$i.local stop $__interface_name
  docker -H watchtower$i.local container rm $__interface_name
  docker -H watchtower$i.local pull $__interface_image
  docker -H watchtower$i.local run --name $__interface_name -v /data:/data --privileged --network=host -dit --restart unless-stopped -e ROBOT_TYPE=watchtower $__interface_image

  docker -H watchtower$i.local stop $__localization_name
  docker -H watchtower$i.local container rm $__localization_name
  docker -H watchtower$i.local pull $__localization_image
  docker -H watchtower$i.local run --name $__localization_name -v /data:/data --privileged --network=host -dit -e ROBOT_TYPE=watchtower -e LAB_ROS_MASTER_IP=$__master_ip $__localization_image
done
