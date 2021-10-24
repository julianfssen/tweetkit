require_relative '../spec_helper'

describe Tweetkit::Search do
  describe '.evaluate' do
    let(:search) { Tweetkit::Search.new('united') }
    it 'constructs the current query correctly' do
      search.evaluate do
        is :retweet
        contains 'pogba', 'mason greenwood'
        has_one_of :media, :link
        not_from 'ManUtd'
      end
      expect(search.current_query).to eq('united is:retweet pogba "mason greenwood" has:media OR has:link -from:ManUtd')
    end
  end
end
