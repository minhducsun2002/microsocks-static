# syntax=docker/dockerfile:1

# alpine:3.24.2
FROM alpine@sha256:c54a80678a9e7a744b39d478329d5eb8e568c2e0321defd14cab57047557e202 as build

RUN apk add --no-cache build-base linux-headers git

WORKDIR /build

RUN git clone https://github.com/rofl0r/microsocks --revision 307950cb1296b521fe86384fd695062ade5304b5
WORKDIR /build/microsocks
RUN make LDFLAGS="-static"



FROM alpine@sha256:c54a80678a9e7a744b39d478329d5eb8e568c2e0321defd14cab57047557e202
WORKDIR /app
COPY --from=build /build/microsocks/microsocks /app/microsocks
