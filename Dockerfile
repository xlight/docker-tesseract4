FROM ubuntu
RUN apt-get update && apt-get install -y autoconf automake libtool autoconf-archive pkg-config libpng12-dev libjpeg8-dev libtiff5-dev zlib1g-dev  libicu-dev libpango1.0-dev libcairo2-dev git curl && \
rm -rf /var/lib/apt/lists/*
RUN curl http://www.leptonica.org/source/leptonica-1.74.1.tar.gz -o leptonica-1.74.1.tar.gz && \
tar -zxvf leptonica-1.74.1.tar.gz && \
cd leptonica-1.74.1 && ./configure && make && make install && \
cd .. && rm -rf leptonica*
RUN git clone --depth 1 https://github.com/tesseract-ocr/tesseract.git && \
cd tesseract && \
./autogen.sh && \
./configure --enable-debug && \
LDFLAGS="-L/usr/local/lib" CFLAGS="-I/usr/local/include" make && \
make install && \
ldconfig && \
make training && \
make training-install && \
cd .. && rm -rf tesseract

