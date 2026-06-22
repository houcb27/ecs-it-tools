FROM node:lts-alpine AS builder
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN npm install -g pnpm && pnpm i --frozen-lockfile
COPY . .
RUN pnpm run build 

FROM nginx:stable-alpine 
COPY --from=builder /app/dist /usr/share/nginx/html
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER app
EXPOSE 80
