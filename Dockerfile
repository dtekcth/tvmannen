FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:c2011b544697b56b1d305d99b4a85a7bc2920c0b3b9d7d5c0d5a174edfd34d3a

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
