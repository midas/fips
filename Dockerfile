# Build ##################################################################################

FROM midas/elixir-phoenix-dev:centos8-erl23.3.4.19-ex1.13.4 AS build
ARG env
ARG rel_name

RUN mkdir /app
WORKDIR /app

# Deps
RUN echo -e "\033[0;32mBuilding Dependencies\033[0m"
RUN mix local.hex --force && \
    mix local.rebar --force
ENV MIX_ENV=$env

COPY mix.exs mix.lock ./
#COPY config/config.exs config/${MIX_ENV}.exs config/
RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile

# Compilation
COPY lib lib

RUN mix compile

# Release
COPY rel rel
RUN mix release $rel_name


# Release artifact #######################################################################

#FROM quay.io/centos/centos:stream
FROM iberonllc/centos8:release-base AS app
ARG env
ARG rel_name
RUN echo $rel_name

#RUN dnf update -y
#RUN dnf install wget ca-certificates tar xz expat ncurses-libs openssl bash -y
#RUN wget "https://archive.archlinux.org/packages/m/mono/mono-5.18.0.240-1-x86_64.pkg.tar.xz" -O "/tmp/mono.pkg.tar.xz"
#RUN tar -xJf "/tmp/mono.pkg.tar.xz"
#RUN cert-sync /etc/ssl/certs/ca-bundle.crt
#RUN rm /tmp/*

RUN mkdir /app
WORKDIR /app

ENV MIX_ENV=$env

COPY --from=build /app/_build/$env/rel/$rel_name ./

RUN chown -R nobody: /app
USER nobody
ENV HOME=/app
CMD ["/app/bin/fips", "start"]
#CMD ["/bin/bash"]
