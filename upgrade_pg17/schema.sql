-- postgres17にアップグレードしたとき、ウィンドウ関数で型のキャストがエラーになったので確認する
-- 再現しないな
CREATE TABLE users (id UUID PRIMARY KEY, name VARCHAR, age VARCHAR);

INSERT INTO
    users (id, name, age)
SELECT
    gen_random_uuid(),
    FORMAT('test%s', i),
    '10.1'
FROM
    GENERATE_SERIES(1, 10000) AS i;


SELECT id, ROUND((LEAD(age, 1) OVER (PARTITION BY age ORDER BY id))::NUMERIC) AS r FROM users;