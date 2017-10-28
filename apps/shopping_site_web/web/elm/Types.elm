module Types exposing (..)

type Msg
    = SearchChange String
    | ExpandFilters
    | FilterPriceMinChange String
    | FilterPriceMaxChange String

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
                    , price : Maybe PriceFilter
                    , error : Maybe String
                    , orderBy : Ordering
                    , yearAdded : Maybe YearFilter
                    }

type alias PriceFilter = { minVal : Float
                         , maxVal : Float
                         }

type alias YearFilter = { minVal : Float
                        , maxVal : Float
                        }
