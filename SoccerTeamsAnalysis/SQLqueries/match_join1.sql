
SELECT --c.*,
			l.name,
			m.date,
			m.season,
			m.stage,
			m.home_team_api_id,
			m.away_team_api_id,
			t1.team_long_name,
			m.home_team_goal,
			m.away_team_goal,
			t2.team_long_name,
			m.goal,
			m.possession
FROM Country c
JOIN League l
ON  c.id = l.country_id
JOIN Match m
ON c.id = m.country_id AND l.id = m.league_id
JOIN Team t1
ON m.home_team_api_id = t1.team_api_id 
JOIN Team t2
ON m.away_team_api_id = t2.team_api_id 
WHERE c.name IN ('Spain','England')
