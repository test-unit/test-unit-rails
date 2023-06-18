FROM ruby:2.3

RUN \
  echo "debconf debconf/frontend select Noninteractive" | \
    debconf-set-selections

RUN \
  echo 'APT::Install-Recommends "false";' > \
    /etc/apt/apt.conf.d/disable-install-recommends

# Fetch packages from archive because ruby2.3 image is based on Debian stretch
RUN \
  echo "deb http://archive.debian.org/debian stretch main" > \
    /etc/apt/sources.list

RUN \
  apt update && \
  apt upgrade -y && \
  apt install -y -V \
    bc \
    chromium-driver \
    chromium \
    nodejs \
    yarn && \
  apt clean && \
  rm -rf /var/lib/apt/lists/*

ARG RAILS_VERSION

# Ruby 2.3's bundled rubygems is too old that it fails to install rails
RUN gem update --system 3.3.26
RUN gem install rails -v "~>${RAILS_VERSION}.0"

ENV RAILS_VERSION ${RAILS_VERSION}

CMD /source/test/test_app.sh
