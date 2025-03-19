-- User Table: Stores user information
INSERT INTO User (UserID, Gender, FirstName, MiddleName, LastName, EmailAddress, EmailConfirmed, PhoneNumber) 
VALUES 
(1, 'M', 'John', 'A.', 'Doe', 'john.doe@example.com', TRUE, '1234567890'),
(2, 'F', 'Jane', NULL, 'Smith', 'jane.smith@example.com', FALSE, '2345678901'),
(3, 'M', 'Robert', 'B.', 'Brown', 'robert.brown@example.com', TRUE, '3456789012'),
(4, 'F', 'Emily', 'C.', 'Davis', 'emily.davis@example.com', TRUE, '4567890123'),
(5, 'O', 'Alex', NULL, 'Wilson', 'alex.wilson@example.com', FALSE, '5678901234'),
(6, 'M', 'David', 'D.', 'Miller', 'david.miller@example.com', TRUE, '6789012345'),
(7, 'F', 'Sophia', NULL, 'Anderson', 'sophia.anderson@example.com', FALSE, '7890123456'),
(8, 'M', 'Michael', 'E.', 'Taylor', 'michael.taylor@example.com', TRUE, '8901234567'),
(9, 'F', 'Olivia', NULL, 'Martinez', 'olivia.martinez@example.com', TRUE, '9012345678'),
(10, 'M', 'Daniel', 'F.', 'Thomas', 'daniel.thomas@example.com', FALSE, '0123456789');

-- Credential Table: Stores user authentication details
INSERT INTO Credential (UserID, HashedPASSWORD, Salt, LastChanged, Status) 
VALUES 
(1, 'hashed_pwd_1', 'salt1234', CURRENT_TIMESTAMP, 'A'),
(2, 'hashed_pwd_2', 'salt5678', CURRENT_TIMESTAMP, 'A'),
(3, 'hashed_pwd_3', 'salt9101', CURRENT_TIMESTAMP, 'I'),
(4, 'hashed_pwd_4', 'salt1121', CURRENT_TIMESTAMP, 'A'),
(5, 'hashed_pwd_5', 'salt3141', CURRENT_TIMESTAMP, 'L'),
(6, 'hashed_pwd_6', 'salt5161', CURRENT_TIMESTAMP, 'A'),
(7, 'hashed_pwd_7', 'salt7181', CURRENT_TIMESTAMP, 'I'),
(8, 'hashed_pwd_8', 'salt9202', CURRENT_TIMESTAMP, 'A'),
(9, 'hashed_pwd_9', 'salt1222', CURRENT_TIMESTAMP, 'L'),
(10, 'hashed_pwd_10', 'salt3242', CURRENT_TIMESTAMP, 'A');

-- Customer Table: Stores registered customers
INSERT INTO Customer (CustomerID, UserID, CartID)
VALUES 
(1, 1, 1001),
(2, 2, 1002),
(3, 3, 1003),
(4, 4, 1004),
(5, 5, 1005),
(6, 6, 1006),
(7, 7, 1007),
(8, 8, 1008),
(9, 9, 1009),
(10, 10, 1010);

-- Manufacturer Table: Stores manufacturer details
INSERT INTO Manufacturer (ManufacturerID, ManufacturerName)  
VALUES  
(1, 'Apple'),  
(2, 'Samsung'),  
(3, 'Sony'),  
(4, 'LG'),  
(5, 'Nike'),  
(6, 'Adidas'),  
(7, 'Dell'),  
(8, 'HP'),  
(9, 'Lenovo'),  
(10, 'Microsoft');  

-- Product Table: Stores product details
INSERT INTO Product (ProductID, ProductName, ProductPrice, ProductDescription, ProductAvailable, InventoryQuantity, ManufacturerID)
VALUES
(1, 'iPhone 15', 999.99, 'Latest iPhone model with A16 chip', TRUE, 50, 1),
(2, 'Galaxy S23', 899.99, 'Flagship Samsung smartphone with AMOLED display', TRUE, 40, 2),
(3, 'PlayStation 5', 499.99, 'Next-gen gaming console by Sony', TRUE, 30, 3),
(4, 'LG OLED TV', 1299.99, '55-inch OLED TV with stunning picture quality', TRUE, 20, 4),
(5, 'Air Max Sneakers', 149.99, 'Comfortable and stylish Nike sneakers', TRUE, 100, 5),
(6, 'Adidas Ultraboost', 179.99, 'High-performance running shoes', TRUE, 80, 6),
(7, 'Dell XPS 15', 1499.99, 'Powerful laptop for work and play', TRUE, 25, 7),
(8, 'HP Spectre x360', 1399.99, 'Premium convertible laptop with touchscreen', TRUE, 15, 8),
(9, 'Lenovo ThinkPad X1', 1299.99, 'Business laptop with high durability', TRUE, 30, 9),
(10, 'Surface Pro 9', 1099.99, 'Microsoft 2-in-1 tablet with detachable keyboard', TRUE, 20, 10);

