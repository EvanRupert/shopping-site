module Update exposing ( update )

import Date

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

        FilterDateMinChange str ->
            let
                oldFiltering = model.filtering
                oldDateFilter = model.filtering.dateFilter
                date = stringToMaybeDate str
            in
                { model | filtering = { oldFiltering | 
                    dateFilter = Maybe.andThen (\df -> Just { df | minVal = date }) oldDateFilter } }
                |> filterItems |> (\model -> model ! [])

        FilterDateMaxChange str ->
            let
                oldFiltering = model.filtering
                oldDateFilter = model.filtering.dateFilter
                date = stringToMaybeDate str
            in
                { model | filtering = { oldFiltering | 
                    dateFilter = Maybe.andThen (\df -> Just { df | maxVal = date }) oldDateFilter } }
                |> filterItems |> (\model -> model ! [])

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
    |> dateFilter model.filtering.dateFilter
    |> orderingFilter model.filtering.ordering
    |> (\newItems -> { model | visibleItems = newItems })


orderingFilter : Ordering -> List Item -> List Item
orderingFilter ordering items = 
    case ordering of
        Alphabetic -> List.sortBy .name items
        ReverseAlphabetic -> List.reverse <| List.sortBy .name items


priceFilter : Maybe PriceFilter -> List Item -> List Item
priceFilter priceFilterType items = 
    case priceFilterType of
        Nothing -> items
        Just priceFilter -> 
            items
            |> (\itms -> case priceFilter.minVal of
                            Nothing -> itms
                            Just val -> List.filter (\item -> item.price > val) itms)
            |> (\itms -> case priceFilter.maxVal of
                            Nothing -> itms
                            Just val -> List.filter (\item -> item.price < val) itms)


dateFilter : Maybe DateFilter -> List Item -> List Item
dateFilter dateFilterType items =
    case dateFilterType of
        Nothing -> items
        Just dateFilter ->
            items
            |> (\itms -> case dateFilter.minVal of
                            Nothing -> itms
                            Just val -> List.filter (\item -> (Date.toTime item.updatedAt) > (Date.toTime val)) itms)
            |> (\itms -> case dateFilter.maxVal of
                            Nothing -> itms
                            Just val -> List.filter (\item -> (Date.toTime item.updatedAt) < (Date.toTime val)) itms)


stringToMaybeDate : String -> Maybe Date.Date
stringToMaybeDate str =
    case Date.fromString str of
        Ok date -> Just date
        Err _ -> Nothing


searchFilter : String -> List Item -> List Item
searchFilter str = 
    List.filter (\i -> String.contains 
                        (String.toUpper str) 
                        (String.toUpper i.name))
