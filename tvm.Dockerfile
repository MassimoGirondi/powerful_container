FROM girondi/super_container_torch as base
RUN pip3 install torch torchvision torchaudio torchsummary torchinfo matplotlib onnxruntime decorator scipy attr
RUN apt install -y python3 python3-dev python3-setuptools gcc libtinfo-dev zlib1g-dev build-essential cmake libedit-dev libxml2-dev  software-properties-common

RUN pip3 install typing-extensions psutil scipy tornado psutil 'xgboost>=1.1.0' cloudpickle pybind11 cython pythran  decorator attrs onnx onnxruntime onnxruntime-gpu

RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

FROM base as clone
RUN git clone --recursive https://github.com/apache/tvm /tvm
RUN cd /tvm && git submodule update --init
RUN mkdir -p /tvm/build
COPY res/tvm_config.cmake /tvm/build/config.cmake

FROM clone as build
RUN cd /tvm/build && cmake .. && make -j && make install
RUN cd /tvm/python; python3 setup.py install --user
ENV TVM_HOME=/tvm
ENV PYTHONPATH=$TVM_HOME/python:${PYTHONPATH}




