# Use the Node.js Alpine image
FROM node:lts-alpine

# Set the NODE_ENV to production
ENV NODE_ENV=production

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json files for dependency installation
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]

# Install only production dependencies
RUN npm install --production --silent

# Copy the application files
COPY . .

# Adjust permissions for the node user
RUN chown -R node /usr/src/app

# Switch to the node user
USER node

# Expose the application port
EXPOSE 8000

# Start the application
CMD ["node", "main.js"]
