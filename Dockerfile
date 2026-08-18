FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:c829c05dfa59bf76e511649cad663998edc71c65b0c8ac3d7281039a0c4ba1d3

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
