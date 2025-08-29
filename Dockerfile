# Use Node 18 with Alpine
FROM node:18-alpine

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your project files
COPY . .

# Expose port (default React port is 5173)
EXPOSE 3000

# Start the React development server
CMD ["npm", "start"]
