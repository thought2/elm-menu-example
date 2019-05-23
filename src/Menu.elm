module Menu exposing (Config, Model, Msg(..), init, update, views)

import Html exposing (..)
import SelectList exposing (SelectList)



-- MODEL


type alias Model a =
    SelectList a


init : List a -> a -> List a -> Model a
init before selected after =
    SelectList.fromLists before selected after



-- UPDATE


type Msg a
    = Select a


update : Msg a -> Model a -> Model a
update msg model =
    case msg of
        Select selection ->
            SelectList.select ((==) selection) model



-- VIEW


type alias Config a msg =
    { onSelf : Msg a -> msg
    , viewItem : { isSelected : Bool, item : a } -> Html (Msg a)
    }


views : Config a msg -> Model a -> List (Html msg)
views config model =
    model
        |> SelectList.mapBy
            (\pos item ->
                Html.map config.onSelf <|
                    config.viewItem
                        { isSelected = pos == SelectList.Selected
                        , item = item
                        }
            )
        |> SelectList.toList
