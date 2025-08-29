FROM debian

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Set environment variables for Idris2
ENV IDRIS2_PREFIX=/usr/local
ENV PATH=$IDRIS2_PREFIX/bin:$PATH
#ENV LD_LIBRARY_PATH=$IDRIS2_PREFIX/lib:$LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=$IDRIS2_PREFIX/lib

# Install essential build tools and dependencies
RUN apt-get update && apt-get install -y \
    # Essential build tools
    build-essential \
    make \
    git \
    curl \
    wget \
    # C compiler and libraries
    clang \
    gcc \
    libc6-dev \
    # GMP library (required for Chez Scheme)
    libgmp-dev \
    libgmp10 \
    # Additional utilities
    vim \
    nano \
    ca-certificates \
    libx11-dev \
    && rm -rf /var/lib/apt/lists/*


# Install Chez Scheme (preferred backend for Idris2)
# We'll build from source to ensure thread support with --threads
WORKDIR /tmp
RUN wget https://github.com/cisco/ChezScheme/releases/download/v10.0.0/csv10.0.0.tar.gz \
    && tar -xzf csv10.0.0.tar.gz

RUN cd csv10.0.0 \
    && ./configure --threads --installprefix=/usr/local \
    && make \
    && make install \
    && cd / \
    && rm -rf /tmp/csv10.0.0*

# Install idris2-pack using the official installation script
RUN curl -fsSL https://raw.githubusercontent.com/stefan-hoeck/idris2-pack/main/install.bash | SCHEME=chezscheme bash

# Add pack to PATH
ENV PATH=/root/.pack/bin:$PATH

#RUN pack install-app idris2-lsp
 
