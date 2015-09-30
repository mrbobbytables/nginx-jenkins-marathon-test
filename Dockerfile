FROM nginx

COPY ./skel /

RUN chmod +x init.sh

CMD ["./init.sh"]
