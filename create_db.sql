CREATE DATABASE IF NOT EXISTS StockTrack;
USE StockTrack;

-- Drop the existing table if it exists
DROP TABLE IF EXISTS stock;

-- Create the new table with the updated fields
CREATE TABLE stock (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name TEXT,
    upc TEXT,
    quantity INTEGER,
    expiry DATE,
    dateAdded DATE,
    datePurchased DATE,
    wholesalePrice REAL,
    retailPrice REAL
);

-- Insert some sample data into the stock table
INSERT INTO stock (name, upc, quantity, expiry, dateAdded, datePurchased, wholesalePrice, retailPrice)
VALUES 
    ('Product A', 'UPC123', 100, '2024-05-01', '2024-04-15', '2024-01-01', 10.50, 20.00),
    ('Product B', 'UPC456', 50, '2024-06-01', '2024-04-15', '2024-01-15', 15.75, 25.00);

-- Drop the existing table if it exists
DROP TABLE IF EXISTS Hardware;

-- Drop the existing user if it exists
DROP USER IF EXISTS 'appuser'@'localhost';

-- Create a new user
CREATE USER 'appuser'@'localhost' IDENTIFIED WITH mysql_native_password BY 'app2027';

-- Grant privileges to the user
GRANT ALL PRIVILEGES ON StockTrack.* TO 'appuser'@'localhost';

-- Create a table for user details
CREATE TABLE IF NOT EXISTS userdetails (
    username VARCHAR(50),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    hashedPassword VARCHAR(255) NOT NULL,
    PRIMARY KEY (username)
);

-- Add UNIQUE constraint on username
ALTER TABLE userdetails ADD UNIQUE KEY unique_username (username);

-- Insert data into the userdetails table
INSERT INTO userdetails (username, first_name, last_name, email, hashedPassword) 
VALUES 
    ('user1', 'John', 'Doe', 'john@example.com', 'hashed_password1'),
    ('user2', 'Jane', 'Smith', 'jane@example.com', 'hashed_password2');

-- Select data from the userdetails table
SELECT * FROM userdetails;

-- Connect both tables via pk and fk in order to link username to stock table
ALTER TABLE stock
ADD COLUMN username VARCHAR(50),
ADD CONSTRAINT fk_username
FOREIGN KEY (username)
REFERENCES userdetails(username)
ON DELETE CASCADE; 
-- This line will delete all stock items from the user when the user is deleted
