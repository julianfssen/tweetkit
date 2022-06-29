require "test_helper"

class SearchFactoryTest < Minitest::Test
  def setup
    @search_factory = Tweetkit::Client::Search::SearchFactory.new("united")
  end

  def test_evaluate_constructs_the_current_query
    search_factory.evaluate do
      is :retweet
      contains "pogba", "mason greenwood"
      has_one_of :media, :link
      not_from "ManUtd"
    end

    assert_equal "united is:retweet pogba \"mason greenwood\" has:media OR has:link -from:ManUtd", search_factory.current_query
  end
end
