FROM python:3.11

RUN mkdir /src

RUN apt-get clean \
    && apt-get -y update

WORKDIR /src
COPY requirements.txt /src
RUN pip install -r requirements.txt
COPY src /src/

ENV SECRET_KEY verysecretXd
ENV PORT 4001
EXPOSE $PORT

CMD uwsgi --enable-threads --http-socket :$PORT --module tv:app
