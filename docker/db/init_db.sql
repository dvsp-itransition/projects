CREATE TABLE IF NOT EXISTS products (
    id serial PRIMARY KEY, 
    name varchar(100), 
    price float
);

INSERT INTO products (name, price) VALUES  
    ('Banana', 1), 
    ('Mango', 2), 
    ('Ananas', 3);
    