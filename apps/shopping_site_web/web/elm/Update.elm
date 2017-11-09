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
 
        -- Find a way to condence this atrocity of a case statement into something better
        -- maybe make reusable function for 
        -- FilterPriceMinChange, FilterPriceMaxChange, FilterYearMinChange, and FilterYearMaxChange
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

        FilterYearMinChange str ->
            let
                oldFiltering = model.filtering
                oldYearFilter = model.filtering.yearFilter
            in
                case String.toInt str of
                    Ok int ->
                        if oldYearFilter == Nothing then
                            { model | filtering = { oldFiltering | yearFilter = Just { minVal = Just int, maxVal = Nothing } } }
                            |> filterItems |> (\model -> model ! [])
                        else
                            { model | filtering = { oldFiltering | yearFilter = Maybe.andThen (\pf -> Just { pf | minVal = Just int }) oldYearFilter } }
                            |> filterItems |> (\model -> model ! [])
                    Err err -> { model | filtering = { oldFiltering | error = Just err } } ! []

        FilterYearMaxChange str ->
            let
                oldFiltering = model.filtering
                oldYearFilter = model.filtering.yearFilter
            in
                case String.toInt str of
                    Ok int -> 
                        if oldYearFilter == Nothing then
                            { model | filtering = { oldFiltering | yearFilter = Just { minVal = Nothing, maxVal = Just int } } }
                            |> filterItems |> (\model -> model ! [])
                        else
                            { model | filtering = { oldFiltering | yearFilter = Maybe.andThen (\pf -> Just { pf | maxVal = Just int }) oldYearFilter } }
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
    model.allItems
    |> searchFilter model.filtering.searchText
    |> priceFilter model.filtering.priceFilter
    |> yearFilter model.filtering.yearFilter
    |> orderingFilter model.filtering.ordering
    |> (\newItems -> { model | visibleItems = newItems })


orderingFilter : Ordering -> List Item -> List Item
orderingFilter ordering items = 
    case ordering of
        Alphabetic -> List.sortBy .name items
        ReverseAlphabetic -> List.reverse <| List.sortBy .name items


priceFilter : Maybe PriceFilter -> List Item -> List Item
priceFilter priceFilterType items = items --TODO: imiplement


yearFilter : Maybe YearFilter -> List Item -> List Item
yearFilter yearFilterType items = items --TODO: implement


searchFilter : String -> List Item -> List Item
searchFilter str = 
    List.filter (\i -> String.contains 
                        (String.toUpper str) 
                        (String.toUpper i.name))
