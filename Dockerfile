FROM ubuntu:18.04
RUN apt update && \
    apt install -y cmake \
    wget \
    python3-pip && \
    pip3 install conan


