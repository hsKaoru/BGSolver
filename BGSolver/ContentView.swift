//
//  ContentView.swift
//  SwiftUItTest
//
//  Created by Igor Podolskiy on 11.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                UnitCell()
                UnitCell()
                UnitCell()
                UnitCell()
                UnitCell()
                UnitCell()
                UnitCell()
            }
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Start battle")
                }
                ResultTextView()
            }
            HStack {
                UnitCell()
                UnitCell()
                UnitCell()
                UnitCell()
                UnitCell()
                UnitCell()
                UnitCell()
            }
        }
    }
}

struct ResultTextView: View {
    var result: String?
    var body: some View {
        Text(textForResult(text: result))
    }

    func textForResult(text: String?) -> String {
        if let text = text {
            return text
        }
        return "WIN: " + "0" + "% "
        + "LOSE: " + "0" + "% "
        + "TIE: " + "0" + "%"
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
