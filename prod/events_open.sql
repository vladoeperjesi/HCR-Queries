SELECT
  uid,
  country,
  app_version,
  device_category,
  mobile_brand_name,
  mobile_model_name,
  mobile_marketing_name,
  event_name,
  platform,
  event_timestamp_ms,
  event_timestamp,
  user_creation_timestamp,
  days_retained,
  ltv_revenue,
  up_first_app_version,
  up_gems,
  up_coins,
  up_track_level,
  up_first_open_time,
  up_iapPurchasedCount,
  up_track_level_backend,
  up_rank,
  up_user_property_rank,
  ep_coins,
  ep_firebase_event_origin,
  ep_firebase_screen_class,
  ep_firebase_screen_id,
  ep_gems,
  ep_session_coins,
  ep_session_gems,
  ep_session_time,
  ep_total_coins,
  ep_total_gems,
  ep_total_play_time,
  ep_total_time,
  ep_wc_rank
FROM
  [hill-climb-racing-2-67064304:materialized_views.events_flat_20170702]
WHERE
  (event_name = 'open_league_overview'
    OR event_name = 'open_player_profile'
    OR event_name = 'open_rank_leaderboard')
  AND uid NOT IN (
  SELECT
    uid
  FROM
    [hill-climb-racing-2-67064304:materialized_views.lifetime_cheaters_hackers])