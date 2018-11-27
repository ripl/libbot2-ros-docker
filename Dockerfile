FROM afdaniele/libbot2:latest

# set Ubuntu codename
ENV UBUNTU_DISTRIB_CODENAME "xenial"

# set ROS codename
ENV ROS_DISTRO "kinetic"

# set default ROS master hostname
ENV ROS_MASTER_HOST "localhost"

# Setup ROS sources
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $UBUNTU_DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'

# Setup ROS keys
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

# update apt lists and install system libraries, then clean the apt cache
RUN apt update && apt install -y \
    ros-$ROS_DISTRO-desktop \
    # clean the apt cache
    && rm -rf /var/lib/apt/lists/*

# source ROS
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /etc/bash.bashrc

# copy and set entrypoint
COPY assets/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
