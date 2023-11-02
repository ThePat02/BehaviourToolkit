extends MiniMax


## Returns true, if the game is over
func is_game_over(_state: Resource) -> bool:
    return false


## Evaluates the state
func evaluate(_state: Resource) -> float:
    return 0.0


## Returns all possible moves
func possible_moves(_state: Resource) -> Array:
    return []


## Applies the move to the state
func make_move(_state: Resource, _move):
    return


# Example usage for finding the best move
# var best_score = -INF
# for move in possible_moves(initial_state):
#     new_state = state.duplicate()
#     score = minimax(new_state, 3, False)
#     if score > best_score:
#         best_score = score
#         best_move = move
