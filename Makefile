all: test
	elm-make src/Main.elm --output build/app.js --warn
	elm-css src/css/Stylesheets.elm

get-deps:
	elm package install

test:
	elm-test
