FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:22aab28b086f0b947d4ac89fd17a7ed4d3d9c61771e4e79ae10b9d6dbd48a9c8

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
