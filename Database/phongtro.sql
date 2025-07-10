-- CSDL phongtro
CREATE DATABASE IF NOT EXISTS phongtro;
USE phongtro;

CREATE TABLE payment_method (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

INSERT INTO payment_method(name) VALUES ('Theo tháng'), ('Theo quý'), ('Theo năm');

CREATE TABLE room (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tenant_name VARCHAR(50) NOT NULL,
    phone VARCHAR(10) NOT NULL,
    start_date DATE NOT NULL,
    payment_method_id INT NOT NULL,
    note VARCHAR(200),
    FOREIGN KEY (payment_method_id) REFERENCES payment_method(id)
);
