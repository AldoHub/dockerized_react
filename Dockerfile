#--- SIMPLE NPM BUILD implementation
#use node alpine (for smaller size)
#FROM node:18-alpine
#set the working directory to /app inside container
#WORKDIR /app
#COPY . .
#Install dependencies
#RUN npm ci
#Build the app
#RUN npm run build
#set the env to production
#ENV NODE_ENV production
#Expose the default port 3000
#EXPOSE 3000
#start the app
#CMD ["npm", "start", "build"]

#--- use the next commands to run the docker process using the dockerfile
#docker build . -t <docker-app-tag>
#docker images | grep <docker-app-tag>
#docker run -p 3000:3000 -d <docker-app-tag> 



#--- NGINX implementation
#--- the docker implementation will only have the build folder instead of all the app
FROM node:18-alpine as builder
WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build

#--- bundle static assets with nginx
FROM nginx:1.25.1-alpine as production
ENV NODE_ENV production
#copy build assets from 'builder' image
COPY --from=builder /app/build /usr/share/nginx/html
#add custom nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
#expose port
EXPOSE 80
#start nginx
CMD ["nginx", "-g", "daemon off;"]

#--- use the next commands to run the docker process using the dockerfile
#docker build . -t <docker-app-tag>
#map the Nginx port 80 inside the container to the 3000 on the host machine
#docker run -p 3000:80 -d <docker-app-tag>