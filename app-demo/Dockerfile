# 1. Partimos de la imagen oficial de Node.js (LTS)
FROM node:18-alpine

# 2. Creamos el directorio de trabajo dentro del contenedor
WORKDIR /usr/src/app

# 3. Copiamos solo package.json y package-lock.json (si existe) para aprovechar cache de Docker
COPY package.json package-lock.json* ./

# 4. Instalamos solamente dependencias de producción
RUN npm install --production

# 5. Copiamos el resto del código fuente
COPY . .

# 6. Exponemos el puerto en que escuchará Express
EXPOSE 8080

# 7. Comando que se ejecuta por defecto al iniciar el contenedor
CMD ["npm", "start"]
