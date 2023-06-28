FROM registry.scontain.com/sconecuratedimages/crosscompilers AS builder
RUN apk update
RUN apk add git curl go
# ENV SCONE_HEAP 1G
ENV SCONE_VERSION 1
ENV SCONE_LOG INFO
ENV GO111MODULE off
RUN go get -compiler gccgo -u github.com/golang/groupcache
RUN curl  -fsSL --output groupcache.go https://gist.githubusercontent.com/fiorix/816117cfc7573319b72d/raw/797d2ed5b567dcffb8ebd8896a3d7671b1a44b31/groupcache.go
RUN go build -compiler gccgo -buildmode=exe groupcache.go

FROM alpine:latest
COPY --from=builder /groupcache /
COPY --from=builder /opt/scone/cross-compiler/x86_64-linux-musl/lib/libgo.s* /opt/scone/cross-compiler/x86_64-linux-musl/lib/
COPY --from=builder /opt/scone/cross-compiler/x86_64-linux-musl/lib/libgcc_s.s* /opt/scone/cross-compiler/x86_64-linux-musl/lib/
COPY --from=builder /opt/scone/lib/ld-scone-x86_64.s* /opt/scone/lib/
COPY --from=builder /opt/scone/cross-compiler/x86_64-linux-musl/lib/libc.scone-x86_64.s* /opt/scone/cross-compiler/x86_64-linux-musl/lib/
COPY --from=builder /etc/sgx-musl.conf /etc/sgx-musl.conf
ENV LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/opt/scone/cross-compiler/x86_64-linux-musl/lib"
CMD sh -c "SCONE_HEAP=1G SCONE_VERSION=1 SCONE_LOG=INFO /groupcache"