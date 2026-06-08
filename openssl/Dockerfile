FROM ubuntu:24.04

# Make sure curl picks up the new openssl
ENV PKG_CONFIG_LIBDIR=/usr/lib64/pkgconfig:/usr/lib/pkgconfig:/usr/lib/x86_64-linux-gnu/pkgconfig/:$PKG_CONFIG_LIBDIR
# Set the environment variable LD_LIBRARY_PATH to ensure we get the right libraries
ENV LD_LIBRARY_PATH=/usr/lib64:/usr/lib:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
# The branch of openssl to clone
ARG OPENSSL_URL=https://github.com/openssl/openssl.git
ARG OPENSSL_BRANCH=master

# Install needed tools
RUN apt-get update && apt-get install -y \
    git make gcc perl cmake build-essential \
    autoconf libtool pkg-config libpsl-dev && \
    apt-get clean

WORKDIR /

# download and build openssl 
RUN git clone --depth 1 -b $OPENSSL_BRANCH $OPENSSL_URL && \
    cd openssl && \
    ./Configure enable-sslkeylog enable-trace enable-fips disable-docs --prefix=/usr --openssldir=/etc/pki/tls && \
    make -j 4 && make install

# copy run script and run it
COPY setup_server.sh .
RUN chmod +x setup_server.sh

CMD ["sleep", "infinity"]

