# --------- BUILD STAGE ----------
    
    
FROM node:20-alpine AS build

# Set Working Directory 

WORKDIR /app

# Install dependencies

COPY package*.json ./

RUN npm ci 

# Copy Source 

COPY . . 

# Build Vue app 

RUN npm run build 


# ------- Production Stage --------

FROM nginx:stable-alpine

#REMOVE DEFAULT NGINX CONFIG 

RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx config 

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy build files from previous stage 

COPY --from=build /app/dist /usr/share/nginx/html 

# Expose Port 

EXPOSE 80 

# Run nginx 

CMD ["nginx", "-g", "daemon off;"]