# Build Stage
# Multi-platform images
FROM --platform=$BUILDPLATFORM node:20-alpine as builder

RUN mkdir /project
WORKDIR /project

# 构建缓存
COPY package.json package-lock.json ./
RUN npm ci

COPY . .
CMD ["npm", "run", "build"]

# Stage 2
FROM nginx:stable-alpine-perl

COPY --from=builder /project/dist/k8s_angular_demo/browser /usr/share/nginx/html

EXPOSE 80
