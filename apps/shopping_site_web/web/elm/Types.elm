module Types exposing (..)

type Msg
    = SearchChange String


type alias Flags = { payload : String }

type alias Item = { name : String
                  , description : String
                  , price : Float
                  , imageUrl : String
                  }

type alias Model = { allItems : List Item
                   , visibleItems : List Item
                   , searchText : String
                   }


