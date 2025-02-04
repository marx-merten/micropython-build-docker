# Use the official Ubuntu Jammy as a parent image
FROM ubuntu:jammy

ARG MPY_VERSION=v1.24.1

# Set the working directory
WORKDIR /buildtools

# Update the package list and install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential libffi-dev git pkg-config gcc-arm-none-eabi libnewlib-arm-none-eabi cmake \
    python3 python3-pip python3-venv libusb-1.0-0-dev  bsdmainutils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/marx-merten/micropython.git /micropython && \
    cd /micropython && \
    git remote add upstream https://github.com/micropython/micropython && \
    git fetch upstream --tags && \
    git checkout -b wrk $MPY_VERSION


RUN cd /micropython && \
    git submodule update --init && \
    make -C mpy-cross


RUN export VER=$(grep -o 'IDF_VER=v[0-9]*\.[0-9]*\.[0-9]*' /micropython/tools/ci.sh | cut -d'=' -f2) && \
    mkdir -p /frameworks && \
    cd /frameworks && \
    git clone -b $VER --recursive https://github.com/espressif/esp-idf.git && \
    cd /frameworks/esp-idf && \
    git submodule update --init --recursive && \
    ./install.sh


# Copy the current directory contents into the container at /app
COPY ./tools /buildtools
COPY ./template /template_workspace
# Run app.py when the container launches
CMD ["bash"]
