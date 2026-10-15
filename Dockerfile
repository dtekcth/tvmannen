FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:ef1c5b72f752f04443067471ac5d292ef19ad01990888b13351798dfb705e92d

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
