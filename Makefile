all:
	elm-make Main.elm Model.elm Player.elm --output index.html

get-deps:
	elm package install
