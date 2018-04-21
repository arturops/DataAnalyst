
WITH league_table AS ( 
								SELECT 
										l.id AS league_id,
										t.team_api_id AS team_id,
										l.name AS league,
										--m.date,
										m.season AS season,
										t.team_long_name AS team,
										--m.stage,
										SUM( CASE  WHEN (m.home_team_api_id = t.team_api_id AND m.home_team_goal - m.away_team_goal >= 1) THEN 1 ELSE 0 END) AS HomeWins,
										SUM( CASE WHEN (m.home_team_api_id = t.team_api_id  AND m.home_team_goal = m.away_team_goal) THEN 1 ELSE 0 END) AS HomeDraws,
										SUM( CASE WHEN (m.home_team_api_id = t.team_api_id AND m.home_team_goal - m.away_team_goal < 0) THEN 1 ELSE 0 END) AS HomeLoses,
										SUM( CASE WHEN (m.away_team_api_id = t.team_api_id AND m.away_team_goal - m.home_team_goal >=1 ) THEN 1 ELSE 0 END) AS AwayWins,
										SUM( CASE WHEN (m.away_team_api_id = t.team_api_id AND m.away_team_goal = m.home_team_goal) THEN 1 ELSE 0 END) AS AwayDraws,
										SUM( CASE WHEN (m.away_team_api_id = t.team_api_id AND m.away_team_goal - m.home_team_goal < 0) THEN 1 ELSE 0 END) AS AwayLoses,
										SUM( CASE WHEN m.home_team_api_id = t.team_api_id THEN m.home_team_goal END ) AS HomeGoals,
										SUM( CASE WHEN m.home_team_api_id = t.team_api_id THEN m.away_team_goal END ) AS HomeGoalsConceded,
										SUM( CASE WHEN m.away_team_api_id = t.team_api_id THEN m.away_team_goal END ) AS AwayGoals,
										SUM( CASE WHEN m.away_team_api_id = t.team_api_id THEN m.home_team_goal END ) AS AwayGoalsConceded	
							FROM League l
							JOIN Match m
							ON l.id = m.league_id
							JOIN Team t
							ON m.home_team_api_id = t.team_api_id  OR m.away_team_api_id = t.team_api_id
							WHERE l.name LIKE 'England%' OR l.name LIKE 'Spain%' OR l.name LIKE 'Italy%' OR l.name LIKE 'Germany%'
										OR l.name LIKE 'France%' OR l.name LIKE 'Netherlands%'
							GROUP BY l.name, m.season, t.team_long_name
							ORDER BY m.season, HomeWins DESC, AwayWins DESC 
			),
			
			league_results AS (			
										SELECT 
													league_id,
													team_id,
													league,
													season,
													team,
													(HomeWins + AwayWins)*3 + (HomeDraws + AwayDraws) AS total_points,
													(HomeWins + AwayWins + HomeDraws + AwayDraws + HomeLoses + AwayLoses) AS total_matches,
													(HomeWins + AwayWins) AS win,
													(HomeDraws + AwayDraws)  AS draw,
													(HomeLoses + AwayLoses) AS lose,
													(HomeGoals + AwayGoals) AS total_goals,
													(HomeGoalsConceded + AwayGoalsConceded) AS total_goals_conceded,
													(HomeGoals + AwayGoals) - (HomeGoalsConceded + AwayGoalsConceded)  AS goals_difference,
													(HomeWins + HomeDraws + HomeLoses) AS home_g,
													(AwayWins + AwayDraws + AwayLoses) AS away_g,
													HomeWins AS home_wins,
													HomeDraws AS home_draws,
													HomeLoses AS home_loses,
													AwayWins AS away_wins,
													AwayDraws AS away_draws,
													AwayLoses AS away_loses,
													HomeGoals AS home_goals,
													HomeGoalsConceded AS home_goals_conceded,
													AwayGoals AS away_goals,
													AwayGoalsConceded AS away_goals_conceded
										FROM league_table
										ORDER BY season, total_points DESC 
			)
			
