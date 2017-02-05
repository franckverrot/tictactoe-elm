module Player exposing ( Player(A, B, Unclaimed)
                       , show
                       )

type Player = A
            | B
            | Unclaimed

show : Player -> String
show player = case player of
                      A -> "A"
                      B -> "B"
                      Unclaimed -> "?"
