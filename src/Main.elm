module Main exposing (Model, Msg(..), Status(..), handleUrlChange, init, subscriptions, update, view)

import Browser exposing (Document)
import Browser.Navigation
import Color
import Css
import Css.Global
import Css.Reset
import Html.Styled exposing (a, button, div, h1, header, li, nav, p, text, ul)
import Html.Styled.Attributes exposing (href)
import Html.Styled.Events exposing (onClick)
import Json.Decode
import Route exposing (Route)
import Url
import Url.Parser exposing (Parser)


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Route
    | ModeChanged Color.DisplayMode


type Status
    = Success
    | Loading


type alias Data =
    { count : Int
    }


type alias Model =
    { status : Status
    , key : Browser.Navigation.Key
    , route : Route
    , data : Data
    , mode : Color.DisplayMode
    }


type alias Flags =
    { count : Count
    , displayMode : Color.DisplayMode
    }


type alias Count =
    { value : Int
    }


init : Json.Decode.Value -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model Loading
        key
        (Maybe.withDefault Route.top (parseUrlAsRoute url))
        (Data (Result.withDefault 10 (decoder flags |> Result.map (\result -> result.count.value))))
        (Result.withDefault Color.Default (decoder flags |> Result.map (\result -> result.displayMode)))
    , Cmd.none
    )


decodeFlags : Json.Decode.Decoder Flags
decodeFlags =
    Json.Decode.map2 Flags
        (Json.Decode.field "count" decodeCount)
        (Json.Decode.field "displayMode" decodeDisplayMode)


decodeDisplayMode : Json.Decode.Decoder Color.DisplayMode
decodeDisplayMode =
    Json.Decode.string
        |> Json.Decode.andThen
            (\value ->
                case
                    Color.fromString value
                of
                    Just head ->
                        Json.Decode.succeed head

                    Nothing ->
                        Json.Decode.fail value
            )


decodeCount : Json.Decode.Decoder Count
decodeCount =
    Json.Decode.map Count (Json.Decode.field "value" Json.Decode.int)


decoder : Json.Decode.Value -> Result Json.Decode.Error Flags
decoder =
    Json.Decode.decodeValue decodeFlags


main : Program Json.Decode.Value Model Msg
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

        ModeChanged mode ->
            ( { model | mode = mode }, Cmd.none )


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
    let
        theme =
            Color.theme model.mode
    in
    { title = title
    , body =
        List.map Html.Styled.toUnstyled <|
            Css.Global.global (Css.Global.body [ Css.backgroundColor theme.primary ] :: Css.Reset.ericMeyer)
                :: (navigationBar navigationRoute model.route
                        :: (case model.route of
                                Route.Top _ ->
                                    [ div
                                        []
                                        (List.concat
                                            [ [ text "main"
                                              , text (String.fromInt model.data.count)
                                              ]
                                            , Color.displayModeSet
                                                |> List.map
                                                    (\mode -> button [ onClick (ModeChanged mode) ] [ text (Color.toString mode) ])
                                            ]
                                        )
                                    ]

                                Route.History _ ->
                                    [ div
                                        []
                                        [ text "history"
                                        ]
                                    ]
                           )
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
