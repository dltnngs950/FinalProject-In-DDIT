-- emp test data
-- 부서
INSERT INTO dept VALUES(0, null, '관리자');
INSERT INTO dept VALUES(1, null, '마케팅');
INSERT INTO dept VALUES(2, null, 'IT');
INSERT INTO dept VALUES(3, null, '영업');
INSERT INTO dept VALUES(4, null, '시스템');

-- brown 정보
INSERT INTO emp VALUES (1000, 1, null, 'brown', 'brownPass', '브라운', 'Brown', 3, TO_DATE('1995-08-14', 'YYYY-MM-dd'), '01011112222', 
'0421054545', 'brown@naver.com', 'ddit1@ddit.kr', '555-555', '영민빌딩', '대덕인재개발원 301호', TO_DATE('2015-05-12', 'YYYY-MM-dd'), 
null, 500, null, null, 15, 140, 2, 110, 106, 130);
-- 관리자 정보
INSERT INTO emp VALUES (0, 0, null, 'admin', '1234', '관리자', 'Administrator', 3, TO_DATE('1964-12-25', 'YYYY-MM-dd'), '01011111111', 
'0421054545', 'admin@admin.com', null, '555-555', '영민빌딩', '대덕인재개발원 301호', TO_DATE('1988-12-25', 'YYYY-MM-dd'), 
null, 500, null, null, 9999, 140, 0, 110, 107, 130);

INSERT INTO emp VALUES (1001, 2, null, 'sally', 'sallyPass', '샐리', 'sally', 4, TO_DATE('1996-01-22', 'YYYY-MM-dd'), '01023233132', 
'0421102252', 'sally@daum.net', 'ddit2@ddit.kr', '213-454', '영민빌딩', '대덕인재개발원 301호', TO_DATE('2008-11-22', 'YYYY-MM-dd'), 
null, 480, null, null, 15, 140, 1, 110, 106, 130);

INSERT INTO emp VALUES (1002, 3, null, 'ryan', 'ryanPass', '라이언', 'ryan', 3, TO_DATE('1998-09-11', 'YYYY-MM-dd'), '01044448879', 
'0424457898', 'ryan@naver.com', 'ddit3@ddit.kr', '213-778', '영민빌딩', '대덕인재개발원 301호', TO_DATE('2014-12-28', 'YYYY-MM-dd'), 
null, 450, null, null, 15, 140, 1, 110, 106, 130);

INSERT INTO emp VALUES (1003, 3, null, 'edward', 'edwardPass', '에드워드', 'edward', 3, TO_DATE('1992-01-2', 'YYYY-MM-dd'), '01044448879', 
'0424457898', 'ryan@naver.com', 'ddit3@ddit.kr', '213-778', '영민빌딩', '대덕인재개발원 301호', TO_DATE('2016-11-01', 'YYYY-MM-dd'), 
null, 450, null, null, 15, 140, 1, 110, 106, 130);

INSERT INTO emp VALUES (1004, 4, null, 'cony', 'conyPass', '코니', 'cony', 3, TO_DATE('1992-5-2', 'YYYY-MM-dd'), '01031312323', 
'042123456', 'cony@naver.com', 'ddit5@ddit.kr', '213-778', '영민빌딩', '대덕인재개발원 301호', TO_DATE('2017-08-21', 'YYYY-MM-dd'), 
null, 1000, null, null, 15, 140, 1, 110, 106, 130);

-- 공통코드 유형 
SELECT *
FROM comm_type;

INSERT INTO comm_type VALUES('H001', '인사(직급)');
INSERT INTO comm_type VALUES('H002', '인사(재직상태)');
INSERT INTO comm_type VALUES('H003', '인사(직무상태)');
INSERT INTO comm_type VALUES('H004', '인사(근무상태)');
INSERT INTO comm_type VALUES('H005', '인사(로그인)');
INSERT INTO comm_type VALUES('H006', '근태');
INSERT INTO comm_type VALUES('H007', '전자결재');
INSERT INTO comm_type VALUES('H008', '일정관리');
INSERT INTO comm_type VALUES('H009', 'PMS');
INSERT INTO comm_type VALUES('H010', '일감');
INSERT INTO comm_type VALUES('H011', '사내쪽지');
INSERT INTO comm_type VALUES('H012', '화상회의');
INSERT INTO comm_type VALUES('H013', '성별');
INSERT INTO comm_type VALUES('H014', '권한');
INSERT INTO comm_type VALUES('H015', '일감진행상태');
INSERT INTO comm_type VALUES('H000', '활성화여부');

-------------------------------------------
SELECT *
FROM comm_cd;

