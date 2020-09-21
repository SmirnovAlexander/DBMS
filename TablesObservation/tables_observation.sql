/* show jobs of employees */
select ename, job
from   emp

/* number of employees per department */
select    dept.dname, count(emp.empno) as count
from      dept
left join emp
on        emp.deptno = dept.deptno
group by  dept.dname
order by  count desc

/* average salary per job */
select   job, round(avg(sal), 2) as salary
from     emp
group by job
order by salary desc

/* min and max salary per job */
select   job, min(sal) as min, max(sal) as max
from     emp
group by job
order by min asc

/* summary salary per department */
select    dept.dname, coalesce(sum(emp.sal), 0) as sum
from      dept
left join emp
on        emp.deptno = dept.deptno
group by  dept.dname
order by  sum

/* form every possible manager pairs */
select emp1.ename, emp2.ename
from   emp emp1
join   emp emp2 on emp1.empno < emp2.empno
where  emp1.job='MANAGER' and emp2.job='MANAGER'

/* comparing all people to their managers (MGR) */
select   emp1.empno, emp1.job, emp1.deptno, emp2.empno as MGR_EMPNO, emp2.job as MGR_JOB, emp2.deptno as MGR_DEPTNO
from     emp emp1
join     emp emp2
on       emp1.mgr = emp2.empno
order by emp1.job
