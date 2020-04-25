default: build open

build:
	swiftc -o "example.app/Contents/MacOS/main" *.swift -g

open:
	example.app/Contents/MacOS/main -NSDocumentRevisionsDebugMode YES

clean:
	rm example.app/Contents/MacOS/main

