SELECT
  user_dim.user_id AS uid,
  user_dim.geo_info.country,
  user_dim.app_info.app_version,
  user_dim.device_info.device_category,
  user_dim.device_info.mobile_brand_name,
  user_dim.device_info.mobile_model_name,
  user_dim.device_info.mobile_marketing_name,
  dim.name AS event_name,
  LOWER(user_dim.app_info.app_platform) AS platform,
  TIMESTAMP_MICROS(dim.timestamp_micros) AS event_timestamp_ms,
  dim.timestamp_micros AS event_timestamp,
  TIMESTAMP_MICROS(user_dim.first_open_timestamp_micros) AS user_creation_timestamp,
  DATE_DIFF(EXTRACT(date
    FROM
      TIMESTAMP_MICROS(dim.timestamp_micros)), EXTRACT(date
    FROM
      TIMESTAMP_MICROS(user_dim.first_open_timestamp_micros)), DAY) AS days_retained,
  user_dim.ltv_info.revenue as ltv_revenue,
(SELECT value.value.string_value FROM UNNEST(user_dim.user_properties) WHERE key = "first_app_version" ) AS up_first_app_version,
(SELECT value.value.string_value FROM UNNEST(user_dim.user_properties) WHERE key = "gems" ) AS up_gems,
(SELECT value.value.string_value FROM UNNEST(user_dim.user_properties) WHERE key = "coins" ) AS up_coins,
(SELECT value.value.string_value FROM UNNEST(user_dim.user_properties) WHERE key = "track_level" ) AS up_track_level,
(SELECT value.value.int_value FROM UNNEST(user_dim.user_properties) WHERE key = "first_open_time" ) AS up_first_open_time,
(SELECT value.value.string_value FROM UNNEST(user_dim.user_properties) WHERE key = "iapPurchasedCount" ) AS up_iapPurchasedCount,
(SELECT value.value.string_value FROM UNNEST(user_dim.user_properties) WHERE key = "track_level_backend" ) AS up_track_level_backend,
(SELECT value.value.string_value FROM UNNEST(user_dim.user_properties) WHERE key = "Rank" ) AS up_rank,
(SELECT value.value.string_value FROM UNNEST(user_dim.user_properties) WHERE key = "rank" ) AS up_user_property_rank,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "action" ) AS ep_action,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "amount" ) AS ep_amount,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "basis27" ) AS ep_basis27,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "boss" ) AS ep_boss,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "campaign" ) AS ep_campaign,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "chest_index" ) AS ep_chest_index,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "chest_slots_open" ) AS ep_chest_slots_open,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "click_timestamp" ) AS ep_click_timestamp,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "coins" ) AS ep_coins,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "coins_cost" ) AS ep_coins_cost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "cost" ) AS ep_cost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "cup_id" ) AS ep_cup_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "cup_name" ) AS ep_cup_name,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "currency" ) AS ep_currency,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level" ) AS ep_current_level,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_" ) AS ep_current_level_,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_air_control" ) AS ep_current_level_air_control,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_center_of_mass" ) AS ep_current_level_center_of_mass,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_downforce" ) AS ep_current_level_downforce,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_engine" ) AS ep_current_level_engine,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_fuel_tank" ) AS ep_current_level_fuel_tank,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_gearbox" ) AS ep_current_level_gearbox,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_grip" ) AS ep_current_level_grip,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_power_distribution" ) AS ep_current_level_power_distribution,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_rollcage" ) AS ep_current_level_rollcage,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_springs" ) AS ep_current_level_springs,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_stability" ) AS ep_current_level_stability,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_turbo" ) AS ep_current_level_turbo,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "distance" ) AS ep_distance,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "distance_to_fuel" ) AS ep_distance_to_fuel,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "engagement_time_msec" ) AS ep_engagement_time_msec,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_air_control" ) AS ep_equipped_air_control,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_coin_boost" ) AS ep_equipped_coin_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_flip_speed_boost" ) AS ep_equipped_flip_speed_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_fuel_boost" ) AS ep_equipped_fuel_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_fume_boost" ) AS ep_equipped_fume_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_glide" ) AS ep_equipped_glide,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_heavyweight" ) AS ep_equipped_heavyweight,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_magnet" ) AS ep_equipped_magnet,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_perfect_landing_boost" ) AS ep_equipped_perfect_landing_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_rollcage" ) AS ep_equipped_rollcage,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_start_boost" ) AS ep_equipped_start_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_coin_boost" ) AS ep_equipped_truck_coin_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_flip_speed_boost" ) AS ep_equipped_truck_flip_speed_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_fuel_boost" ) AS ep_equipped_truck_fuel_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_fume_boost" ) AS ep_equipped_truck_fume_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_glide" ) AS ep_equipped_truck_glide,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_heavyweight" ) AS ep_equipped_truck_heavyweight,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_magnet" ) AS ep_equipped_truck_magnet,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_perfect_landing_boost" ) AS ep_equipped_truck_perfect_landing_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_start_boost" ) AS ep_equipped_truck_start_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_turbo_boost" ) AS ep_equipped_truck_turbo_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_wheelie_boost" ) AS ep_equipped_truck_wheelie_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_winter_tyres" ) AS ep_equipped_truck_winter_tyres,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_turbo_boost" ) AS ep_equipped_turbo_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_wheelie_boost" ) AS ep_equipped_wheelie_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_winter_tyres" ) AS ep_equipped_winter_tyres,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "error_value" ) AS ep_error_value,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "event" ) AS ep_event,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "fatal" ) AS ep_fatal,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "firebase_conversion" ) AS ep_firebase_conversion,
( SELECT value.int_value FROM UNNEST(dim.params) WHERE key = "firebase_error" ) AS ep_firebase_error,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "firebase_event_origin" ) AS ep_firebase_event_origin,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "firebase_screen" ) AS ep_firebase_screen,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "firebase_screen_class" ) AS ep_firebase_screen_class,
( SELECT value.int_value FROM UNNEST(dim.params) WHERE key = "firebase_screen_id" ) AS ep_firebase_screen_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "friendCount" ) AS ep_friendCount,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "fuel_remaining" ) AS ep_fuel_remaining,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "gems" ) AS ep_gems,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "id" ) AS ep_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "item_category" ) AS ep_item_category,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "item_name" ) AS ep_item_name,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "level" ) AS ep_level,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "level_name" ) AS ep_level_name,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "medium" ) AS ep_medium,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "msg" ) AS ep_msg,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "new_best" ) AS ep_new_best,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "new_level_max" ) AS ep_new_level_max,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "new_player_id" ) AS ep_new_player_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "num_times_asked" ) AS ep_num_times_asked,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "offer_id" ) AS offer_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "old_level_max" ) AS ep_old_level_max,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "old_player_id" ) AS ep_old_player_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "open_special" ) AS ep_open_special,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "origin" ) AS origin,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "part" ) AS ep_part,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "placement" ) AS ep_placement,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "points_1" ) AS ep_points_1,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "points_2" ) AS ep_points_2,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "points_3" ) AS ep_points_3,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "points_4" ) AS ep_points_4,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "points_earned" ) AS ep_points_earned,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "points_max" ) AS ep_points_max,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "position" ) AS ep_position,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "previous_app_version" ) AS ep_previous_app_version,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "previous_duration" ) AS ep_previous_duration,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "previous_first_open_count" ) AS ep_previous_first_open_count,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "previous_os_version" ) AS ep_previous_os_version,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "previous_scene" ) AS ep_previous_scene,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "previous_tab" ) AS ep_previous_tab,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "price" ) AS ep_price,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "product_id" ) AS ep_product_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "product_name" ) AS ep_product_name,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "progress_steps" ) AS ep_progress_steps,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "quantity" ) AS ep_quantity,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "race_event" ) AS ep_race_event,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "race_id" ) AS ep_race_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "race_index" ) AS ep_race_index,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "race_time" ) AS ep_race_time,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "race_type" ) AS ep_race_type,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "rank_delta" ) AS ep_rank_delta,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "rarity" ) AS ep_rarity,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "reason" ) AS ep_reason,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "reward_source" ) AS ep_reward_source,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "reward_source_product_id" ) AS ep_reward_source_product_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "sandbox" ) AS ep_sandbox,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "scene" ) AS ep_scene,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "session_coins" ) AS ep_session_coins,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "session_gems" ) AS ep_session_gems,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "session_time" ) AS ep_session_time,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "signature" ) AS ep_signature,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "source" ) AS ep_source,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "source_product_id" ) AS ep_source_product_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "special" ) AS ep_special,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "tab" ) AS ep_tab,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "time_difference_1" ) AS ep_time_difference_1,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "time_difference_2" ) AS ep_time_difference_2,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "time_difference_3" ) AS ep_time_difference_3,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "time_difference_4" ) AS ep_time_difference_4,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "timestamp" ) AS ep_timestamp,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "total_amount_needed" ) AS ep_total_amount_needed,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "total_coins" ) AS ep_total_coins,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "total_coins_collected" ) AS ep_total_coins_collected,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "total_gems" ) AS ep_total_gems,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "total_parts_inventory" ) AS ep_total_parts_inventory,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "total_play_time" ) AS ep_total_play_time,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "total_time" ) AS ep_total_time,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "type" ) AS ep_type,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "type_specification" ) AS ep_type_specification,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "unlocked" ) AS ep_unlocked,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "update_with_analytics" ) AS ep_update_with_analytics,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "upgrade" ) AS ep_upgrade,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "upgrade_cost" ) AS ep_upgrade_cost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "user_has_vehicle" ) AS ep_user_has_vehicle,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "validated" ) AS ep_validated,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "value" ) AS ep_value,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "vehicle" ) AS ep_vehicle,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "vehicle_chest" ) AS ep_vehicle_chest,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "vehicle_level" ) AS ep_vehicle_level,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "wc_rank" ) AS ep_wc_rank
FROM
  `hill-climb-racing-2-67064304.com_fingersoft_hcr2_ANDROID.app_events_20170702`,
  UNNEST(event_dim) AS dim
