FROM node:14-alpine as build
WORKDIR /finalproject
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=build /finalproject/build .
EXPOSE 80
CMD ["nginx", "-g","daemon off;"]
