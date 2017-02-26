module Player exposing ( Player(A, B, Unclaimed)
                       , showPlayer
                       )

type Player = A
            | B
            | Unclaimed

showPlayer : Player -> String
showPlayer player = case player of
                A -> "A"
                B -> "B"
                Unclaimed -> "?"
