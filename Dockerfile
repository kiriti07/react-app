FROM node:14-slim as build
WORKDIR /usr/src/app
COPY package*.json ./
#RUN [ ! -f package-lock.json ] && npm install || echo "package-lock.json exists"
RUN npm ci
COPY . .
RUN npm run build
FROM nginx:stable-alpine
COPY --from=build /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
