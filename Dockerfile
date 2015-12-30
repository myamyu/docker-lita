FROM ruby:2.2
MAINTAINER myamyutamago<myamyu@quwtara.space>

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git && \
    apt-get clean all

RUN mkdir -p /opt/lita/bundle && \
    useradd -d /opt/lita lita -G staff && \
    chown -R -v lita:staff /opt/lita

USER lita

ENV GEM_HOME /opt/lita/bundle
RUN gem install bundler

WORKDIR /opt/lita
VOLUME /opt/lita
COPY ./bot.bash /opt/lita/bot.bash

CMD ["/opt/lita/bot.bash"]
