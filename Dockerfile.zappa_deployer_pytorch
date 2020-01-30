#####################################################################################
##### Image to deploy Pytorch Model to AWS Lambda using zappa #####

##### Example usage:

##### docker run --rm -v "$PROJECT_DIR":/"$APP_DIR" \
#####      -e AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" -e AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" \
#####      -e stage="$STAGE" -e cmd="$CMD" -e arg="$ARG" gautamborg/zappa_deployer_pytorch:latest

##### PROJECT_DIR : The project directory that is to be deployed
##### APP_DIR : The dir in this image that is to be mounted to. Should be `app`
##### AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY :  AWS credentials to deploy to lambda
##### STAGE : The deployment stage to be used; this should have matching config in `zappa_settings.json` eg. dev
##### CMD : The zappa command you are Running eg. status, deploy
##### ARG : Any extra arg to the zappa command eg. --since 2m
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

COPY pytorch_lambda_pack/ /app_temp

RUN cd torch/lib && \
    unzip libcaffe2.zip && \
    rm -rf libcaffe2.zip

COPY zappa_deployer.sh zappa_deployer.sh

RUN chmod 755 zappa_deployer.sh

WORKDIR /app

ENTRYPOINT ["/app_temp/zappa_deployer.sh"]
