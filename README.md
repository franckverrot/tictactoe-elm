# Tic Tac Toe in Elm

Demo URL: http://franck.verrot.fr/tictactoe-elm/

## Notes

(from the initial commit [023baa8](https://github.com/franckverrot/tictactoe-elm/commit/023baa8dcf95aba3399a8d3fae8adb4b9636b654))

```
The most interesting part was to find how to emit a custom command by
piggybacking it on `Time.now`.

There are three events in this app:

1. `Reset`
  Resets the game to its initial state
2. `Clicked index`
  Claim a box for a specific user, triggers `CheckWinner` when it's done
3. `CheckWinner player currentPlayerShouldChange time`
  Checks for stalemate or a winner
```
