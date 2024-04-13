# Build ##################################################################################

FROM elixir:1.14.5-otp-24-alpine AS build
ARG env
ARG rel_name
RUN apk add --no-cache --update build-base git npm
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

FROM alpine:3.17 AS app
ARG env
ARG rel_name
RUN echo $rel_name
RUN apk upgrade --no-cache && \
    apk add --no-cache bash openssl libgcc libstdc++ ncurses-libs
RUN mkdir /app
WORKDIR /app

ENV MIX_ENV=$env

COPY --from=build /app/_build/$env/rel/$rel_name ./

RUN chown -R nobody: /app
USER nobody
ENV HOME=/app
CMD ["/app/bin/fips", "start"]
