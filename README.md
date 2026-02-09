To set up and run the **Asset Management System**, follow the instructions below. This project is a Java-based application that uses **Maven** for dependency management.

# README.md

## Project Overview

The Asset Management System is a Java application designed to track and manage organizational assets. It follows a standard Maven project structure with source code in `src/main/java`, configuration resources in `src/main/resources`, and web components in `src/main/webapp`.

## Prerequisites

Before you begin, ensure you have the following installed on your local machine:

* **Java Development Kit (JDK):** Version 8 or 17 is recommended.
* **Apache Maven:** For building the project and managing dependencies.
* **Integrated Development Environment (IDE):** IntelliJ IDEA, Eclipse, or VS Code.
* **Database:** A relational database management system (likely MySQL based on standard Java web app configurations).

## Setup and Installation

### 1. Extract the Project

Download and extract the `AssetManagemntSystem.rar` file to your desired local directory.

### 2. Database Configuration

1. Open your database management tool (e.g., MySQL Workbench).
2. Create a new database for the project:
```sql
CREATE DATABASE asset_management;

```


3. Locate the configuration file: `src/main/resources/application.properties`.
4. Update the database connection details to match your local environment:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/asset_management
spring.datasource.username=YOUR_USERNAME
spring.datasource.password=YOUR_PASSWORD

```



### 3. Build the Project

Open a terminal in the project root directory and run the following command to download dependencies and build the application:

```bash
mvn clean install

```

### 4. Running the Application

* **Using Maven:**
```bash
mvn spring-boot:run

```


* **Using an IDE:**
1. Import the project as a **Maven Project**.
2. Locate the main class (usually named `AssetManagementApplication.java` or similar) within `src/main/java`.
3. Right-click the file and select **Run As > Java Application**.



## Project Structure

* **`src/main/java`**: Contains the backend logic (Controllers, Services, Models).
* **`src/main/resources`**: Contains static configurations and application properties.
* **`src/main/webapp`**: Contains frontend assets (HTML, JSP, CSS, JS).
* **`pom.xml`**: The Maven configuration file defining dependencies.

## Troubleshooting

* **Port Conflict:** If port `8080` is already in use, change the port in `application.properties` by adding `server.port=9090`.
* **Dependency Issues:** If the build fails, try running `mvn clean install -U` to force an update of the dependencies.
* **Database Connection:** Ensure your database server is running and the credentials in `application.properties` are correct.
