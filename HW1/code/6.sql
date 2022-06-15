select  time.date, round(d.coronavirus,2) as coronavirus, time.confirmed as confirmed_accumulate, 
		lag(time.confirmed,0,0) over (order by time.date) -
		lag(time.confirmed,1,0) over (order by time.date) as confirmed_add,
		time.deceased as dead_accumulate,
		lag(time.deceased,0,0) over (order by time.date) -
		lag(time.deceased,1,0) over (order by time.date) as dead_add
from	(select st.date, st.coronavirus
		from (select std(coronavirus)*2 as threshold
			  from search_trend
			  where date between '2019-12-25' and '2020-06-29'
			  ) as s, search_trend as st
		where st.coronavirus > s.threshold
		) as d, time 
where d.date = time.date;

