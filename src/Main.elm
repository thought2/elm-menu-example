module Main exposing (Model, Msg(..), init, subscriptions, update, view)

import Html as Html exposing (..)
import Html.Attributes as Attrs exposing (..)
import Html.Events as Events exposing (..)
import Menu

import Html.Events as Events


-- MODEL


type alias Model =
    { menu1 : Menu.Model Page
    , menu2 : Menu.Model Int
    }


type Page
    = Home
    | About
    | Bla
    | More


pageToLink : Page -> Menu.Link
pageToLink page =
    case page of
        Home ->
            { title = "Home" }

        About ->
            { title = "About" }

        Bla ->
            { title = "Bla" }

        More ->
            { title = "More" }


init : ( Model, Cmd msg )
init =
    ( { menu1 = Menu.init [] Home [ About, Bla, More ]
      , menu2 = Menu.init (List.range 0 10) 11 (List.range 12 20)
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Menu1Msg (Menu.Msg Page)
    | Menu2Msg (Menu.Msg Int)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Menu1Msg subMsg ->
            ( { model
                | menu1 = Menu.update subMsg model.menu1
              }
            , Cmd.none
            )

        Menu2Msg subMsg ->
            ( { model
                | menu2 = Menu.update subMsg model.menu2
              }
            , Cmd.none
            )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 []
            [ text "Menu1"
            , Menu.view
                { toLink = pageToLink
                , msgConstructor = Menu1Msg
                }
                model.menu1
            ]
        , h1 []
            [ text "Menu2"
            , Menu.view
                { toLink = \i -> { title = toString i }
                , msgConstructor = Menu2Msg
                }
                model.menu2
            ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
