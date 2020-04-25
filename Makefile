default: build open

build:
	swiftc -o example.app/Contents/MacOS/main main.swift

open:
	open example.app

clean:
	rm example.app/Contents/MacOS/main

