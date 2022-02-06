//
//  InsertionSort.swift
//  VisualAlgorithms
//
//  Created by ebpearls on 05/02/2022.
//

import SwiftUI

struct InsertionSort: View {
    
    @State var unsortedArray = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    
    let result = Result()
    
    @State var canSort = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Group {
                        ForEach(unsortedArray) { x in
                            Text("\(x)").animation(.easeInOut, value: unsortedArray)
                        }
                }
                }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                
                ZStack {
                    
                    Rectangle()
                        .foregroundColor(canSort ? Color.green : Color.black)
                        .frame(width: 100, height: 40, alignment: .center)
                        .cornerRadius(10)
                    
                    Button(canSort ? "Sort" : "Scramble") {
                        guard !result.isSorting else { return }
                        if canSort {
                            result.isSorting.toggle()
                            applyInsertionSort(unsortedArray)
                        } else {
                            unsortedArray.shuffle()
                        }
                        canSort.toggle()
                    }.foregroundColor(Color.white)
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                Text("""
                 func insertionSort(_ array: [Int]) -> [Int] {
                     var sortedArray = array
                     for index in 1..<sortedArray.count {
                         var currentIndex = index
                         while currentIndex > 0 && sortedArray[currentIndex] < sortedArray[currentIndex - 1] {
                             sortedArray.swapAt(currentIndex - 1, currentIndex)
                             currentIndex -= 1
                         }
                     }
                     return sortedArray
                 }
                """)
                    .foregroundColor(Color.green)
                    .font(Font.caption)
                
                Spacer()
            }.navigationTitle("Insertion Sort")
        }
    }
    
    func applyInsertionSort( _ array: [Int]){
        var sortedArray = array
        //start swapping from 1 index as we are comparing and swaping elements with their left adjacent element
        for index in 1..<array.count {
             var currentIndex = index
            while currentIndex > 0 && sortedArray[currentIndex] < sortedArray[currentIndex - 1] {
                
                sortedArray.swapAt(currentIndex, currentIndex - 1)
                currentIndex -= 1//changing
                result.arrays.append(sortedArray)
            }
        }
        
        result.arrays.enumerated().forEach { index, array in
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.5) {
                unsortedArray = array
                if array == result.arrays.last {
                    result.isSorting.toggle()
                }
            }
        }

    }
}

struct InsertionSort_Previews: PreviewProvider {
    static var previews: some View {
        InsertionSort()
    }
}

extension Int: Identifiable {
    public var id: String {
        String(self)
    }
}

class Result {
    var arrays = [[Int]]()
    var isSorting = false
}
