# BASE IMAGE
FROM node:alpine as builder

# DEPENDENCIES
WORKDIR '/app/'

COPY package.json .
RUN npm install

COPY . .

# CMD!
RUN npm run build

# /app/build <= inside of the builder containers

# Multi step builds
# `nginx` hosting static files
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html