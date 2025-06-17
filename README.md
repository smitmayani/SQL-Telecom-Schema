# SQL-Telecom-Schema
This repository contains the SQL schema, sample data, and various analytical queries for a simplified Telecom Database Management System. It also includes Entity-Relationship (ER) diagrams illustrating the database structure.

## Table of Contents

- [Project Overview](#project-overview)
- [Database Schema](#database-schema)
- [Sample Data](#sample-data)
- [Queries](#queries)
  - [Basic Queries](#basic-queries)
  - [Complex Queries](#complex-queries)
- [ER Diagrams](#er-diagrams)
- [Getting Started](#getting-started)
- [Technologies Used](#technologies-used)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Project Overview

This project aims to demonstrate the design and implementation of a relational database for a telecommunications provider. It covers core entities such as customers, service plans, subscriptions, network elements, and usage records (data, calls, SMS), along with billing and support functionalities. The included SQL scripts allow for database creation, population with sample data, and execution of various analytical and reporting queries.

## Database Schema

The `Database Implementation.sql` file contains the SQL Data Definition Language (DDL) scripts to create the entire database schema. The database is named `telecom_provider` and consists of the following tables:

- **CUSTOMER**: Stores information about individual and business customers.
- **SERVICE_PLAN**: Defines different mobile service plans with their pricing and limits.
- **SUBSCRIPTION**: Links customers to their service plans and manages subscription details.
- **NETWORK_ELEMENT**: Contains details about network infrastructure like cell towers, switches, and routers.
- **DATA_USAGE**: Records detailed data consumption events for each subscription.
- **CALL_RECORD**: Stores information about voice and video calls made or received.
- **SMS_RECORD**: Logs all SMS messages, including direction and status.
- **BILL**: Manages billing cycles and payment status for subscriptions.
- **SUPPORT_TICKET**: Tracks customer support inquiries.

## Sample Data

The `Sample Data.sql` file provides SQL `INSERT` statements to populate all tables with realistic sample data. This data is essential for testing the queries and understanding the database's functionality.

## Queries

Two sets of queries are provided:

### Basic Queries

The `Basic Queries.sql` file contains fundamental SQL queries for common reporting and data retrieval tasks. Examples include:

- Retrieving full customer information with active subscription details.
- Analyzing monthly data usage per customer.
- Total outgoing SMS per customer.
- Detailed billing history for a specific customer.
- Identifying high-value customers based on spending.
- Call pattern analysis: average call duration per type.
- Data usage load by tower and network type.
- Subscriptions with overdue or unpaid bills.
- Customers with open high-priority support tickets.

### Complex Queries

The `Complex Queries.sql` file contains more advanced SQL queries that often involve multiple joins, subqueries, and aggregations to provide deeper insights. Examples include:

- Calculating detailed monthly bills, including overages for data, calls, and SMS.
- Analyzing calling patterns: identifying the most frequently used tower per customer.
- Identifying high-value customers by total data and call usage.
- Determining the top 2 towers by total data transferred in a specific period.



## Technologies Used

-   **Database:** MySQL
-   **Language:** SQL
-   **ER Diagramming:** MySQL Workbench

## Contributing

Feel free to fork this repository, submit pull requests, or open issues if you have suggestions, improvements, or find any bugs.

## License

This project is open-sourced under the MIT License. See the `LICENSE` file for more details. (You might need to create a `LICENSE` file if you want to explicitly state a license).

## Contact

If you have any questions or feedback, please feel free to reach out.

---