-- 인사(직급) H001
INSERT INTO comm_cd VALUES('H001', '000', '관리자', 'Y');
INSERT INTO comm_cd VALUES('H001', '100', '사장', 'Y');
INSERT INTO comm_cd VALUES('H001', '101', '부장', 'Y');
INSERT INTO comm_cd VALUES('H001', '102', '차장', 'Y');
INSERT INTO comm_cd VALUES('H001', '103', '과장', 'Y');
INSERT INTO comm_cd VALUES('H001', '104', '대리', 'Y');
INSERT INTO comm_cd VALUES('H001', '105', '주임', 'Y');
INSERT INTO comm_cd VALUES('H001', '106', '사원', 'Y');
INSERT INTO comm_cd VALUES('H001', '107', '관리자', 'Y');

-- 인사(재직상태) H002
INSERT INTO comm_cd VALUES('H002', '110', '재직', 'Y');
INSERT INTO comm_cd VALUES('H002', '111', '휴직', 'Y');
INSERT INTO comm_cd VALUES('H002', '112', '퇴사', 'Y');

-- 인사(직무상태) H003
INSERT INTO comm_cd VALUES('H003', '120', '서버/백엔드', 'Y');
INSERT INTO comm_cd VALUES('H003', '121', '프론트엔드', 'Y');
INSERT INTO comm_cd VALUES('H003', '122', '웹풀스택', 'Y');
INSERT INTO comm_cd VALUES('H003', '123', '데이터엔지니어', 'Y');
INSERT INTO comm_cd VALUES('H003', '124', '시스템/네트워크', 'Y');
INSERT INTO comm_cd VALUES('H003', '125', '시스템/소프트웨어', 'Y');
INSERT INTO comm_cd VALUES('H003', '126', '응용프로그램', 'Y');

-- 인사(근무상태) H004
INSERT INTO comm_cd VALUES('H004', '130', '업무중', 'Y');
INSERT INTO comm_cd VALUES('H004', '131', '외근', 'Y');
INSERT INTO comm_cd VALUES('H004', '132', '출장', 'Y');
INSERT INTO comm_cd VALUES('H004', '133', '연차', 'Y');
INSERT INTO comm_cd VALUES('H004', '134', '반차', 'Y');
INSERT INTO comm_cd VALUES('H004', '135', '교육중', 'Y');
INSERT INTO comm_cd VALUES('H004', '136', '자리비움', 'Y');
INSERT INTO comm_cd VALUES('H004', '137', '업무종료', 'Y');

-- 인사(로그인) H005
INSERT INTO comm_cd VALUES('H005', '140', '동의', 'Y');
INSERT INTO comm_cd VALUES('H005', '141', '미동의', 'Y');

-- 근태 H006
INSERT INTO comm_cd VALUES('H006', '200', '연차', 'Y');
INSERT INTO comm_cd VALUES('H006', '201', '반차(오전)', 'Y');
INSERT INTO comm_cd VALUES('H006', '202', '반차(오후)', 'Y');
INSERT INTO comm_cd VALUES('H006', '203', '조퇴', 'Y');
INSERT INTO comm_cd VALUES('H006', '204', '병가', 'Y');

-- 전자결재 H007
INSERT INTO comm_cd VALUES('H007', '300', '제출', 'Y');
INSERT INTO comm_cd VALUES('H007', '301', '승인', 'Y');
INSERT INTO comm_cd VALUES('H007', '302', '미승인', 'Y');
INSERT INTO comm_cd VALUES('H007', '303', '반려', 'Y');
INSERT INTO comm_cd VALUES('H007', '304', '전결', 'Y');
INSERT INTO comm_cd VALUES('H007', '305', '완료', 'Y');
INSERT INTO comm_cd VALUES('H007', '306', '미완료', 'Y');
INSERT INTO comm_cd VALUES('H007', '307', '임시저장', 'Y');

-- 일정관리 H008
INSERT INTO comm_cd VALUES('H008', '400', '출장', 'Y');
INSERT INTO comm_cd VALUES('H008', '401', '휴가', 'Y');
INSERT INTO comm_cd VALUES('H008', '402', '휴일', 'Y');
INSERT INTO comm_cd VALUES('H008', '403', '업무', 'Y');
INSERT INTO comm_cd VALUES('H008', '404', '프로젝트', 'Y');
INSERT INTO comm_cd VALUES('H008', '405', '미팅', 'Y');
INSERT INTO comm_cd VALUES('H008', '406', '개인', 'Y');
INSERT INTO comm_cd VALUES('H008', '407', '기타', 'Y');

