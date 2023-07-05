module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (disabled)
import Html.Events exposing (onClick)


type alias Counter =
    { count : Int
    , lastMsg : Maybe Msg
    , step : Int
    , history : List Int
    }


type alias Model =
    List Counter


init : Model
init =
    [ { count = 0
      , lastMsg = Nothing
      , step = 1
      , history = []
      }
    ]


type Msg
    = Plus1 Int
    | Minus1 Int
    | Reset Int
    | SetStep Int Int
    | Undo Int
    | NewCounter


update : Msg -> Model -> Model
update msg model =
    case msg of
        Plus1 id ->
            List.indexedMap updateCounter model
                |> List.map
                    (\( index, counter ) ->
                        if index == id then
                            { counter | count = counter.count + counter.step, history = counter.count :: counter.history, lastMsg = Just (Plus1 id) }

                        else
                            counter
                    )

        Minus1 id ->
            List.indexedMap updateCounter model
                |> List.map
                    (\( index, counter ) ->
                        if index == id then
                            { counter | count = counter.count - counter.step, history = counter.count :: counter.history, lastMsg = Just (Minus1 id) }

                        else
                            counter
                    )

        Reset id ->
            List.indexedMap updateCounter model
                |> List.map
                    (\( index, counter ) ->
                        if index == id then
                            { counter | count = 0, history = [], lastMsg = Just (Reset id) }

                        else
                            counter
                    )

        SetStep id newStep ->
            List.indexedMap updateCounter model
                |> List.map
                    (\( index, counter ) ->
                        if index == id then
                            { counter | step = newStep }

                        else
                            counter
                    )

        Undo id ->
            List.indexedMap updateCounter model
                |> List.map
                    (\( index, counter ) ->
                        if index == id then
                            case counter.history of
                                [] ->
                                    counter

                                h :: t ->
                                    { counter | count = h, history = t }

                        else
                            counter
                    )

        NewCounter ->
            model ++ [ { count = 0, lastMsg = Nothing, step = 1, history = [] } ]


updateCounter : Int -> a -> ( Int, a )
updateCounter index counter =
    ( index, counter )


view : Model -> Html Msg
view model =
    div []
        (List.indexedMap viewCounter model
            ++ [ button [ onClick NewCounter ] [ text "Add new counter" ] ]
        )


viewCounter : Int -> Counter -> Html Msg
viewCounter id counter =
    div []
        [ div [] [ text ("Counter: " ++ String.fromInt counter.count) ]
        , button [ onClick (Plus1 id), disabled (counter.count >= 100) ] [ text ("+" ++ String.fromInt counter.step) ]
        , button [ onClick (Minus1 id), disabled (counter.count <= 0) ] [ text ("-" ++ String.fromInt counter.step) ]
        , button [ onClick (Reset id) ] [ text "Reset" ]
        , div [] [ text ("Step: " ++ String.fromInt counter.step) ]
        , div [] [ text ("History: " ++ (List.map String.fromInt counter.history |> List.reverse |> String.join ", ")) ]
        , button [ onClick (Undo id), disabled (List.isEmpty counter.history) ] [ text "Undo" ]
        , displayLastMsg counter.lastMsg
        ]


displayLastMsg : Maybe Msg -> Html Msg
displayLastMsg maybeMsg =
    div []
        [ text <|
            case maybeMsg of
                Just msg ->
                    "Last message: " ++ msgToText msg

                Nothing ->
                    "No last message"
        ]


msgToText : Msg -> String
msgToText msg =
    case msg of
        Plus1 _ ->
            "Plus1"

        Minus1 _ ->
            "Minus1"

        Reset _ ->
            "Reset"

        SetStep _ _ ->
            "SetStep"

        Undo _ ->
            "Undo"

        NewCounter ->
            "NewCounter"


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
