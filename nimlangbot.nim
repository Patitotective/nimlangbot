import std/[httpclient, json, os]
import twitter

const (botUsername, botId) = ("nimlangbot", "1543268386175688704")

proc main() = 
  assert existsEnv("CONSUMER_KEY") and existsEnv("CONSUMER_SECRET") and existsEnv("ACCESS_TOKEN") and existsEnv("ACCESS_TOKEN_SECRET")

  let twitterAPI = newTwitterAPI(getEnv("CONSUMER_KEY"), getEnv("CONSUMER_SECRET"), getEnv("ACCESS_TOKEN"), getEnv("ACCESS_TOKEN_SECRET"))
  let data = twitterApi.tweetsSearchRecent("#nimlang OR #nim_lang OR nimlang OR nim_lang lang:en -malware -virus -is:retweet").body.parseJson()["data"]

  for tweet in data:
    discard twitterApi.usersIdRetweets(botId, %* {"tweet_id": tweet["id"]})
    discard twitterApi.usersIdLikes(botId %* {"tweet_id": tweet["id"]})

when isMainModule:
  main()
