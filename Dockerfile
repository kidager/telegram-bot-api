# syntax=docker/dockerfile:1
# Base image is pinned by digest and bumped by dependabot (it only understands literal FROM lines).
FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6 AS builder

# Upstream telegram-bot-api commit to build. Bump it when a new Bot API version ships.
ARG TELEGRAM_BOT_API_REF=e3e9dd8e5b3d7ab8537cd5a10dc31d5ffa8f82d1

# Packages are unpinned on purpose, the weekly CI clean build catches breakage.
# hadolint ignore=DL3018
RUN apk add --no-cache \
        alpine-sdk \
        ccache \
        clang \
        cmake \
        git \
        gperf \
        linux-headers \
        llvm \
        openssl-dev \
        zlib-dev

WORKDIR /src

RUN git init -q . \
    && git remote add origin https://github.com/tdlib/telegram-bot-api.git \
    && git fetch -q --depth 1 origin "${TELEGRAM_BOT_API_REF}" \
    && git checkout -q FETCH_HEAD \
    && git submodule update --init --recursive --depth 1

# Compare compilers by content, so a reinstalled toolchain still hits the cache.
ENV CCACHE_DIR=/ccache \
    CCACHE_COMPILERCHECK=content \
    CCACHE_MAXSIZE=1G

# clang needs far less memory than GCC for tdlib.
RUN --mount=type=cache,id=ccache,target=/ccache \
    ccache -z && \
    cmake -S . -B build \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX:PATH=/usr/local \
        -DCMAKE_C_COMPILER=clang \
        -DCMAKE_CXX_COMPILER=clang++ \
        -DCMAKE_C_COMPILER_LAUNCHER=ccache \
        -DCMAKE_CXX_COMPILER_LAUNCHER=ccache && \
    cmake --build build --target install --parallel "$(nproc)" && \
    ccache -s

FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

WORKDIR /app

# hadolint ignore=DL3018
RUN apk add --no-cache \
    libstdc++ \
    openssl

# Install telegram-bot-api server
COPY --from=builder /usr/local/bin/telegram-bot-api /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/telegram-bot-api", "--local"]
