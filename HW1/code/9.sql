select team.team_long_name, t.avg_win_score
from	(select  win_team.team_id, round(sum(case when win_team.team_id = m.home_team_id then m.home_team_score - m.away_team_score 
								  when win_team.team_id = m.away_team_id then m.away_team_score - m.home_team_score end) / count(*), 2)as avg_win_score, avg(win_team.win_point) as win_point
		from	(select home.team_id, (home.point + away.point)/(home.match_count + away.match_count) as win_point
				from (select home_team_id as team_id, sum(case when home_team_score > away_team_score then 2 when home_team_score < away_team_score then 0 when home_team_score = away_team_score then 1 end) as point,
					 count(*) as match_count
					 from match_info where season like '2015/2016' group by home_team_id) home
				left join (select away_team_id as team_id, sum(case when away_team_score > home_team_score then 2 when away_team_score < home_team_score then 0 when away_team_score = home_team_score then 1 end) as point,
						  count(*) as match_count
						  from match_info where season like '2015/2016' group by away_team_id) away
				on home.team_id = away.team_id
				order by (home.point + away.point)/(home.match_count + away.match_count) DESC
				limit 5
				) win_team
		left join match_info as m
		on (m.season like '2015/2016' and (win_team.team_id = m.home_team_id or win_team.team_id = m.away_team_id))
		group by win_team.team_id
		) t
left join team
on team.id = t.team_id
order by t.win_point DESC;