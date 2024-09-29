# Stage 1: Build Frontend
FROM node:14 AS frontend

# Set the working directory for the frontend
WORKDIR /app/frontend

# Copy package.json and package-lock.json for frontend
COPY front_end/package*.json ./

# Install frontend dependencies
RUN npm install

# Copy the rest of the frontend application code
COPY front_end ./

# Build the frontend application
RUN npm run build

# Stage 2: Build Backend
FROM your-backend-base-image AS backend

# Set the working directory for the backend
WORKDIR /app/backend

# Copy necessary files for the backend
COPY backend/ .  # Adjust if you have specific files to copy

# Optionally copy the built frontend files to the backend
COPY --from=frontend /app/frontend/build ./frontend  # Adjust path as needed

# Install backend dependencies
RUN your-backend-setup-commands  # Add any commands needed to set up the backend

# Specify how to run your backend application
CMD ["npm", "start"]
