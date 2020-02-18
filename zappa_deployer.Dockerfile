FROM continuumio/miniconda3:4.3.27

RUN cp /bin/bash /bin/sh

RUN pip install zappa awscli && \
    export PATH=~/.local/bin:$PATH

ENV PATH /opt/conda/bin:$PATH

RUN conda create -n zappa_env python=3.6 flask

RUN echo "export VIRTUAL_ENV=/opt/conda/envs/zappa_env" >> ~/.bashrc && \
    echo "source activate zappa_env" >> ~/.bashrc

COPY basic_api_requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY zappa_deployer.sh zappa_deployer.sh

RUN chmod 755 /zappa_deployer.sh

ENTRYPOINT ["/zappa_deployer.sh"]
