//
//  SwiftUIView.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 11.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import SwiftUI

import SwiftUI

func showWindow() {
    var windowRef:NSWindow
    windowRef = NSWindow(
        contentRect: NSRect(x: 0, y: 0, width: 100, height: 100),
        styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
        backing: .buffered, defer: false)
    windowRef.contentView = NSHostingView(rootView: MyView(myWindow: windowRef))
    windowRef.makeKeyAndOrderFront(nil)
}

struct MyView: View {
    let myWindow:NSWindow?
    var body: some View {
        VStack{
            Text("This is in a separate window.")
            HStack{
                Button(action:{
                    showWindow()
                }) {
                    Text("Open another window")
                }
                Button(action:{
                    self.myWindow!.close()
                }) {
                    Text("Close this window")
                }
            }
        }
    .padding()
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MyView(myWindow: nil)
    }
}
