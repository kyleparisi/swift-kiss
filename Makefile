default: build open

build:
	swiftc -o "example.app/Contents/MacOS/main" Sources/*.swift main.swift -g
	
# -F : frameworks for compiling
# -xlinker rpath : set runpath for dynamic linking
test_build:
	ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES=yes swiftc \
	-F/Applications/Xcode.app/Contents/SharedFrameworks \
	-F/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/Library/Frameworks \
	-Xlinker -rpath -Xlinker /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/Library/Frameworks \
	-Xlinker -rpath -Xlinker /Applications/Xcode.app/Contents/SharedFrameworks \
	-sdk /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk \
	-target x86_64-apple-macos10.15 \
	Tests/*.swift Sources/*.swift

open:
	example.app/Contents/MacOS/main -NSDocumentRevisionsDebugMode YES

clean:
	rm -rf example.app/Contents/MacOS/main*

