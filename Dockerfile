FROM node:20-alpine AS builder
WORKDIR /app
COPY app/package.json app/pnpm-lock.yaml ./
RUN npm install -g pnpm && pnpm install --no-frozen-lockfile
COPY app/ .
RUN NODE_OPTIONS=--max_old_space_size=4096 pnpm run build

FROM nginx:stable-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN addgroup -S appgroup && adduser -S appuser -G appgroup \
    && mkdir -p /var/cache/nginx /var/run \
    && chown -R appuser:appgroup /var/cache/nginx /var/run /etc/nginx/conf.d /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]