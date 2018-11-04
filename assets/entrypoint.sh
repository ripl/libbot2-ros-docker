#!/bin/bash

set -e

# source ROS
source /opt/ros/${ROS_DISTRO}/setup.bash --extend

# auto-source third-party script (if any)
if [ -f /code/devel/setup.bash ]; then
    source /code/devel/setup.bash --extend
fi

# source third-party script (if any)
if [ -n "${SOURCE_BASH}" ]; then
    source ${SOURCE_BASH} --extend
fi

# set ROS master URI
export ROS_MASTER_URI="http://${ROS_MASTER_HOST}:11311"

# exec given command
exec "$@"