-- PMS H009
INSERT INTO comm_cd VALUES('H009', '500', '완료', 'Y');
INSERT INTO comm_cd VALUES('H009', '501', '진행중', 'Y');
INSERT INTO comm_cd VALUES('H009', '502', '취소', 'Y');
INSERT INTO comm_cd VALUES('H009', '503', '승인대기중', 'Y');
INSERT INTO comm_cd VALUES('H009', '504', '승인완료', 'Y');

-- 일감 H010
INSERT INTO comm_cd VALUES('H010', '600', '보통', 'Y');
INSERT INTO comm_cd VALUES('H010', '601', '낮음', 'Y');
INSERT INTO comm_cd VALUES('H010', '602', '높음', 'Y');
INSERT INTO comm_cd VALUES('H010', '603', '긴급', 'Y');
INSERT INTO comm_cd VALUES('H010', '604', '즉시', 'Y');
INSERT INTO comm_cd VALUES('H015', '605', '진행중', 'Y');
INSERT INTO comm_cd VALUES('H015', '606', '완료', 'Y');

-- 사내 쪽지 H011
INSERT INTO comm_cd VALUES('H011', '700', '읽음', 'Y');
INSERT INTO comm_cd VALUES('H011', '701', '안읽음', 'Y');
INSERT INTO comm_cd VALUES('H011', '702', '받은쪽지함', 'Y');
INSERT INTO comm_cd VALUES('H011', '703', '보낸쪽지함', 'Y');
INSERT INTO comm_cd VALUES('H011', '704', '임시저장함', 'Y');
INSERT INTO comm_cd VALUES('H011', '705', '휴지통', 'Y');

-- 화상회의 H012
INSERT INTO comm_cd VALUES('H012', '800', '진행중', 'Y');
INSERT INTO comm_cd VALUES('H012', '801', '종료', 'Y');

-- 남성 or 여성 H013
INSERT INTO comm_cd VALUES('H013', '3', '남성', 'Y');
INSERT INTO comm_cd VALUES('H013', '4', '여성', 'Y');

-- 권한 H014
INSERT INTO comm_cd VALUES('H014', '0', '관리자', 'Y');
INSERT INTO comm_cd VALUES('H014', '1', '일반사원', 'Y');
INSERT INTO comm_cd VALUES('H014', '2', '팀장', 'Y');

-- 활성 및 비활성화 H000
INSERT INTO comm_cd VALUES('H000', '1', '활성화', 'Y');
INSERT INTO comm_cd VALUES('H000', '2', '비활성화', 'Y');

-- 근태 test datas
INSERT INTO onoff VALUES(on_seq.nextval, TO_DATE('2021/02/25 08:48:19', 'YYYY/MM/dd hh24:MI:SS'),
                        TO_DATE('2021/02/25 17:58:12', 'YYYY/MM/dd hh24:MI:SS'), 1001);
INSERT INTO onoff VALUES(on_seq.nextval, TO_DATE('2021/02/24 08:55:44', 'YYYY/MM/dd hh24:MI:SS'),
                        TO_DATE('2021/02/24 18:11:02', 'YYYY/MM/dd hh24:MI:SS'), 1001);
INSERT INTO onoff VALUES(on_seq.nextval, TO_DATE('2021/02/23 08:52:32', 'YYYY/MM/dd hh24:MI:SS'),
                        TO_DATE('2021/02/23 17:58:48', 'YYYY/MM/dd hh24:MI:SS'), 1001);
INSERT INTO onoff VALUES(on_seq.nextval, TO_DATE('2021/02/12 08:38:17', 'YYYY/MM/dd hh24:MI:SS'),
                        TO_DATE('2021/02/22 17:59:46', 'YYYY/MM/dd hh24:MI:SS'), 1001);
INSERT INTO onoff VALUES(on_seq.nextval, TO_DATE('2021/03/08 09:00:11', 'YYYY/MM/dd hh24:MI:SS'),
                        TO_DATE('2021/03/08 19:22:17', 'YYYY/MM/dd hh24:MI:SS'), 1000);
INSERT INTO onoff VALUES(on_seq.nextval, TO_DATE('2021/03/09 09:00:11', 'YYYY/MM/dd hh24:MI:SS'),
TO_DATE('2021/02/26 19:22:17', 'YYYY/MM/dd hh24:MI:SS'), 1001);

INSERT INTO onoff VALUES(on_seq.nextval, TO_DATE('2021/02/26 09:00:11', 'YYYY/MM/dd hh24:MI:SS'),
TO_DATE('2021/02/26 19:22:17', 'YYYY/MM/dd hh24:MI:SS'), 1000);

