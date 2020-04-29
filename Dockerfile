FROM python:3.7.7-alpine3.11
RUN apk update && apk upgrade && \
	apk add make gcc g++ && \
	python -m pip install mutagen
WORKDIR /work
