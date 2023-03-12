FROM node:18-alpine as build
WORKDIR /app

RUN apk add --no-cache curl && \
    curl -fsSL "https://github.com/pnpm/pnpm/releases/latest/download/pnpm-linuxstatic-x64" -o /bin/pnpm; chmod +x /bin/pnpm

COPY pnpm-lock.yaml ./
RUN pnpm fetch

COPY . ./
RUN pnpm install --offline

RUN pnpm build
RUN pnpm prune --prod

FROM node:18-alpine
WORKDIR /app
EXPOSE 3000
ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=3000

COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/build ./build
COPY --from=build /app/package.json ./

CMD ["node", "build"]