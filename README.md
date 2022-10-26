# entitlementChecks

A simple bash script inspired by Cedric Owens [EntitlementCheck](https://github.com/cedowens/EntitlementCheck). Like Cedric Owens script, this script checks for the following entitlements;

 - com.apple.security.cs.disable-library-validation
 - com.apple.security.cs-allow-dyld-environment-variables
 - com.apple.security.get-task-allow
 - com.apple.security.cs.allow-unsigned-executable-memory
 - com.apple.security.files.downlaods.read-only
 - com.apple.security.files.downloads.read-write
 - com.apple.security.files.all
 - com.apple.security.files.user-selected.read-only
 - com.apple.security.files.user-selected.read-write
 - com.apple.private.security.clear-library-validation
 - com.apple.private.tcc.allow

All the heavy lifting is done by [`jtool2`](http://newosxbook.com/tools/jtool.html). If your on Apple Silicone you can install `jtool2` with [this Gist](https://gist.github.com/jthorpe6/9dfbb04df4caf845735daaa475c0986e).

### Example output

```
./check.sh
[*] com.apple.security.cs.disable-library-validation found -> /Applications/Burp Suite Professional.app/Contents/MacOS/JavaApplicationStub can load arbitrary unsigned plugins/frameworks
[*] com.apple.security.cs.allow-unsigned-executable-memory found -> /Applications/Burp Suite Professional.app/Contents/MacOS/JavaApplicationStub allows c code patching
[*] com.apple.security.cs.disable-library-validation found -> /Applications/Emacs.app/Contents/MacOS/Emacs-arm64-11 can load arbitrary unsigned plugins/frameworks
[*] com.apple.security.cs.disable-library-validation found -> /Applications/Emacs.app/Contents/MacOS/Emacs-x86_64-10_11 can load arbitrary unsigned plugins/frameworks
[*] com.apple.security.cs.disable-library-validation found -> /Applications/Emacs.app/Contents/MacOS/Emacs-x86_64-10_14 can load arbitrary unsigned plugins/frameworks
[*] com.apple.security.cs.disable-library-validation found -> /usr/local/bin/ebrowse can load arbitrary unsigned plugins/frameworks
[*] com.apple.security.cs.disable-library-validation found -> /usr/local/bin/emacsclient can load arbitrary unsigned plugins/frameworks
[*] com.apple.security.cs.disable-library-validation found -> /usr/local/bin/etags can load arbitrary unsigned plugins/frameworks
```
