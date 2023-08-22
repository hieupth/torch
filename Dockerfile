ARG BASE=hieupth/mamba
ARG TORCH_VERSION=1.13.1
ARG CUDA_VERSION=11.7

FROM ${BASE}
# Recall args.
ARG CUDA_VERSION
ARG TORCH_VERSION
# Set envs.
ENV DS_BUILD_OPS=1
# Install packages.
RUN mamba install -y pytorch==${TORCH_VERSION} torchvision torchaudio pytorch-cuda=${CUDA_VERSION} cudatoolkit-dev -c pytorch -c nvidia -c conda-forge && \
    pip install transformers[torch] accelerate triton==1.0.0 --no-cache-dir && \
    pip install deepspeed --no-cache-dir && \
    mamba clean -ay && \
    ds_report