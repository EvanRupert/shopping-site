-- FIXME: Data is being sent to the javascript but the elm is not
-- loading for some reason


module ItemList exposing (..)

import Html exposing (..)
import Json.Decode as Json



main : Program Flags Model Msg
main = programWithFlags { init = init
                        , view = view
                        , update = update
                        , subscriptions = \_ -> Sub.none
                        }

-- Types

type Msg
    = Nothing


type alias Flags = { items : String }

type alias Item = { name : String
                  , description : String
                  , price : Float
                  , imageUrl : String
                  }

type alias Model = { items : List Item }


init : Flags -> (Model, Cmd Msg)
init flags = 
    { items = decodeJson flags.items } ! []



defaultItem : Item
defaultItem = { name = "Invalid"
              , description = "Invalid"
              , price = 0
              , imageUrl = "Invalid"
              }



itemDecoder : Json.Decoder Item
itemDecoder = 
    Json.map4 Item
        (Json.at ["name"] Json.string)
        (Json.at ["description"] Json.string)
        (Json.at ["price"] Json.float)
        (Json.at ["imageUrl"] Json.string)


decodeJson : String -> List Item
decodeJson str = 
    let
        result = Json.decodeString (Json.list itemDecoder) str
    in
        Result.withDefault [defaultItem] result

-- View

view : Model -> Html Msg
view model = 
    div [] <| List.map viewItem model.items


viewItem : Item -> Html Msg
viewItem item = 
    div []
        [ h1 [] [ text item.name ]
        , p [] [ text item.description ]
        , p [] [ item.price |> toString |> text ]
        , p [] [ text item.imageUrl ]
        ]


-- Update

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = model ! []


