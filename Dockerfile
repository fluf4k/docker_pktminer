FROM alpine:latest AS builder
RUN apk add curl rust cargo build-base gcc wget git

WORKDIR /pkt
RUN git clone https://github.com/cjdelisle/packetcrypt_rs && \
    cd packetcrypt_rs && \
    cargo build --release

FROM alpine
WORKDIR /app
RUN apk add libgcc
COPY --from=builder /pkt/packetcrypt_rs/target/release/packetcrypt /app/ 
ENTRYPOINT ["/app/packetcrypt", "ann", " http://noworries.tech/pool http://pool.pkteer.com"]
