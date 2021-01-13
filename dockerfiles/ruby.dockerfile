ARG FROM
FROM ${FROM}

RUN \
  echo "debconf debconf/frontend select Noninteractive" | \
    debconf-set-selections

RUN \
  echo 'APT::Install-Recommends "false";' > \
    /etc/apt/apt.conf.d/disable-install-recommends

RUN \
  apt update && \
  apt install -y -V \
    chromium-driver \
    chromium-sandbox \
    nodejs \
    yarnpkg && \
  ln -s yarnpkg /usr/bin/yarn && \
  apt clean && \
  rm -rf /var/lib/apt/lists/*

ARG RAILS_VERSION
RUN gem install rails -v "~>${RAILS_VERSION}"

CMD /source/test/test_app.sh
