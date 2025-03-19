CREATE DATABASE OnlineShoppingDB;
USE OnlineShoppingDB;

-- User Table: Stores user information
CREATE TABLE User (
    UserID INT PRIMARY KEY,  -- Unique identifier for each user
    Gender CHAR(1) NOT NULL CHECK (Gender IN ('M', 'F', 'O')),  -- Gender must be 'M' (Male), 'F' (Female), or 'O' (Other)
    FirstName VARCHAR(50) NOT NULL,  -- First name of the user (required)
    MiddleName VARCHAR(50),  -- Middle name (optional)
    LastName VARCHAR(50) NOT NULL,  -- Last name of the user (required)
    EmailAddress VARCHAR(255) UNIQUE NOT NULL,  -- Unique email address (required)
    EmailConfirmed TINYINT(1) DEFAULT 0,  -- Indicates whether the email is verified (default: FALSE)
    PhoneNumber CHAR(10) UNIQUE,  -- Unique 10-digit phone number (optional but must be valid)
    CONSTRAINT chk_phone_number CHECK (PhoneNumber REGEXP '^[0-9]{10}$')  -- Phone number must be 10 digits
);

-- Credential Table: Stores user authentication details
CREATE TABLE Credential (
    UserID INT PRIMARY KEY,  -- Links credentials to a specific user (one-to-one relationship)
    HashedPASSWORD VARCHAR(255) NOT NULL,  -- Hashed password for security (required)
    Salt VARCHAR(10) NOT NULL,  -- Salt value used for password hashing (required)
    LastChanged DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Timestamp of the last password update
    Status CHAR(1) NOT NULL CHECK (Status IN ('A', 'I', 'L')),  -- 'A' (Active), 'I' (Inactive), 'L' (Locked)
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE  -- Delete credentials if the user is deleted
);

-- Customer Table: Stores registered customers
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,  -- Unique identifier for each customer
    UserID INT UNIQUE NOT NULL,  -- Links a customer to a user (each user can be a customer only once)
    CartID INT UNIQUE,  -- Links a customer to a cart (optional)
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE  -- Delete customer record if the user is deleted
);

-- Manufacturer Table: Stores manufacturer details
CREATE TABLE Manufacturer (
    ManufacturerID INT PRIMARY KEY,  -- Unique identifier for each manufacturer
    ManufacturerName VARCHAR(255) NOT NULL UNIQUE  -- Name of the manufacturer (required and unique)
);

-- Product Table: Stores product details
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,  -- Unique identifier for each product
    ProductName VARCHAR(255) NOT NULL,  -- Name of the product (required)
    ProductPrice DECIMAL(10,2) NOT NULL CHECK (ProductPrice > 0),  -- Price must be greater than 0
    ProductDescription TEXT,  -- Description of the product (optional)
    ProductAvailable BOOLEAN NOT NULL DEFAULT TRUE,  -- Availability of the product (default: TRUE)
    ProductChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Timestamp of last product update
    InventoryQuantity INT NOT NULL CHECK (InventoryQuantity >= 0),  -- Number of items in stock (must be ≥ 0)
    ManufacturerID INT,  -- Links product to a manufacturer
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID) ON DELETE SET NULL  -- Set to NULL if manufacturer is deleted
);

-- CartProducts Table: Many-to-Many relationship between Cart and Products
CREATE TABLE CartProducts (
    CartID INT NOT NULL,  -- Links to Cart table
    ProductID INT NOT NULL,  -- Links to Product table
    DateAdded DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Timestamp when the product was added to the cart
    Quantity INT NOT NULL CHECK (Quantity > 0),  -- Ensures at least 1 product is added to the cart
    PRIMARY KEY (CartID, ProductID),  -- Ensures each cart-product combination is unique
    FOREIGN KEY (CartID) REFERENCES Customer(CartID) ON DELETE CASCADE,  -- Delete if the cart is removed
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE  -- Delete if the product is removed
);

-- Category Table: Stores product categories
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,  -- Unique identifier for each category
    CategoryName VARCHAR(255) NOT NULL UNIQUE  -- Unique name for each category
);

-- CategoryProduct Table: Many-to-Many relationship between Product and Category
CREATE TABLE CategoryProduct (
    ProductID INT NOT NULL,  -- Links to Product table
    CategoryID INT NOT NULL,  -- Links to Category table
    PRIMARY KEY (ProductID, CategoryID),  -- Composite primary key to ensure uniqueness
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE,  -- Remove link if product is deleted
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID) ON DELETE CASCADE  -- Remove link if category is deleted
);

