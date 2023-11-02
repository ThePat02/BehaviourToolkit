class_name MiniMax extends Algorithm
## A simple implementation of the MiniMax algorithm


func minimax(state: Resource, depth: int, maximizingPlayer: bool) -> float:
    if depth == 0 or is_game_over(state):
        return evaluate(state)
    
    if maximizingPlayer:
        var max_eval: float = -INF

        for move in possible_moves(state):
            var new_state = state.duplicate()
            make_move(new_state, move)
            var evaluation = minimax(new_state, depth - 1, false)
            
            max_eval = maxf(max_eval, evaluation)
        
        return max_eval
    
    if not maximizingPlayer:
        var min_eval: float = INF

        for move in possible_moves(state):
            var new_state = state.duplicate()
            make_move(new_state, move)
            var evaluation = minimax(new_state, depth - 1, true)
            
            min_eval = minf(min_eval, evaluation)
        
        return min_eval

    return 0


## Returns true, if the game is over
func is_game_over(state: Resource) -> bool:
    return false


## Evaluates the state
func evaluate(state: Resource) -> float:
    return 0.0


## Returns all possible moves
func possible_moves(state: Resource) -> Array:
    return []


## Applies the move to the state
func make_move(state: Resource, move):
    return
