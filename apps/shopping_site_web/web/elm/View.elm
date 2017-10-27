module View exposing ( view )

import Types exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onInput, onClick )


view : Model -> Html Msg
view model = 
    div []
        [ input [ type_ "text"
                , placeholder "Search"
                , class "form-control"
                , id "search"
                , onInput SearchChange
                ] []
        , if model.expandedFilters then filtersMenu model else expandFiltersButton model
        , div [ class "container" ] (model.visibleItems
                                    |> groupInto 3
                                    |> List.map viewGroup
                                    )
        ]


expandFiltersButton : Model -> Html Msg
expandFiltersButton model = 
    button [ type_ "button"
           , class "btn btn-secondary btn-lg btn-block"
           , onClick ExpandFilters 
           ]  
        [ text "Additional Filters" ]


filtersMenu : Model -> Html Msg
filtersMenu model = 
    div [ class "card" ]
        [ div [ class "row" ]
            [ div [ class "col-3"] 
                [ h6 [] [ text "Price"]
                , Html.form []
                    [ label [ for "minimumPrice" ] [ text "Minimum" ]
                    , input [ id "minimumPrice", onInput FilterPriceMinnge ] []
                    , label [ for "maximumPrice" ] [ text "Maximum" ] []
                    , input [ id "maximumPrice", onInput FilterPriceMaxChange ] []
                    ]
                ]
            ]
        ]


viewGroup : List Item -> Html Msg
viewGroup items =
    div [ class "row margin-row" ] <| List.map viewItem items


viewItem : Item -> Html Msg
viewItem item = 
    div [ class "col-md-4" ]
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