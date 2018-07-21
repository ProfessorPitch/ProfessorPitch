
import sys
sys.path.append('C:\Python\Scripts\Twitter')
import tweepy
import private

auth = tweepy.OAuthHandler(private.TWITTER_APP_KEY, private.TWITTER_APP_SECRET)
auth.set_access_token(private.TWITTER_KEY,private.TWITTER_SECRET)
api = tweepy.API(auth)

public_tweets = api.home_timeline()
for tweet in public_tweets:
    print (tweet.text)
