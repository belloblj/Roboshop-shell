# Roboshop-shell
This project is built with docs from
#### https://github.com/learndevopsonline/learndevopsonline

#### https://learndevopsonline.github.io/learndevopsonline/build/docs/RoboShop-Project/catalogue/

The project is based on Shell Scripting hence the name Roboshop-shell.

#### IDE used: IntelliJ IDEA Community version
#### Linux Username & Password : centos / DevOps321
#### Linux Version: CentOS8
#### Cloud Service: AWS EC2 Free tier

# Project Overview
This is an e-commerce webp service used to shop for robots.
The project is built on DevOps and Agile principles with the use of microservices approach.

Project is having the following components / microservices.
#### Frontend
    Static landing page

#### MongoDB
    Database management of choice

#### Catalogue
    Serving the list of items that displays in roboshop application (NodeJS is used here)

#### Redis
    For in-memory data storage(Caching) and allows users to access the data of database over API.

#### User
    User Logins and Registrations Service (NodeJS is used here)

#### Cart
    Shopping Cart service is also managed with the use of NodeJS

#### MySQL
    Database management

#### Shipping
    - For finding the distance of the package to be shipped and calculate the price based on that.Shipping service is written in Java

#### RabbitMQ 
    - a messaging Queue which is used by some components of the applications.

#### Payment 
    - for payments in RoboShop e-commerce app. This service is written on Python 3.6

#### Dispatch
    - the service which dispatches the product after purchase. It is written in GoLang.
