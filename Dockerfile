FROM kudato/baseimage:docker-18.09

ENV AWS_DEFAULT_REGION=us-east-1

COPY plugin.sh /

RUN chmod +x /plugin.sh \
    && apk add --no-cache python3 bash \
    && pip3 install awscli

CMD [ "/plugin.sh" ]