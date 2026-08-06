FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:729e2d68f73add0263ce1ea17b99a4a960832f04e1bd4de4e523fd6276ab4226

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
