//
//  ContentView.swift
//  Shared
//
//  Created by CHEN GUAN-JHEN on 2022/1/9.
//

import SwiftUI

struct ContentView: View {
    @State var dataSource = Array(0...100)
    let title: String
    @State var isFlip = false
    var body: some View {
        VStack  {
            Button(action: { 
                withAnimation {
                    isFlip.toggle()
                }
            }) {
                Text("Button")
            }
            List(dataSource, id: \.self) { data in
                VStack {
                    
                    NavigationLink("\(data)") {
                        ContentView(dataSource: dataSource, title: "\(data)")
                    }
                    if isFlip {
                        Text("Open")
                    }
                }
                
            }
        }.navigationTitle(title)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(title: "Root")
    }
}
