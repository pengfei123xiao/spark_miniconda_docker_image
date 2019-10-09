# ======spark-miniconda docker image======
FROM debian:stretch
LABEL maintainer="pengfei123xiao@gmail.com"

## Declare Enviroments Variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH
ENV SPARK_HOME=/spark

## Install Miniconda3
RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.7.10-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

## Install Spark
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y scala && \
    conda install -y  -c conda-forge findspark && \
    wget http://apache.mirror.amaze.com.au/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz && \
    tar xvf spark-2.4.4-bin-hadoop2.7.tgz && \
    ln -s spark-2.4.4-bin-hadoop2.7 spark

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
