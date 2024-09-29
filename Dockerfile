# Base image for frontend
FROM node:14 AS frontend-build

# Set working directory for frontend
WORKDIR /app/frontend

# Copy the frontend image files directly
COPY front_end/ ./

# If you have a build step, uncomment the next line
# RUN npm run build # Remove this if you don't need a build step

# Base image for backend
FROM node:14 AS backend-build

# Set working directory for backend
WORKDIR /app/backend

# Copy the backend image files directly
COPY backend/ ./

# If you have a build step, uncomment the next line
# RUN npm run build # Remove this if you don't need a build step

# Final stage to run both applications
FROM node:14

# Copy built frontend and backend from previous stages
COPY --from=frontend-build /app/frontend /app/frontend
COPY --from=backend-build /app/backend /app/backend

# Set working directory for running the applications
WORKDIR /app

# Expose ports (if needed, adjust based on your app's configuration)
EXPOSE   # Port for frontend
EXPOSE   # Port for backend

# Start command for both applications
# Assuming you have the frontend and backend starting commands; adjust as necessary
CMD ["node", "backend/server.js"]  # Adjust this to your backend start command