INSERT INTO onoff VALUES(on_seq.nextval, TO_DATE('2021/02/26 09:00:11', 'YYYY/MM/dd hh24:MI:SS'),
TO_DATE('2021/02/26 19:22:17', 'YYYY/MM/dd hh24:MI:SS'), 1000);

INSERT INTO onoff VALUES(on_seq.nextval, TO_DATE('2021/02/26 09:00:11', 'YYYY/MM/dd hh24:MI:SS'),
TO_DATE('2021/02/26 19:22:17', 'YYYY/MM/dd hh24:MI:SS'), 1000);

COMMIT;                   
-- 누적 초 계산해보기
SELECT TO_DATE(TO_CHAR(TRUNC(sysdate)+NUMTODSINTERVAL(((offwork_time - attend_time)*24*60*60), 'second'), 'hh24:mi:ss'), 'hh24:mi:ss') "누적 합"
FROM onoff
WHERE emp_no = 1001;

SELECT *
FROM onoff
WHERE emp_no = 1001;

SELECT TO_CHAR(TRUNC(sysdate)+NUMTODSINTERVAL(281224, 'second'), 'hh24:mi:ss') "누적 합"
FROM onoff
WHERE emp_no = 1001;

SELECT TO_CHAR(TRUNC(sysdate)+NUMTODSINTERVAL(281224, 'second'), 'hh24:mi:ss') "누적 합"
from dual;

-- 281224초 시 , 분 , 초로 나타내기
SELECT Round(281224/(60*60))||':'||
       LPad(Round(Mod((281224/60),60)),2,0)||':' ||
       LPad(Round(Mod(281224,60)),2,0) "시분초"
FROM dual;

SELECT Round(((offwork_time - attend_time)*24*60*60)/(60*60))||':'||
       LPad(Round(Mod((((offwork_time - attend_time)*24*60*60)/60),60)),2,0)||':' ||
       LPad(Round(Mod(((offwork_time - attend_time)*24*60*60),60)),2,0) "시분초"
FROM onoff
WHERE emp_no = 1001;

-- 누적 초 구하기 (사원번호 1001)
SELECT SUM(((offwork_time - attend_time)*24*60*60)) "누적 초"
FROM onoff
WHERE emp_no = 1001;

SELECT SUM(((offwork_time - attend_time)*24*60*60)) "누적 초"
FROM onoff
WHERE emp_no = 1001
AND TO_DATE('20210221', 'yyyymmdd') <= attend_time
AND TO_DATE('20210227', 'yyyymmdd') >= attend_time;

-- 요일뽑기
SELECT level lv, TO_DATE(:yyyymm, 'yyyymm') + level-1 day,
      TO_CHAR(TO_DATE(:yyyymm, 'yyyymm') + LEVEL-1, 'day') date_char,
      TO_CHAR(TO_DATE(:yyyymm, 'yyyymm') + LEVEL-1, 'iw') iw
FROM dual
WHERE TO_DATE(:yyyymm, 'yyyymm') + level-1 = TO_DATE('20210202', 'yyyymmdd')
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'yyyymm')), 'dd');

SELECT * 
FROM 
(SELECT level lv, TO_DATE(:yyyymm, 'yyyymm') + level-1 day,
        TO_CHAR(TO_DATE(:yyyymm, 'yyyymm') + LEVEL-1, 'd') data_num,
        TO_CHAR(TO_DATE(:yyyymm, 'yyyymm') + LEVEL-1, 'day') date_char,
        TO_CHAR(TO_DATE(:yyyymm, 'yyyymm') + LEVEL-1, 'iw') iw
FROM onoff
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'yyyymm')), 'dd')
AND TO_CHAR(attend_time, 'yyyymm') >= TO_CHAR(TO_DATE(:yyyymm, 'yyyymm'), 'dd'));


-- 오전9시가 넘으면 지각처리
SELECT e.emp_no empno ,ko_nm, eg_nm, d.dept_nm dept_nm, 
        TO_CHAR(attend_time, 'hh24:mi') attend_time, TO_CHAR(offwork_time,'hh24:mi') offwork_time,
        TO_CHAR(attend_time, 'yyyy/mm/dd') day, TO_CHAR(attend_time, 'day') "DATE",
        CASE WHEN TO_CHAR(attend_time, 'hh24:mi:ss') > '09:00:10' THEN '지각' ELSE ' ' END late
FROM onoff o, emp e, dept d
WHERE o.emp_no = e.emp_no
AND e.dept_no = d.dept_no
AND o.emp_no = 1001
ORDER BY attend_time;

