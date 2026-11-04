FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:be23e58d8bebb2a6dc1e4a600173fa6e1c6ad7717519df728c1f62ad0544ca64

RUN mkdir /src
WORKDIR /src

COPY uv.lock /src
COPY pyproject.toml /src
RUN uv sync
COPY src /src/

ENV SECRET_KEY verysecretXd
ENV PORT 4001
EXPOSE $PORT

CMD uv run uwsgi --enable-threads --http-socket :$PORT --module tv:app
