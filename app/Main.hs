{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}
module Main (main) where

import Servant
import Network.Wai.Handler.Warp
import System.Environment


main :: IO ()
main = do
  port <- getEnv "PORT"
  putStrLn "hihi"
  run (read port) (serve api server)

server :: Server API
server = return () :<|> (\a b -> return (a * b)) :<|> (\a b -> return (a + b))

api :: Proxy API
api = Proxy

type API =
 Get '[JSON] ()
 :<|> "mult" :> Capture "a" Int :> Capture "b" Int :> Get '[JSON] Int
 :<|> "add" :> Capture "a" Int :> Capture "b" Int :> Get '[JSON] Int
