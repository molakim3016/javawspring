show tables;

create table guest2 (
	idx int not null auto_increment primary key,		/* 고유번호 */
	name varchar(20) not null,		/* 방문자 성명 */
	email varchar(60),						/* 이메일 주소 */
	homePage varchar(60),					/* 홈페이지 주소 */
	visitDate datetime default now(),	/* 방문일자 */
	hostIp varchar(50) not null,	/* 방문자 IP */
	content text not null					/* 방문소감 */
);

desc guest2;

insert into guest2 values (default,'관리자','hakbackho@gmail.com','naver.com',default,'192.168.50.118','방명록 서비스를 개시합니다.');

select * from guest2;