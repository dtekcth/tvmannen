FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:9bd1baabe5533289d202e432b1b1e2c924dbf269bec3dcccb57c06e2e76ba979

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
