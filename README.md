# Cinephilia E-Commerce Platform

A REST-based e-commerce application for eco-friendly movie posters inspired by iconic films and independent artists.

The platform supports customer and administrator accounts, product management, shopping carts, wishlists, order processing, and user management through a collection of RESTful web services.

## Overview

Cinephilia is an online store specializing in eco-friendly decorative movie posters. The application was designed as a network-centric information system that automates the management of products, users, shopping carts, favorites, and customer orders.

The system supports two user roles:

- Customers
- Administrators

Each role has access to different functionalities through dedicated interfaces.

## Features

### Customer Features

- User registration
- User login/logout
- Profile management
- Product browsing
- Product search
- Shopping cart management
- Wishlist management
- Order checkout
- Account updates

### Administrator Features

- Product management
  - Add products
  - Update products
  - Delete products
- User management
  - View users
  - Update usernames
  - Delete user accounts
- Monitor platform activity

## Architecture

The application follows a RESTful architecture and uses web services to support communication between the user interfaces and the backend.

```text
Client (JSP Pages)
        │
        ▼
RESTful Web Services
        │
        ▼
MySQL Database
```

## Technologies Used

### Backend

- Java
- RESTful Web Services
- Jersey (JAX-RS)
- Apache Tomcat

### Frontend

- JSP
- HTML
- CSS
- JavaScript

### Database

- MySQL

## Database Design

Database:

```text
cinephilia
```

Main tables:

```text
users
products
favourites
carts
orders
```

These tables store:

- User information
- Product catalog
- Wishlist items
- Shopping carts
- Customer orders

## Implemented Web Services

The platform includes 25 web services and internal service operations.

Core functionalities include:

### Authentication

- Register
- Login
- Logout
- Delete Account
- Update User

### Product Operations

- Add Product
- Update Product
- Delete Product
- Search Products
- View Products

### Shopping Features

- Add To Cart
- Remove From Cart
- Add To Favourites
- Remove From Favourites
- Checkout

### Administration

- User Information Management
- User Count Reporting
- Product Management
- User Role Validation

## Project Structure

```text
.
├── README.md
├── database/
│   └── cinephilia.sql
├── docs/
│   └── technical_documentation.pdf
├── src/
│   └── cinephilia/web/services/
│       └── Cinephilia.java
├── assets/
└── WebContent/
    ├── cinephilia.css
    ├── cinephilia.js
    ├── CinephiliaHome.jsp
    ├── CinephiliaShop.jsp
    ├── CinephiliaSearch.jsp
    ├── CinephiliaCart.jsp
    ├── CinephiliaAccount.jsp
    ├── CinephiliaAdminHome.jsp
    ├── CinephiliaAdminProducts.jsp
    ├── CinephiliaAdminUsers.jsp
    ├── META-INF/
    └── WEB-INF/
```

## Running the Project

### Requirements

- Java 8+
- Apache Tomcat 9
- MySQL Server

### Database Setup

Create a database named:

```sql
CREATE DATABASE cinephilia;
```

Import the provided database dump:

```bash
mysql -u <username> -p cinephilia < cinephilia.sql
```

The SQL file can be found in:

```text
database/cinephilia.sql
```

## Documentation

Full technical documentation can be found [here](docs/technical_documentation.pdf)

The document contains:

- System analysis
- REST endpoint descriptions
- Database schema
- User guide
- Installation instructions
- Interface walkthroughs

## Learning Outcomes

- Java web development
- REST API design
- JSP-based applications
- MySQL database design
- User authentication
- E-commerce workflows
- CRUD operations
- Client-server architecture
- Network-centric information systems

## Academic Context

This project was completed as part of the Network-Centric Information Systems course during my BSc studies in Digital Systems at the University of Piraeus.
