FROM alpine
WORKDIR /project
COPY . .
RUN apk add --no-cache bash


