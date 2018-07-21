
import sys
sys.path.append('C:\Python\Scripts\Twitter')
import tweepy
import private

import json
import sqlite3

conn = sqlite3.connect('Twitter.db')
c = conn.cursor()
#CReate Table in SQLIte DB
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================
# tb_create = """CREATE TABLE tweets2
#       			(created_at, favorite_count, favorited, filter_level, lang, 
#                   retweet_count, retweeted, source, text, truncated, user_created_at,  
#                   user_followers_count, user_location, user_lang, user_name, 
#                   user_screen_name, user_time_zone, user_utc_offset, user_friends_count)"""
# c.execute(tb_create) 
# conn.commit()
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================
# =============================================================================
##End create statement
class StreamListener(tweepy.StreamListener):
    
    def on_status(self, status):
        print (status)
    
    def on_error(self, status_code):
        print(status_code)
        
    def on_data(self, data):
        all_data             = json.loads(data)
        created_at           = all_data['created_at']
        favorite_count       = all_data['favorite_count']
        favorited            = all_data['favorited']
        filter_level         = all_data['filter_level']
        lang                 = all_data['lang']
        retweet_count        = all_data['retweet_count']
        retweeted            = all_data['retweeted']
        source               = all_data['source']
        text                 = all_data['text']
        truncated            = all_data['truncated']
        user_created_at      = all_data['user']['created_at']
        user_followers_count = all_data['user']['followers_count']
        user_location        = all_data['user']['location']
        user_lang            = all_data['user']['lang']
        user_name            = all_data['user']['name']
        user_screen_name     = all_data['user']['screen_name']
        user_time_zone       = all_data['user']['time_zone']
        user_utc_offset      = all_data['user']['utc_offset']
        user_friends_count   = all_data['user']['friends_count']
        
        c.execute('''INSERT INTO tweets2 
			(created_at, favorite_count, favorited, filter_level, lang, 
                         retweet_count, retweeted, source, text, truncated, user_created_at,  
                         user_followers_count, user_location, user_lang, user_name, 
                         user_screen_name, user_time_zone, user_utc_offset, user_friends_count) 
			VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)''', 
			(created_at, favorite_count, favorited, filter_level, lang, retweet_count, 
                         retweeted, source, text, truncated, user_created_at, 
                         user_followers_count, user_location, user_lang, user_name, 
                         user_screen_name, user_time_zone, user_utc_offset, user_friends_count))
        conn.commit()
        


auth = tweepy.OAuthHandler(private.TWITTER_APP_KEY, private.TWITTER_APP_SECRET)
auth.set_access_token(private.TWITTER_KEY,private.TWITTER_SECRET)

api = tweepy.API(auth)

stream_listener = StreamListener()
stream = tweepy.Stream(auth=api.auth, listener=stream_listener)
stream.filter(track=["#StarWars"], languages=['en'])