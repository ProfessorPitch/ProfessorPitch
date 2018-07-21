import sys
sys.path.append('C:\Python\Scripts\Twitter')
import tweepy
import private
import datetime, time

auth = tweepy.OAuthHandler(private.TWITTER_APP_KEY, private.TWITTER_APP_SECRET)
auth.set_access_token(private.TWITTER_KEY,private.TWITTER_SECRET)
api = tweepy.API(auth)

