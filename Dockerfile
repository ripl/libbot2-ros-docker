FROM ripl/libbot2:latest

# set Ubuntu codename
ENV UBUNTU_DISTRIB_CODENAME "xenial"

# set ROS codename
#ENV ROS_DISTRO "kinetic"
ENV ROS_DISTRO "noetic"

# set default ROS master hostname
ENV ROS_MASTER_HOST "localhost"

# Setup ROS sources
#RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $UBUNTU_DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'

RUN apt update && apt install -y curl

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

# update apt lists and install system libraries, then clean the apt cache
RUN apt update && apt install -y \
    ros-$ROS_DISTRO-desktop \
    # clean the apt cache
    && rm -rf /var/lib/apt/lists/*

# Setup ROS keys
#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# update apt lists and install system libraries, then clean the apt cache
#RUN apt update && apt install -y \
#    ros-$ROS_DISTRO-desktop \
    # clean the apt cache
#    && rm -rf /var/lib/apt/lists/*

# source ROS
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /etc/bash.bashrc

# copy and set entrypoint
COPY assets/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
