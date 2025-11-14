FROM ubuntu:22.04 AS builder

RUN apt update && apt upgrade -y
RUN apt install binutils-dev build-essential -y
WORKDIR /work
ADD . .
RUN make install

FROM ubuntu:22.04 AS base
RUN apt update && apt upgrade -y
RUN apt install binutils -y
RUN apt clean
COPY --from=builder /usr/local/lib/* /usr/local/lib/
COPY bin/zrun /usr/local/bin/zrun
