FROM ruby:2.2
MAINTAINER myamyutamago<myamyu@quwtara.space>

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git && \
    apt-get clean all
RUN gem install lita && \
    gem install bundler

RUN mkdir /opt/lita && \
    useradd -d /opt/lita lita && \
    chown lita:lita /opt/lita

USER lita
WORKDIR /opt/lita
VOLUME /opt/lita

COPY ./bot.bash /opt/lita/bot.bash

CMD ["/opt/lita/bot.bash"]
