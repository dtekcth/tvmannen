FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:bfdd41785fbe2997ea3662c780a9d818422a705c334c2ebfc9f1464ad668bb2d

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
