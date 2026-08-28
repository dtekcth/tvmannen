FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:e40421a6f5661e968d75f21c727321c9ae49c1c24e09ad708ae06248e4c48427

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
