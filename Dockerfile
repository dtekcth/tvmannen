FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:de7e00c5c9721a201f39adac03d23b36904c6765918ee893f9e27a9a8d2aaaed

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
