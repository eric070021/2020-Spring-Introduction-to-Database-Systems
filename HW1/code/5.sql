select tp.province, tp.date
from	(select f.province, max(f.diff) as mdiff
		from	(select tp.province, 
					lag(tp.confirmed,0,0) over (partition by tp.province order by tp.date) -
					lag(tp.confirmed,1,0) over (partition by tp.province order by tp.date) as diff
				 from (select r.province
					  from  (select avg(elderly_population_ratio) as ratio
								from region
								where province = city
							) as re, region as r
					  where r.elderly_population_ratio > re.ratio
							 and r.province = r.city
					 ) as p, time_province as tp
				 where p.province = tp.province
				)as f
		group by f.province
		) as final, (select province, date, 
					lag(confirmed,0,0) over (partition by province order by date) -
					lag(confirmed,1,0) over (partition by province order by date) as diff
					from time_province) as tp
where final.mdiff = tp.diff and final.province = tp.province;
