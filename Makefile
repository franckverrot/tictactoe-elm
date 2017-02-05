all:
	elm-make src/Main.elm --output index.html

get-deps:
	elm package install
