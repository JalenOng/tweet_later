class TweetWorker
  # Remember to create a migration!
  include Sidekiq::Worker

  sidekiq_options :retry => 5

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    user = tweet.user
    client = user.create_client

    client.update(tweet.status)

    # set up Twitter OAuth client here
    # actually make API call
    # Note: this does not have access to controller/view helpers
    # You'll have to re-initialize everything inside here
  end

end


