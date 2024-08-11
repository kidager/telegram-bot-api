FROM alpine:3.21.3 AS builder

WORKDIR /app

# Compile telegram-bot-api server:
RUN apk add --no-cache \
        alpine-sdk=1.1-r0 \
        cmake=3.31.1-r0 \
        git=2.47.2-r0 \
        gperf=3.1-r4 \
        linux-headers=6.6-r1 \
        openssl-dev=3.3.3-r0 \
        zlib-dev=1.3.1-r2 \
    && git clone --recursive https://github.com/tdlib/telegram-bot-api.git

WORKDIR /app/telegram-bot-api

RUN rm -rf build && mkdir build

WORKDIR /app/telegram-bot-api/build

RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local .. && \
    cmake --build . --target install

FROM alpine:3.21.3

WORKDIR /app

# Install dependencies
RUN apk add --no-cache \
    libstdc++=14.2.0-r4 \
    openssl=3.3.3-r0

# Install telegram-bot-api server
COPY --from=builder /usr/local/bin/telegram-bot-api /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/telegram-bot-api", "--local"]
