debug-scripts for testing - do not delete
------------------------------------------------------------------------------------------------------------------------
SELECT
distinct dim.name AS event_name
FROM
`hill-climb-racing-2-67064304.com_fingersoft_hillclimbracing2_IOS.app_events_20170507`,
UNNEST(event_dim) AS dim order by 1
------------------------------------------------------------------------------------------------------------------------
SELECT
*
FROM
`hill-climb-racing-2-67064304.com_fingersoft_hillclimbracing2_IOS.app_events_20170507`,
UNNEST(event_dim) AS dim where dim.name = 'cheater_detected'
------------------------------------------------------------------------------------------------------------------------
SELECT
event.name,
params.key
FROM
`hill-climb-racing-2-67064304.com_fingersoft_hillclimbracing2_IOS.app_events_intraday_20170618`,
UNNEST(event_dim) AS event,
UNNEST(event.params) AS params
WHERE
user_dim.app_info.app_version = '1.6.0'
AND event.name IN ('tuning_part_upgraded',
cokolvek_dalsie')
GROUP BY
1,2
ORDER BY
1
------------------------------------------------------------------------------------------------------------------------
tsttst