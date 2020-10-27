# build stage
FROM node:10 as build-stage

LABEL maintainer=002097

# 创建一个工作目录
WORKDIR /app

# 拷贝所有的文件到工作目录下（非源码需要忽略的文件 .dockerignore 中配置）
COPY . .

RUN npm install --registry=https://registry.npm.taobao.org

RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage

COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 80

