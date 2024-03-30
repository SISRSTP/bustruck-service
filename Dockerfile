#Production Dockerfile
FROM node:lts as build

# Create app directory and copy package.json and package-lock.json
WORKDIR /app
COPY package*.json ./

#Sync package.json and package-lock.json
RUN npm install --only=production --omit=dev

# Install app dependencies and clean cache
RUN npm ci --only=production --omit=dev && npm cache clean --force 

# Set the environment to production
ENV NODE_ENV production

# Copy app source code
COPY . .

#Check if node_modules are installed and then run the app
CMD [ -d "node_modules" ]  && npm run build && npm run start:prod || npm ci && npm run start:prod