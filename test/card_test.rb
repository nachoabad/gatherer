require "minitest/autorun"
require_relative '../lib/card'
require_relative '../lib/query'

class CardTest < Minitest::Test
  SAMPLE_CARDS = JSON.parse(File.read('test/sample_responses/cards.json'))['cards']

  def setup
    Card.stub :all, SAMPLE_CARDS do
      @cards = Query.new(Card.all)
    end
  end

  def test_cards_grouped_by_attribute
    expected = {
                  "A"=>[{"name"=>"One", "colors"=>["Red"], "rarity"=>"Uncommon", "set"=>"A"}, {"name"=>"Two", "colors"=>["Red"], "rarity"=>"Common", "set"=>"A"}], 
                  "B"=>[{"name"=>"Three", "colors"=>["Green", "Red", "Blue"], "rarity"=>"Rare", "set"=>"B"}, {"name"=>"Four", "colors"=>["Green", "Red"], "rarity"=>"Rare", "set"=>"B"}, {"name"=>"Five", "colors"=>["Blue"], "rarity"=>"Rare", "set"=>"B"}], 
                  "C"=>[{"name"=>"Six", "colors"=>["Blue", "Red"], "rarity"=>"Rare", "set"=>"C"}]
                }
      
    assert_equal expected, @cards.grouped_by_attribute('set')
  end

  def test_cards_grouped_by_two_attributes
    expected = {
                  "A"=>{"Uncommon"=>[{"name"=>"One", "colors"=>["Red"], "rarity"=>"Uncommon", "set"=>"A"}], "Common"=>[{"name"=>"Two", "colors"=>["Red"], "rarity"=>"Common", "set"=>"A"}]}, 
                  "B"=>{"Rare"=>[{"name"=>"Three", "colors"=>["Green", "Red", "Blue"], "rarity"=>"Rare", "set"=>"B"}, {"name"=>"Four", "colors"=>["Green", "Red"], "rarity"=>"Rare", "set"=>"B"}, {"name"=>"Five", "colors"=>["Blue"], "rarity"=>"Rare", "set"=>"B"}]}, 
                  "C"=>{"Rare"=>[{"name"=>"Six", "colors"=>["Blue", "Red"], "rarity"=>"Rare", "set"=>"C"}]}
                }
    
    assert_equal expected, @cards.grouped_by_two_attributes('set', 'rarity')
  end

  def test_cards_with_attribute_values
    expected =  [
                  {"name"=>"Three", "colors"=>["Green", "Red", "Blue"], "rarity"=>"Rare", "set"=>"B"},
                  {"name"=>"Six", "colors"=>["Blue", "Red"], "rarity"=>"Rare", "set"=>"C"}
                ]

    assert_equal expected, @cards.with_attribute_values('colors', 'Red', 'Blue')
  end

  def test_set_of_cards_with_attribute_values
    expected = [{"name"=>"Three", "colors"=>["Green", "Red", "Blue"], "rarity"=>"Rare", "set"=>"B"}]

    set_B_cards = @cards.grouped_by_attribute('set')['B']
    set_B_cards_query = Query.new(set_B_cards)

    assert_equal expected, set_B_cards_query.with_attribute_values('colors', 'Red', 'Blue')
  end
end