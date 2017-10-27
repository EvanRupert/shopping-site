module Update exposing ( update )

import Types exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SearchChange search ->
            let
                items = model.allItems
                oldFiltering = model.filtering
            in
                { model | visibleItems = searchFilter search items
                        , filtering = { oldFiltering | searchText = search } 
                } ! []
        ExpandFilters ->
            let
                old = model.filtering.expandedFilterMenu
                oldFiltering = model.filtering
            in
                { model | 
                    filtering = { oldFiltering | expandedFilterMenu = not old} 
                } ! []
        FilterPriceMinChange str -> model ! [] --TODO implement

        FilterPriceMaxChange str -> model ! [] --TODO implement
        


searchFilter : String -> List Item -> List Item
searchFilter str = 
    List.filter (\i -> String.contains 
                        (String.toUpper str) 
                        (String.toUpper i.name))
