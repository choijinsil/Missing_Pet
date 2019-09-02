
------------------------------------------------- 테이블 생성 --------------------------------------------

-- user_info
create table user_info(
	id	     varchar2(50)        not null,
	name	 varchar2(50)        not null,
	pass	 varchar2(50)        not null,
	email	 varchar2(50 char)   not null,
	tel		 varchar2(50)        not null,
	address	 varchar2(100)       not null,
	black	 varchar2(10)            null,
	constraint user_info_pk primary key(id)
);

-- missing_info
create table missing_info(
	missing_no			 integer 				 not null,
	id					 varchar2(50)  			 not null,
	missing_pic			 varchar2(500)  		 not null,
	write_date			 date 					 not null,
	missing_place 		 varchar2(100) 			 not null,
	missing_date 		 date 					 not null,
	missing_type 		 varchar2(20) 			 not null,
	missing_comment		 varchar2(1000 char)  		 null,
	tip					 varchar2(50) 			 not null,
	complete_date 		 date 						 null,
	constraint missing_info_pk primary key(missing_no)
);

-- wit_info	
create table wit_info(
	wit_no			 integer 				 not null,
	missing_pic		 varchar2(500) 			 not null,
	find_date		 date 					 not null,
	wit_place		 varchar2(100) 			 not null,
	wit_comment		 varchar2(1000 char) 		 null,
	id				 varchar2(50) 			 not null,
	missing_no 		 integer 				 not null,
	constraint wit_info_pk primary key(wit_no)
);



------------------------------------------------- 시퀀스 추가 --------------------------------------------

-- missing_seq (missing_no)
create sequence missing_seq
	start with 1
	increment by 1
	nocycle
	nocache;
	
-- wit_seq (wit_no)	
create sequence wit_seq
	start with 1
	increment by 1
	nocycle
	nocache;
	
	
-------------------------------------------------- 제약조건 추가 --------------------------------------------

alter table missing_info add constraint missing_id_fk foreign key(id) references user_info(id);
alter table wit_info add constraint wit_id_fk foreign key(id) references user_info(id);
alter table wit_info add constraint wit_no_fk foreign key(missing_no) references missing_info(missing_no);

	
	
------------------------------------------------- 테이블, 시퀀스 제거 --------------------------------------------

drop table wit_info;
drop table missing_info;
drop table user_info;
drop sequence missing_seq;
drop sequence wit_seq;


------------------------------------------------- 관리자 데이터 --------------------------------------------

insert into user_info (id, name, pass, email, tel, address, black) 
values ('admin', '관리자', '1234', '.', '.', '.', 'N');


------------------------------------------------- 샘플 데이터 --------------------------------------------
-- user_info
insert into user_info (id, name, pass, email, tel, address, black) 
values ('apple10', '사과', '1234', 'orange@gmail.com', '010-1234-4567', '서울시 마포구 공덕동 롯데캐슬프레지던트', 'N');






------------------------ 쿼리문 테스트
select * from user_info;
select * from missing_info;
select * from wit_info;


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	