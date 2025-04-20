# Stage 1: Build React App
FROM node:20-slim AS builder

WORKDIR /app
COPY . .
RUN npm ci && npm run build

# Stage 2: Serve with NGINX
FROM nginx:1.27-alpine

COPY --from=builder /app/build /usr/share/nginx/html
