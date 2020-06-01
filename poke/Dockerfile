FROM node:14.3.0-stretch AS node_deps

WORKDIR /app
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# --------------------------------------------------

FROM node_deps AS poke

WORKDIR /app

ARG app_env=development
ENV NODE_ENV=$app_env
EXPOSE 3002
ENTRYPOINT ["yarn"]
CMD ["start"]

COPY package.json package.json
COPY yarn.lock yarn.lock
RUN yarn install

COPY . .
