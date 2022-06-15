select r.province, w.cnt 
from (select code,count(avg_relative_humidity) as cnt
	  from weather
	  where avg_relative_humidity>70 and date like '2016-05%'
	  group by code
	  order by count(avg_relative_humidity) DESC
	  limit 3
	  ) as w, region as r 
where w.code = r.code;