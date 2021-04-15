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
		WHERE q.emp_no = b.emp_no_b
		AND q.emp_no = 1) a 
		WHERE ROWNUM <= :page * :pageSize ) 
WHERE rn BETWEEN (:page-1) * :pageSize +1 AND :page * :pageSize;
        
        
-- 연차정보
SELECT NVL(SUM(used_vac), 0) used_vac,  
		CASE WHEN vac_cnt > 13 THEN 0 ELSE vac_cnt END total_mon_vac, 
		CASE WHEN vac_cnt < 13 THEN 0 ELSE vac_cnt END total_vac, 
		vac_cnt - NVL(SUM(used_vac), 0) remain_vac
FROM 
   (SELECT e.emp_no emp_no, (v.e_dt - v.s_dt) + 1 used_vac, vac_cnt   
	FROM emp e, vacation v 
	WHERE e.emp_no = v.emp_no(+)
    AND v.emp_no = 1) 
GROUP BY emp_no, vac_cnt;
        

 --- 연차 사용 현황 test
SELECT *
FROM vacation;
        
INSERT INTO vacation VALUES(vac_seq.nextval, sysdate+1, sysdate+3, 1, 200 );
        
COMMIT;

DELETE vacation WHERE TO_CHAR(s_dt, 'yyyymmdd') = TO_CHAR(sysdate+1, 'yyyymmdd'); 
        
--
SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT e.emp_no emp_no ,e.emp_id emp_id, ko_nm, eg_nm, d.dept_nm dept_nm, cd_ko_nm,
        TO_CHAR(attend_time, 'hh24:mi') attend_time, TO_CHAR(offwork_time,'hh24:mi') offwork_time,
        TO_CHAR(attend_time, 'yyyy/mm/dd') day, TO_CHAR(attend_time, 'day') "date",
        CASE WHEN TO_CHAR(attend_time, 'hh24:mi:ss') > '09:00:00' THEN '지각' ELSE ' ' END late,
        TO_CHAR(offwork_time - TO_CHAR(attend_time, 'hh24')/24,'hh24') || '.' ||           
        TO_CHAR(offwork_time - TO_CHAR(attend_time, 'mi')/(24*60),'mi') work_time
FROM onoff o, emp e, dept d, comm_cd c
WHERE o.emp_no = e.emp_no
AND e.dept_no = d.dept_no
AND c.comm_no = e.po_cd
AND attend_time <= TO_CHAR(sysdate, 'yyyymmdd')
AND o.emp_no = 1
ORDER BY day DESC, attend_time DESC) a
WHERE ROWNUM <= 1 * 5 )
WHERE rn BETWEEN (1-1) * 5 + 1 AND 1 * 5;

UPDATE onoff SET offwork_time = TO_DATE(TO_CHAR(attend_time, 'yyyy/mm/dd'));

-- 당일 근로시간 쿼리
SELECT attend_time, offwork_time, TO_CHAR(offwork_time - TO_CHAR(attend_time, 'hh24')/24,'hh24') || ':' ||           
       TO_CHAR(offwork_time - TO_CHAR(attend_time, 'mi')/(24*60),'mi') || ':' ||      
       TO_CHAR(offwork_time - TO_CHAR(attend_time, 'ss')/(24*60*60),'ss') work_time
FROM onoff
WHERE TO_CHAR(attend_time, 'yyyy/mm/dd') = TO_CHAR(sysdate, 'yyyy/mm/dd');
--
SELECT NVL(SUM(used_vac), 0) used_vac,  
         CASE WHEN vac_cnt > 13 THEN 0 ELSE vac_cnt END total_mon_vac, 
         CASE WHEN vac_cnt < 13 THEN 0 ELSE vac_cnt END total_vac, 
          vac_cnt - NVL(SUM(used_vac), 0) remain_vac
FROM 
    (SELECT e.emp_no emp_no, (v.e_dt - v.s_dt) + 1 used_vac, vac_cnt   
     FROM emp e, vacation v 
     WHERE e.emp_no = v.emp_no(+)
     AND e.emp_no = 3) 
     GROUP BY emp_no, vac_cnt;
        
----------- 근태 그래프 쿼리 최근 7일
SELECT *
    FROM
    (SELECT ROWNUM rn, a.*
     FROM
		(SELECT e.emp_no emp_no ,e.emp_id emp_id, ko_nm, eg_nm, d.dept_nm dept_nm, cd_ko_nm,
		        TO_CHAR(attend_time, 'hh24:mi') attend_time, TO_CHAR(offwork_time,'hh24:mi') offwork_time,
		        TO_CHAR(attend_time, 'yyyy/mm/dd') day, TO_CHAR(attend_time, 'day') "date",
		        CASE WHEN TO_CHAR(attend_time, 'hh24:mi:ss') > '09:00:00' THEN '지각' ELSE ' ' END late,
		        TO_CHAR(offwork_time - TO_CHAR(attend_time, 'hh24')/24,'hh24') || '.' ||           
		        TO_CHAR(offwork_time - TO_CHAR(attend_time, 'mi')/(24*60),'mi') work_time
		FROM onoff o, emp e, dept d, comm_cd c
		WHERE o.emp_no = e.emp_no
		AND e.dept_no = d.dept_no
		AND c.comm_no = e.po_cd
		AND attend_time <= TO_CHAR(sysdate, 'yyyymmdd')
		AND o.emp_no = 1
		ORDER BY day DESC, attend_time) a
		WHERE ROWNUM <= 1 * 7 )
WHERE rn BETWEEN (1-1) * 7 + 1 AND 1 * 7;



