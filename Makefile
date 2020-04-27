default: build open

build:
	swiftc -o "example.app/Contents/MacOS/main" Sources/*.swift main.swift -g

open:
	example.app/Contents/MacOS/main -NSDocumentRevisionsDebugMode YES

clean:
	rm -rf example.app/Contents/MacOS/main*

test: test_build test_open	

# -F : frameworks for compiling
# -xlinker rpath : set runpath for dynamic linking
test_build:
	swiftc \
	-F/Applications/Xcode.app/Contents/SharedFrameworks \
	-F/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/Library/Frameworks \
	-Xlinker -rpath -Xlinker /Applications/Xcode.app/Contents/SharedFrameworks \
	-Xlinker -rpath -Xlinker /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/Library/Frameworks \
	-sdk /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk \
	-target x86_64-apple-macos10.15 \
	-o "example.app/Contents/Plugins/exampletests.xctest/Contents/MacOS/main" \
	Tests/*.swift Sources/*.swift
	
test_open:
	./example.app/Contents/Plugins/exampletests.xctest/Contents/MacOS/main

