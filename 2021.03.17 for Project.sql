-- 연차리스트 페이징
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
AND q.dept_nm LIKE '%%'
AND q.ko_nm LIKE '%%'
AND hire_dt > TO_DATE('20081111', 'yyyymmdd')
AND hire_dt < TO_DATE('20161211', 'yyyymmdd')
AND q.emp_no = 1000)a
WHERE ROWNUM <= :page * :pageSize)
WHERE rn BETWEEN (:page-1) * :pageSize +1 AND :page * :pageSize;

	SELECT COUNT(*)
	FROM
	((SELECT distinct(e.emp_no) emp_no,ko_nm , dept_nm , cd_ko_nm , TO_CHAR(hire_dt, 'yyyy/mm/dd') hire_dt, 
        NVL(TO_CHAR(retire_dt, 'yyyy/mm/dd'), '-') retire_dt, 
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
            AND q.dept_nm LIKE '%%'
            AND q.ko_nm LIKE '%%';