SELECT 
			league_id,
			team_id,
			league,
			team,
			SUM(total_points) AS total_points,
			100.0*SUM(win)/SUM(total_matches)  +  100.0*SUM(draw)/SUM(total_matches) AS overall_effectivity,
			100.0*SUM(lose)/SUM(total_matches) AS overall_ineffectuality,
			CAST(ROUND(1.0*SUM(total_points) /SUM(total_matches))  AS INT) AS avg_points_per_match,
			SUM(total_matches) AS total_matches,
			--
			SUM(win) AS total_wins,
			SUM(draw) AS total_draws,
			SUM(lose) AS total_loses,
			
			CAST( 100.0*SUM(win)/SUM(total_matches)  AS REAL) AS win_pct,
			CAST( 100.0*SUM(draw)/SUM(total_matches) AS REAL) AS draw_pct,
			CAST( 100.0*SUM(lose)/SUM(total_matches) AS REAL) AS lose_pct,
			--
			SUM(total_goals) AS total_goals,
			SUM(total_goals_conceded) AS total_goals_conceded,
			SUM(goals_difference) AS total_goals_difference,
			
			SUM(total_goals)/SUM(total_matches) AS avg_goal_per_match,
			SUM(total_goals_conceded) /SUM(total_matches) AS avg_goal_against_per_match,
			
			--
			SUM(home_g) AS home,
			SUM(away_g) AS away,
			SUM(home_wins) AS total_home_wins,
			SUM(home_draws) AS total_home_draws,
			SUM(home_loses) AS total_home_loses,
			SUM(away_wins) AS total_away_wins,
			SUM(away_draws) AS total_away_draws,
			SUM(away_loses) AS total_away_loses,
			
			
			CAST( 100.0*SUM(home_wins)/SUM(win) AS REAL) AS avg_home_win,
			CAST( 100.0*SUM(home_draws)/SUM(draw) AS REAL) AS avg_home_draw,
			CAST( 100.0*SUM(home_loses)/SUM(lose) AS REAL) AS avg_home_lose,
			
			CAST( 100.0*SUM(away_wins)/SUM(win) AS REAL) AS avg_away_win,
			CAST( 100.0*SUM(away_draws)/SUM(draw) AS REAL) AS avg_away_draw,
			CAST( 100.0*SUM(away_loses)/SUM(lose) AS REAL) AS avg_away_lose,
			
			
			CAST( 100.0*SUM(home_wins)/SUM(home_g) AS REAL) AS prop_home_win,
			CAST( 100.0*SUM(away_wins)/SUM(away_g) AS REAL) AS prop_away_win,
			
			CAST( 100.0*SUM(home_draws)/SUM(home_g) AS REAL) AS prop_home_draw,
			CAST( 100.0*SUM(away_draws)/SUM(away_g) AS REAL) AS prop_away_draw,
			
			CAST( 100.0*SUM(home_loses)/SUM(home_g) AS REAL) AS prop_home_lose,
			CAST( 100.0*SUM(away_loses)/SUM(away_g) AS REAL) AS prop_away_lose,
			
			--
			SUM(home_goals) AS total_home_goals,
			SUM(home_goals_conceded) AS total_home_goals_conceded,
			SUM(away_goals) AS total_away_goals,
			SUM(away_goals_conceded) AS total_away_goals_conceded,
			
			
			100.0*SUM(home_goals)/SUM(total_goals) AS prop_home_goals,
			100.0*SUM(away_goals)/SUM(total_goals) AS prop_away_goals,
			100.0*SUM(home_goals_conceded)/SUM(total_goals_conceded) AS prop_home_goals_recv,
			100.0*SUM(away_goals_conceded)/SUM(total_goals_conceded) AS prop_away_goals_recv,
			
			ROUND(1.0*SUM(home_goals)/SUM(total_matches) )AS avg_home_goals_per_match,
			ROUND(1.0*SUM(away_goals)/SUM(total_matches) )AS avg_away_goals_per_match
			
FROM league_results
GROUP BY team
ORDER BY overall_effectivity DESC, total_points DESC, total_goals_difference DESC

