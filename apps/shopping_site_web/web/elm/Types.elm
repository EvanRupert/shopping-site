module Types exposing (..)

type Msg
    = NoChange
    | ItemLoad(String)


type alias Flags = { payload : String }

type alias Item = { name : String
                  , description : String
                  , price : Float
                  , imageUrl : String
                  }

type alias Model = { items : List Item }

