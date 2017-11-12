module Types exposing (..)

import Date


type Msg
    = SearchChange String
    | ExpandFilters
    | FilterPriceMinChange String
    | FilterPriceMaxChange String
    | FilterDateMinChange String
    | FilterDateMaxChange String
    | OrderingChange Ordering

type Ordering
    = Alphabetic
    | ReverseAlphabetic

type alias Flags = 
    { payload : String }

type alias Item = 
    { name : String
    , description : String
    , price : Float
    , imageUrl : String
    , updatedAt : Date.Date
    }

type alias Model = 
    { allItems : List Item
    , visibleItems : List Item
    , filtering : Filter
    }

type alias Filter = 
    { searchText : String
    , expandedFilterMenu : Bool
    , priceFilter : Maybe PriceFilter
    , error : Maybe String
    , ordering : Ordering
    , dateFilter : Maybe DateFilter
    }

type alias PriceFilter = 
    { minVal : Maybe Float
    , maxVal : Maybe Float
    }

type alias DateFilter = 
    { minVal : Maybe Date.Date
    , maxVal : Maybe Date.Date
    }


-- January 1 2017 00:00:00
defaultDate : Date.Date 
defaultDate = Date.fromTime 1483246800000