SELECT e.emp_no emp_no ,e.emp_id emp_id, ko_nm, eg_nm, d.dept_nm dept_nm, 
           TO_CHAR(attend_time, 'hh24:mi:ss') attend_time, TO_CHAR(offwork_time,'hh24:mi:ss') offwork_time,
           TO_CHAR(attend_time, 'yyyy/mm/dd') day, TO_CHAR(attend_time, 'day') "DATE",
           CASE WHEN TO_CHAR(attend_time, 'hh24:mi:ss') > '09:00:00' THEN '지각' ELSE ' ' END late
FROM onoff o, emp e, dept d
WHERE o.emp_no = e.emp_no
AND e.dept_no = d.dept_no
AND o.emp_no = 1001
ORDER BY attend_time;
    
SELECT e.ko_nm, d.dept_nm
FROM emp e, dept d
WHERE e.dept_no = d.dept_no
AND emp_no = 1001;

SELECT *
FROM comm_cd
WHERE comm_tp_char = 'H001';

-- 근태 리스트 페이징
SELECT emp_no, emp_id ,ko_nm, eg_nm, dept_nm, day, attend_time, offwork_time, "date", late, cd_ko_nm 
FROM
    (SELECT ROWNUM rn, a.*
	 FROM
		(SELECT e.emp_no emp_no ,e.emp_id emp_id, ko_nm, eg_nm, d.dept_nm dept_nm, cd_ko_nm, 
                TO_CHAR(attend_time, 'hh24:mi') attend_time, TO_CHAR(offwork_time,'hh24:mi') offwork_time,
                TO_CHAR(attend_time, 'yyyy/mm/dd') day, TO_CHAR(attend_time, 'day') "date",
                CASE WHEN TO_CHAR(attend_time, 'hh24:mi:ss') > '09:00:00' THEN '지각' ELSE ' ' END late
         FROM onoff o, emp e, dept d, comm_cd c
         WHERE o.emp_no = e.emp_no
         AND e.dept_no = d.dept_no
         AND c.comm_no = e.po_cd
         AND attend_time > sysdate-7
         AND attend_time < sysdate
         AND o.emp_no = 1
         ORDER BY day DESC, attend_time DESC) a
        WHERE ROWNUM <= :page * :pageSize )
		WHERE rn BETWEEN (:page-1) * :pageSize +1 AND :page * :pageSize;

SELECT e.emp_no emp_no ,e.emp_id emp_id, ko_nm, eg_nm, d.dept_nm dept_nm,
       TO_CHAR(attend_time, 'hh24:mi:ss') attend_time, TO_CHAR(offwork_time,'hh24:mi:ss') offwork_time,
       TO_CHAR(attend_time, 'yyyy/mm/dd') day, TO_CHAR(attend_time, 'day') "DATE",
       CASE WHEN TO_CHAR(attend_time, 'hh24:mi:ss') > '09:00:00' THEN '지각' ELSE ' ' END late
FROM onoff o, emp e, dept d
WHERE o.emp_no = e.emp_no
AND e.dept_no = d.dept_no
ORDER BY attend_time;



SELECT emp_no, emp_id ,ko_nm, eg_nm, dept_nm, day, attend_time, offwork_time, "date", late, cd_ko_nm 
FROM
    (SELECT ROWNUM rn, a.*
     FROM
		(SELECT e.emp_no emp_no ,e.emp_id emp_id, ko_nm, eg_nm, d.dept_nm dept_nm, cd_ko_nm, 
                TO_CHAR(attend_time, 'hh24:mi') attend_time, TO_CHAR(offwork_time,'hh24:mi') offwork_time,
                TO_CHAR(attend_time, 'yyyy/mm/dd') day, TO_CHAR(attend_time, 'day') "date",
                CASE WHEN TO_CHAR(attend_time, 'hh24:mi:ss') > '09:00:00' THEN '지각' ELSE ' ' END late
         FROM onoff o, emp e, dept d, comm_cd c
         WHERE o.emp_no = e.emp_no
         AND e.dept_no = d.dept_no
         AND c.comm_no = e.po_cd
         ORDER BY day DESC, attend_time DESC) a
            WHERE ROWNUM <= :page * :pageSize)
	WHERE rn BETWEEN (:page-1) * :pageSize +1 AND :page * :pageSize;

    INSERT INTO onoff VALUES(on_seq.nextval, TO_DATE('2021/03/30 08:58:11', 'YYYY/MM/dd hh24:MI:SS'),
                        TO_DATE('2021/03/30 17:48:33', 'YYYY/MM/dd hh24:MI:SS'), 1);                    
    SELECT *
    FROM onoff
    ORDER BY attend_time DESC;
    

    
   