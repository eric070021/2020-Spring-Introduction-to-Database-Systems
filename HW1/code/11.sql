select  sum(case when m.home_team_score > m.away_team_score then 1 else 0 end) / count(*) as home_team_win_rate,
		sum(case when ((p.home_strong > p.away_strong) and (m.home_team_score > m.away_team_score)) then 1 
				 when ((p.away_strong > p.home_strong) and (m.away_team_score > m.home_team_score)) then 1 else 0 end) / count(*) as strong_team_win_rate
from	(select  p.id, 
				sum(case when p.home_rate is not null then p.home_rate else 0 end) / count(p.home_rate) as home_strong, 
				sum(case when p.away_rate is not null then p.away_rate else 0 end) / count(p.away_rate) as away_strong 
		from	(select  p.id, p.home_team_id, p.home_player, p.home_rate, p.away_team_id, p.away_player,  max(pa2.overall_rating) as away_rate
				from	(select  p.id, p.home_team_id, p.home_player, max(pa1.overall_rating) as home_rate, p.away_team_id, p.away_player, p.date
						from	(select id, home_team_id, home_player_1 as home_player, away_team_id, away_player_1 as away_player, date from match_info 
								union
								select id, home_team_id, home_player_2 as home_player, away_team_id, away_player_2 as away_player, date from match_info 
								union
								select id, home_team_id, home_player_3 as home_player, away_team_id, away_player_3 as away_player, date from match_info 
								union
								select id, home_team_id, home_player_4 as home_player, away_team_id, away_player_4 as away_player, date from match_info 
								union
								select id, home_team_id, home_player_5 as home_player, away_team_id, away_player_5 as away_player, date from match_info 
								union
								select id, home_team_id, home_player_6 as home_player, away_team_id, away_player_6 as away_player, date from match_info 
								union
								select id, home_team_id, home_player_7 as home_player, away_team_id, away_player_7 as away_player, date from match_info 
								union
								select id, home_team_id, home_player_8 as home_player, away_team_id, away_player_8 as away_player, date from match_info 
								union
								select id, home_team_id, home_player_9 as home_player, away_team_id, away_player_9 as away_player, date from match_info 
								union
								select id, home_team_id, home_player_10 as home_player, away_team_id, away_player_10 as away_player, date from match_info 
								union
								select id, home_team_id, home_player_11 as home_player, away_team_id, away_player_11 as away_player, date from match_info 
								) p
						left join player_attributes pa1 on ((pa1.player_api_id = p.home_player)  and (pa1.overall_rating <= p.date))
						group by p.id, p.home_team_id, p.home_player, p.away_team_id, p.away_player, p.date
						) p
				left join player_attributes pa2 on ((pa2.player_api_id = p.away_player) and (pa2.overall_rating <= p.date))	
				group by p.id, p.home_team_id, p.home_player, p.home_rate, p.away_team_id, p.away_player, p.date
				) p
		where p.home_player is not null or p.away_player is not null
		group by p.id
		order by p.id ASC
		) p
left join match_info m on (m.id = p.id);





