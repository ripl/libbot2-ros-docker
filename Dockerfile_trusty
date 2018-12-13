FROM ripl/libbot2:trusty

# set ROS codename
ENV ROS_DISTRO "indigo"

# set default ROS master hostname
ENV ROS_MASTER_HOST "localhost"

# update apt lists and install system libraries, then clean the apt cache
RUN apt update && apt install -y \
    curl \
    # clean the apt cache
    && rm -rf /var/lib/apt/lists/*

# install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py && \
    python /tmp/get-pip.py && \
    rm -f /tmp/get-pip.py

# remove numpy
RUN apt remove -y python-numpy

# install numpy
RUN pip install --upgrade numpy

# install opencv3.4
RUN pip install --upgrade opencv-python

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
