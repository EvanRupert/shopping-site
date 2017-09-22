module ItemList exposing (..)

import Html exposing (..)



main : Program Flags Model Msg
main = programWithFlags { init = init
                        , view = view
                        , update = update
                        , subscriptions = \_ -> Sub.none
                        }

-- Types

type Msg
    = Nothing


type alias Flags = { something : String
                   , somethingElse : String 
                   }

type alias Item = { id : Int
                  , name : String
                  , description : String
                  , price : Float
                  , imageUrl : String}

type alias Model = { items : List Item }


init : Flags -> (Model, Cmd Msg)
init flags = 
    flags
    |> toString
    |> Debug.log
    |> \_ -> { items = [] } ! []



-- View

view : Model -> Html Msg
view model = 
    text "Hello, World"




-- Update

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = model ! []


