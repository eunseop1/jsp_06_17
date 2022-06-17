CREATE SEQUENCE memo_idx_seq;

CREATE TABLE memo(
	idx NUMBER PRIMARY KEY,
	name varchar2(100) NOT NULL,
	password varchar2(100) NOT NULL,
	content varchar2(100) NOT NULL,
	regdate timestamp DEFAULT sysdate,
	ip varchar2(100) NOT null
);

INSERT INTO
	memo(idx, name, passoword, content, ip)
VALUES
	(memo_idx_seq.nextval, '한사람', '1234', '나는 1등이다~!!', '197.164.0.626');
SELECT * FROM memo;