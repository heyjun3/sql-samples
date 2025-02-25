CREATE TABLE
    items (id UUID PRIMARY KEY, NAME VARCHAR, created_at TIMESTAMP DEFAULT NOW());

INSERT INTO
    items (id, NAME)
SELECT
    gen_random_uuid (),
    'test'
FROM
    GENERATE_SERIES(1, 100);

CREATE TABLE
    departments (id UUID PRIMARY KEY, parent_id UUID, NAME VARCHAR NOT NULL, created_at TIMESTAMP DEFAULT NOW());

ALTER TABLE departments
ADD CONSTRAINT parentkey FOREIGN KEY (parent_id) REFERENCES departments (id);

INSERT INTO
    departments (id, NAME)
VALUES
    (gen_random_uuid (), 'test');

INSERT INTO
    departments (id, parent_id, NAME)
VALUES
    (gen_random_uuid (), '673ab624-9885-4fd6-b41f-d8066034bd35', 'child');

INSERT INTO
    departments (id, parent_id, NAME)
VALUES
    (gen_random_uuid (), gen_random_uuid (), 'child2');

BEGIN;

INSERT INTO
    departments (id, NAME)
VALUES
    ('b560ac8d-9b27-47ea-bb5a-81c98e58348c', 'test2');

INSERT INTO
    departments (id, parent_id, NAME)
VALUES
    (gen_random_uuid (), 'b560ac8d-9b27-47ea-bb5a-81c98e58348c', 'child2');

COMMIT;

-- not working
BEGIN;

INSERT INTO
    departments (id, parent_id, NAME)
VALUES
    (gen_random_uuid (), '881663cb-5e20-4f89-9548-564ef09fb788', 'child2');

INSERT INTO
    departments (id, NAME)
VALUES
    ('881663cb-5e20-4f89-9548-564ef09fb788', 'test2');

COMMIT;

BEGIN;

INSERT INTO
    departments (id, parent_id, NAME)
VALUES
    (gen_random_uuid (), '881663cb-5e20-4f89-9548-564ef09fb788', 'child2'),
    ('881663cb-5e20-4f89-9548-564ef09fb788', NULL, 'test3');

COMMIT;