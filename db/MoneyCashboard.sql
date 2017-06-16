DROP TABLE transactions;
DROP TABLE tags;
DROP  TABLE merchants;

CREATE TABLE tags(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255)
);

CREATE TABLE merchants(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255)
);

CREATE TABLE transactions(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255),
tag_id INT4 REFERENCES tags(id),
merchant_id INT4 REFERENCES merchants(id)
);