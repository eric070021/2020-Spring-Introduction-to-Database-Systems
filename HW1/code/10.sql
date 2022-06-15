select  p.id, round(avg(p.home_age), 2) as home_player_avg_age, round(avg(away_age), 2) as away_player_avg_age, round(sum(p.home_rate * p.home_count) / sum(p.home_count), 2) as home_player_avg_rating, 
		round(sum(case when p.away_rate is not null then p.away_rate * p.away_count else 0 end) / sum(case when p.away_rate is not null then p.away_count else 0 end), 2) as away_player_avg_rating
from	(select  p.id, p.home_team_id, p.home_player, p.home_age, p.home_rate, p.home_count,
				p.away_team_id, p.away_player, p.away_age, avg(pa2.overall_rating) as away_rate, count(*) as away_count, p.date	
		from	(select  p.id, p.home_team_id, p.home_player, p.home_age, avg(pa1.overall_rating) as home_rate, count(*) as home_count,
						 p.away_team_id, p.away_player, p.away_age, p.date  	
				from	(select  p.id, p.home_team_id, p.home_player, TIMESTAMPDIFF(YEAR, p1.birthday, p.date) as home_age, p.away_team_id, p.away_player, TIMESTAMPDIFF(YEAR, p2.birthday, p.date) as away_age, p.date	
						from   (select 	landslide.id, pid.home_team_id, pid.home_player, pid.away_team_id, pid.away_player, landslide.date
								from	(select id, date from match_info where ((home_team_score - away_team_score) >= 5 and (((B365H > B365D) and (B365H > B365A)) or ((WHH > WHD) and (WHH > WHA)) or ((SJH > SJD) and (SJH > SJA))))
										or ((away_team_score - home_team_score) >= 5 and (((B365A > B365D) and (B365A > B365H)) or ((WHA > WHD) and (WHA > WHH)) or ((SJA > SJD) and (SJA > SJH)))) 
										) landslide
								left join   (select id, home_team_id, home_player_1 as home_player, away_team_id, away_player_1 as away_player from match_info 
											union
											select id, home_team_id, home_player_2 as home_player, away_team_id, away_player_2 as away_player from match_info 
											union
											select id, home_team_id, home_player_3 as home_player, away_team_id, away_player_3 as away_player from match_info 
											union
											select id, home_team_id, home_player_4 as home_player, away_team_id, away_player_4 as away_player from match_info 
											union
											select id, home_team_id, home_player_5 as home_player, away_team_id, away_player_5 as away_player from match_info 
											union
											select id, home_team_id, home_player_6 as home_player, away_team_id, away_player_6 as away_player from match_info 
											union
											select id, home_team_id, home_player_7 as home_player, away_team_id, away_player_7 as away_player from match_info 
											union
											select id, home_team_id, home_player_8 as home_player, away_team_id, away_player_8 as away_player from match_info 
											union
											select id, home_team_id, home_player_9 as home_player, away_team_id, away_player_9 as away_player from match_info 
											union
											select id, home_team_id, home_player_10 as home_player, away_team_id, away_player_10 as away_player from match_info 
											union
											select id, home_team_id, home_player_11 as home_player, away_team_id, away_player_11 as away_player from match_info
											) pid
								on pid.id = landslide.id 
								) p
						left join player p1 on p1.player_api_id = p.home_player
						left join player p2 on p2.player_api_id = p.away_player
						) p
				left join player_attributes pa1 on ((pa1.player_api_id = p.home_player) and (pa1.date > DATE_SUB(p.date,INTERVAL 6 MONTH)) and (pa1.date <= p.date))
				group by p.id, p.home_team_id, p.home_player, p.home_age, p.away_team_id, p.away_player, p.away_age, p.date 
				) p
		left join player_attributes pa2 on ((pa2.player_api_id = p.away_player) and (pa2.date > DATE_SUB(p.date,INTERVAL 6 MONTH)) and (pa2.date <= p.date))
		group by p.id, p.home_team_id, p.home_player, p.home_age, p.away_team_id, p.away_player, p.away_age, p.date
		) p
group by p.id
order by p.id ASC;

