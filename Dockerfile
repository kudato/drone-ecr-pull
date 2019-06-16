FROM docker:18.09

ADD plugin.sh /

RUN chmod +x /plugin.sh \
    && apk add --no-cache python3 bash \
    && pip3 install awscli

ENTRYPOINT [ "/plugin.sh" ]