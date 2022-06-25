require "test_helper"

class DummyClass
  include Tweetkit::Client::Search::Conjunctions
end

class TestConjunctions < Minitest::Test
  attr_accessor :search

  def setup
    @search = DummyClass.new
  end

  def test_contains
    assert_equal "a b c", search.contains("a", "b", "c")
  end

  def test_contains_one
    assert_equal "a OR b OR c", search.contains_one("a", "b", "c")
  end

  def test_without
    assert_equal "-a -b -c", search.without("a", "b", "c")
  end

  def test_has
    assert_equal "has:a has:b has:c", search.has("a", "b", "c")
  end

  def test_has_one
    assert_equal "has:a OR has:b OR has:c", search.has_one("a", "b", "c")
  end

  def test_has_no
    assert_equal "-has:a -has:b -has:c", search.has_no("a", "b", "c")
  end

  def test_is_a
    assert_equal "is:a is:b is:c", search.is_a("a", "b", "c")
  end

  def test_is_one_of
    assert_equal "is:a OR is:b OR is:c", search.is_one_of("a", "b", "c")
  end

  def test_is_not
    assert_equal "-is:a -is:b -is:c", search.is_not("a", "b", "c")
  end

  def test_from
    assert_equal "from:a from:b from:c", search.from("a", "b", "c")
  end

  def test_from_one
    assert_equal "from:a OR from:b OR from:c", search.from_one("a", "b", "c")
  end

  def test_not_from
    assert_equal "-from:a -from:b -from:c", search.not_from("a", "b", "c")
  end

  def test_to
    assert_equal "to:a to:b to:c", search.to("a", "b", "c")
  end

  def test_to_one_of
    assert_equal "to:a OR to:b OR to:c", search.to_one_of("a", "b", "c")
  end

  def test_not_to
    assert_equal "-to:a -to:b -to:c", search.not_to("a", "b", "c")
  end

  def test_with_link
    assert_equal "url:google.com", search.with_link("google.com")
  end

  def test_with_links
    assert_equal "url:google.com url:github.com url:facebook.com", search.with_links("google.com", "github.com", "facebook.com")
  end

  def test_with_one_of_links
    assert_equal "url:google.com OR url:github.com OR url:facebook.com", search.with_one_of_links("google.com", "github.com", "facebook.com")
  end

  def test_without_link
    assert_equal "-url:google.com", search.without_link("google.com")
  end

  def test_without_links
    assert_equal "-url:google.com -url:github.com -url:facebook.com", search.without_links("google.com", "github.com", "facebook.com")
  end

  def test_retweets_of
    assert_equal "retweets_of:john retweets_of:jack retweets_of:jane", search.retweets_of("john", "jack", "jane")
  end

  def test_retweets_of_one_of
    assert_equal "retweets_of:john OR retweets_of:jack OR retweets_of:jane", search.retweets_of_one_of("john", "jack", "jane")
  end

  def test_not_retweets_of
    assert_equal "-retweets_of:john -retweets_of:jack -retweets_of:jane", search.not_retweets_of("john", "jack", "jane")
  end

  def test_with_context
    assert_equal "context:a context:b context:c", search.with_context("a", "b", "c")
  end

  def test_with_one_of_context
    assert_equal "context:a OR context:b OR context:c", search.with_one_of_context("a", "b", "c")
  end

  def test_without_context
    assert_equal "-context:a -context:b -context:c", search.without_context("a", "b", "c")
  end

  def test_with_entity
    assert_equal "entity:a entity:b entity:c", search.with_entity("a", "b", "c")
  end

  # TODO: Consider passing one_of to method args instead of a separate method
  def test_with_one_of_entity
    assert_equal "entity:a OR entity:b OR entity:c", search.with_one_of_entity("a", "b", "c")
  end

  def test_without_entity
    assert_equal "-entity:a -entity:b -entity:c", search.without_entity("a", "b", "c")
  end

  def test_with_conversation_id
    assert_equal "conversation_id:a conversation_id:b conversation_id:c", search.with_conversation_id("a", "b", "c")
  end

  def test_without_conversation_id
    assert_equal "-conversation_id:a -conversation_id:b -conversation_id:c", search.without_conversation_id("a", "b", "c")
  end

  # TODO: Change to place instead
  def test_location
    assert_equal "place:a place:b place:c", search.location("a", "b", "c")
  end

  def test_from_one_of_location
    assert_equal "place:a OR place:b OR place:c", search.from_one_of_location("a", "b", "c")
  end

  def test_not_from_location
    assert_equal "-place:a -place:b -place:c", search.not_from_location("a", "b", "c")
  end

  def test_country
    assert_equal "place_country:a place_country:b place_country:c", search.country("a", "b", "c")
  end

  def test_from_one_of_country
    assert_equal "place_country:a OR place_country:b OR place_country:c", search.from_one_of_country("a", "b", "c")
  end

  def test_not_from_country
    assert_equal "-place_country:a -place_country:b -place_country:c", search.not_from_country("a", "b", "c")
  end

  # TODO: Change to language instead
  def test_lang
    assert_equal "lang:a lang:b lang:c", search.lang("a", "b", "c")
  end

  def test_not_lang
    assert_equal "-lang:a -lang:b -lang:c", search.not_lang("a", "b", "c")
  end

  def test_group
    query = Proc.new do
      is :tweet
      contains "word", "two words"
      has_one_of :image, :link
    end

    grouped_query = search.send(:group, &query)

    is_query = search.is(:tweet)
    contains_query = search.contains("word", "two words")
    has_one_of_query = search.has_one_of(:image, :link)

    assert_equal "(is:tweet word \"two words\" has:image OR has:link)", grouped_query
    assert_equal "is:tweet", is_query
    assert_equal "word \"two words\"", contains_query
    assert_equal "has:image OR has:link", has_one_of_query
  end
end
