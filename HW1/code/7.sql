select pa.preferred_foot, round(avg(pa.long_shots), 2) as `avg_long_shots`
from	(select distinct `home_player_1` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `home_player_2` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `home_player_3` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `home_player_4` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `home_player_5` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `home_player_6` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `home_player_7` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `home_player_8` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `home_player_9` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `home_player_10` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `home_player_11` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `away_player_1` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `away_player_2` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `away_player_3` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `away_player_4` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `away_player_5` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `away_player_6` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `away_player_7` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `away_player_8` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `away_player_9` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `away_player_10` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		union
		select distinct `away_player_11` as `player_api_id` from `match_info` where `season` like '2015/2016' and `league_id` = (select `id` from `league` where `name` like 'Italy Serie A')
		) as `p`, (select pa.player_api_id, pmax.date, pa.preferred_foot, pa.long_shots
					from (select `player_api_id`, max(`date`) as `date` from `player_attributes` group by `player_api_id`) as `pmax`,
						  `player_attributes` as `pa`
					where pmax.player_api_id = pa.player_api_id and pmax.date = pa.date 
				) as `pa`
where p.player_api_id is not null and p.player_api_id = pa.player_api_id 
group by pa.preferred_foot;


