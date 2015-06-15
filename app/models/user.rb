class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets

  def create_client
    twitter = Twitter::REST::Client.new do |config|
      config.consumer_key = API_KEYS[:consumer_key]
      config.consumer_secret = API_KEYS[:consumer_secret]
      config.access_token = self.token
      config.access_token_secret = self.secret

    end
  end

  def tweet(status)
    tweet = tweets.create!(:status => status)
    job_id = TweetWorker.perform_async(tweet.id)
    # job_id = TweetWorker.perform_at(0.05.hours.from_now, tweet.id, 1)
    job_id
  end

end
