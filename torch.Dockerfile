FROM girondi/super_container
RUN pip3 install torch torchvision torchaudio torchsummary torchinfo matplotlib onnxruntime-gpu decorator scipy attr
