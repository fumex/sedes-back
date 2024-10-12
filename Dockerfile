FROM node:18-alpine3.18

# Instalar las dependencias necesarias para compilar sharp
RUN apk add --no-cache \
  build-base \
  gcc \
  zlib-dev \
  libpng-dev \
  vips-dev \
  python3 \
  g++ \
  make \
  libc6-compat

WORKDIR /opt/app
COPY package.json package-lock.json ./

# Forzar la instalación de sharp para la arquitectura linuxmusl
RUN npm install --platform=linuxmusl --arch=x64 sharp

# Instalar las demás dependencias del proyecto
RUN npm install

COPY . .
EXPOSE 1337
CMD ["npm", "run", "develop"]
