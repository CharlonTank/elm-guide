## Welcome Everyone ❤️

### Mob Programming - Elm

From now on, we will use [Ellie](https://ellie-app.com/) to write Elm code.

[Syntax checker - counter](https://ellie-app.com/nh2vgCwLfgda1)

You can open the [cheatsheet](https://github.com/CharlonTank/elm-guide/blob/main/CheatSheet.md) I created but I advise you to also open the official documentation: [Elm documentation](https://guide.elm-lang.org/). There is also a [French Version of the official Doc](https://guide.elm-france.fr/) and a [French version of my cheatsheet](https://github.com/CharlonTank/elm-guide/blob/main/CheatSheet%20-%20Fran%C3%A7ais.md)

### Exercice 1 - Improve the counter

- Open this link: [Basic counter](https://ellie-app.com/ng6kbB5Lj8Ha1)

- Goal 1: Add a reset button.

  - Add a new message `Reset` and try to compile the code.
    - ```elm
        type Msg
            = Increment
            | Decrement
            | Reset
      ```
  - You will see that the compiler is complaining because the `update` function is not handling the new message.
  - Add a new case to the `update` function to handle the `Reset` message.
  - Add a new button to the `view` function to trigger the `Reset` message.

- Goal 2: Add 2 buttons, one to multiply by 2 and one to multiply by 3.

  - Add a new message `MultiplyBy Int` and try to compile the code.
  - You will see that the compiler is complaining because the `update` function is not handling the new message.
  - Add a new case to the `update` function to handle the `MultiplyBy` message.
    - Hint: `MultiplyBy nb -> ...` will match the message and bind the `nb` variable to the value passed to the message.
  - Add 2 new buttons to the `view` function to trigger the `MultiplyBy` message.

[Correction Code Exercice 1](https://ellie-app.com/ngThm7hxFJ3a1)

### Exercice 2 - Improve a login form

- Open this link: [Login form](https://ellie-app.com/ngWWyTVQzLra1)

- Goal 1: Add a password length check.

  - Update the `viewValidation` function to add a check ensuring that the password is longer than 8 characters.
  - You can use the [String.length](https://package.elm-lang.org/packages/elm/core/latest/String#length) function to get the length of a string.
  - ```elm
      if String.length "hello" == 42 then
        "The answer to life, the universe, and everything"
      else
        "Something else"
    ```

- Goal 2: Add checks for character variety in password.
  - Add checks to ensure the password contains uppercase, lowercase, and numeric characters.
  - You should check [String](https://package.elm-lang.org/packages/elm/core/latest/String) package for useful functions
  - This one will be useful: [String.any](https://package.elm-lang.org/packages/elm/core/latest/String#any) in combination with [Char.isUpper](https://package.elm-lang.org/packages/elm/core/latest/Char#isUpper), [Char.isLower](https://package.elm-lang.org/packages/elm/core/latest/Char#isLower), and [Char.isDigit](https://package.elm-lang.org/packages/elm/core/latest/Char#isDigit).
  - ```elm
      String.any Char.isUpper "hello" == False
      String.any Char.isLower "hello" == True
      String.any Char.isDigit "hello" == False
    ```

[Correction Code Exercice 2](https://ellie-app.com/ngXwfcSpxjBa1)

### Exercice 3 - Improve a random quote generator

- Open this link: [Random quote generator](https://ellie-app.com/nhnmj9M7LDRa1)

- Goal: When fetching a new quote, fetch a cat image from [The Cat API](https://api.thecatapi.com/v1/images/search?size%253Dfull) and display it next to the quote.

  - Add a new field to the `Model` to store the image url

    - ```elm
        type alias Model =
            { quote : WebData Quote
            , catImageUrl : WebData String
            }
      ```
    - Now try to compile the code. You will see that the compiler is complaining because the `init` function is not handling the new field:

    ```bash
        Line 21, Column 5
    Something is off with the body of the `init` definition:

    21|>    ( { quote = NotAsked }
    22|>    , getRandomQuote
    23|>    )

    The body is a tuple of type:

        ( { quote : RemoteData e a }, Cmd Msg )

    But the type annotation on `init` says it should be:

        ( Model, Cmd Msg )

    Hint: Looks like the catImageUrl field is missing.
    ```

    - Inspire yourself from the `quote` field to initialize the `catImageUrl` field.

    - If you want only one button to fetch the quote and the image, you can use the [Cmd.batch](https://package.elm-lang.org/packages/elm/core/latest/Platform-Cmd#batch) function to combine the 2 commands into one.
      ```elm
          Cmd.batch
              [ getRandomQuote
              , getRandomCatImage
              ]
      ```
    - You can use the [Json.Decode.at](https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#at) function to extract the image url from the response: `(Decode.at [ "0", "url" ] Decode.string)` since the only field we are interested in is the `url` field of the first element of the array.

    - To display the image, you can use the [img](https://package.elm-lang.org/packages/elm/html/latest/Html#img) function from the [Html](https://package.elm-lang.org/packages/elm/html/latest/Html) package in combination with the [src](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#src) attribute
      ```elm
          img [ src "https://www.example.com/cat.jpg" ] []
      ```

[Correction Code Exercice 3](https://ellie-app.com/nhNrkYFzmY2a1)

### I hope you enjoyed this workshop! Don't hesitate to reach out to me if you have any questions!

### Love you all!

## Still have time?

### Check how to play ones again outside of the sandbox with [Time](https://guide.elm-lang.org/effects/time.html) using subscriptions

### Exercice 1 - Elite Version - Improve the counter

#### Open this link: [Go here](https://ellie-app.com/ng6kbB5Lj8Ha1)

The original Elm code creates a simple application with a counter, where the user can increase or decrease the count. The updated version is more complex and involves handling multiple counters, each with a step size and a history of values. Additionally, the updated version allows counters to be reset and undone.

Let's break this down into a series of tasks:

#### Task 1: Define the Counter Type

The first task involves defining a new type `Counter` that will represent each individual counter in the app. This includes the count, the step size, the history, and the last message.

#### Task 2: Define the Model Type

The Model, which was previously a single Counter, is now a List of Counters. Redefine the Model to reflect this change.

#### Task 3: Initialize the Model

Change the `init` function to initialize the Model as a List with one Counter.

#### Task 4: Define the Messages

The Messages have been expanded to include more types of actions. Modify the Msg type to reflect these changes. The new Messages include `Plus1`, `Minus1`, `Reset`, `SetStep`, `Undo`, and `NewCounter`, each with an associated `id`.

#### Task 5: Implement the Update Function

The `update` function is now much more complex. It now needs to update specific Counters in the Model based on their `id` and handle new types of Messages. It should update the Counter's count, step size, history, and last message as appropriate for each type of Message.

#### Task 6: Implement the View Function

The `view` function should be updated to render a List of Counters. Each Counter should display its count, step size, and history. The Counter should also have buttons for each action that can be performed on it: increase, decrease, reset, undo, and change step size.

#### Task 7: Display the Last Message

Create a new function, `displayLastMsg`, to handle the display of the last message for each counter based on the `maybeMsg` parameter.

#### Task 8: Implement the Main Function

Finally, update the `main` function to use the new `init`, `update`, and `view` functions in the `Browser.sandbox` call.

#### Reflection:

After each task, the team should take some time to discuss and understand what was done, why it was done, and how it contributes to the overall project. This will help team members to solidify their understanding of the Elm language, its architectural pattern, and the logic of the application.

[Complete Code Exercise 1 - Elite Version](https://ellie-app.com/ngRPgspLC4Ca1)

### More

Elm is a delightful language for reliable webapps. Generate JavaScript with great performance and no runtime exceptions.

[Official guide](https://guide.elm-lang.org/)
