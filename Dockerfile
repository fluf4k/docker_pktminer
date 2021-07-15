FROM alpine:latest AS builder
RUN apk add curl rust cargo build-base gcc wget git

WORKDIR /pkt
RUN git clone https://github.com/cjdelisle/packetcrypt_rs && \
    cd packetcrypt_rs && \
    cargo build --release --features portable --target=x86_64-unknown-linux-musl

FROM alpine
WORKDIR /app
RUN apk add libgcc
COPY --from=builder /pkt/packetcrypt_rs/target/release/packetcrypt /app/ 
ENTRYPOINT ["/app/packetcrypt", "ann", " http://pool.pkteer.com http://pool.pkt.world http://pool.pktpool.io"]
