FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --production --no-cache

COPY . .

EXPOSE 3000

CMD ["npm", "start"]