# Pull base image.
FROM node:8-slim
MAINTAINER Nimrod Nagy <nimrod.nagy@lynxsolutions.eu>

# Latest Git version
RUN echo "deb http://ftp.us.debian.org/debian testing main contrib non-free " >> /etc/apt/sources.list
RUN echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list

# Install git
RUN apt-get update && apt-get install -y git rsync bzip2 xvfb curl 
RUN mkdir /usr/share/man/man1
RUN apt-get install -y -t jessie-backports  openjdk-8-jre-headless ca-certificates-java

# Install google-chrome
RUN set -xe \
    && curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Global install gulp and bower
# RUN npm set progress=false && \
#    npm install -g gulp grunt bower phantomjs && \
#    printf '\n%s' 'registry = http://nexus.lynxsolutions.eu/repository/npm/' >> /root/.npmrc && \
#    echo '{ "allow_root": true }' > /root/.bowerrc

# Binary may be called nodejs instead of node
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Define working directory.
WORKDIR /workspace

CMD ["/bin/bash"]
ENTRYPOINT []
