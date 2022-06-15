select l.name, league_rate.prob 
from	(select m.league_id, (sum(case when m.home_team_score > m.away_team_score and team.team_id = m.home_team_id then 1 else 0 end) +
							sum(case when m.away_team_score > m.home_team_score and team.team_id = m.away_team_id then 1 else 0 end)) / count(*) as prob
		from	(select pid.id, pid.team_id
				from	(select id, home_team_id as team_id, home_player_1 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, home_team_id as team_id, home_player_2 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, home_team_id as team_id, home_player_3 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, home_team_id as team_id, home_player_4 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, home_team_id as team_id, home_player_5 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, home_team_id as team_id, home_player_6 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, home_team_id as team_id, home_player_7 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, home_team_id as team_id, home_player_8 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, home_team_id as team_id, home_player_9 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, home_team_id as team_id, home_player_10 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, home_team_id as team_id, home_player_11 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, away_team_id as team_id, away_player_1 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, away_team_id as team_id, away_player_2 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, away_team_id as team_id, away_player_3 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, away_team_id as team_id, away_player_4 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, away_team_id as team_id, away_player_5 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, away_team_id as team_id, away_player_6 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, away_team_id as team_id, away_player_7 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, away_team_id as team_id, away_player_8 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, away_team_id as team_id, away_player_9 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, away_team_id as team_id, away_player_10 as player_api_id from match_info where `season` like '2015/2016'
						union
						select id, away_team_id as team_id, away_player_11 as player_api_id from match_info where `season` like '2015/2016'
						) as pid
				left join player
				on pid.player_api_id = player.player_api_id
				where pid.player_api_id is not null 
				group by pid.id, pid.team_id
				having avg(player.height) > 180
				) as team
		left join match_info m
		on team.id = m.id
		group by m.league_id
		) as league_rate 
left join league l
on league_rate.league_id = l.id;



						
						
						

