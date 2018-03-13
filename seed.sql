DROP TABLE IF EXISTS orders;

CREATE TABLE orders (

 id SERIAL PRIMARY KEY,
 temp VARCHAR(255),
 size VARCHAR(255),
 toppings TEXT[]

);

INSERT INTO orders (temp , size, toppings) VALUES ('Medium' , '6oz', '{"Lettuce","Onions","Pickles","Relish","Bacon"}');