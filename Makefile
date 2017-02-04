all:
	elm-make App.elm --output index.html

get-deps:
	elm package install
