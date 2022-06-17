package kr.MS.vo;

import java.util.Date;

import lombok.Data;

/*
 * CREATE TABLE memo(
	idx NUMBER PRIMARY KEY,
	name varchar2(100) NOT NULL,
	password varchar2(100) NOT NULL,
	content varchar2(100) NOT NULL,
	regdate timestamp DEFAULT sysdate,
	ip varchar2(100) NOT null
);
 */
@Data
public class MemoVO {
	private int idx;
	private String name;
	private String password;
	private String content;
	private Date regDate;
	private String ip;
	
	private String mode;
}
