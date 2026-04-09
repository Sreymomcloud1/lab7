# Use a lightweight base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy dependencies first (for caching)
COPY package*.json ./
RUN npm install

# Copy the rest of the code
COPY . .

# Expose the FoodExpress port
EXPOSE 3000

CMD ["npm", "start"]
