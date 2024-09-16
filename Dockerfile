ARG ELIXIR_VERSION=1.17.2
FROM elixir:$ELIXIR_VERSION as base
##############################################################################
FROM base as build

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    locales \
    inotify-tools && \
    apt-get clean && \
    update-locale LANG=C.UTF-8 LC_ALL=C.UTF-8
##############################################################################
FROM build as final

WORKDIR /app

RUN mix local.hex --force && \
    mix archive.install hex phx_new --force && \
    mix local.rebar --force

COPY . .

CMD [ "bash" ]
