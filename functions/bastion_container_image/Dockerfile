FROM ubuntu

RUN apt-get update && \
  apt-get install -y default-mysql-client && \
  apt-get -y install mysql-client && \
  apt-get -y install redis && \
  apt-get -y install vim

CMD ["tail", "-f", "/dev/null"]
