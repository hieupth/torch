ARG BASE=hieupth/mamba
ARG TORCH=1.13.1
ARG CUDA_TAG=11.7
ARG CUDA_VERSION=11.7.1

FROM ${BASE}
# Recall args.
ARG TORCH
ARG CUDA_TAG
ARG CUDA_VERSION
# Install PyTorch CUDA_TAG
RUN mamba install -y pytorch==${TORCH} torchvision torchaudio pytorch-cuda=${CUDA_TAG} cuda-nvcc -c pytorch -c "nvidia/label/cuda-${CUDA_VERSION}" && \
    mamba clean -ay && \
    nvcc --version
# Install other packages
RUN mamba install -y opencv pandas polars matplotlib && \
    conda clean -ay
# Install huggingface
RUN pip install --no-cache-dir \
        transformers \
        accelerate