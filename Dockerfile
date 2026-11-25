FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:3662478808dac994df3d08ddff3468e834d17da850c743724b7d04d94ea61389

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
