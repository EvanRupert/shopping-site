-- FIXME: Elm has received the items but the json decoder is failing


module ItemList exposing (..)

import Html exposing (..)
import Json.Decode as Json
import Types exposing (..)


-- TESTING
-- main : Html msg
-- main =
--     text "Hello, World!"


main : Program Flags Model Msg
main = programWithFlags { init = init
                        , view = view
                        , update = update
                        , subscriptions = \_ -> Sub.none
                        }

--****************************INIT*********************************


-- init : Flags -> (Model, Cmd Msg)
-- init flags = 
--     { items = flags.payload
--               |> decodeJson
--               |> Debug.log "Elm received items" 
--     } ! []

init : Flags -> (Model, Cmd Msg)
init flags = { items = flags.payload
                       |> decodeJson
                       |> Debug.log "Elm received items"
             } ! []


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
        (Json.at ["image_url"] Json.string)


decodeJson : String -> List Item
decodeJson str = 
    let
        result = Json.decodeString (Json.list itemDecoder) str
    in
        Result.withDefault [defaultItem] result

--*****************************VIEW*******************************

view : Model -> Html Msg
view model = 
    div []
        [ h1 [] [ text "Hello, World!" ]
        , div [] <| List.map viewItem model.items
        ]


viewItem : Item -> Html Msg
viewItem item = 
    div []
        [ h1 [] [ text item.name ]
        , p [] [ text item.description ]
        , p [] [ item.price |> toString |> text ]
        , p [] [ text item.imageUrl ]
        ]


--*****************************UPDATE******************************

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoChange -> model ! []


