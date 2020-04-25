import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {

    lazy var window = NSWindow(contentRect: NSMakeRect(100, 100, 200, 200),
                styleMask: .titled, backing: .buffered, defer: false, screen: nil)

    func applicationDidFinishLaunching(_ notification: Notification) {
        let button = NSButton(frame: NSMakeRect(20, 20, 100, 32))
        button.title = "Click Me"
        button.target = self
        button.action = #selector(onClick)
        window.contentView?.addSubview(button)
        window.makeKeyAndOrderFront(nil)
    }

    @IBAction func onClick(_: Any) {
        NSSound.beep()
        NSLog("Clicked")
    }

}


autoreleasepool {
	let delegate = AppDelegate()
	// NSApplication delegate is a weak reference,
	// so we have to make sure it's not deallocated.
	// In Objective-C you would use NS_VALID_UNTIL_END_OF_SCOPE
	withExtendedLifetime(delegate, {
		let application = NSApplication.shared
		application.delegate = delegate
		application.run()
		application.delegate = nil
	})
}