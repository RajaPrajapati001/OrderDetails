# Use Node 18 with Alpine
FROM node:18-alpine

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json first
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the project
COPY . .

# Expose port (agar aapka backend 3000 pe run hota hai)
EXPOSE 3000

# Start the server
CMD ["node", "app.js"]
