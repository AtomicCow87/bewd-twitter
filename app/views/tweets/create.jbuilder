json.tweet do
  json.id @tweet.id
  json.username @tweet.user.username
  json.message @tweet.message
end