-- CartProducts Table: Many-to-Many relationship between Cart and Products
INSERT INTO CartProducts (CartID, ProductID, Quantity)  
VALUES  
(1001, 1, 2),  -- iPhone 15  
(1001, 3, 1),  -- PlayStation 5  
(1002, 2, 1),  -- Galaxy S23  
(1003, 5, 2),  -- Air Max Sneakers  
(1003, 6, 1),  -- Adidas Ultraboost  
(1004, 4, 1),  -- LG OLED TV  
(1005, 7, 1),  -- Dell XPS 15  
(1006, 8, 2),  -- HP Spectre x360
(1007, 9, 1),  -- Lenovo ThinkPad X1
(1008, 10, 1); -- Surface Pro 9

-- Category Table: Stores product categories
INSERT INTO Category (CategoryID, CategoryName)
VALUES
(1, 'Smartphones'),
(2, 'Laptops'),
(3, 'Gaming Consoles'),
(4, 'Televisions'),
(5, 'Shoes'),
(6, 'Sportswear'),
(7, 'Computers'),
(8, 'Accessories'),
(9, 'Tablets'),
(10, 'Office Equipment');

-- CategoryProduct Table: Many-to-Many relationship between Product and Category
INSERT INTO CategoryProduct (ProductID, CategoryID)
VALUES
(1, 1),  -- iPhone 15 in Smartphones category
(2, 1),  -- Galaxy S23 in Smartphones category
(3, 3),  -- PlayStation 5 in Gaming Consoles category
(4, 4),  -- LG OLED TV in Televisions category
(5, 5),  -- Air Max Sneakers in Shoes category
(6, 6),  -- Adidas Ultraboost in Sportswear category
(7, 7),  -- Dell XPS 15 in Computers category
(8, 7),  -- HP Spectre x360 in Computers category
(9, 7),  -- Lenovo ThinkPad X1 in Computers category
(10, 9); -- Surface Pro 9 in Tablets category

-- OrderStatus Table: Stores different statuses for an order
INSERT INTO OrderStatus (OrderStatusCode, OrderStatusDescription)
VALUES
(1, 'Pending'),  -- Order is pending
(2, 'Shipped'),  -- Order has been shipped
(3, 'Delivered'),  -- Order has been delivered
(4, 'Canceled'),  -- Order has been canceled
(5, 'Returned');  -- Order has been returned

-- PaymentMethod Table: Stores different types of payment methods available for transactions  
INSERT INTO PaymentMethod (PaymentMethodID, MethodName)
VALUES
(1, 'Credit Card'),  -- Payment by Credit Card
(2, 'PayPal'),  -- Payment via PayPal
(3, 'Bank Transfer'),  -- Payment via Bank Transfer
(4, 'Cash on Delivery'),  -- Payment by Cash on Delivery
(5, 'Apple Pay');  -- Payment via Apple Pay

-- Payment Table: Stores details of payments made by customers
INSERT INTO Payment (PaymentID, PaymentMethodID, TotalPrice, Status)
VALUES
(1, 1, 999.99, TRUE),  -- Payment 1 via Credit Card, successful
(2, 2, 899.99, TRUE),  -- Payment 2 via PayPal, successful
(3, 3, 1499.99, FALSE),  -- Payment 3 via Bank Transfer, failed
(4, 4, 199.99, TRUE),  -- Payment 4 via Cash on Delivery, successful
(5, 5, 1099.99, TRUE),  -- Payment 5 via Apple Pay, successful
(6, 1, 799.99, FALSE),  -- Payment 6 via Credit Card, failed
(7, 2, 499.99, TRUE),  -- Payment 7 via PayPal, successful
(8, 3, 1299.99, TRUE),  -- Payment 8 via Bank Transfer, successful
(9, 4, 349.99, FALSE),  -- Payment 9 via Cash on Delivery, failed
(10, 5, 599.99, TRUE);  -- Payment 10 via Apple Pay, successful

