FROM kudato/baseimage:docker-18.09

ADD plugin.sh /

RUN chmod +x /auth.sh \
    && apk add --no-cache python3 bash \
    && pip3 install awscli

CMD [ "/plugin.sh" ]