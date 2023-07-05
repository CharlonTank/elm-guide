### Demo

[Syntax checker - counter](https://ellie-app.com/nh2vgCwLfgda1)

### Exercice 1 - Improve the counter

- Open this link: [Basic counter](https://ellie-app.com/ng6kbB5Lj8Ha1)

- Goal 1: Add a reset button.

  - Add a new message `Reset` and try to compile the code.

- Goal 2: Add 2 buttons, one to multiply by 2 and one to multiply by 3.
  - Messages can have parameters. For example, you can define a message like this: `MultiplyBy Int` and then use it like this `MultiplyBy 2` or `MultiplyBy 3`.

[Correction Code Exercice 1](https://ellie-app.com/ngThm7hxFJ3a1)

### Exercice 2 - Improve a login form

- Open this link: [Login form](https://ellie-app.com/ngWWyTVQzLra1)

- Goal 1: Add a password length check.

  - Update the `viewValidation` function to add a check ensuring that the password is longer than 8 characters.

- Goal 2: Add checks for character variety in password.
  - Add checks to ensure the password contains uppercase, lowercase, and numeric characters. You should check [String](https://package.elm-lang.org/packages/elm/core/latest/String) package for useful functions.

[Correction Code Exercice 2](https://ellie-app.com/ngXwfcSpxjBa1)

### Exercice 3 - Improve a random quote generator

- Open this link: [Random quote generator](https://ellie-app.com/ngXJRskMkxna1)

- Goal: When fetching a new quote, fetch a cat image from [The Cat API](https://api.thecatapi.com/v1/images/search?size%253Dfull) and display it next to the quote.

  - You can use the [Json.Decode.at](https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#at) function to extract the image url from the response.

[Correction Code Exercice 3](https://ellie-app.com/nh2pqvrZFN9a1)

<!-- # Wanna go farther and be a elm master?

1. Exercice 1 - Elite Version - Improve the counter

# [Go here](https://ellie-app.com/ng6kbB5Lj8Ha1)

The original Elm code creates a simple application with a counter, where the user can increase or decrease the count. The updated version is more complex and involves handling multiple counters, each with a step size and a history of values. Additionally, the updated version allows counters to be reset and undone.

Let's break this down into a series of tasks:

## Task 1: Define the Counter Type

The first task involves defining a new type `Counter` that will represent each individual counter in the app. This includes the count, the step size, the history, and the last message.

## Task 2: Define the Model Type

The Model, which was previously a single Counter, is now a List of Counters. Redefine the Model to reflect this change.

## Task 3: Initialize the Model

Change the `init` function to initialize the Model as a List with one Counter.

## Task 4: Define the Messages

The Messages have been expanded to include more types of actions. Modify the Msg type to reflect these changes. The new Messages include `Plus1`, `Minus1`, `Reset`, `SetStep`, `Undo`, and `NewCounter`, each with an associated `id`.

## Task 5: Implement the Update Function

The `update` function is now much more complex. It now needs to update specific Counters in the Model based on their `id` and handle new types of Messages. It should update the Counter's count, step size, history, and last message as appropriate for each type of Message.

## Task 6: Implement the View Function

The `view` function should be updated to render a List of Counters. Each Counter should display its count, step size, and history. The Counter should also have buttons for each action that can be performed on it: increase, decrease, reset, undo, and change step size.

## Task 7: Display the Last Message

Create a new function, `displayLastMsg`, to handle the display of the last message for each counter based on the `maybeMsg` parameter.

## Task 8: Implement the Main Function

Finally, update the `main` function to use the new `init`, `update`, and `view` functions in the `Browser.sandbox` call.

## Reflection:

After each task, the team should take some time to discuss and understand what was done, why it was done, and how it contributes to the overall project. This will help team members to solidify their understanding of the Elm language, its architectural pattern, and the logic of the application.

[Complete Code Exercise 1 - Elite Version](https://ellie-app.com/ngRPgspLC4Ca1)
-->

# More

1. [Official guide:](https://guide.elm-lang.org/)

'Elm is a delightful language for reliable webapps. Generate JavaScript with great performance and no runtime exceptions.'
