require_relative '../spec_helper'

class DummyClass
  include Tweetkit::Client::Search::Conjunctions
end

describe Tweetkit::Client::Search::Conjunctions do
  let(:search) { DummyClass.new }

  describe '.contains' do
    it 'joins terms correctly' do
      result = search.contains('a', 'b', 'c')
      
      expect(result).to eq('a b c')
    end
  end

  describe '.contains_one' do
    it 'joins terms correctly' do
      result = search.contains_one('a', 'b', 'c')
      
      expect(result).to eq('a OR b OR c')
    end
  end

  describe '.without' do
    it 'joins terms correctly' do
      result = search.without('a', 'b', 'c')
      
      expect(result).to eq('-a -b -c')
    end
  end

  describe '.has' do
    it 'joins terms correctly' do
      result = search.has('a', 'b', 'c')
      
      expect(result).to eq('has:a has:b has:c')
    end
  end

  describe '.has_one' do
    it 'joins terms correctly' do
      result = search.has_one('a', 'b', 'c')
      
      expect(result).to eq('has:a OR has:b OR has:c')
    end
  end

  describe '.has_no' do
    it 'joins terms correctly' do
      result = search.has_no('a', 'b', 'c')
      
      expect(result).to eq('-has:a -has:b -has:c')
    end
  end

  describe '.is_a' do
    it 'joins terms correctly' do
      result = search.is_a('a', 'b', 'c')
      
      expect(result).to eq('is:a is:b is:c')
    end
  end

  describe '.is_one_of' do
    it 'joins terms correctly' do
      result = search.is_one_of('a', 'b', 'c')
      
      expect(result).to eq('is:a OR is:b OR is:c')
    end
  end

  describe '.is_not' do
    it 'joins terms correctly' do
      result = search.is_not('a', 'b', 'c')
      
      expect(result).to eq('-is:a -is:b -is:c')
    end
  end

  describe '.from' do
    it 'joins terms correctly' do
      result = search.from('a', 'b', 'c')
      
      expect(result).to eq('from:a from:b from:c')
    end
  end

  describe '.from_one' do
    it 'joins terms correctly' do
      result = search.from_one('a', 'b', 'c')
      
      expect(result).to eq('from:a OR from:b OR from:c')
    end
  end

  describe '.not_from' do
    it 'joins terms correctly' do
      result = search.not_from('a', 'b', 'c')
      
      expect(result).to eq('-from:a -from:b -from:c')
    end
  end

  describe '.to' do
    it 'joins terms correctly' do
      result = search.to('a', 'b', 'c')
      
      expect(result).to eq('to:a to:b to:c')
    end
  end

  describe '.to_one_of' do
    it 'joins terms correctly' do
      result = search.to_one_of('a', 'b', 'c')
      
      expect(result).to eq('to:a OR to:b OR to:c')
    end
  end

  describe '.not_to' do
    it 'joins terms correctly' do
      result = search.not_to('a', 'b', 'c')
      
      expect(result).to eq('-to:a -to:b -to:c')
    end
  end

  describe '.with_link' do
    it 'joins terms correctly' do
      result = search.with_link('google.com')
      
      expect(result).to eq('url:google.com')
    end
  end

  describe '.with_links' do
    it 'joins terms correctly' do
      result = search.with_links('google.com', 'github.com', 'facebook.com')
      
      expect(result).to eq('url:google.com url:github.com url:facebook.com')
    end
  end

  describe '.with_one_of_links' do
    it 'joins terms correctly' do
      result = search.with_one_of_links('google.com', 'github.com', 'facebook.com')
      
      expect(result).to eq('url:google.com OR url:github.com OR url:facebook.com')
    end
  end

  describe '.without_link' do
    it 'joins terms correctly' do
      result = search.without_link('google.com')
      
      expect(result).to eq('-url:google.com')
    end
  end

  describe '.without_links' do
    it 'joins terms correctly' do
      result = search.without_links('google.com', 'github.com', 'facebook.com')
      
      expect(result).to eq('-url:google.com -url:github.com -url:facebook.com')
    end
  end

  describe '.retweets_of' do
    it 'joins terms correctly' do
      result = search.retweets_of('john', 'jack', 'jane')
      
      expect(result).to eq('retweets_of:john retweets_of:jack retweets_of:jane')
    end
  end

  describe '.retweets_of_one_of' do
    it 'joins terms correctly' do
      result = search.retweets_of_one_of('john', 'jack', 'jane')

      expect(result).to eq('retweets_of:john OR retweets_of:jack OR retweets_of:jane')
    end
  end

  describe '.not_retweets_of' do
    it 'joins terms correctly' do
      result = search.not_retweets_of('john', 'jack', 'jane')

      expect(result).to eq('-retweets_of:john -retweets_of:jack -retweets_of:jane')
    end
  end

  describe '.with_context' do
    it 'joins terms correctly' do
      result = search.with_context('a', 'b', 'c')

      expect(result).to eq('context:a context:b context:c')
    end
  end

  describe '.with_one_of_context' do
    it 'joins terms correctly' do
      result = search.with_one_of_context('a', 'b', 'c')

      expect(result).to eq('context:a OR context:b OR context:c')
    end
  end

  describe '.without_context' do
    it 'joins terms correctly' do
      result = search.without_context('a', 'b', 'c')

      expect(result).to eq('-context:a -context:b -context:c')
    end
  end

  describe '.with_entity' do
    it 'joins terms correctly' do
      result = search.with_entity('a', 'b', 'c')

      expect(result).to eq('entity:a entity:b entity:c')
    end
  end

  describe '.with_one_of_entity' do
    it 'joins terms correctly' do
      result = search.with_one_of_entity('a', 'b', 'c')

      expect(result).to eq('entity:a OR entity:b OR entity:c')
    end
  end

  describe '.without_entity' do
    it 'joins terms correctly' do
      result = search.without_entity('a', 'b', 'c')

      expect(result).to eq('-entity:a -entity:b -entity:c')
    end
  end

  describe '.with_conversation_id' do
    it 'joins terms correctly' do
      result = search.with_conversation_id('a', 'b', 'c')

      expect(result).to eq('conversation_id:a conversation_id:b conversation_id:c')
    end
  end

  describe '.without_conversation_id' do
    it 'joins terms correctly' do
      result = search.without_conversation_id('a', 'b', 'c')

      expect(result).to eq('-conversation_id:a -conversation_id:b -conversation_id:c')
    end
  end

  describe '.location' do
    it 'joins terms correctly' do
      result = search.location('a', 'b', 'c')

      expect(result).to eq('place:a place:b place:c')
    end
  end

  describe '.from_one_of_location' do
    it 'joins terms correctly' do
      result = search.from_one_of_location('a', 'b', 'c')

      expect(result).to eq('place:a OR place:b OR place:c')
    end
  end

  describe '.not_from_location' do
    it 'joins terms correctly' do
      result = search.not_from_location('a', 'b', 'c')

      expect(result).to eq('-place:a -place:b -place:c')
    end
  end

  describe '.country' do
    it 'joins terms correctly' do
      result = search.country('a', 'b', 'c')

      expect(result).to eq('place_country:a place_country:b place_country:c')
    end
  end

  describe '.from_one_of_country' do
    it 'joins terms correctly' do
      result = search.from_one_of_country('a', 'b', 'c')

      expect(result).to eq('place_country:a OR place_country:b OR place_country:c')
    end
  end

  describe '.not_from_country' do
    it 'joins terms correctly' do
      result = search.not_from_country('a', 'b', 'c')

      expect(result).to eq('-place_country:a -place_country:b -place_country:c')
    end
  end

  describe '.lang' do
    it 'joins terms correctly' do
      result = search.lang('a', 'b', 'c')

      expect(result).to eq('lang:a lang:b lang:c')
    end
  end

  describe '.not_lang' do
    it 'joins terms correctly' do
      result = search.not_lang('a', 'b', 'c')

      expect(result).to eq('-lang:a -lang:b -lang:c')
    end
  end

  describe '.group' do
    it 'joins terms correctly when grouping terms and does not override original methods after grouping' do
      queries = Proc.new do
        is :tweet
        contains 'word', 'two words'
        has_one_of :image, :link
      end

      grouped_result = search.send(:group, &queries)

      is_result = search.is(:tweet)
      contains_result = search.contains('word', 'two words')
      has_one_of_result = search.has_one_of(:image, :link)

      expect(grouped_result).to eq('(is:tweet word "two words" has:image OR has:link)')
      expect(is_result).to eq('is:tweet')
      expect(contains_result).to eq('word "two words"')
      expect(has_one_of_result).to eq('has:image OR has:link')
    end
  end
end
