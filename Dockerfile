# Dockerfile
# Use an official Node.js runtime as the base image
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the TypeScript code
RUN npm run build

# Expose the port the app runs on
EXPOSE 5000

# Set environment variables
ENV NODE_ENV production

# very basic healtcheck using wget
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --start-interval=15s --retries=3 CMD wget --no-verbose --tries=1 --spider http://localhost:5000/up || exit 1

# Command to run the application
CMD ["npm", "start"]
