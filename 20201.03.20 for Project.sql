-- 연차사용내역 페이징
SELECT *
FROM 
(SELECT ROWNUM rn,a.*
FROM
(SELECT s_dt, e_dt, e.ko_nm, c.cd_ko_nm, dept_nm,
        CASE
            WHEN c.comm_no = 201 THEN (v.e_dt - v.s_dt) + 0.5
            WHEN c.comm_no = 202 THEN (v.e_dt - v.s_dt) + 0.5 ELSE (e_dt - s_dt) + 1 
            END used_vac
FROM vacation v, emp e, comm_cd c, dept d
WHERE v.emp_no = e.emp_no
AND C.COMM_NO = v.vac_cd
AND d.dept_no = e.dept_no
ORDER BY v.vac_no) a
WHERE ROWNUM <= :page * :pageSize )
WHERE rn BETWEEN (:page-1) * :pageSize +1 AND :page * :pageSize;

SELECT COUNT(*)
FROM vacation v, emp e, comm_cd c, dept d
WHERE v.emp_no = e.emp_no
AND C.COMM_NO = v.vac_cd
AND d.dept_no = e.dept_no
ORDER BY v.vac_no;

-- 스프링에서 가져온 페이징 
SELECT ko_nm, cd_ko_nm ,emp_id, dept_nm, hire_dt, retire_dt, work_year, total_mon_vac, total_vac, used_vac, remain_vac
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
                AND v.emp_no(+) = e.emp_no)) q, 
		((SELECT NVL(SUM(used_vac), 0) used_vac,  
		         CASE WHEN vac_cnt > 13 THEN 0 ELSE vac_cnt END total_mon_vac, 
		         CASE WHEN vac_cnt < 13 THEN 0 ELSE vac_cnt END total_vac, 
		         vac_cnt - NVL(SUM(used_vac), 0) remain_vac, emp_no emp_no_b 
		 FROM 
		      (SELECT e.emp_no emp_no,
              CASE WHEN comm_no = 201 THEN (e_dt - s_dt) + 0.5
                   WHEN comm_no = 202 THEN (e_dt - s_dt) + 0.5 ELSE (e_dt - s_dt) + 1 END used_vac
                   , vac_cnt   
               FROM emp e, vacation v, comm_cd c 
               WHERE e.emp_no = v.emp_no(+)
               AND c.comm_no(+) = v.vac_cd)
        GROUP BY emp_no, vac_cnt) 
		ORDER BY emp_no) b 
		WHERE q.emp_no = b.emp_no_b) a );
  
-- 지각 여부 및 근태정보
    SELECT e.emp_no emp_no ,e.emp_id emp_id, ko_nm, eg_nm, d.dept_nm dept_nm,
            TO_CHAR(attend_time, 'hh24:mi:ss') attend_time, NVL(TO_CHAR(offwork_time,'hh24:mi:ss'), '-') offwork_time,
            TO_CHAR(attend_time, 'yyyy/mm/dd') day, TO_CHAR(attend_time, 'day') "DATE",
            CASE WHEN TO_CHAR(attend_time, 'hh24:mi:ss') > '09:00:00' THEN '지각' ELSE '-' END late
    FROM onoff o, emp e, dept d
    WHERE o.emp_no = e.emp_no
    AND e.dept_no = d.dept_no
    AND o.emp_no = 1
    ORDER BY day DESC;
   
        
-- 개인 연차사용내역 리스트
SELECT s_dt, e_dt, e.ko_nm, c.cd_ko_nm, dept_nm,
    CASE
		WHEN c.comm_no = 201 THEN (v.e_dt - v.s_dt) + 0.5
		WHEN c.comm_no = 202 THEN (v.e_dt - v.s_dt) + 0.5 ELSE (e_dt - s_dt) + 1 
    END used_vac
FROM vacation v, emp e, comm_cd c, dept d
WHERE v.emp_no = e.emp_no
AND C.COMM_NO = v.vac_cd
AND d.dept_no = e.dept_no 
AND v.emp_no = 1
ORDER BY v.vac_no;
        
        
