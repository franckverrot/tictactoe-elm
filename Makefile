all:
	elm-make src/Main.elm --output build/app.js --warn

get-deps:
	elm package install
