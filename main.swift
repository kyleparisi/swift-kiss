// reference: https://github.com/lapcat/NiblessMenu

import AppKit

// Apparently these aren't declared anywhere
@objc protocol EditMenuActions {
    func redo(_ sender:AnyObject)
    func undo(_ sender:AnyObject)
}

class AppDelegate: NSObject, NSApplicationDelegate {

    lazy var window = NSWindow(contentRect: NSMakeRect(100, 100, 200, 200),
                styleMask: .titled, backing: .buffered, defer: false, screen: nil)
    lazy var applicationName:String = {
        if let bundleName = Bundle.main.object(forInfoDictionaryKey:"CFBundleName") {
            if let bundleNameAsString = bundleName as? String {
                return bundleNameAsString
            }
            else {
                print("CFBundleName not a String!")
            }
        }
        else {
            print("CFBundleName nil!")
        }
        
        return NSLocalizedString("NiblessMenu", comment:"The name of this application")
    }()

    func applicationDidFinishLaunching(_ notification: Notification) {
        let button = NSButton(frame: NSMakeRect(20, 20, 100, 32))
        button.title = "Click Me"
        button.target = self
        button.action = #selector(onClick)
        window.contentView?.addSubview(button)
        window.makeKeyAndOrderFront(nil)

        populateMainMenu()
    }

    @IBAction func onClick(_: Any) {
        NSSound.beep()
        NSLog("Clicked")
    }

    func populateMainMenu() {
        let mainMenu = NSMenu(title:"MainMenu")
        
        // The titles of the menu items are for identification purposes only and shouldn't be localized.
        // The strings in the menu bar come from the submenu titles,
        // except for the application menu, whose title is ignored at runtime.
        var menuItem = mainMenu.addItem(withTitle:"Application", action:nil, keyEquivalent:"")
        var submenu = NSMenu(title:"Application")
        populateApplicationMenu(submenu)
        mainMenu.setSubmenu(submenu, for:menuItem)
        
        menuItem = mainMenu.addItem(withTitle:"File", action:nil, keyEquivalent:"")
        submenu = NSMenu(title:NSLocalizedString("File", comment:"File menu"))
        populateFileMenu(submenu)
        mainMenu.setSubmenu(submenu, for:menuItem)

        // NSApplication will make a copy of your menu,
        // so if you need to access the mainMenu after this point,
        // your current menu reference won't work anymore,
        // and you need to get a new reference from NSApp.mainMenu
        NSApp.mainMenu = mainMenu
    }
    
    func populateApplicationMenu(_ menu:NSMenu) {
        var title = NSLocalizedString("About", comment:"About menu item") + " " + applicationName
        var menuItem = menu.addItem(withTitle:title, action:#selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent:"")
        menuItem.target = NSApp
        
        menu.addItem(NSMenuItem.separator())
        
        title = NSLocalizedString("Services", comment:"Services menu item")
        menuItem = menu.addItem(withTitle:title, action:nil, keyEquivalent:"")
        let servicesMenu = NSMenu(title:"Services")
        menu.setSubmenu(servicesMenu, for:menuItem)
        NSApp.servicesMenu = servicesMenu
        
        menu.addItem(NSMenuItem.separator())
        
        title = NSLocalizedString("Hide", comment:"Hide menu item") + " " + applicationName
        menuItem = menu.addItem(withTitle:title, action:#selector(NSApplication.hide(_:)), keyEquivalent:"h")
        menuItem.target = NSApp
        
        title = NSLocalizedString("Hide Others", comment:"Hide Others menu item")
        menuItem = menu.addItem(withTitle:title, action:#selector(NSApplication.hideOtherApplications(_:)), keyEquivalent:"h")
        menuItem.keyEquivalentModifierMask = [.command, .option]
        menuItem.target = NSApp
        
        title = NSLocalizedString("Show All", comment:"Show All menu item")
        menuItem = menu.addItem(withTitle:title, action:#selector(NSApplication.unhideAllApplications(_:)), keyEquivalent:"")
        menuItem.target = NSApp
        
        menu.addItem(NSMenuItem.separator())
        
        title = NSLocalizedString("Quit", comment:"Quit menu item") + " " + applicationName
        menuItem = menu.addItem(withTitle:title, action:#selector(NSApplication.terminate(_:)), keyEquivalent:"q")
        menuItem.target = NSApp
    }
    
    func populateFileMenu(_ menu:NSMenu) {
        let title = NSLocalizedString("Close Window", comment:"Close Window menu item")
        menu.addItem(withTitle:title, action:#selector(NSWindow.close), keyEquivalent:"w")
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
