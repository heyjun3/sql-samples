-- joinでindexを使用することでどれだけ速くなるか確認する。
CREATE TABLE
    customer (id UUID PRIMARY KEY, NAME VARCHAR);

CREATE TABLE
    orders (id UUID PRIMARY KEY, customer_id UUID, NAME VARCHAR);

ALTER TABLE orders
ADD CONSTRAINT customer_fk FOREIGN KEY (customer_id) REFERENCES customer (id);

INSERT INTO
    customer (id, NAME)
SELECT
    gen_random_uuid (),
    FORMAT('test%s', i)
FROM
    GENERATE_SERIES(1, 10000000) AS i;

INSERT INTO
    orders (id, customer_id, NAME)
SELECT
    gen_random_uuid (),
    id,
    NAME
FROM
    customer;

EXPLAIN
ANALYZE
SELECT
    *
FROM
    customer
    INNER JOIN orders ON orders.customer_id = customer.id
LIMIT 1000000;