module Main exposing (main)

{-| These are the imports we need to make the app work.
-}

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


{-| What we are building? Data schema called Model.
-- kinda like a json schema.
<https://guide.elm-lang.org/types/type_aliases.html>
<https://package.elm-lang.org/packages/elm/core/1.0.5/Maybe#Maybe>
-}
type alias Model =
    { count : Int
    , lastMsg : Maybe Msg
    }


{-| Initial state of the app when the page loads.
-- kinda like a json object.
<https://package.elm-lang.org/packages/elm/core/1.0.5/Maybe#Maybe>
-}
init : Model
init =
    { count = 42
    , lastMsg = Nothing
    }


{-| Messages are the actions that can be performed on the app.
-- kinda like an enum.
<https://guide.elm-lang.org/types/custom_types.html>
-}
type Msg
    = Plus1
    | Minus1


{-| Update function takes a message and the current model and returns a new model.
pattern matching on the message
<https://guide.elm-lang.org/types/pattern_matching.html>
-}
update : Msg -> Model -> Model
update msg model =
    case msg of
        Plus1 ->
            { model | count = model.count + 1, lastMsg = Just Plus1 }

        Minus1 ->
            { model | count = model.count - 1, lastMsg = Just Minus1 }


{-| View function takes the current model and returns the html to be rendered.
-- <https://package.elm-lang.org/packages/elm/html/latest/>
-}
view : Model -> Html Msg
view model =
    div []
        [ div [] [ text (String.fromInt model.count) ]
        , button [ onClick Plus1 ] [ text "+1" ]
        , button [ onClick Minus1 ] [ text "-1" ]
        , displayLastMsg model.lastMsg
        ]


{-| Helper function to display the last message
<https://guide.elm-lang.org/types/pattern_matching.html>
<https://package.elm-lang.org/packages/elm/core/1.0.5/Maybe#Maybe>
-}
displayLastMsg : Maybe Msg -> Html Msg
displayLastMsg maybeMsg =
    div []
        [ text <|
            case maybeMsg of
                Just Plus1 ->
                    "Plus1"

                Just Minus1 ->
                    "Minus1"

                Nothing ->
                    "No last message"
        ]


{-| This is the main function that starts the app
<https://package.elm-lang.org/packages/elm/browser/latest/Browser#sandbox>
-}
main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
