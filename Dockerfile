# Use the official Flutter Docker image as the base image
FROM cirrusci/flutter:stable

# Set the working directory
WORKDIR /app

# Copy the Flutter web app files to the container
COPY . /app

# Build the Flutter web app
RUN flutter build web --release

# Use the official Nginx Docker image as the base image for serving static files
FROM nginx:latest

# Remove the default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy the Nginx configuration file to the container
COPY nginx.conf /etc/nginx/conf.d/

# Copy the built Flutter web app files to the Nginx web root directory
COPY --from=0 /app/build/web /usr/share/nginx/html

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
