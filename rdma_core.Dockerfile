FROM nvidia/cuda:12.1.0-base-ubuntu22.04
LABEL org.opencontainers.image.authors="girondi@kth.se"

RUN apt update && apt install -y python3 pkg-config libnl-3-dev libnl-route-3-dev git cmake
RUN git clone https://github.com/linux-rdma/rdma-core.git /rdma-core
WORKDIR /rdma-core
RUN cd /rdma-core && ./build.sh

# Cleanup
RUN rm -rf /var/apt
ENTRYPOINT bash
