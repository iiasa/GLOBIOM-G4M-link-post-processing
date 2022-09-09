FROM ubuntu:latest

# Set GAMS version 
ENV GAMS_VERSION=40.1.1

ENV TZ=Europe/Vienna \
    DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends\
 wget\
 curl\
 software-properties-common\
 git\
 unzip\
 r-base-core\
 r-base-dev\
 r-cran-tidyverse

RUN Rscript -e 'install.packages("R.utils")'

# Set GAMS bit architecture, either 'x64_64' or 'x86_32'
ENV GAMS_BIT_ARC=x64_64

# Download GAMS
RUN curl -SL "https://d37drm4t2jghv5.cloudfront.net/distributions/${GAMS_VERSION}/linux/linux_${GAMS_BIT_ARC}_sfx.exe" --create-dirs -o /opt/gams/gams.exe

# Install GAMS
RUN cd /opt/gams &&\
    chmod +x gams.exe; sync &&\
    ./gams.exe &&\
    rm -f gams.exe

# Copy the license file into the container
COPY gamslice.txt .

# Move license file to GAMS dir and add GAMS dir to user env path
# Also install GAMS Transfer R from the package tarball included with GAMS.
RUN GAMS_DIR="$(dirname $(find / -name gams -type f -executable -print))" &&\
    mv gamslice.txt "$GAMS_DIR" &&\
    ln -s "$GAMS_DIR/gams" /usr/local/bin/gams &&\
    echo "export PATH=\$PATH:$GAMS_DIR" >> ~/.bashrc &&\
    cd "$GAMS_DIR" &&\
    ./gamsinst -a &&\
    Rscript -e 'install.packages("./apifiles/R/gamstransfer/source/gamstransfer_r.tar.gz", dependencies=TRUE)'

CMD ["R"]
