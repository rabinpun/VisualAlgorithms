//
//  ContentView.swift
//  VisualAlgorithms
//
//  Created by ebpearls on 05/02/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List{
                NavigationLink(destination: InsertionSort()) {
                    Text("Insertion Sort")
                }
                NavigationLink(destination: QuickSort()) {
                    Text("Quick Sort")
                }
            }
                .padding().navigationTitle(Text("Visual Algorithms"))
                .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
