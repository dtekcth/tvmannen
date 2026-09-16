FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:2af4886919f346130fd08c35825b6a724697687ea3ccf7ded0562fa13e4bc169

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
