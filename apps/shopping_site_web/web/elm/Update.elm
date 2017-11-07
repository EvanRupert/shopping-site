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
                } |> filterItems |> (\model -> model ! [])
        ExpandFilters ->
            let
                old = model.filtering.expandedFilterMenu
                oldFiltering = model.filtering
            in
                { model | 
                    filtering = { oldFiltering | expandedFilterMenu = not old} 
                } ! []
        FilterPriceMinChange str -> 
            let 
                oldFiltering = model.filtering
                oldPriceFilter = model.filtering.priceFilter
            in
                case String.toFloat str of
                    Ok flt ->
                        if oldPriceFilter == Nothing then
                            { model | filtering = { oldFiltering | priceFilter = Just { minVal = Just flt, maxVal = Nothing } } }
                            |> filterItems |> (\model -> model ! [])
                        else
                            { model | filtering = { oldFiltering | priceFilter = Maybe.andThen (\pf -> Just { pf | minVal = Just flt }) oldPriceFilter } }
                            |> filterItems |> (\model -> model ! [])
                    Err err ->
                        { model | filtering = { oldFiltering | error = Just err } } ! []

        FilterPriceMaxChange str ->
            let
                oldFiltering = model.filtering
                oldPriceFilter = model.filtering.priceFilter
            in
                case String.toFloat str of
                    Ok flt ->
                        if oldPriceFilter == Nothing then
                            { model | filtering = { oldFiltering | priceFilter = Just { minVal = Nothing, maxVal = Just flt } } }
                            |> filterItems |> (\model -> model ! [])
                        else
                            { model | filtering = { oldFiltering | priceFilter = Maybe.andThen (\pf -> Just { pf | maxVal = Just flt }) oldPriceFilter } }
                            |> filterItems |> (\model -> model ! [])
                    Err err -> { model | filtering = { oldFiltering | error = Just err } } ! []

        OrderingChange ordering -> 
            let
                oldFiltering = model.filtering
            in
                { model |
                    filtering = { oldFiltering | ordering = ordering }
                } |> filterItems |> (\model -> model ! [])


filterItems : Model -> Model
filterItems model = 
    let 
        items = model.allItems
        search = model.filtering.searchText
        ordering = model.filtering.ordering
        priceFilterType = model.filtering.priceFilter
        yearFilterType = model.filtering.yearFilter
        
        newItems = items
                   |> searchFilter search
                   |> priceFilter priceFilterType
                   |> yearFilter yearFilterType
                   |> orderingFilter ordering
    in
        { model | visibleItems = newItems }


orderingFilter : Ordering -> List Item -> List Item
orderingFilter ordering items = items --TODO: implement


priceFilter : Maybe PriceFilter -> List Item -> List Item
priceFilter priceFilterType items = items --TODO: imiplement


yearFilter : Maybe YearFilter -> List Item -> List Item
yearFilter yearFilterType items = items --TODO: implement


searchFilter : String -> List Item -> List Item
searchFilter str = 
    List.filter (\i -> String.contains 
                        (String.toUpper str) 
                        (String.toUpper i.name))
