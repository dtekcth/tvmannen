FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:db2aa604ff09462e8bbdf02975fcbbc8c838ce8c82d24c7a0c67cb6385a471ba

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