UNION ALL
SELECT
  user_dim.user_id AS uid,
  user_dim.geo_info.country,
  user_dim.app_info.app_version,
  user_dim.device_info.device_category,
  user_dim.device_info.mobile_brand_name,
  user_dim.device_info.mobile_model_name,
  user_dim.device_info.mobile_marketing_name,
  dim.name AS event_name,
  LOWER(user_dim.app_info.app_platform) AS platform,
  TIMESTAMP_MICROS(dim.timestamp_micros) AS event_timestamp_ms,
  dim.timestamp_micros AS event_timestamp,
  TIMESTAMP_MICROS(user_dim.first_open_timestamp_micros) AS user_creation_timestamp,
  DATE_DIFF(EXTRACT(date
    FROM
      TIMESTAMP_MICROS(dim.timestamp_micros)), EXTRACT(date
    FROM
      TIMESTAMP_MICROS(user_dim.first_open_timestamp_micros)), DAY) AS days_retained,
  user_dim.ltv_info.revenue as ltv_revenue,
(SELECT value.value.string_value FROM UNNEST(user_dim.user_properties) WHERE key = "first_app_version" ) AS up_first_app_version,
(SELECT value.value.string_value FROM UNNEST(user_dim.user_properties) WHERE key = "gems" ) AS up_gems,
(SELECT value.value.string_value FROM UNNEST(user_dim.user_properties) WHERE key = "coins" ) AS up_coins,
(SELECT value.value.string_value FROM UNNEST(user_dim.user_properties) WHERE key = "track_level" ) AS up_track_level,
(SELECT value.value.int_value FROM UNNEST(user_dim.user_properties) WHERE key = "first_open_time" ) AS up_first_open_time,
(SELECT value.value.string_value FROM UNNEST(user_dim.user_properties) WHERE key = "iapPurchasedCount" ) AS up_iapPurchasedCount,
(SELECT value.value.string_value FROM UNNEST(user_dim.user_properties) WHERE key = "track_level_backend" ) AS up_track_level_backend,
(SELECT value.value.string_value FROM UNNEST(user_dim.user_properties) WHERE key = "Rank" ) AS up_rank,
(SELECT value.value.string_value FROM UNNEST(user_dim.user_properties) WHERE key = "rank" ) AS up_user_property_rank,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "action" ) AS ep_action,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "amount" ) AS ep_amount,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "basis27" ) AS ep_basis27,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "boss" ) AS ep_boss,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "campaign" ) AS ep_campaign,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "chest_index" ) AS ep_chest_index,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "chest_slots_open" ) AS ep_chest_slots_open,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "click_timestamp" ) AS ep_click_timestamp,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "coins" ) AS ep_coins,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "coins_cost" ) AS ep_coins_cost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "cost" ) AS ep_cost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "cup_id" ) AS ep_cup_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "cup_name" ) AS ep_cup_name,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "currency" ) AS ep_currency,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level" ) AS ep_current_level,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_" ) AS ep_current_level_,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_air_control" ) AS ep_current_level_air_control,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_center_of_mass" ) AS ep_current_level_center_of_mass,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_downforce" ) AS ep_current_level_downforce,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_engine" ) AS ep_current_level_engine,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_fuel_tank" ) AS ep_current_level_fuel_tank,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_gearbox" ) AS ep_current_level_gearbox,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_grip" ) AS ep_current_level_grip,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_power_distribution" ) AS ep_current_level_power_distribution,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_rollcage" ) AS ep_current_level_rollcage,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_springs" ) AS ep_current_level_springs,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_stability" ) AS ep_current_level_stability,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "current_level_turbo" ) AS ep_current_level_turbo,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "distance" ) AS ep_distance,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "distance_to_fuel" ) AS ep_distance_to_fuel,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "engagement_time_msec" ) AS ep_engagement_time_msec,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_air_control" ) AS ep_equipped_air_control,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_coin_boost" ) AS ep_equipped_coin_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_flip_speed_boost" ) AS ep_equipped_flip_speed_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_fuel_boost" ) AS ep_equipped_fuel_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_fume_boost" ) AS ep_equipped_fume_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_glide" ) AS ep_equipped_glide,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_heavyweight" ) AS ep_equipped_heavyweight,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_magnet" ) AS ep_equipped_magnet,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_perfect_landing_boost" ) AS ep_equipped_perfect_landing_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_rollcage" ) AS ep_equipped_rollcage,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_start_boost" ) AS ep_equipped_start_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_coin_boost" ) AS ep_equipped_truck_coin_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_flip_speed_boost" ) AS ep_equipped_truck_flip_speed_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_fuel_boost" ) AS ep_equipped_truck_fuel_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_fume_boost" ) AS ep_equipped_truck_fume_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_glide" ) AS ep_equipped_truck_glide,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_heavyweight" ) AS ep_equipped_truck_heavyweight,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_magnet" ) AS ep_equipped_truck_magnet,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_perfect_landing_boost" ) AS ep_equipped_truck_perfect_landing_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_start_boost" ) AS ep_equipped_truck_start_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_turbo_boost" ) AS ep_equipped_truck_turbo_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_wheelie_boost" ) AS ep_equipped_truck_wheelie_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_truck_winter_tyres" ) AS ep_equipped_truck_winter_tyres,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_turbo_boost" ) AS ep_equipped_turbo_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_wheelie_boost" ) AS ep_equipped_wheelie_boost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "equipped_winter_tyres" ) AS ep_equipped_winter_tyres,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "error_value" ) AS ep_error_value,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "event" ) AS ep_event,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "fatal" ) AS ep_fatal,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "firebase_conversion" ) AS ep_firebase_conversion,
( SELECT value.int_value FROM UNNEST(dim.params) WHERE key = "firebase_error" ) AS ep_firebase_error,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "firebase_event_origin" ) AS ep_firebase_event_origin,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "firebase_screen" ) AS ep_firebase_screen,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "firebase_screen_class" ) AS ep_firebase_screen_class,
( SELECT value.int_value FROM UNNEST(dim.params) WHERE key = "firebase_screen_id" ) AS ep_firebase_screen_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "friendCount" ) AS ep_friendCount,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "fuel_remaining" ) AS ep_fuel_remaining,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "gems" ) AS ep_gems,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "id" ) AS ep_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "item_category" ) AS ep_item_category,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "item_name" ) AS ep_item_name,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "level" ) AS ep_level,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "level_name" ) AS ep_level_name,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "medium" ) AS ep_medium,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "msg" ) AS ep_msg,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "new_best" ) AS ep_new_best,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "new_level_max" ) AS ep_new_level_max,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "new_player_id" ) AS ep_new_player_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "num_times_asked" ) AS ep_num_times_asked,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "offer_id" ) AS offer_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "old_level_max" ) AS ep_old_level_max,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "old_player_id" ) AS ep_old_player_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "open_special" ) AS ep_open_special,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "origin" ) AS origin,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "part" ) AS ep_part,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "placement" ) AS ep_placement,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "points_1" ) AS ep_points_1,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "points_2" ) AS ep_points_2,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "points_3" ) AS ep_points_3,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "points_4" ) AS ep_points_4,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "points_earned" ) AS ep_points_earned,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "points_max" ) AS ep_points_max,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "position" ) AS ep_position,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "previous_app_version" ) AS ep_previous_app_version,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "previous_duration" ) AS ep_previous_duration,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "previous_first_open_count" ) AS ep_previous_first_open_count,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "previous_os_version" ) AS ep_previous_os_version,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "previous_scene" ) AS ep_previous_scene,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "previous_tab" ) AS ep_previous_tab,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "price" ) AS ep_price,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "product_id" ) AS ep_product_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "product_name" ) AS ep_product_name,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "progress_steps" ) AS ep_progress_steps,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "quantity" ) AS ep_quantity,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "race_event" ) AS ep_race_event,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "race_id" ) AS ep_race_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "race_index" ) AS ep_race_index,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "race_time" ) AS ep_race_time,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "race_type" ) AS ep_race_type,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "rank_delta" ) AS ep_rank_delta,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "rarity" ) AS ep_rarity,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "reason" ) AS ep_reason,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "reward_source" ) AS ep_reward_source,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "reward_source_product_id" ) AS ep_reward_source_product_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "sandbox" ) AS ep_sandbox,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "scene" ) AS ep_scene,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "session_coins" ) AS ep_session_coins,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "session_gems" ) AS ep_session_gems,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "session_time" ) AS ep_session_time,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "signature" ) AS ep_signature,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "source" ) AS ep_source,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "source_product_id" ) AS ep_source_product_id,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "special" ) AS ep_special,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "tab" ) AS ep_tab,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "time_difference_1" ) AS ep_time_difference_1,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "time_difference_2" ) AS ep_time_difference_2,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "time_difference_3" ) AS ep_time_difference_3,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "time_difference_4" ) AS ep_time_difference_4,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "timestamp" ) AS ep_timestamp,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "total_amount_needed" ) AS ep_total_amount_needed,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "total_coins" ) AS ep_total_coins,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "total_coins_collected" ) AS ep_total_coins_collected,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "total_gems" ) AS ep_total_gems,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "total_parts_inventory" ) AS ep_total_parts_inventory,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "total_play_time" ) AS ep_total_play_time,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "total_time" ) AS ep_total_time,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "type" ) AS ep_type,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "type_specification" ) AS ep_type_specification,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "unlocked" ) AS ep_unlocked,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "update_with_analytics" ) AS ep_update_with_analytics,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "upgrade" ) AS ep_upgrade,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "upgrade_cost" ) AS ep_upgrade_cost,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "user_has_vehicle" ) AS ep_user_has_vehicle,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "validated" ) AS ep_validated,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "value" ) AS ep_value,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "vehicle" ) AS ep_vehicle,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "vehicle_chest" ) AS ep_vehicle_chest,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "vehicle_level" ) AS ep_vehicle_level,
(SELECT value.string_value FROM UNNEST(dim.params) WHERE key = "wc_rank" ) AS ep_wc_rank
FROM
`hill-climb-racing-2-67064304.com_fingersoft_hillclimbracing2_IOS.app_events_20170702`,
 UNNEST(event_dim) AS dim
