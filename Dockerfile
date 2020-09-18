ARG http_proxy
ARG https_proxy

FROM alpine

ENV http_proxy=$http_proxy
ENV https_proxy=$https_proxy

WORKDIR /workspace
RUN apk add nodejs npm git
RUN git clone https://github.com/obara13/ocr-test.git
WORKDIR /workspace/ocr-test/
RUN npm install

EXPOSE 8080

CMD npm run serve
