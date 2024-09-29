# Base image for frontend
FROM node:14 AS frontend-build

# Set working directory for frontend
WORKDIR /app/frontend

# Copy frontend package.json and package-lock.json
COPY front_end/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the frontend files
COPY front_end/ .

# Build the frontend (if you have a build command)
RUN npm run build

# Base image for backend
FROM node:14 AS backend-build

# Set working directory for backend
WORKDIR /app/backend

# Copy backend package.json and package-lock.json
COPY backend/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the backend files
COPY backend/ .

# Build the backend (if you have a build command)
# RUN npm run build (if needed)

# Final stage to run both applications
FROM node:14

# Copy built frontend and backend from previous stages
COPY --from=frontend-build /app/frontend/build /app/frontend/build
COPY --from=backend-build /app/backend /app/backend

# Set working directory for running the applications
WORKDIR /app

# Expose ports (if needed, adjust based on your app's configuration)
EXPOSE 3000 # For frontend
EXPOSE 5000 # For backend

# Start command (adjust based on your app's structure)
CMD ["node", "backend/server.js"] # Assuming the backend starts with server.js
