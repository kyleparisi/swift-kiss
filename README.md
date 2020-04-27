# swift-kiss

```bash
make test
```

## Notes

[rpath reference](https://blog.krzyzanowskim.com/2018/12/05/rpath-what/)

[dynamic linking reference](https://medium.com/livefront/how-to-add-a-dynamic-swift-framework-to-a-command-line-tool-bab6426d6c31)

[dynamic libraries](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/DynamicLibraries/100-Articles/OverviewOfDynamicLibraries.html)

`-F` is for the compiler to find the frameworks that are being used.

`-Xlinker -rpath -Xlinker` tells the linker rpath (run path) where fameworks are being used for dynamic linking.  Linking is done via `ld`.

The above options could be removed if we copied all the libraries to the expected location.

If you wanted to know _everything_ that xcode does when you build/test your project, open `Show Report Navigator` above the file tree.

~It would be nice if the output was more human.~  Installing `xcpretty` is good.
