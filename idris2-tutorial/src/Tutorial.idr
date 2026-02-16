module Tutorial

------------------------------------------------
-- File to demo lsp functionality for idris2-lsp
------------------------------------------------

HelloWorld = "Hello World"

-- 1. Getting our bearings : Highlighting, List available symbols, Symbol information, Goto definitions, Hover

{-
 'symbols' generally language entities like variables, constants, functions, etc.
 below are a couple of sample symbol definitions. 
-}

demoTrivialFunction : Nat -> Nat
demoTrivialFunction x = x

{-
 When you hover over a symbol, all instances of that symbol should become highlighted
 
 Additionally, you get a bunch of other information when you hover, you also get:
     - the fully qualified name of the symbol (ie: the name including the full module path)
     - if part of a function, you get the qualified name of the arguments and return types
     - available code actions
-}

demoNestedFunction : List Nat -> Nat -> Nat
demoNestedFunction [] acc = acc
demoNestedFunction (a::rest) acc = (demoNestedFunction rest (acc + a) )

{-

TODO this does not seem to be supported currently by Idris2 LSP

On top of being able to see information about symbols, lets also see how we can drill in / navigate by jumping to definitions

Below is a function that depends on 'demoTrivialFunction' above. In the function definition, hover over this and 

--- code start ---

doubleIt : Nat -> Nat
doubleIt x = (demoTrivialFunction (2 * x))

-- code end ---

-}

-- 2. List available symbols (vars, metavars, implicits, types, holes, etc.)

{-
What if we want to show available symbols outside of autocomplete? We can use C-M-i to pull up completion at point.

This should open a drawer with all available symbols in scope

This should be explained in the opened drawer, but you can use M-<up|down> to move between completions, and then M-<enter> to select

After selecting a completion, use M-<delete> to delete

-}

--- Try completion at point below: --



--- Here^ ---

-- 3. Diagnostics : understanding problems

{-
As we edit the code a few things will happen:
- autocompleting will kick in (simple dictionary word autocompletions will be prefixed with 'w')
- errors will be highlighted with '!!'
  - these will also show up in the modeline at the project level

Try to perform a QuickFix on the function below with the following steps:
1. Uncomment the below erroneous code
2. C-c l to start the prefix. 'which-key' should automatically populate potential options
3. select 'a' for code action. wait for further prompts to see next round of recommendations from which key
4. select 'a' again. At this point you should see "Select code action: ..."
5. hit <Tab> to see available code actions. This should include QuickFixes
6. continue to type and Tab to complete until the full code action is selected
7. hit enter for this to take effect
8. C-x C-s to save and refresh

-- erroneous code
functionToFix : Nat -> Nat
functionToFix a = a

-}

-- 2a. opening diagnostic window

{-

Uncomment the below to expose a few instances of erroneous code


wrongNumberOfArgs : Nat -> Nat -> Nat
wrongNumberOfArgs x = x

unrecognizedFunction : Nat -> Nat
unrecognizedFunction x = nonExistent x

incorrectType : Nat 
incorrectType = "test"

-}

{-

We can use the treemacs error list to see all available errors. Do the following to open that:

1. C-c l T e (can pause and get assistance from which-key here too)
2. Use <Tab> to expand the error tree and see all errors
3. Use arrow keys to navigate to different errors (each entry should have a description of the problem)
4. Hit <Enter> to jump to the location of the error

We can also use 'C-x o' to jump out of the diagnostic buffer back to the initial cursor position

When you are ready to close the diagnostics, simply hit 'q' from inside that buffer, or C-x 0

-}

-- 2b. Repl to tinker

{-

TODO confirm this

If you have Idris2 installed, then you can use M-x idris2-repl to open a repl to test ad-hoc expressions

-}

{- 3. Authoring Idris2 programs

Now we have general IDE business under our belt, let's try out some of the features specific to Idris2!

-}

{- 3a. Case splitting

Where a type has a known set of values, case splitting allows us to quickly create definitions for each potential value

'Directions' defined below is an example of this

This is modeled as a code action so in the below try to:
1. hover over the partial function definition (ie: not defined over all inputs)
2. go to code actions with C-l a a (similar to before)
3. Use <Tab> to see options
4. Select 'QuickFix: Add missing cases' by typing out to the sole completion and hitting <Enter>

You may see 'Add clause' as another potential code action here. This one is helpful but a little different: instead of creating a case with a concrete value, it will create a case that handles open-ended values (if you give it a go, then you'll see it introduces an argument instead of pattern matching to one of the specific Direction values)

==== uncomment the below code ===

data Directions = Left | Right | Up | Down

stringifyLeftOrRight : Directions -> String
stringifyLeftOrRight Left = "left"

-}

{-
This also works for infinite types like Nat or List!

As per the docs here: https://idris2.readthedocs.io/en/latest/tutorial/typesfuns.html#data-types

These types are inifinite as they are defined recursively. Specifically part of its value definition includes an argument of the type itself

Let's try to add a clause for such a type - repeat the above, but for 'isItThree' below (will need to uncomment the partial function definition

=== uncomment the below code ===

isItThree : Nat -> Bool
isItThree (S (S (S Z))) = True


-}

{- 3b. Refining holes

Holes are part of Idris2's 'partial programs' feature (docs : https://idris2.readthedocs.io/en/latest/tutorial/typesfuns.html#holes)

Effectively these are substitutable for values or expressions and hold the type needed to satisfy the expression definition

This feature is nice because it allows us to put placeholders to fill in / complete later on. The act of replacing a hole with an actual value or expression is called 'refining'

  -}

-- 3c. Expression searching


