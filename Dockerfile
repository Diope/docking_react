# Build
FROM node:14.17-alpine as build
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH

COPY package.json ./
RUN npm install --silent

RUN npm install react-scripts@4.0.3 -g --silent

COPY . ./

RUN npm run build

# ------ production

FROM nginx:stable-alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]