module Types exposing (..)

type Msg
    = SearchChange String
    | ExpandFilters
    | FilterPriceMinChange String
    | FilterPriceMaxChange String
    | OrderingChange Ordering

type Ordering
    = Alphabetic
    | ReverseAlphabetic

type alias Flags = { payload : String }

type alias Item = { name : String
                  , description : String
                  , price : Float
                  , imageUrl : String
                  }

type alias Model = { allItems : List Item
                   , visibleItems : List Item
                   , filtering : Filter
                   }

type alias Filter = { searchText : String
                    , expandedFilterMenu : Bool
                    , priceFilter : Maybe PriceFilter
                    , error : Maybe String
                    , ordering : Ordering
                    , yearFilter : Maybe YearFilter
                    }

type alias PriceFilter = { minVal : Maybe Float
                         , maxVal : Maybe Float
                         }

type alias YearFilter = { minVal : Maybe Int
                        , maxVal : Maybe Int
                        }
