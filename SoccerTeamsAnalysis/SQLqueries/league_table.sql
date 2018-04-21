
WITH league_table AS ( 
								SELECT 
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
							WHERE l.name like 'England%'
							GROUP BY l.name, m.season, t.team_long_name
							ORDER BY m.season, HomeWins DESC, AwayWins DESC 
			),
			
			league_results AS (			
										SELECT 
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
										

SELECT  *
FROM league_results							


									
								


