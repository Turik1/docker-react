FROM node:10.15.3-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Output is going to be the "build" folder
# /app/build is the folder that we want to copy in the run phase


# new FROM statements terminate the previous FROM statements
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# default command starts the nginx-server, don't have to specify it