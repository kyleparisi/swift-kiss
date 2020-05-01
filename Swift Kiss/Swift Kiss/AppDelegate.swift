//
//  AppDelegate.swift
//  Swift Kiss
//
//  Created by Kyle Parisi on 4/28/20.
//  Copyright © 2020 Kyle Parisi. All rights reserved.
//

import Cocoa
import SwiftUI
import Splash

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let font = Font(path: "~/Desktop/Andale Mono.ttf", size: 19)
        let theme = Theme.sundellsColors(withFont: font)
        let highlighter = SyntaxHighlighter(format: AttributedStringOutputFormat(theme: theme))
        let content = highlighter.highlight("func hello() -> String")
        
        let textView = MyTextView(frame: NSRect(x: 100, y: 100, width: 480, height: 300))
        textView.isAutomaticQuoteSubstitutionEnabled = false
        textView.textStorage?.append(content)
        

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView?.addSubview(textView)
        window.makeKeyAndOrderFront(nil)
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

class MyTextView: NSTextView {
    override func didChangeText() {
        let font = Font(path: "~/Desktop/Andale Mono.ttf", size: 19)
        let theme = Theme.sundellsColors(withFont: font)
        let highlighter = SyntaxHighlighter(format: AttributedStringOutputFormat(theme: theme))
        let string = self.textStorage?.string
        let content = highlighter.highlight(string!)
        let cursor = self.selectedRanges.first?.rangeValue.location
        self.textStorage?.setAttributedString(content)
        self.setSelectedRange(NSRange(location: cursor!, length: 0))
    }
}
