import AppKit
import Splash

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationWillFinishLaunching(_ notification: Notification) {
        let contentViewController = RootViewController()
        let window = NSWindow(contentViewController: contentViewController)
        window.setContentSize(NSSize(width: 800, height: 600))
        let wc = NSWindowController(window: window)
        wc.contentViewController = contentViewController
        window.setFrameAutosaveName("windowFrame")
        window.makeKeyAndOrderFront(nil)
    }
}

extension NSTextView {
    func configureAndWrapInScrollView(isEditable editable: Bool, inset: CGSize) -> NSScrollView {
        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        
        isEditable = editable
        textContainerInset = inset
        autoresizingMask = [.width]
        isAutomaticQuoteSubstitutionEnabled = false
        isAutomaticDashSubstitutionEnabled = false
        scrollView.documentView = self
        return scrollView
    }
}

class RootViewController: NSViewController {
    let editor = MyTextView()
    override func loadView() {
        let editorSV = editor.configureAndWrapInScrollView(isEditable: true, inset: CGSize(width: 30, height: 10))
        editor.allowsUndo = true
        self.view = editorSV
    }
}

class MyTextView: NSTextView {
    private let commandKey = NSEvent.ModifierFlags.command.rawValue
    
    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        if event.type == NSEvent.EventType.keyDown {
            if (event.modifierFlags.rawValue & NSEvent.ModifierFlags.deviceIndependentFlagsMask.rawValue) == commandKey {
                switch event.charactersIgnoringModifiers! {
                case "x":
                    if NSApp.sendAction(#selector(NSText.cut(_:)), to:nil, from:self) { return true }
                case "c":
                    if NSApp.sendAction(#selector(NSText.copy(_:)), to:nil, from:self) { return true }
                case "v":
                    if NSApp.sendAction(#selector(NSText.paste(_:)), to:nil, from:self) { return true }
                case "z":
                    if NSApp.sendAction(Selector(("undo:")), to:nil, from:self) { return true }
                case "a":
                    if NSApp.sendAction(#selector(NSResponder.selectAll(_:)), to:nil, from:self) { return true }
                default:
                    break
                }
            }
        }
        return super.performKeyEquivalent(with: event)
    }
    
    override func didChangeText() {
        let font = Font(path: "~/Desktop/Andale Mono.ttf", size: 15)
        let theme = Theme.sundellsColors(withFont: font)
        let highlighter = SyntaxHighlighter(format: AttributedStringOutputFormat(theme: theme))
        let string = self.textStorage?.string
        let content = highlighter.highlight(string!)
        let cursor = self.selectedRanges.first?.rangeValue.location
        self.textStorage?.setAttributedString(content)
        self.setSelectedRange(NSRange(location: cursor!, length: 0))
    }
}

func application(delegate: NSApplicationDelegate) -> NSApplication {
    // Inspired by https://www.cocoawithlove.com/2010/09/minimalist-cocoa-programming.html
    let app = NSApplication.shared
    app.delegate = delegate
    return app
}

let delegate = AppDelegate()
let app = application(delegate: delegate)
app.run()