-- OrderStatus Table: Stores different statuses for an order
CREATE TABLE OrderStatus (
    OrderStatusCode INT PRIMARY KEY,  -- Unique identifier for order status
    OrderStatusDescription VARCHAR(255) NOT NULL UNIQUE  -- Description of the status (e.g., 'Pending', 'Shipped')
);

-- PaymentMethod Table: Stores different types of payment methods available for transactions  
CREATE TABLE PaymentMethod (
    PaymentMethodID INT PRIMARY KEY,  -- Unique identifier for each payment method
    MethodName VARCHAR(255) NOT NULL UNIQUE  -- Descriptive name of the payment method (e.g., Credit Card, PayPal)
);

-- Payment Table: Stores details of payments made by customers  
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,  -- Unique identifier for each payment transaction
    PaymentMethodID INT,  -- References the payment method used
    TotalPrice DECIMAL(10,2) NOT NULL,  -- Total amount paid for the order
    PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Date and time of the payment
    Status BOOLEAN NOT NULL DEFAULT FALSE,  -- Indicates if the payment was successful (TRUE) or failed (FALSE)
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethod(PaymentMethodID) ON DELETE SET NULL  -- Ensures referential integrity with PaymentMethod table
);

-- Order Table: Stores customer orders and their details
CREATE TABLE `Order` (
    OrderID INT PRIMARY KEY,  -- Unique identifier for each order
    CustomerID INT NOT NULL,  -- References the Customer placing the order
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Timestamp when the order was placed
    PaymentID INT,  -- Allow NULL for PaymentID (if payment is removed, set to NULL)
    OrderStatusCode INT,  -- References the status of the order (e.g., Pending, Shipped, Completed)
    
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE,  -- Deletes order if customer is deleted
    FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID) ON DELETE SET NULL,  -- Sets PaymentID to NULL if payment is removed
    FOREIGN KEY (OrderStatusCode) REFERENCES OrderStatus(OrderStatusCode) ON DELETE SET NULL  -- Maintains order integrity
);

-- OrderProduct Table: Maps products to specific orders, tracking the quantity of each product in the order
CREATE TABLE OrderProduct (
    OrderID INT,  -- References the Order table, indicating which order this product is part of
    ProductID INT,  -- References the Product table, indicating which product is in the order
    Quantity INT NOT NULL CHECK (Quantity > 0),  -- Quantity of the product in the order; must be greater than 0
    PRIMARY KEY (OrderID, ProductID),  -- Composite primary key to ensure each product can only appear once per order
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID) ON DELETE CASCADE,  -- Ensures referential integrity with Order table; deletes related entries if the order is deleted
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE  -- Ensures referential integrity with Product table; deletes related entries if the product is deleted
);

-- Review Table: Stores reviews given by customers for products, including ratings, text, and the review date
CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,  -- Unique identifier for each review
    ReviewRating DECIMAL(1,1) CHECK (ReviewRating >= 0 AND ReviewRating <= 5),  -- Rating for the product (must be between 0 and 5)
    ReviewText TEXT,  -- Optional text description for the review
    ReviewDate DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Date when the review was posted, default is current timestamp
    ProductID INT NOT NULL,  -- References the Product table, indicating which product the review is for
    CustomerID INT NOT NULL,  -- References the Customer table, indicating which customer wrote the review
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE,  -- Ensures referential integrity with Product table; deletes review if the product is deleted
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE  -- Ensures referential integrity with Customer table; deletes review if the customer is deleted
);

-- Promotion Table: Stores details about promotional offers, including the discount percentage and validity period
CREATE TABLE Promotion (
    PromotionID INT PRIMARY KEY,  -- Unique identifier for each promotion
    PromotionName VARCHAR(50) NOT NULL,  -- Ensures each promotion has a name
    ReleaseDate DATETIME NOT NULL,  -- Ensures a release date is provided
    ExpiryDate DATETIME NOT NULL,  -- Ensures an expiry date is provided
    DiscountPercent INT CHECK (DiscountPercent >= 0 AND DiscountPercent <= 100),  -- Ensures the discount is between 0% and 100%
    CONSTRAINT chk_promotion_dates CHECK (ReleaseDate < ExpiryDate)  -- Ensures the release date is earlier than the expiry date
);

-- ProductSpecial Table: Maps promotions to specific products, enabling products to be part of one or more promotions
CREATE TABLE ProductSpecial (
    PromotionID INT,  -- References the Promotion table, indicating which promotion the product is part of
    ProductID INT,  -- References the Product table, indicating which product is part of the promotion
    PRIMARY KEY (PromotionID, ProductID),  -- Composite primary key to ensure each product can only be linked to a promotion once
    FOREIGN KEY (PromotionID) REFERENCES Promotion(PromotionID) ON DELETE CASCADE,  -- Ensures referential integrity with Promotion table; deletes related entries if the promotion is deleted
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE  -- Ensures referential integrity with Product table; deletes related entries if the product is deleted
);

