#!/bin/bash

set -e

# source ROS
source /opt/ros/${ROS_DISTRO}/setup.bash

# set ROS master URI
export ROS_MASTER_URI="http://${ROS_MASTER_HOST}:11311"

# exec given command
exec "$@"
