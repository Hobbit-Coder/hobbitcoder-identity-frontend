FROM node:lts-alpine AS build
WORKDIR /app
COPY . /app/
ARG configuration=production
RUN npm cache clean --force
RUN npm ci
RUN npm run build --configuration=${configuration}

FROM nginx:alpine
COPY --from=build /app/dist/hobbitcoder-identity-frontend/browser /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
EXPOSE 443

#docker build . -t hobbitcoder-identity-frontend-image:0.0.1 --build-arg configuration="production"
#docker run -d --name hobbitcoder-identity-frontend-app -p 8080:80 hobbitcoder-identity-frontend-image:0.0.1