-- ProductImage Table: Stores images and related HTML content for products
CREATE TABLE ProductImage (
    ProductImageID INT PRIMARY KEY,  -- Unique identifier for each product image
    ProductID INT NOT NULL,  -- References the Product table, indicating which product this image belongs to
    ImagePath TEXT NOT NULL,  -- Stores the image path, URL, or base64-encoded image data
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE  -- Ensures referential integrity; deletes image records if the associated product is deleted
);

-- Roles Table: Stores different user roles (e.g., Super Admin, Data Entry Admin)
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY,  -- Unique identifier for each role
    RoleName VARCHAR(50) NOT NULL UNIQUE  -- Name of the role (e.g., Admin, Moderator, User)
);

-- PermissionFunctions Table: Defines the available permissions in the system
CREATE TABLE PermissionFunctions (
    PermissionID INT PRIMARY KEY,  -- Unique identifier for each permission
    PermissionName VARCHAR(50) NOT NULL UNIQUE  -- Name of the permission (e.g., View Reports, Manage Users)
);

-- Permissions Table: Maps roles to their assigned permissions
CREATE TABLE Permissions (
    RoleID INT,  -- References the Roles table
    PermissionID INT,  -- References the PermissionFunctions table
    PRIMARY KEY (RoleID, PermissionID),  -- Composite primary key to ensure unique role-permission pairs
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID) ON DELETE CASCADE,  -- Deletes permissions if the role is deleted
    FOREIGN KEY (PermissionID) REFERENCES PermissionFunctions(PermissionID) ON DELETE CASCADE  -- Deletes permissions if the permission is deleted
);

-- Admins Table: Stores system administrators and their assigned permissions
CREATE TABLE Admins (
    AdminID INT PRIMARY KEY,  -- Unique identifier for each admin
    UserID INT UNIQUE NOT NULL,  -- Ensures each user can only be an admin once
    RoleID INT NOT NULL,  -- Role assigned to the admin
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE,  -- Deletes admin if the user is deleted
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID) ON DELETE CASCADE  -- Deletes admin if the role is deleted
);

-- Province Table: Stores province/state-level geographical divisions
CREATE TABLE Province (
    ProvinceID INT PRIMARY KEY,  -- Unique identifier for each province
    ProvinceName VARCHAR(255) NOT NULL UNIQUE  -- Name of the province, must be unique and not null
);

-- Country Table: Stores country-level geographical data
CREATE TABLE Country (
    CountryCode VARCHAR(10) PRIMARY KEY,  -- Unique identifier for each country (e.g., "US", "CA", "AU")
    CountryName VARCHAR(255) NOT NULL UNIQUE  -- Full name of the country, must be unique and not null
);

-- District Table: Stores district-level geographical data
CREATE TABLE District (
    DistrictID INT PRIMARY KEY,  -- Unique identifier for each district (e.g., "D001")
    DistrictName VARCHAR(255) NOT NULL UNIQUE  -- Full name of the district, must be unique and not null
);

-- ZipCode Table: Stores postal codes and their associated locations
CREATE TABLE ZipCode (
    ZipCode VARCHAR(10) PRIMARY KEY,  -- Unique postal code identifier
    CountryCode VARCHAR(10) NOT NULL,  -- References the country where the ZIP code belongs
    ProvinceID INT NOT NULL,  -- References the province
    DistrictID INT NOT NULL,  -- References the district

    -- Foreign key constraints
    FOREIGN KEY (CountryCode) REFERENCES Country(CountryCode) ON DELETE CASCADE,
    FOREIGN KEY (ProvinceID) REFERENCES Province(ProvinceID) ON DELETE CASCADE,
    FOREIGN KEY (DistrictID) REFERENCES District(DistrictID) ON DELETE CASCADE
);

-- Address Table: Stores customer addresses
CREATE TABLE Address (
    AddressID INT PRIMARY KEY,  -- Unique identifier for each address
    AddressText TEXT NOT NULL,  -- Full address description (e.g., street, house number)
    ZipCode VARCHAR(10) NOT NULL,  -- References the ZipCode table
    CustomerID INT NOT NULL,  -- References the Customer table
    AddressType VARCHAR(50) CHECK (AddressType IN ('Home', 'Work', 'Other')),  -- Defines address types (only allows specific values)

    -- Foreign key constraints
    FOREIGN KEY (ZipCode) REFERENCES ZipCode(ZipCode) ON DELETE CASCADE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE
);