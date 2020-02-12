require 'yaml'
require_relative 'lib/card.rb'
require_relative 'lib/query.rb'

puts 'Please wait while all cards are fetched... This will take a while :('

cards = Query.new(Card.all)

cards_grouped_by_set          = cards.grouped_by_attribute('set')
cards_group_by_set_and_rarity = cards.grouped_by_two_attributes('set', 'rarity')

ktk_set_cards                           = cards_grouped_by_set['KTK']
ktk_set_cards_with_colors_red_and_blue  = cards.with_attribute_values('colors', 'Red', 'Blue')

puts cards_grouped_by_set.to_yaml
puts cards_group_by_set_and_rarity.to_yaml
puts ktk_set_cards_with_colors_red_and_blue.to_yaml
