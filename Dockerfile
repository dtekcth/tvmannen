FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:d1df4f51a3351691af7b1a887c287070cd387d32c08cdfc46a448ba08a2c0cc2

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
