FROM ghcr.io/astral-sh/uv:python3.11-trixie@sha256:736115e0bc99dcfa4cc88ac4300bea5d392823301642041ba3698cd37cc6f040

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
