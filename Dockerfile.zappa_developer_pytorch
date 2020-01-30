#####################################################################################
##### Image to use as dev env for building Flask app for AWS Lambda that needs Pytorch #####

##### Example usage:

##### docker run -it --rm -p 5000:5000 -v "$PROJECT_DIR":"/$APP_DIR" gautamborg/zappa_developer_pytorch:latest

##### PROJECT_DIR : The project directory that is to be deployed
##### APP_DIR : The dir in this image that is to be mounted to. Should be `app`

##### To run bash inside the container, you can override the entyrypoint by
##### docker run -it --rm -p 5000:5000 -v "$PROJECT_DIR":"/$APP_DIR" --entrypoint "bash" gautamborg/zappa_developer_pytorch:latest
#####################################################################################

FROM continuumio/miniconda3:4.3.27

RUN cp /bin/bash /bin/sh

RUN apt-get install unzip

RUN pip install zappa awscli && \
    export PATH=~/.local/bin:$PATH

ENV PATH /opt/conda/bin:$PATH

WORKDIR /app_temp

COPY basic_api_requirements.txt requirements.txt

RUN conda create -n zappa_env python=3.6 flask && \
    source activate zappa_env && \
    pip install -r requirements.txt

RUN echo "export VIRTUAL_ENV=/opt/conda/envs/zappa_env" >> ~/.bashrc && \
    echo "source activate zappa_env" >> ~/.bashrc

COPY pytorch_lambda_pack/ /opt/conda/envs/zappa_env/lib/python3.6/site-packages/

RUN cd /opt/conda/envs/zappa_env/lib/python3.6/site-packages/torch/lib && \
    unzip libcaffe2.zip && \
    rm -rf libcaffe2.zip

COPY dev_server_starter.sh dev_server_starter.sh
RUN chmod 755 dev_server_starter.sh

WORKDIR /app

ENTRYPOINT ["/app_temp/dev_server_starter.sh"]
