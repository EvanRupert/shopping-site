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
        , if model.filtering.expandedFilterMenu then 
            filtersMenu model
          else 
            expandFiltersButton model
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
        [ text "Advanced" ]


filtersMenu : Model -> Html Msg
filtersMenu model = 
    div [ class "card border-secondary" ]
        [ div [ class "row" ]
            [ div [ class "col-4" ] <| priceFilterMenu model
            , div [ class "col-4" ] <| orderingMenu model
            , div [ class "col-4" ] <| yearFilterMenu model
            ]
        , button [ type_ "button"
                 , class "btn btn-secondary btn-lg btn-block"
                 , onClick ExpandFilters
                 ] [ text "Close Advanced" ]
        ]

-- TODO: Implement function
orderingMenu : Model -> List (Html Msg)
orderingMenu model = 
    [ label [ for "orderingSelect"] [ text "Ordering:" ]
    , Html.select [ class "form-control"
                  , id "orderingSelect" 
                  , onInput ( stringToOrdering >> OrderingChange)
                  ]
        [ option [] [ text "Alphabetic" ]
        , option [] [ text "Reverse Alphabetic" ] --TODO: add additional orderings
        ]
    ]


stringToOrdering : String -> Ordering
stringToOrdering str = 
    case str of
        "Alphabetic" -> Alphabetic
        "Reverse Alphabetic" -> ReverseAlphabetic --TODO: add additional orderings
        _ -> Debug.crash "Ordering select list threw unexpected result"


-- TODO: Implement function
yearFilterMenu : Model -> List (Html Msg)
yearFilterMenu model =
    [ h6 [] [ text "Year" ]
    , div [ class "row" ]
        [ div [ class "col-5" ]
            [ label [ for "minimumYear" ] []
            , input [ id "minimumYear" 
                    , class "price-year-filter-input"
                    , onInput FilterYearMinChange
                    ] []
            ]
        , div [ class "col-2" ]
            [ p [] [ text "to" ]
            ]
        , div [ class "col-5" ]
            [ label [ for "maximumYear" ] []
            , input [ id "maximumYear" 
                    , class "price-year-filter-input"
                    , onInput FilterYearMaxChange
                    ] []
            ]
        ]
    ]


priceFilterMenu : Model -> List (Html Msg)
priceFilterMenu model =
    [ h6 [] [ text "Price"]
    , div [ class "row" ]
        [ div [ class "col-5" ]
            [ label [ for "minimumPrice" ] []
            , input [ id "minimumPrice"
                    , class "price-year-filter-input"
                    , onInput FilterPriceMinChange
                    ] []
            ]
        , div [ class "col-2" ]
            [ p [] [ text "to" ]
            ]
        , div [ class "col-5" ]
            [ label [ for "maximumPrice" ] []
            , input [ id "maximumPrice"
                    , class "price-year-filter-input"
                    , onInput FilterPriceMaxChange 
                    ] []
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