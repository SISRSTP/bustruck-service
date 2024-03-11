#Production Dockerfile
FROM node:lts as build

# Create app directory and copy package.json and package-lock.json
WORKDIR /app
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy app source code
COPY . .

#Check if node_modules are installed and then run the app
CMD [ -d "node_modules" ] && npm run start:prod || npm install && npm run start:prod