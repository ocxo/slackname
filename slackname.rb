#!/usr/bin/env ruby

require 'dotenv'
require 'json'
require 'optparse'

Dotenv.load

token = ENV['SLACK_TOKEN']
user  = ENV['SLACK_USER']

optparse = OptionParser.new
optparse.parse!
status_text = ARGV.join(" ")

emoji = %w{
  +1 100 8ball admission_tickets aerial_tramway airplane alarm_clock
  alembic alien ambulance amphora anchor angel ant apple
  arrow_right_hook art articulated_lorry athletic_shoe atom_symbol
  baby_bottle baby_chick badminton_racquet_and_shuttlecock balloon
  ballot_box_with_ballot ballot_box_with_check bamboo banana barber
  barely_sunny baseball basketball bath bathtub battery
  beach_with_umbrella bear bee beer beers beetle bell bellhop_bell
  bento bicyclist bike bird birthday black_joker
  black_nib blossom blowfish blue_book blue_car blue_heart blush
  boar boat book bookmark books boom boot bouquet bow
  bow_and_arrow bowling bread bridge_at_night briefcase bug
  building_construction bulb bullettrain_front bullettrain_side burrito
  bus busstop cactus cake camel camera camera_with_flash camping
  candle candy car card_file_box card_index card_index_dividers
  carousel_horse cat2 cat cd chains champagne checkered_flag
  cheese_wedge cherries cherry_blossom chestnut chicken
  children_crossing chipmunk chocolate_bar christmas_tree church
  cinema circus_tent city_sunrise city_sunset cityscape clap clapper
  classical_building clipboard closed_book closed_lock_with_key
  closed_umbrella cloud cocktail coffee coffin comet compression
  computer confetti_ball construction control_knobs cookie corn cow2
  cow crab credit_card crescent_moon cricket_bat_and_ball crocodile
  crossed_flags crystal_ball curly_loop curry custard
  cyclone dancer dancers dango dark_sunglasses dart
  dash deciduous_tree derelict_house_building desert desert_island
  desktop_computer dizzy dog2 dog dollar dolls dolphin door
  doughnut dove_of_peace dragon dragon_face dress dromedary_camel
  droplet dvd ear ear_of_rice earth_africa earth_americas earth_asia
  egg eggplant eight_pointed_black_star eight_spoked_asterisk
  electric_plug elephant email euro european_castle
  evergreen_tree expressionless eye eyeglasses
  eyes face_with_rolling_eyes facepunch fallen_leaf fax feet
  ferris_wheel ferry field_hockey_stick_and_ball file_cabinet
  film_frames film_projector fire fire_engine fireworks
  first_quarter_moon first_quarter_moon_with_face fish fish_cake
  fishing_pole_and_fish fist flags flashlight fleur_de_lis floppy_disk
  flower_playing_cards fog foggy football footprints 
  fountain four_leaf_clover frame_with_picture fried_shrimp fries frog
  fuelpump full_moon full_moon_with_face funeral_urn game_die gear
  gem ghost gift goat golf golfer grapes green_apple green_book
  green_heart grin grinning guardsman guitar haircut hamburger
  hammer hammer_and_pick hammer_and_wrench hamster hand handbag hash
  hatched_chick hatching_chick headphones hear_no_evil heart_eyes
  heart_eyes_cat helicopter helmet_with_white_cross herb hibiscus
  high_heel honey_pot horse horse_racing hot_pepper hotdog
  hotsprings hourglass hourglass_flowing_sand house house_buildings
  house_with_garden hugging_face ice_cream ice_hockey_stick_and_puck
  ice_skate icecream imp information_desk_person innocent
  izakaya_lantern jack_o_lantern japan japanese_castle japanese_goblin
  japanese_ogre jeans joy joy_cat joystick kaaba key keyboard
  kimono koala label last_quarter_moon
  last_quarter_moon_with_face laughing leaves ledger lemon leopard
  level_slider light_rail lightning link linked_paperclips lion_face
  lock lock_with_ink_pen lollipop loop loud_sound
  loudspeaker lower_left_ballpoint_pen lower_left_crayon
  lower_left_fountain_pen lower_left_paintbrush mag mailbox_with_mail
  man_in_business_suit_levitating mans_shoe mantelpiece_clock maple_leaf
  mask massage meat_on_bone medal mega melon memo metro
  microphone microscope milky_way minibus minidisc money_with_wings
  moneybag monkey monkey_face monorail moon mortar_board
  mostly_sunny motor_boat mount_fuji mountain mountain_bicyclist
  mountain_cableway mountain_railway mouse2 mouse moyai
  muscle mushroom musical_keyboard musical_note musical_score
  nail_care national_park necktie nerd_face neutral_face new_moon
  new_moon_with_face newspaper night_with_stars no_entry no_entry_sign
  no_mouth nose notebook notebook_with_decorative_cover notes
  nut_and_bolt ocean octopus oden office ok_hand ok_woman old_key
  om_symbol oncoming_automobile oncoming_bus oncoming_police_car
  oncoming_taxi open_hands orange_book ox package page_facing_up
  page_with_curl pager palm_tree panda_face paperclip partly_sunny
  partly_sunny_rain passenger_ship peach pear pencil2 penguin
  performing_arts person_with_ball
  person_with_pouting_face phone pick pig2 pig pig_nose pill
  pineapple pizza point_down point_left point_right point_up
  point_up_2 police_car poodle popcorn post_office postal_horn pouch
  poultry_leg pound pray prayer_beads princess printer purple_heart
  purse pushpin rabbit2 rabbit racehorse racing_car
  racing_motorcycle radio radioactive_sign railway_car rain_cloud
  rainbow raised_hand_with_fingers_splayed raised_hands raising_hand ram
  ramen rat recycle relaxed relieved ribbon rice rice_ball
  rice_cracker rice_scene ring robot_face rocket rolled_up_newspaper
  roller_coaster rooster rose rosette rotating_light round_pushpin
  rowboat rugby_football runner running_shirt_with_sash sake sandal
  santa satellite satellite_antenna saxophone scales school_satchel
  scissors scorpion see_no_evil seedling shamrock
  shaved_ice sheep shell shinto_shrine ship shirt shower ski
  skier sleuth_or_spy slightly_smiling_face slot_machine
  small_airplane smile smile_cat smiley smiley_cat smiling_imp
  smirk smirk_cat smoking snail snake snow_capped_mountain
  snow_cloud snowboarder snowflake snowman snowman_without_snow
  soccer space_invader spaghetti sparkle sparkler sparkles
  sparkling_heart speak_no_evil speech_balloon speedboat spider
  spider_web spiral_calendar_pad spiral_note_pad spock-hand
  sports_medal stadium stars station statue_of_liberty
  steam_locomotive stew stopwatch strawberry stuck_out_tongue
  stuck_out_tongue_closed_eyes stuck_out_tongue_winking_eye
  studio_microphone sun_with_face sunflower sunglasses sunny
  sunrise sunrise_over_mountains surfer sushi suspension_railway
  sweat_drops sweat_smile sweet_potato swimmer syringe
  table_tennis_paddle_and_ball taco tada tanabata_tree tangerine
  taxi tea telephone_receiver telescope tennis tent the_horns
  thermometer thinking_face thought_balloon thunder_cloud_and_rain
  ticket tiger2 tiger timer_clock tokyo_tower tomato tongue
  tophat tornado tractor traffic_light train2 train tram
  triangular_flag_on_post triangular_ruler trolleybus trophy
  tropical_drink tropical_fish truck trumpet tulip turkey turtle
  tv twisted_rightwards_arrows umbrella umbrella_on_ground
  umbrella_with_rain_drops unicorn_face upside_down_face v
  vertical_traffic_light vhs violin volcano
  volleyball walking waning_crescent_moon waning_gibbous_moon warning
  wastebasket watch water_buffalo watermelon wave
  waxing_crescent_moon wc weight_lifter whale2 whale
  wheel_of_dharma white_check_mark
  wind_blowing_face wind_chime wine_glass wink wolf
  womans_hat world_map wrench writing_hand yellow_heart yen
  yin_yang yum zap
}

emoji = emoji.sample

#status_text = emoji if status_text == ""

status_emoji = emoji.prepend("%3A")
status_emoji << "%3A"

presence_response = `curl -s 'https://slack.com/api/users.getPresence?token=#{token}&user=#{user}'`
presence = JSON.parse(presence_response)['presence']


profile = `curl -s 'https://slack.com/api/users.profile.get?token=#{token}'`
status_text = JSON.parse(profile)['profile']['status_text']

if presence == 'active' && status_text.empty?
  curl = `curl -s -XPOST 'https://slack.com/api/users.profile.set?token=#{token}&profile=%7B%22status_emoji%22%3A%22#{status_emoji}%22%2C%22status_text%22%3A%22#{status_text}%22%7D'`
end
