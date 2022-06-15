select 	sum(case when ((home_team_score > away_team_score) and (B365H < B365D) and (B365H < B365A)) then B365H 
				  when ((away_team_score > home_team_score) and (B365A < B365D) and (B365A < B365H)) then B365A 
				  when ((home_team_score <= away_team_score) and (B365H < B365D) and (B365H < B365A)) then -B365H 
				  when ((away_team_score <= home_team_score) and (B365A < B365D) and (B365A < B365H)) then -B365A else 0 end) as B365_betsmall_win,
		sum(case when ((home_team_score > away_team_score) and (WHH < WHD) and (WHH < WHA)) then WHH 
				  when ((away_team_score > home_team_score) and (WHA < WHH) and (WHA < WHD)) then WHA 
				  when ((home_team_score <= away_team_score) and (WHH < WHD) and (WHH < WHA)) then -WHH 
				  when ((away_team_score <= home_team_score) and (WHA < WHH) and (WHA < WHD)) then -WHA  else 0 end) as WH_betsmall_win,
		sum(case when ((home_team_score > away_team_score) and (SJH < SJD) and (SJH < SJA)) then SJH 
				  when ((away_team_score > home_team_score) and (SJA < SJD) and (SJA < SJH)) then SJA 
				  when ((home_team_score <= away_team_score) and (SJH < SJD) and (SJH < SJA)) then -SJH 
				  when ((away_team_score <= home_team_score) and (SJA < SJD) and (SJA < SJH)) then -SJA   else 0 end) as SJ_betsmall_win from match_info
				  where B365H is not null and B365D is not null and B365A is not null and
						WHH is not null and WHD is not null and WHA is not null and
						SJH is not null and SJD is not null and SJA is not null and home_team_score is not null and away_team_score is not null;
						
select 	sum(case when ((home_team_score > away_team_score) and (B365H > B365D) and (B365H > B365A)) then B365H 
				  when ((away_team_score > home_team_score) and (B365A > B365D) and (B365A > B365H)) then B365A 
				  when ((home_team_score <= away_team_score) and (B365H > B365D) and (B365H > B365A)) then -B365H 
				  when ((away_team_score <= home_team_score) and (B365A > B365D) and (B365A > B365H)) then -B365A else 0 end) as B365_betbig_win,
		sum(case when ((home_team_score > away_team_score) and (WHH > WHD) and (WHH > WHA)) then WHH 
				  when ((away_team_score > home_team_score) and (WHA > WHH) and (WHA > WHD)) then WHA 
				  when ((home_team_score <= away_team_score) and (WHH > WHD) and (WHH > WHA)) then -WHH 
				  when ((away_team_score <= home_team_score) and (WHA > WHH) and (WHA > WHD)) then -WHA  else 0 end) as WH_betbig_win,
		sum(case when ((home_team_score > away_team_score) and (SJH > SJD) and (SJH > SJA)) then SJH 
				  when ((away_team_score > home_team_score) and (SJA > SJD) and (SJA > SJH)) then SJA 
				  when ((home_team_score <= away_team_score) and (SJH > SJD) and (SJH > SJA)) then -SJH 
				  when ((away_team_score <= home_team_score) and (SJA > SJD) and (SJA > SJH)) then -SJA   else 0 end) as SJ_betbig_win from match_info
				  where B365H is not null and B365D is not null and B365A is not null and
						WHH is not null and WHD is not null and WHA is not null and
						SJH is not null and SJD is not null and SJA is not null and home_team_score is not null and away_team_score is not null;
						
select 	sum(case when ((home_team_score = away_team_score) and (B365D > B365H) and (B365D > B365A)) then B365D
				 when ((home_team_score != away_team_score) and (B365D > B365H) and (B365D > B365A)) then -B365D else 0 end) as B365_betbigdual_win,
		sum(case when ((home_team_score = away_team_score) and (WHD > WHH) and (WHD > WHA)) then WHD
				 when ((home_team_score != away_team_score) and (WHD > WHH) and (WHD > WHA)) then -WHD else 0 end) as WH_betbigdual_win,
		sum(case when ((home_team_score = away_team_score) and (SJD > SJH) and (SJD > SJA)) then SJD
				 when ((home_team_score != away_team_score) and (SJD > SJH) and (SJD > SJA)) then -SJD else 0 end) as SJ_betbigdual_win from match_info
				  where B365H is not null and B365D is not null and B365A is not null and
						WHH is not null and WHD is not null and WHA is not null and
						SJH is not null and SJD is not null and SJA is not null and home_team_score is not null and away_team_score is not null;
						
select 	sum(case when ((home_team_score = away_team_score) and (B365D < B365H) and (B365D < B365A)) then B365D
				 when ((home_team_score != away_team_score) and (B365D < B365H) and (B365D < B365A)) then -B365D else 0 end) as B365_betsmalldual_win,
		sum(case when ((home_team_score = away_team_score) and (WHD < WHH) and (WHD < WHA)) then WHD
				 when ((home_team_score != away_team_score) and (WHD < WHH) and (WHD < WHA)) then -WHD else 0 end) as WH_betsmalldual_win,
		sum(case when ((home_team_score = away_team_score) and (SJD < SJH) and (SJD < SJA)) then SJD
				 when ((home_team_score != away_team_score) and (SJD < SJH) and (SJD < SJA)) then -SJD else 0 end) as SJ_betsmalldual_win from match_info
				  where B365H is not null and B365D is not null and B365A is not null and
						WHH is not null and WHD is not null and WHA is not null and
						SJH is not null and SJD is not null and SJA is not null and home_team_score is not null and away_team_score is not null;

										