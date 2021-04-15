
-- 연차리스트 페이징
-- work_year : 근속연수, used_vac 사용한 연차 수, total_month_vac : 사원이 가지고 있는 총 연차 수, total_vac : 사원이 가지고 있는 총 연차 수,
-- remain_vac : 잔여 연차 수
SELECT emp_no, ko_nm, dept_nm, cd_ko_nm, hire_dt, retire_dt, work_year, used_vac, total_mon_vac, total_vac, remain_vac, emp_id
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT *
FROM
((SELECT distinct(e.emp_no) emp_no,ko_nm , dept_nm , cd_ko_nm , TO_CHAR(hire_dt, 'yyyy/mm/dd') hire_dt, 
        NVL(TO_CHAR(retire_dt, 'yyyy/mm/dd'), '-') retire_dt, emp_id, 
        TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) work_year
FROM emp e, comm_cd c, dept d, vacation v
WHERE e.po_cd = c.comm_no
AND d.dept_no = e.dept_no
AND v.emp_no(+) = e.emp_no))q,
((SELECT NVL(SUM(used_vac), 0) used_vac, 
        CASE WHEN vac_cnt > 13 THEN 0 ELSE vac_cnt END total_mon_vac,
        CASE WHEN vac_cnt < 13 THEN 0 ELSE vac_cnt END total_vac,
        vac_cnt - NVL(SUM(used_vac), 0) remain_vac, emp_no emp_no_b
FROM
(SELECT e.emp_no emp_no, (v.e_dt - v.s_dt) + 1 used_vac, vac_cnt  
FROM emp e, vacation v
WHERE e.emp_no = v.emp_no(+))
GROUP BY emp_no, vac_cnt)
ORDER BY emp_no)b
WHERE q.emp_no = b.emp_no_b) a
WHERE ROWNUM <= :page * :pageSize)
WHERE rn BETWEEN (:page-1) * :pageSize +1 AND :page * :pageSize;

-- 근속 월수 데이터
SELECT hire_dt, sysdate 오늘날짜, TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) 근속년수,
TRUNC(MONTHS_BETWEEN(sysdate, hire_dt)) 근속월수
FROM emp
ORDER BY hire_dt;

SELECT TO_CHAR(TRUNC(sysdate)+NUMTODSINTERVAL(281224, 'second'), 'hh24:mi:ss') "근속연수"
from dual;

-- 연차 테스트 데이터
INSERT INTO vacation VALUES(vac_seq.nextval, TO_DATE('20210212', 'YYYY/MM/dd'),
TO_DATE('20210215', 'YYYY/MM/dd'), 1000, 200);

INSERT INTO vacation VALUES(vac_seq.nextval, TO_DATE('20210122', 'YYYY/MM/dd'), 
null, 1000, 201);

INSERT INTO vacation VALUES(vac_seq.nextval, TO_DATE('20210122', 'YYYY/MM/dd'), 
null, 1001, 202);

INSERT INTO vacation VALUES(vac_seq.nextval, TO_DATE('20210212', 'YYYY/MM/dd'), 
null, 1003, 202);

INSERT INTO vacation VALUES(vac_seq.nextval, TO_DATE('20210106', 'YYYY/MM/dd'), 
TO_DATE('20210111', 'YYYY/MM/dd'), 1004, 200);

COMMIT;

SELECT TO_CHAR(offwork_time, 'hh24:mi:ss') offwork_time
FROM onoff
WHERE TO_CHAR(attend_time, 'yyyy/mm/dd') = TO_CHAR(sysdate, 'yyyy/mm/dd')
AND emp_no = 0;

-- 당일 근로시간 쿼리
SELECT COUNT(offwork_time)
FROM onoff
WHERE TO_CHAR(attend_time, 'yyyy/mm/dd') = TO_CHAR(sysdate, 'yyyy/mm/dd')
AND emp_no = 1;

-- 사원 근속연수에따라 연차 업데이트하는 쿼리
UPDATE emp SET vac_cnt = NVL((CASE 
            WHEN TRUNC(MONTHS_BETWEEN(sysdate, hire_dt)) = 1 THEN 1
            WHEN TRUNC(MONTHS_BETWEEN(sysdate, hire_dt)) = 2 THEN 2
            WHEN TRUNC(MONTHS_BETWEEN(sysdate, hire_dt)) = 3 THEN 3
            WHEN TRUNC(MONTHS_BETWEEN(sysdate, hire_dt)) = 4 THEN 4
            WHEN TRUNC(MONTHS_BETWEEN(sysdate, hire_dt)) = 5 THEN 5
            WHEN TRUNC(MONTHS_BETWEEN(sysdate, hire_dt)) = 6 THEN 6
            WHEN TRUNC(MONTHS_BETWEEN(sysdate, hire_dt)) = 7 THEN 7
            WHEN TRUNC(MONTHS_BETWEEN(sysdate, hire_dt)) = 8 THEN 8
            WHEN TRUNC(MONTHS_BETWEEN(sysdate, hire_dt)) = 9 THEN 9
            WHEN TRUNC(MONTHS_BETWEEN(sysdate, hire_dt)) = 10 THEN 10 
            WHEN TRUNC(MONTHS_BETWEEN(sysdate, hire_dt)) = 11 THEN 11
            WHEN TRUNC(MONTHS_BETWEEN(sysdate, hire_dt)) = 12 THEN 12
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 1 THEN 15
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 2 THEN 15
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 3 THEN 16
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 4 THEN 16
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 5 THEN 17
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 6 THEN 17
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 7 THEN 18
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 8 THEN 18
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 9 THEN 19
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 10 THEN 19
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 11 THEN 20
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 12 THEN 20
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 13 THEN 21
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 14 THEN 21
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 15 THEN 22
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 16 THEN 22
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 17 THEN 23 
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 18 THEN 23
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 19 THEN 24
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 20 THEN 24
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 21 THEN 25
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 22 THEN 25
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 23 THEN 26
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 24 THEN 26
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 25 THEN 27
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 26 THEN 27
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 27 THEN 28
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 28 THEN 28
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 29 THEN 29
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 30 THEN 29
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 31 THEN 30
            WHEN TRUNC(TRUNC(MONTHS_BETWEEN(sysdate, hire_dt))/12) = 32 THEN 30
            END), 0);
            
