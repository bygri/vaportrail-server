FROM swift:4 as builder

RUN apt-get -qq update && apt-get install -y \
  libmysqlclient-dev \
  && rm -r /var/lib/apt/lists/*

WORKDIR /app/

COPY . .

RUN mkdir -p /build/lib && cp -R /usr/lib/swift/linux/*.so /build/lib
RUN swift build -c release && mv `swift build -c release --show-bin-path` /build/bin

# Production

FROM ubuntu:16.04

RUN apt-get -qq update && apt-get install -y apt-utils \
  && echo debconf debconf/frontend select Noninteractive | debconf-set-selections \
  && apt-get -q -y install \
  libicu55 libxml2 libbsd0 libcurl3 libatomic1 \
  tzdata \
  mysql-server \
  libmysqlclient20 \
  && rm -r /var/lib/apt/lists/*
WORKDIR /app/
COPY --from=builder /build/bin/vaportrail .
COPY --from=builder /build/lib/* /usr/lib/
COPY --from=builder /app/Config/ ./Config/
EXPOSE 80
ENTRYPOINT chown -R mysql:mysql /var/lib/mysql && service mysql start && echo "create database vaportrail" | mysql \
  && ./vaportrail --env=production
