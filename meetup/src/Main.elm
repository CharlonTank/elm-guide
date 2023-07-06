module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (disabled, src, style)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (required)
import RemoteData exposing (RemoteData(..), WebData)


type alias Model =
    { quote : WebData Quote
    , cat : WebData Cat
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { quote = NotAsked
      , cat = NotAsked
      }
    , Cmd.batch [ getRandomQuote, getRandomCat ]
    )


type Msg
    = Fetch
    | GotQuote (Result Http.Error Quote)
    | GotCat (Result Http.Error Cat)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Fetch ->
            ( { model | quote = Loading, cat = Loading }, Cmd.batch [ getRandomQuote, getRandomCat ] )

        GotQuote newQuote ->
            ( { model | quote = RemoteData.fromResult newQuote }, Cmd.none )

        GotCat newCat ->
            ( { model | cat = RemoteData.fromResult newCat }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "Random Quotes" ]
        , button [ onClick Fetch, disabled (isLoading model) ] [ text "Fetch New Data" ]
        , viewData model.quote
        , viewCat model.cat
        ]


viewData : WebData Quote -> Html Msg
viewData quoteData =
    case quoteData of
        Loading ->
            text "Loading quote..."

        Success quote ->
            div []
                [ blockquote [] [ text quote.quote ]
                , p [ style "text-align" "right" ]
                    [ text "— "
                    , cite [] [ text quote.source ]
                    , text (" by " ++ quote.author ++ " (" ++ String.fromInt quote.year ++ ")")
                    ]
                ]

        Failure _ ->
            text "Failed to load quote."

        _ ->
            text ""


isLoading : Model -> Bool
isLoading model =
    model.cat == Loading || model.quote == Loading


viewCat : WebData Cat -> Html Msg
viewCat catData =
    case catData of
        Loading ->
            text "Loading cat..."

        Success cat ->
            div []
                [ img [ src cat.url ] [] ]

        Failure err ->
            text ("Failed to load cat." ++ httpErrorToString err)

        _ ->
            text ""


type alias Quote =
    { quote : String
    , source : String
    , author : String
    , year : Int
    }


type alias Cat =
    { id : String
    , url : String
    , width : Int
    , height : Int
    }


quoteDecoder : Decode.Decoder Quote
quoteDecoder =
    Decode.succeed Quote
        |> required "quote" Decode.string
        |> required "source" Decode.string
        |> required "author" Decode.string
        |> required "year" Decode.int


catDecoder : Decode.Decoder Cat
catDecoder =
    Decode.succeed Cat
        |> required "id" Decode.string
        |> required "url" Decode.string
        |> required "width" Decode.int
        |> required "height" Decode.int


getRandomQuote : Cmd Msg
getRandomQuote =
    Http.get
        { url = "https://elm-lang.org/api/random-quotes"
        , expect = Http.expectJson GotQuote quoteDecoder
        }


getRandomCat : Cmd Msg
getRandomCat =
    Http.get
        { url = "https://api.thecatapi.com/v1/images/search?size%253Dfull"
        , expect = Http.expectJson GotCat (Decode.index 0 catDecoder)
        }


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


httpErrorToString : Http.Error -> String
httpErrorToString error =
    case error of
        Http.BadUrl url ->
            "Bad URL: " ++ url

        Http.Timeout ->
            "Request timed out."

        Http.NetworkError ->
            "Network error."

        Http.BadStatus code ->
            "Bad status code: " ++ String.fromInt code

        Http.BadBody msg ->
            "Bad body: " ++ msg
