#Dockerfile to build a pdf2htmlEx with gevent server image
FROM ubuntu:20.04

# Set timezone for pip instalation purpose
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install pip3, wget and pdf2htmlex specific libs
RUN apt-get -qqy update && \
    apt-get install -qqy python3-pip wget libfontconfig1 libcairo2 libjpeg-turbo8  && \
# Download latest pdf2htmlEX
    wget https://github.com/pdf2htmlEX/pdf2htmlEX/releases/download/v0.18.8.rc1/pdf2htmlEX-0.18.8.rc1-master-20200630-Ubuntu-bionic-x86_64.deb && \
# Rename downloaded library
    mv pdf2htmlEX-0.18.8.rc1-master-20200630-Ubuntu-bionic-x86_64.deb pdf2htmlEX.deb && \
# Install pdf2htmlEX
    apt-get install -qqy ./pdf2htmlEX.deb

# Copy all required files into /opt/app/ directory
ADD requirements.txt \
    pdf_2_html_service.py \
    entrypoint.sh \
    /opt/app/

WORKDIR /opt/app

# Install server requirements
RUN pip3 install -r requirements.txt

ENTRYPOINT [ "sh", "entrypoint.sh" ]