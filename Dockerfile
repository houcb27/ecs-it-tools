FROM node:lts-alpine AS builder
ENV NPM_CONFIG_LOGLEVEL warn
ENV CI true
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN npm install -g pnpm && pnpm i --frozen-lockfile
COPY . .
RUN pnpm run build 

FROM nginx:stable-alpine 
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]