FROM node AS build

WORKDIR /opt/ng
COPY package.json ./
COPY package-lock.json ./
RUN npm ci
RUN npm run ngcc
ENV PATH="./node_modules/.bin:$PATH" 

COPY . ./

RUN npm run ng build docker-for-angular --prod 

FROM nginx
COPY --from=build /opt/ng/dist/docker-for-angular /usr/share/nginx/html