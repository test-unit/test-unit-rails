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
    bc \
    chromium-driver \
    chromium-sandbox \
    nodejs \
    yarnpkg && \
  ln -s yarnpkg /usr/bin/yarn && \
  apt clean && \
  rm -rf /var/lib/apt/lists/*

ARG RAILS_VERSION

# Ruby 2.4's bundled rubygems is too old that it fails to install rails
RUN if ruby -v | grep -qF 'ruby 2.4.'; then gem update --system 3.3.26; fi
RUN gem install rails -v "~>${RAILS_VERSION}.0"

ENV RAILS_VERSION ${RAILS_VERSION}

CMD /source/test/test_app.sh
