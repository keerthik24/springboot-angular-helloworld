# Stage 1: Build Angular frontend
FROM node:latest AS angular-build
WORKDIR /app
COPY frontend/ ./frontend/
WORKDIR /app/frontend
RUN npm install
RUN npm run build

# Stage 2: Build Spring Boot backend
FROM maven:latest AS spring-boot-build
WORKDIR /app
COPY backend/ ./backend/
WORKDIR /app/backend
RUN mvn clean package

# Stage 3: Combine Angular frontend and Spring Boot backend into a single container
FROM openjdk:latest
WORKDIR /app
COPY --from=angular-build /app/frontend/dist/ ./frontend/dist/
COPY --from=spring-boot-build /app/backend/target/*.jar ./backend/
EXPOSE 8080
CMD ["java", "-jar", "./backend/*.jar"]
