module Main exposing (Status(..), view)

import Browser exposing (Document)
import Browser.Navigation
import Html.Styled exposing (a, div, h1, header, li, nav, p, text, ul)
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
    ( Model Loading key (Maybe.withDefault Route.top (parseUrlAsRoute url))
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


parseUrlAsRoute : Url.Url -> Maybe Route
parseUrlAsRoute url =
    Url.Parser.parse routeParser url


handleUrlChange : Url.Url -> Msg
handleUrlChange url =
    UrlChanged (Maybe.withDefault Route.top (parseUrlAsRoute url))


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


navigationRoute : List Route
navigationRoute =
    [ Route.top, Route.history ]


navigationBar : List Route -> Route -> Html.Styled.Html Msg
navigationBar routeList currentRoute =
    header
        []
        [ h1 [] [ text title ]
        , div []
            [ nav []
                [ ul []
                    (routeList
                        |> List.map
                            (\route ->
                                let
                                    content =
                                        text <| Route.toString route

                                    element =
                                        if route == currentRoute then
                                            p [] [ content ]

                                        else
                                            a [ transition route ] [ content ]
                                in
                                li [] [ element ]
                            )
                    )
                ]
            ]
        ]


view : Model -> Document Msg
view model =
    { title = title
    , body =
        List.map Html.Styled.toUnstyled <|
            navigationBar navigationRoute model.route
                :: (case model.route of
                        Route.Top _ ->
                            [ div
                                []
                                [ text "main"
                                ]
                            ]

                        Route.History _ ->
                            [ div
                                []
                                [ text "history"
                                ]
                            ]
                   )
    }


title : String
title =
    "Issassembler"


transition : Route -> Html.Styled.Attribute Msg
transition route =
    href ("/" ++ Route.toString route)


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none
