module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (src, style)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (required)
import RemoteData exposing (RemoteData(..), WebData)


type alias Model =
    { quote : WebData Quote
    , catImage : WebData String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { quote = NotAsked
      , catImage = NotAsked
      }
    , Cmd.batch [ getRandomQuote, getRandomImage ]
    )


type Msg
    = FetchQuote
    | GotQuote (Result Http.Error Quote)
    | FetchImage
    | GotImage (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchQuote ->
            ( { model | quote = Loading }, getRandomQuote )

        GotQuote newQuote ->
            ( { model | quote = RemoteData.fromResult newQuote }, Cmd.none )

        FetchImage ->
            ( { model | catImage = Loading }, getRandomImage )

        GotImage newImage ->
            ( { model | catImage = RemoteData.fromResult newImage }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "Random Quotes" ]
        , button [ onClick FetchQuote, onClick FetchImage ] [ text "Fetch New Data" ]
        , viewData model.quote model.catImage
        ]


viewData : WebData Quote -> WebData String -> Html Msg
viewData quoteData imageData =
    case ( quoteData, imageData ) of
        ( Loading, _ ) ->
            text "Loading quote..."

        ( _, Loading ) ->
            text "Loading image..."

        ( Success quote, Success imageUrl ) ->
            div []
                [ blockquote [] [ text quote.quote ]
                , p [ style "text-align" "right" ]
                    [ text "— "
                    , cite [] [ text quote.source ]
                    , text (" by " ++ quote.author ++ " (" ++ String.fromInt quote.year ++ ")")
                    ]
                , img [ src imageUrl ] []
                ]

        ( Failure _, _ ) ->
            text "Failed to load quote."

        ( _, Failure _ ) ->
            text "Failed to load image."

        _ ->
            text "Nothing to display."


type alias Quote =
    { quote : String
    , source : String
    , author : String
    , year : Int
    }


quoteDecoder : Decode.Decoder Quote
quoteDecoder =
    Decode.succeed Quote
        |> required "quote" Decode.string
        |> required "source" Decode.string
        |> required "author" Decode.string
        |> required "year" Decode.int


imageDecoder : Decode.Decoder String
imageDecoder =
    Decode.at [ "0", "url" ] Decode.string


getRandomQuote : Cmd Msg
getRandomQuote =
    Http.get
        { url = "https://elm-lang.org/api/random-quotes"
        , expect = Http.expectJson GotQuote quoteDecoder
        }


getRandomImage : Cmd Msg
getRandomImage =
    Http.get
        { url = "https://api.thecatapi.com/v1/images/search?size=full"
        , expect = Http.expectJson GotImage imageDecoder
        }


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
