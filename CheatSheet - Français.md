# Elm Cheatsheet

## Introduction

Elm is a statically-typed functional programming language that compiles to JavaScript. It's known for its reliability, performance, and excellent error messages. Elm also implements a variant of the Flux/Redux architecture (often called "The Elm Architecture") which can be a great way to structure web applications. To learn more, refer to the [Elm guide](https://guide.elm-lang.org/).

## Basic Syntax and Concepts

### Basic Values and Types

```elm
5       -- Int
5.0     -- Float
True    -- Bool
"Hello" -- String
['a', 'b', 'c'] -- List Char
```

Elm has immutable data. Once a value is created, it cannot be changed. Instead, new values are created based on old ones. For more, see the [Elm guide's section on types](https://guide.elm-lang.org/types/).

### Functions

```elm
add x y = x + y -- Define a function
add 5 3 -- Call a function
```

Functions in Elm are pure, meaning they always produce the same output for the same inputs and have no side effects. Check the [Elm guide's section on functions](https://guide.elm-lang.org/core_language.html#functions).

### Records

```elm
person = { name = "Alice", age = 30 } -- Create a record
person.name -- Access a field
{ person | age = 31 } -- Update a field (actually creates a new record)
```

Records are similar to JavaScript objects or Python dictionaries. However, in line with Elm's immutability principle, you can't directly change a field in a record. Instead, you create a new record based on an existing one.

### Type Aliases and Custom Types

```elm
type alias Person = { name : String, age : Int } -- Type alias for records
type TrafficLight = Red | Yellow | Green -- Custom type (aka "tagged union" or "enum")
```

Type aliases and custom types can be very powerful. You can read more about them in the [Elm guide](https://guide.elm-lang.org/types/custom_types.html).

### Lists

```elm
numbers = [1, 2, 3, 4, 5] -- Define a list
List.length numbers -- Get the length of a list
List.map ((*) 2) numbers -- Apply a function to each item
List.filter (\n -> n > 3) numbers -- Keep only items that satisfy a condition
List.append [1, 2] [3, 4] -- Join two lists together
```

Elm provides a [List package](https://package.elm-lang.org/packages/elm/core/latest/List) with several handy functions.

### Tuples

```elm
pair = (42, "Answer") -- Define a tuple
Tuple.first pair -- Get the first item in a tuple
Tuple.second pair -- Get the second item in a tuple
```

Elm's [Tuple package](https://package.elm-lang.org/packages/elm/core/latest/Tuple) includes functions to work with pairs and triples.

### Maybe

Maybe is a type that represents an optional value. A Maybe can be either Just value or Nothing.

```elm
isEven x = if x % 2 == 0 then Just x else Nothing -- Function that returns a Maybe
Maybe.map ((*) 2) (isEven 5) -- Apply a function to Maybe, results in Nothing
Maybe.map ((*) 2) (isEven 6) -- Apply a function to Maybe, results in Just 12
```

The [Maybe package](https://package.elm-lang.org/packages/elm/core/latest/Maybe) provides several useful functions for working with this type.

## The Elm Architecture

Elm applications are structured around a Model - Update - View architecture.

```elm
import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)

-- MODEL

type alias Model = Int

initialModel : Model
initialModel = 0

-- UPDATE

type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1
        Decrement ->
            model - 1

-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Increment ] [ text "+" ]
        , div [] [ text (String.fromInt model) ]
        , button [ onClick Decrement ] [ text "-" ]
        ]

-- MAIN

main =
    Browser.sandbox { init = initialModel, update = update, view = view }
```

This architecture is explained in detail in the [Elm guide](https://guide.elm-lang.org/architecture/).

## Elm Packages

Elm packages are available on [package.elm-lang.org](https://package.elm-lang.org/). You can install them using the `elm install` command.

`````bash

## Elm REPL

````bash

Elm REPL (Read-Evaluate-Print-Loop) helps in testing individual Elm expressions by running them on an interactive command line tool.

```bash
$ elm repl
> 1 + 1
2 : number
> "Hello" ++ " " ++ "World"
"Hello World" : String
> List.length [1, 2, 3]
3 : Int
`````

Quit the REPL session by pressing `Ctrl + D`.

## Debug Tool

Elm's Debug tool provides assistance in tracing application data flow and logging variables and expressions to the debugging console.

```elm
import Debug

update : Msg -> Model -> Model
update msg model =
    let
        _ = Debug.log "A debug message" model
    in
    model
```

You can also implement placeholders in your program using `Debug.todo`. This function allows you to concentrate initially on the core application logic and handle the specific edge cases later.

When the program execution reaches a `Debug.todo`, it will deliberately trigger a runtime error. `Debug.todo` should only be used during development and should not exist in your production code.

```elm
import Debug

update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1
        _ ->
            Debug.todo "Handle other messages later"
```

Elm facilitates time-travel debugging, allowing you to trace any execution by rewinding and reviewing the application's state through its previous stages. This feature can be enabled using the `--debug` flag.

```bash
$ elm make src/Main.elm --debug
```

When using the `--optimize` flag for your production code, any Debug call will make your deployment fail.

For a more detailed exploration, have a look at the official [Debug](https://package.elm-lang.org/packages/elm/core/latest/Debug) documentation.

## Core Language Features

Elm's core features include:

- Functional programming
- Statically-typed
- Friendly compiler
- No runtime exceptions
- Managed effects
- Immutable data
- Type inference

For more details, read the [Elm guide's introduction](https://guide.elm-lang.org/introduction/).

## Next steps

Elm has an active package ecosystem. You can find libraries for everything from parsing JSON to handling drag-and-drop in the [Elm package catalog](https://package.elm-lang.org/). It's worth exploring once you've got the basics down.

[Official next steps](https://guide.elm-lang.org/next_steps.html)

## Learning Materials

Start your Elm journey with these educational resources:

- [Official Elm Guide](https://guide.elm-lang.org/): A comprehensive guide covering the language basics, architecture, and more.
- [Elm Documentation](https://elm-lang.org/docs): The official Elm documentation.
- [Elm Weekly](https://www.elmweekly.nl/): A weekly newsletter that keeps you updated with the latest news and developments in the Elm ecosystem.
- [Elm Radio](https://elm-radio.com/): A podcast where the hosts discuss Elm topics, packages, and techniques.

## Friendly and helpful community around Elm

Connect, ask questions, and learn from fellow Elm users through these community platforms:

- [Incremental Elm Discord](https://discord.gg/Qvjxsmwt): A Discord server where you can interact with other Elm enthusiasts and learn incrementally.
- [Elm Slack](https://elm-lang.org/community/slack): A Slack community for Elm users.
- [Elm Discourse](https://discourse.elm-lang.org/): An active forum for discussions, questions, and community interaction around Elm.
- [Elm Subreddit](https://www.reddit.com/r/elm/): A Reddit community filled with discussions, resources, and news related to Elm.

## Tools and Libraries

Enhance your Elm development experience with these tools and libraries:

- [Elm Package Catalog](https://package.elm-lang.org/): The official package ecosystem for Elm, hosting libraries for various functionalities.
- [Elm Search](https://klaftertief.github.io/elm-search/): A tool for searching the Elm package ecosystem.
- [elm-review](https://package.elm-lang.org/packages/jfmengels/elm-review/latest/): A package for enforcing best practices and avoiding common pitfalls in Elm programming.
- [elm-ui](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest) and [Elm Designer](https://github.com/passiomatic/elm-designer): Tools for building user interfaces in a declarative and design-friendly way.
- [elm-graphql](https://github.com/dillonkearns/elm-graphql): A library for interacting with GraphQL APIs in a type-safe and composable manner.
- [Elm Time](https://github.com/elm-time/elm-time): An open-source, cross-platform runtime environment for Elm.
- [elm-live](https://github.com/wking-io/elm-live): A development server for Elm with hot-reloading capabilities.

## Real-world Elm Applications and Platforms

Discover what you can build with Elm by exploring these real-world applications and platforms:

- [Lamdera](https://lamdera.com/): A platform blending Elm with serverless backends, offering a seamless full-stack development experience.
- [Meetdown.app](https://meetdown.app/): An open-source and forever free alternative to Meetup built with Lamdera.
- [Elm Pages](https://elm-pages.com/): A static site generator built with Elm, allowing you to create reliable and fast web pages.

Happy coding with Elm!
