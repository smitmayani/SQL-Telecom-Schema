-- Database Schema Implementation

-- Create the database
CREATE DATABASE telecom_provider;
USE telecom_provider;

-- CUSTOMER table
CREATE TABLE CUSTOMER (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL UNIQUE,
    Email VARCHAR(100) UNIQUE,
    JoinDate DATE NOT NULL,
    CustomerType ENUM('Individual', 'Business') NOT NULL,
    CreditRating INT CHECK (CreditRating BETWEEN 300 AND 850)
);

-- SERVICE_PLAN table
CREATE TABLE SERVICE_PLAN (
    PlanID INT AUTO_INCREMENT PRIMARY KEY,
    PlanName VARCHAR(50) NOT NULL,
    MonthlyPrice DECIMAL(10, 2) NOT NULL,
    DataLimitGB INT NOT NULL,
    CallLimitMins INT NOT NULL,
    SMSLimit INT NOT NULL,
    RoamingPolicy VARCHAR(100),
    ThrottleSpeed VARCHAR(50)
);

-- SUBSCRIPTION table
CREATE TABLE SUBSCRIPTION (
    SubscriptionID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    PlanID INT NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL UNIQUE,
    IMEI VARCHAR(20),
    SIMNumber VARCHAR(20) UNIQUE,
    StartDate DATE NOT NULL,
    EndDate DATE,
    Status ENUM('Active', 'Suspended', 'Terminated') NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
    FOREIGN KEY (PlanID) REFERENCES SERVICE_PLAN(PlanID)
);

-- NETWORK_ELEMENT table
CREATE TABLE NETWORK_ELEMENT (
    ElementID INT AUTO_INCREMENT PRIMARY KEY,
    TowerID VARCHAR(20) NOT NULL,
    Type ENUM('Cell Tower', 'Switch', 'Router', 'Base Station') NOT NULL,
    Location VARCHAR(200) NOT NULL,
    CallCapacity INT,
    DataCapacity DECIMAL(10, 2),
    Technology VARCHAR(50)
);

-- DATA_USAGE table
CREATE TABLE DATA_USAGE (
    DataID INT AUTO_INCREMENT PRIMARY KEY,
    SubscriptionID INT NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL,
    DataUsedMB DECIMAL(10, 2) NOT NULL,
    NetworkType VARCHAR(20) NOT NULL,
    TowerID VARCHAR(20) NOT NULL,
    FOREIGN KEY (SubscriptionID) REFERENCES SUBSCRIPTION(SubscriptionID)
);

-- CALL_RECORD table
CREATE TABLE CALL_RECORD (
    CallID INT AUTO_INCREMENT PRIMARY KEY,
    SubscriptionID INT NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL,
    CallType ENUM('Voice', 'Video') NOT NULL,
    Direction ENUM('Incoming', 'Outgoing') NOT NULL,
    TowerID VARCHAR(20) NOT NULL,
    FOREIGN KEY (SubscriptionID) REFERENCES SUBSCRIPTION(SubscriptionID)
);

-- SMS_RECORD table
CREATE TABLE SMS_RECORD (
    SMSID INT AUTO_INCREMENT PRIMARY KEY,
    SubscriptionID INT NOT NULL,
    Timestamp DATETIME NOT NULL,
    Recipient VARCHAR(20) NOT NULL,
    Status ENUM('Delivered', 'Failed', 'Pending') NOT NULL,
    Direction ENUM('Incoming', 'Outgoing') NOT NULL,
    TowerID VARCHAR(20) NOT NULL,
    FOREIGN KEY (SubscriptionID) REFERENCES SUBSCRIPTION(SubscriptionID)
);

-- BILL table
CREATE TABLE BILL (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    SubscriptionID INT NOT NULL,
    PeriodStart DATE NOT NULL,
    PeriodEnd DATE NOT NULL,
    DueDate DATE NOT NULL,
    PaidAmount DECIMAL(10, 2) DEFAULT 0.00,
    Status ENUM('Paid', 'Unpaid', 'Overdue') NOT NULL DEFAULT 'Unpaid',
    FOREIGN KEY (SubscriptionID) REFERENCES SUBSCRIPTION(SubscriptionID)
);

-- SUPPORT_TICKET table
CREATE TABLE SUPPORT_TICKET (
    TicketID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    IssueType VARCHAR(50) NOT NULL,
    OpenDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Priority ENUM('Low', 'Medium', 'High', 'Critical') NOT NULL,
    Status ENUM('Open', 'In Progress', 'Resolved', 'Closed') NOT NULL DEFAULT 'Open',
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)
);
