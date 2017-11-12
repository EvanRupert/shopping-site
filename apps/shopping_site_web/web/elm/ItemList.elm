-- TODO: Implement price filtering from filters box
-- TODO: Implement ordering from filters box
-- TODO: Implement year added filtering

-- FIXME: dates not working


module ItemList exposing (..)

import Json.Decode as Json
import Date

import Html exposing ( programWithFlags )

import Types exposing (..)
import View exposing ( view )
import Update exposing ( update )


main : Program Flags Model Msg
main = programWithFlags { init = init
                        , view = view
                        , update = update
                        , subscriptions = \_ -> Sub.none
                        }


init : Flags -> (Model, Cmd Msg)
init flags = 
    let
        items = decodeJson flags.payload
    in
        { allItems = items
        , visibleItems = List.sortBy .name items
        , filtering = { searchText = ""
                      , expandedFilterMenu = False
                      , priceFilter = Nothing 
                      , error = Nothing
                      , ordering = Alphabetic
                      , dateFilter = Nothing
                      }
        } ! []


defaultItem : Item
defaultItem = { name = "Invalid"
              , description = "Invalid"
              , price = 0
              , imageUrl = "Invalid"
              , updatedAt = defaultDate
              }


itemDecoder : Json.Decoder Item
itemDecoder = 
    Json.map5 Item
        (Json.at ["name"] Json.string)
        (Json.at ["description"] Json.string)
        (Json.at ["price"] Json.float)
        (Json.at ["image_url"] Json.string)
        (Json.at ["updated_at"] decodeDate)


decodeDate : Json.Decoder Date.Date
decodeDate =
    Json.map (\x -> case Date.fromString x of
                        Ok value -> value
                        Err _ -> defaultDate) Json.string


decodeJson : String -> List Item
decodeJson = 
    Json.decodeString (Json.list itemDecoder) >> Result.withDefault [defaultItem]
