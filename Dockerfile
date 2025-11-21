FROM rust:1-trixie

ARG TARGETARCH

ENV DEBIAN_FRONTEND=noninteractive
ENV CC=musl-gcc
ENV AR=ar
ENV RUST_BACKTRACE=full

RUN apt-get update && apt-get install -y musl-tools

# Still fails with this:
# RUN apt-get install -y cmake

WORKDIR /app
ADD . .

RUN case "$TARGETARCH" in \
      arm64) TARGET=aarch64-unknown-linux-musl ;; \
      amd64) TARGET=x86_64-unknown-linux-musl ;; \
      riscv64) TARGET=riscv64gc-unknown-linux-musl ;; \
      *) echo "Does not support $TARGETARCH" && exit 1 ;; \
    esac && \
    rustup target add $TARGET && \
    cargo build --target $TARGET
