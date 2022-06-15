select province, city, elementary_school_count as cnt 
from region 
where province!=city 
order by elementary_school_count DESC 
limit 3;
