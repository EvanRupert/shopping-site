-- FIXME: Elm has received the items but the json decoder is failing


module ItemList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

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


init : Flags -> (Model, Cmd Msg)
init flags = { items = decodeJson flags.payload } ! []


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
        , div [ class "container" ] (model.items
                                    |> groupInto 3
                                    |> List.map viewGroup
                                    )
        ]


viewGroup : List Item -> Html Msg
viewGroup items =
    div [ class "row margin-row" ] <| List.map viewItem items


viewItem : Item -> Html Msg
viewItem item = 
    div [ class "col" ]
    [
        div [ class "card" ]
            [ img [ class "card-img-top", src item.imageUrl ] []
            , div [ class "card-body" ]
                [ h4 [ class "card-title" ] [ text item.name ]
                , p [ class "card-text" ] [ text item.description ]
                , p [] [ item.price |> toString |> text ]
                ]
            ]
    ]


groupInto : Int -> List a -> List (List a)
groupInto n l =
    case l of
        [] -> []
        l -> (List.take n l) :: (groupInto n (List.drop n l))

--*****************************UPDATE******************************

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoChange -> model ! []


