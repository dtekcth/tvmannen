FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:5fe5e9be67ebe7adefc96369ebc4f3f1e8f3bacf87d0727b31ad9ce852fd8208

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
