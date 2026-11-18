FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:0a5fd8106cad4a146c6ffc791f9aae80cba14e9b226c9786bb5100c6a002854c

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
