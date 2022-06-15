# Image that provides:
# - Clang
# - CMake
# - Python27 (for run-clang-tidy.py)
# - utf8 locale support
#
# Based on https://github.com/sol-prog/Clang-in-Docker
# Check http://releases.llvm.org/download.html#7.0.1 for the latest available binaries
# 
# to build : docker build -t clang .
# to run   : docker run --rm -it -v <source>:<destination> clang /bin/bash

FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
  xz-utils \
  build-essential \
  curl \
  locales \
  wget \
  python2.7 \
  && rm -rf /var/lib/apt/lists/* \
  && curl -SL http://releases.llvm.org/7.0.1/clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-18.04.tar.xz \
  | tar -xJC . && \
  mv clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-18.04 clang_7.0.1

ENV PATH="/clang_7.0.1/bin:${PATH}"
ENV LD_LIBRARY_PATH="/clang_7.0.1/lib:${LD_LIBRARY_PATH}"
ENV CC=clang
ENV CXX=clang++

# Install new cmake (based on https://github.com/ttroy50/cmake-examples/blob/master/dockerfiles/ubuntu16.04-cmake-3.10.3)
RUN cd /usr/local/src \ 
    && wget https://github.com/Kitware/CMake/releases/download/v3.14.0-rc1/cmake-3.14.0-rc1.tar.gz \
    && tar xvf cmake-3.14.0-rc1.tar.gz \ 
    && cd cmake-3.14.0-rc1 \
    && ./bootstrap \
    && make \
    && make install \
    && cd .. \
    && rm -rf cmake*

# Set the locale (required for mbstowcs/wcstombs to work...)
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

RUN apt update && apt install -y ninja-build

CMD ["/bin/bash"]