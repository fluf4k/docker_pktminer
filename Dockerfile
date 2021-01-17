FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y \
        build-essential \
        ca-certificates \
        curl \
        git \
        ssh \
        libssl-dev \
        pkg-config && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV RUSTUP_HOME=/rust
ENV CARGO_HOME=/cargo 
ENV PATH=/cargo/bin:/rust/bin:$PATH

WORKDIR /

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN git clone https://github.com/cjdelisle/packetcrypt_rs.git &&\
      cd packetcrypt_rs &&\
      cargo build --release &&\
      cp target/release/packetcrypt /usr/bin/

RUN echo "clean up" &&\
      rm -r /packetcrypt_rs

ENTRYPOINT ["/usr/bin/packetcrypt"]
