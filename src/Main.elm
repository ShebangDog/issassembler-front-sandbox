module Main exposing (Status(..), view)

import Browser exposing (Document)
import Browser.Navigation
import Html.Styled exposing (a, div, text)
import Html.Styled.Attributes exposing (href)
import Route exposing (Route)
import Url
import Url.Parser exposing (Parser)


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Route


type Status
    = Success
    | Loading


type alias Model =
    { status : Status
    , key : Browser.Navigation.Key
    , route : Route
    }


init : () -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init () url key =
    ( Model Loading key (Maybe.withDefault Route.top (Url.Parser.parse routeParser url))
    , Cmd.none
    )


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = LinkClicked
        , onUrlChange = handleUrlChange
        }


handleUrlChange : Url.Url -> Msg
handleUrlChange url =
    UrlChanged (Maybe.withDefault Route.top (Url.Parser.parse routeParser url))


routeParser : Parser (Route -> Route) Route
routeParser =
    Url.Parser.oneOf
        ([ Route.top, Route.history ]
            |> List.map (\route -> Url.Parser.map route (Url.Parser.s (Route.toString route)))
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Browser.Navigation.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Browser.Navigation.load href )

        UrlChanged route ->
            ( { model | route = route }, Cmd.none )


view : Model -> Document Msg
view model =
    case model.route of
        Route.Top from ->
            { title = "main"
            , body =
                List.map Html.Styled.toUnstyled
                    [ div
                        []
                        [ text "main"
                        , div [] [ a [ transition (Route.toHistory from) ] [ text "History" ] ]
                        , div [] [ a [ transition (Route.toTop from) ] [ text "Main" ] ]
                        ]
                    ]
            }

        Route.History from ->
            { title = "hisotry"
            , body =
                List.map Html.Styled.toUnstyled
                    [ div
                        []
                        [ text "history"
                        , a [ transition (Route.toTop from) ] [ text "Main" ]
                        ]
                    ]
            }


transition : Route -> Html.Styled.Attribute Msg
transition route =
    href ("/" ++ Route.toString route)


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none