-- Order Table: Stores customer orders and their details
INSERT INTO `Order` (OrderID, CustomerID, OrderDate, PaymentID, OrderStatusCode)
VALUES
(1, 1, '2025-03-13 10:30:00', 1, 1),  -- Pending order
(2, 2, '2025-03-13 11:00:00', 2, 2),  -- Shipped order
(3, 3, '2025-03-13 12:15:00', 3, 3),  -- Completed order
(4, 4, '2025-03-13 13:30:00', 4, 1),  -- Pending order
(5, 5, '2025-03-13 14:00:00', 5, 2),  -- Shipped order
(6, 6, '2025-03-13 15:45:00', 6, 3),  -- Completed order
(7, 7, '2025-03-13 16:15:00', 7, 1),  -- Pending order
(8, 8, '2025-03-13 17:00:00', 8, 2),  -- Shipped order
(9, 9, '2025-03-13 18:30:00', 9, 3),  -- Completed order
(10, 10, '2025-03-13 19:00:00', 10, 1);  -- Pending order

-- OrderProduct Table: Maps products to specific orders, tracking the quantity of each product in the order
INSERT INTO OrderProduct (OrderID, ProductID, Quantity)
VALUES
(1, 1, 2),  -- Order 1 contains 2 iPhones
(1, 2, 1),  -- Order 1 contains 1 Galaxy S23
(2, 3, 1),  -- Order 2 contains 1 PlayStation 5
(3, 4, 1),  -- Order 3 contains 1 LG OLED TV
(4, 5, 2),  -- Order 4 contains 2 Air Max Sneakers
(5, 6, 1),  -- Order 5 contains 1 Adidas Ultraboost
(6, 7, 1),  -- Order 6 contains 1 Dell XPS 15
(7, 8, 1),  -- Order 7 contains 1 HP Spectre x360
(8, 9, 1),  -- Order 8 contains 1 Lenovo ThinkPad X1
(9, 10, 1);  -- Order 9 contains 1 Surface Pro 9

-- Review Table: Stores reviews given by customers for products, including ratings, text, and the review date
INSERT INTO Review (ReviewID, ReviewRating, ReviewText, ProductID, CustomerID)
VALUES
(1, 4.5, 'Great phone with excellent performance!', 1, 1),  -- Customer 1 reviews iPhone 15
(2, 3.0, 'Good, but the battery could be better.', 2, 2),  -- Customer 2 reviews Galaxy S23
(3, 5.0, 'Amazing gaming console! Highly recommend.', 3, 3),  -- Customer 3 reviews PlayStation 5
(4, 4.0, 'Best TV I have ever owned. Picture quality is superb.', 4, 4),  -- Customer 4 reviews LG OLED TV
(5, 2.5, 'Comfortable, but the size options are limited.', 5, 5),  -- Customer 5 reviews Air Max Sneakers
(6, 4.8, 'Great for running. The boost technology works wonders.', 6, 6),  -- Customer 6 reviews Adidas Ultraboost
(7, 4.7, 'Great laptop, but a bit expensive.', 7, 7),  -- Customer 7 reviews Dell XPS 15
(8, 5.0, 'I love this laptop! The touchscreen is amazing.', 8, 8),  -- Customer 8 reviews HP Spectre x360
(9, 4.9, 'Business laptop with top-notch durability.', 9, 9),  -- Customer 9 reviews Lenovo ThinkPad X1
(10, 3.5, 'Nice tablet, but the keyboard is not very responsive.', 10, 10);  -- Customer 10 reviews Surface Pro 9

