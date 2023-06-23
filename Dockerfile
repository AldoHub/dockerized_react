#use node alpine (for smaller size)
FROM node:18-alpine
#set the working directory to /app inside container
WORKDIR /app
COPY . .
#Install dependencies
RUN npm ci
#Build the app
RUN npm run build
#set the env to production
ENV NODE_ENV production
#Expose the default port 3000
EXPOSE 3000
#start the app
CMD ["npm", "start", "build"]


#--- use the next commands to run the docker process using the dockerfile
#docker build . -t <docker-app-tag>
#docker images | grep <docker-app-tag>
#docker run -p 3000:3000 -d <docker-app-tag> 
