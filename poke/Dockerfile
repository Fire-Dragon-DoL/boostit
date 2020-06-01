FROM node:14.3.0-stretch AS node_deps

WORKDIR /app
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN yarn global add serve

# --------------------------------------------------

FROM node_deps AS poke

WORKDIR /app

ARG boom_url='http://localhost:3001/v1'
ENV REACT_APP_BOOM_URL="${boom_url}"
EXPOSE 3002
CMD ["serve", "-p", "3002", "-s", "./build"]

COPY package.json package.json
COPY yarn.lock yarn.lock
RUN yarn install

COPY . .

RUN yarn run build
