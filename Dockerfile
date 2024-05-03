COPY frontend/ ./frontend/
WORKDIR /app/frontend
RUN npm install
RUN npm run build

# Stage 2: Build Spring Boot backend
FROM maven:latest
WORKDIR /app
COPY backend/ ./backend/
WORKDIR /app/backend
RUN mvn clean package

# Stage 3: Combine Angular frontend and Spring Boot backend into a single container
FROM openjdk:latest
WORKDIR /app
COPY . .
EXPOSE 8081
CMD ["java", "-jar", "/app/backend/your-spring-boot-app.jar"]