-- Promotion Table: Stores details about promotional offers, including the discount percentage and validity period
INSERT INTO Promotion (PromotionID, PromotionName, ReleaseDate, ExpiryDate, DiscountPercent)
VALUES
(1, 'Summer Sale', '2025-06-01 00:00:00', '2025-06-30 23:59:59', 20),  -- 20% off during the Summer Sale
(2, 'Black Friday Deals', '2025-11-27 00:00:00', '2025-11-29 23:59:59', 50),  -- 50% off during Black Friday
(3, 'Christmas Discount', '2025-12-20 00:00:00', '2025-12-26 23:59:59', 30),  -- 30% off for Christmas
(4, 'New Year Sale', '2025-12-30 00:00:00', '2026-01-02 23:59:59', 25),  -- 25% off during New Year
(5, 'Spring Clearance', '2025-04-01 00:00:00', '2025-04-15 23:59:59', 15),  -- 15% off during Spring Clearance
(6, 'VIP Member Discount', '2025-03-01 00:00:00', '2025-03-31 23:59:59', 10),  -- 10% off for VIP members
(7, 'Cyber Monday Sale', '2025-11-30 00:00:00', '2025-11-30 23:59:59', 40),  -- 40% off during Cyber Monday
(8, 'Flash Sale', '2025-06-15 00:00:00', '2025-06-15 23:59:59', 60),  -- 60% off for Flash Sale
(9, 'Holiday Bonus', '2025-12-01 00:00:00', '2025-12-15 23:59:59', 35),  -- 35% off during the Holiday Bonus
(10, 'Back to School', '2025-08-01 00:00:00', '2025-08-31 23:59:59', 20);  -- 20% off for Back to School

-- ProductSpecial Table: Maps promotions to specific products, enabling products to be part of one or more promotions
INSERT INTO ProductSpecial (PromotionID, ProductID)
VALUES
(1, 1),  -- Summer Sale for iPhone 15
(2, 2),  -- Black Friday Deals for Galaxy S23
(3, 3),  -- Christmas Discount for PlayStation 5
(4, 4),  -- New Year Sale for LG OLED TV
(5, 5),  -- Spring Clearance for Air Max Sneakers
(6, 6),  -- VIP Member Discount for Adidas Ultraboost
(7, 7),  -- Cyber Monday Sale for Dell XPS 15
(8, 8),  -- Flash Sale for HP Spectre x360
(9, 9),  -- Holiday Bonus for Lenovo ThinkPad X1
(10, 10); -- Back to School for Surface Pro 9

-- ProductImage Table: Stores images and related HTML content for products
INSERT INTO ProductImage (ProductImageID, ProductID, ImagePath)
VALUES
(1, 1, 'https://example.com/images/iphone15.jpg'),  -- Image for iPhone 15
(2, 2, 'https://example.com/images/galaxys23.jpg'),  -- Image for Galaxy S23
(3, 3, 'https://example.com/images/ps5.jpg'),  -- Image for PlayStation 5
(4, 4, 'https://example.com/images/lgoledtv.jpg'),  -- Image for LG OLED TV
(5, 5, 'https://example.com/images/airmaxsneakers.jpg'),  -- Image for Air Max Sneakers
(6, 6, 'https://example.com/images/adidasultraboost.jpg'),  -- Image for Adidas Ultraboost
(7, 7, 'https://example.com/images/dellxps15.jpg'),  -- Image for Dell XPS 15
(8, 8, 'https://example.com/images/hpspectrex360.jpg'),  -- Image for HP Spectre x360
(9, 9, 'https://example.com/images/thinkpadx1.jpg'),  -- Image for Lenovo ThinkPad X1
(10, 10, 'https://example.com/images/surfacepro9.jpg');  -- Image for Surface Pro 9


-- Roles Table: Stores different user roles (e.g., Super Admin, Data Entry Admin)
INSERT INTO Roles (RoleID, RoleName)
VALUES
(1, 'Super Admin'),  -- Role for super admin
(2, 'Staff Admin');  -- Role for staff admin

-- PermissionFunctions Table: Defines the available permissions in the system
INSERT INTO PermissionFunctions (PermissionID, PermissionName)
VALUES
(1, 'Dashboard'),  -- Permission for accessing the dashboard
(2, 'Inventory'),  -- Permission for managing inventory
(3, 'Orders'),  -- Permission for managing orders
(4, 'User Manager'),  -- Permission for managing users
(5, 'Flash Sales'),  -- Permission for managing flash sales
(6, 'Report');  -- Permission for accessing and generating reports

