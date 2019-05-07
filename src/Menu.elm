module Menu exposing (Config, Link, Model, Msg(..), init, update, view)

import Html exposing (..)
import Html.Events as Events
import SelectList exposing (SelectList)



-- MODEL


type alias Model a =
    { links : SelectList a
    }


init : List a -> a -> List a -> Model a
init before selected after =
    { links = SelectList.fromLists before selected after
    }



-- UPDATE


type Msg a
    = Select a


update : Msg a -> Model a -> Model a
update msg model =
    case msg of
        Select selection ->
            { links = SelectList.select ((==) selection) model.links }



-- VIEW


type alias Link =
    { title : String }


type alias Config msg a =
    { toLink : a -> Link
    , msgConstructor : Msg a -> msg
    }


view : Config msg a -> Model a -> Html msg
view config model =
    ul []
        (model.links
            |> SelectList.mapBy
                (\pos item ->
                    li [ Events.onClick (config.msgConstructor <| Select item) ]
                        [ text <|
                            (if pos == SelectList.Selected then
                                "-> "

                             else
                                ""
                            )
                                ++ (config.toLink item).title
                        ]
                )
            |> SelectList.toList
        )
