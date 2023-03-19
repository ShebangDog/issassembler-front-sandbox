port module Main exposing (Model, Msg(..), Status(..), handleUrlChange, init, subscriptions, update, view)

import Browser exposing (Document)
import Browser.Navigation
import Color
import Css
import Css.Global
import Css.Reset
import Html.Styled exposing (a)
import Html.Styled.Attributes exposing (href)
import Json.Decode
import Json.Encode
import Monocle.Lens exposing (Lens)
import NavigationBar
import Page
import Route exposing (Route)
import Url
import Url.Parser exposing (Parser)


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Route
    | ModeChanged Color.DisplayMode
    | Receive ( Json.Encode.Value, Json.Encode.Value )


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



-- Flags


type alias Flags =
    { count : Data
    , displayMode : Color.DisplayMode
    }


countOfFlags : Lens { a | count : b } b
countOfFlags =
    let
        get flags =
            flags.count

        set count flags =
            { flags | count = count }
    in
    Lens get set


displayModeOfFlags : Lens { a | displayMode : b } b
displayModeOfFlags =
    let
        get flags =
            flags.displayMode

        set displayMode flags =
            { flags | displayMode = displayMode }
    in
    Lens get set


decodeFlags : Json.Decode.Decoder Flags
decodeFlags =
    Json.Decode.map2 Flags
        (Json.Decode.field "count" decodeData)
        (Json.Decode.field "displayMode" decodeDisplayMode)


decodeDisplayMode : Json.Decode.Decoder Color.DisplayMode
decodeDisplayMode =
    let
        decodeStringAsDispalyMode value =
            Color.fromString value
                |> Maybe.map Json.Decode.succeed
                |> Maybe.withDefault (Json.Decode.fail value)
    in
    Json.Decode.andThen decodeStringAsDispalyMode Json.Decode.string


decodeValue : Json.Decode.Decoder Int
decodeValue =
    Json.Decode.field "value" Json.Decode.int


decodeData : Json.Decode.Decoder Data
decodeData =
    Json.Decode.map Data decodeValue


decoder : Json.Decode.Value -> Result Json.Decode.Error Flags
decoder =
    Json.Decode.decodeValue decodeFlags


init : Json.Decode.Value -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        decodedFlags =
            decoder flags

        maybeRoute =
            parseUrlAsRoute url

        dataResult =
            Result.map countOfFlags.get decodedFlags

        colorResult =
            Result.map displayModeOfFlags.get decodedFlags
    in
    ( Model
        Loading
        key
        (Maybe.withDefault Route.top maybeRoute)
        (Result.withDefault (Data 10) dataResult)
        (Result.withDefault Color.Default colorResult)
    , Cmd.none
    )


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
    let
        route =
            parseUrlAsRoute url
    in
    UrlChanged
        (Maybe.withDefault Route.top route)


routeParser : Parser (Route -> Route) Route
routeParser =
    let
        parserTuple route =
            ( route, Route.toString route )

        parseRoute ( route, routeTag ) =
            Url.Parser.map route (Url.Parser.s routeTag)
    in
    Url.Parser.oneOf (List.map (parserTuple >> parseRoute) Route.routeSet)


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
            ( { model | mode = mode }, storeToStorage ( "mode", Json.Encode.string (Color.toString mode) ) )

        Receive ( _, newValue ) ->
            ( { model | mode = Result.withDefault model.mode (Json.Decode.decodeValue decodeDisplayMode newValue) }
            , Cmd.none
            )


port storeToStorage : ( String, Json.Encode.Value ) -> Cmd msg


port storageReceiver : (( Json.Decode.Value, Json.Decode.Value ) -> msg) -> Sub msg


view : Model -> Document Msg
view model =
    let
        theme =
            Color.theme model.mode
    in
    { title = title
    , body =
        List.map Html.Styled.toUnstyled
            [ Css.Global.global
                (List.concat
                    [ [ Css.Global.body [ Css.backgroundColor theme.background ] ]
                    , Css.Reset.ericMeyer
                    ]
                )
            , NavigationBar.view theme title Route.routeSet model.route Route.transition
            , Page.view model (Page.Action ModeChanged)
            ]
    }


title : String
title =
    "Issassembler"


subscriptions : Model -> Sub Msg
subscriptions model =
    storageReceiver Receive
