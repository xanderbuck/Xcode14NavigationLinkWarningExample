//
//  ContentView.swift
//  Xcode14NavigationLinkWarningExample
//
//  Created by Alex Buck on 9/15/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var isViewPushed = false
    
    var body: some View {
        //we have to support Navigation View for now since we support iOS 14 & 15 still
        NavigationView {
            VStack {
                Text("View A")
                Button(action: { isViewPushed = true } ) {
                    Text("Push To View B")
                }
            }
            .background(
                //we're using initializer of Navigation link since we still support iOS 14 & 15 still
                NavigationLink(destination: AnyView(ViewB()), isActive: $isViewPushed) {
                    EmptyView()
                }
            )
        }
        //commenting out this line fixes the issue, but I need to explicitly use StackNavigationViewStyle in my production app to fix a bug
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ViewB: View {
    
    @State var isViewPushed = false
    
    var body: some View {
        VStack(spacing: 40) {
            Text("View B")
            
            VStack {
                Text("Pressing the Back Button on this view will print out the following warning:")
                
                Text("NavigationLink presenting a value must appear inside a NavigationContent-based NavigationView. Link will be disabled.")
                    .foregroundColor(.red)
            }
            .multilineTextAlignment(.center)
            
            Button(action: { isViewPushed = true } ) {
                Text("Push To View C")
            }
        }
        .background(
            NavigationLink(destination: AnyView(ViewC()), isActive: $isViewPushed) {
                EmptyView()
            }
        )
    }
}

struct ViewC: View {
    
    var body: some View {
        Text("View C")
    }
    
}

