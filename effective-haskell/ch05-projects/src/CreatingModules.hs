-- |
-- A demonstration module.
module CreatingModules where

-- |
-- Prefix message with "Exciting news: ".
excitingMessage :: String -> String
excitingMessage message = "Exciting news: " <> message <> "!!!"

{- |
Name.
-}
data Name = Name
  {
    getName :: String -- ^ Retrieve name value.
  }
data Salutation = Salutation { getSalutation :: String }

{- |
A GreetingMessage contains all of the information needed to generate a
greeting using 'formatMessage'. You can get a default greeting without
attribution from 'defaultMessage'. This makes it convenient to use
record update syntax to construct a new greeting:

>>> formatMessage defaultMessage { greetingFrom = [ Name "A Haskeller"] }
"Hello Friend, from: A Haskeller"
-}
data GreetingMessage = GreetingMessage
    { greetingSalutation :: Salutation
    -- ^ A 'Salutation', like \"Hello\"
    , greetingTo         :: Name
    -- ^ 'Name' of the person that should be greeted
    , greetingFrom       :: [Name]
    -- ^ 'Name's of the people who are sending the greeting
    }

data GreetingMessage2 = GreetingMessage2
    { -- | A 'Salutation', like \"Hello\"
    greetingSalutation2 :: Salutation
    , -- | 'Name' of the person that should be greeted
    greetingTo2         :: Name
    , -- | 'Name's of the people who are sending the greeting
    greetingFrom2       :: [Name]
    }

{- |
A default greeting message that isn't attributed to anyone:

@
GreetingMessage
{ greetingSalutation = Salutation \"Hello\"
, greetingTo = Name \"Friend\"
, greetingFrom = []
}
@
-}
defaultMessage :: GreetingMessage
defaultMessage = GreetingMessage
  { greetingSalutation = Salutation "Hello"
  , greetingTo = Name "Friend"
  , greetingFrom = []
  }

formatMessage :: GreetingMessage -> String
formatMessage (GreetingMessage greetingSalutation greetingTo greetingFrom) =
  greetingWithSuffix
  where
    basicGreeting = getSalutation greetingSalutation <> " " <> getName greetingTo
    greetingWithSuffix =
      case greetingFrom of
        [] ->
          basicGreeting <> "!"
        [friend] ->
          basicGreeting <> ", from: " <> getName friend
        [friendA, friendB] ->
          basicGreeting <> ", from: " <> getName friendA <> " and " <> getName friendB
        friends ->
          basicGreeting <> ", from your friends: " <> formatFriendList friends

    formatFriendList friends =
      case friends of
      [] ->
        ""
      [friend] ->
        "and " <> getName friend
      (friend:moreFriends) ->
        getName friend <> ", " <> formatFriendList moreFriends

{- |
A test message that you can use to see how messages are formatted.

>>> testMessage
"Hello Friend, from: test example"
-}
testMessage :: String
testMessage = formatMessage $ defaultMessage { greetingFrom = [Name "test example"] }
