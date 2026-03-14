FROM node:20-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install curl first and fix any dpkg issues
RUN apt-get update && \
    apt-get install -y --fix-missing curl && \
    dpkg --configure -a && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

# Add health check after curl is installed
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/ || exit 1

CMD ["npm", "start"]