-- Permissions Table: Maps roles to their assigned permissions
INSERT INTO Permissions (RoleID, PermissionID)
VALUES
    (1, 1),  -- super admin: Dashboard
    (1, 2),  -- super admin: Inventory
    (1, 3),  -- super admin: Orders
    (1, 4),  -- super admin: User Manager
    (1, 5),  -- super admin: Flash Sales
    (1, 6);  -- super admin: Report
    (2, 2),  -- staff admin: Inventory
    (2, 3);  -- staff admin: Orders

-- Admins Table: Stores system administrators and their assigned permissions
INSERT INTO Admins (AdminID, UserID, RoleID)
VALUES 
(1, 1, 1),  -- John Doe is Super Admin
(2, 2, 2),  -- Jane Smith is Staff Admin
(3, 3, 1),  -- Robert Brown is Super Admin
(4, 4, 2),  -- Emily Davis is Staff Admin
(5, 5, 1),  -- Alex Wilson is Super Admin
(6, 6, 2),  -- David Miller is Staff Admin
(7, 7, 1),  -- Sophia Anderson is Super Admin
(8, 8, 2),  -- Michael Taylor is Staff Admin
(9, 9, 1),  -- Olivia Martinez is Super Admin
(10, 10, 2);  -- Daniel Thomas is Staff Admin

-- Province Table: Stores province/state-level geographical divisions
INSERT INTO Province (ProvinceID, ProvinceName)
VALUES 
(1, 'Ontario'),
(2, 'Quebec'),
(3, 'British Columbia'),
(4, 'Alberta'),
(5, 'Nova Scotia'),
(6, 'New Brunswick'),
(7, 'Manitoba'),
(8, 'Saskatchewan'),
(9, 'Prince Edward Island'),
(10, 'Newfoundland and Labrador');

-- Country Table: Stores country-level geographical data
INSERT INTO Country (CountryCode, CountryName)
VALUES 
('US', 'United States'),
('CA', 'Canada'),
('AU', 'Australia'),
('GB', 'United Kingdom'),
('IN', 'India'),
('FR', 'France'),
('DE', 'Germany'),
('IT', 'Italy'),
('JP', 'Japan'),
('BR', 'Brazil');

-- District Table: Stores district-level geographical data
INSERT INTO District (DistrictID, DistrictName)
VALUES
(1, 'Central District'),
(2, 'North District'),
(3, 'South District'),
(4, 'East District'),
(5, 'West District'),
(6, 'Uptown District'),
(7, 'Downtown District'),
(8, 'Suburban District'),
(9, 'Industrial District'),
(10, 'Rural District');

-- ZipCode Table: Stores postal codes and their associated locations
INSERT INTO ZipCode (ZipCode, CountryCode, ProvinceID, DistrictID)
VALUES
('10001', 'US', 1, 1),  -- ZIP code for the first province and district
('20001', 'US', 2, 2),  -- ZIP code for the second province and district
('30001', 'CA', 3, 3),  -- ZIP code for Canada
('40001', 'CA', 4, 4),  -- Another ZIP code for Canada
('50001', 'AU', 5, 5),  -- ZIP code for Australia
('60001', 'US', 6, 6),  -- Another ZIP code for the US
('70001', 'IN', 7, 7),  -- ZIP code for India
('80001', 'IN', 8, 8),  -- Another ZIP code for India
('90001', 'GB', 9, 9),  -- ZIP code for the UK
('10002', 'GB', 10, 10);  -- Another ZIP code for the UK

-- Address Table: Stores customer addresses
INSERT INTO Address (AddressID, AddressText, ZipCode, CustomerID, AddressType)
VALUES
(1, '123 Elm Street, Apartment 5B', '10001', 1, 'Home'),
(2, '456 Maple Avenue, Suite 10', '20001', 2, 'Work'),
(3, '789 Oak Drive, House 3', '30001', 3, 'Home'),
(4, '101 Pine Road, Apartment 2A', '40001', 4, 'Work'),
(5, '202 Cedar Lane, House 8', '50001', 5, 'Home'),
(6, '303 Birch Way, Office 4', '60001', 6, 'Work'),
(7, '404 Walnut Boulevard, Apartment 7C', '70001', 7, 'Home'),
(8, '505 Chestnut Street, Suite 8', '80001', 8, 'Work'),
(9, '606 Redwood Parkway, House 9', '90001', 9, 'Home'),
(10, '707 Fir Road, Office 1A', '10002', 10, 'Work');