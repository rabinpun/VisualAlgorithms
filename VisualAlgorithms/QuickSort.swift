//
//  QuickSort.swift
//  VisualAlgorithms
//
//  Created by ebpearls on 06/02/2022.
//

import SwiftUI

struct QuickSort: View {
    @State var unsortedArray = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    
    let result = QuickSortResult()
    
    @State var canSort = false
    
    @State var highlightedElements = [Int]()

    @State var sortedArray = [Int]()
    
    @State var finalArray = [Int]()
    
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
                            applyQuickSort(unsortedArray)
                        } else {
                            unsortedArray.shuffle()
                        }
                        canSort.toggle()
                    }.foregroundColor(Color.white)
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                
                HStack {
                    Group {
                        ForEach(sortedArray) { x in
                            Text("\(x)").animation(.easeInOut, value: sortedArray)
                        }
                }
                }
                
                HStack {
                    Group {
                        ForEach(finalArray) { x in
                            Text("\(x)")
                                .foregroundColor(highlightedElements.contains(x) ? Color.green : Color.black)
                                .animation(.easeInOut, value: finalArray)
                        }
                }
                }
                
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
            }.navigationTitle("Quick Sort")
        }
    }
    
    func applyQuickSort( _ array: [Int]){
        let finalSortedArray = quickSort(array)
        
        finalArray = finalSortedArray
        
        for index in 0..<result.leftarrays.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.5) {
                sortedArray = result.leftarrays[index].array + result.middlearrays[index].array + result.rightarrays[index].array
                if isSorted(array: result.leftarrays[index].array) {
                    highlightedElements.append(contentsOf: result.leftarrays[index].array)
                } else if isSorted(array: result.rightarrays[index].array){
                    highlightedElements.append(contentsOf: result.rightarrays[index].array)
                }
                if result.leftarrays.last!.array == result.leftarrays[index].array {
                    result.isSorting = false
                }
            }
        }

    }
    
    func quickSort(_ array: [Int]) -> [Int] {
        guard array.count > 1 else {
            return array }
        let pivot = array.count / 2
        let smallerArray = array.filter({ $0 < array[pivot] })
        result.leftarrays.append(Container(array: smallerArray))
        let equalArray = array.filter({ $0 == array[pivot] })
        result.middlearrays.append(Container(array: equalArray))
        let greaterArray = array.filter({ $0 > array[pivot] })
        result.rightarrays.append(Container(array: greaterArray))
        return quickSort(smallerArray) + equalArray + quickSort(greaterArray)
    }
}

struct QuickSort_Previews: PreviewProvider {
    static var previews: some View {
        QuickSort()
    }
}

class QuickSortResult {
    var leftarrays = [Container]()
    var rightarrays = [Container]()
    var middlearrays = [Container]()
    var isLeft = true
    var isSorting = false
}

struct Container: Identifiable {
    let id = UUID()
    var array = [Int]()
}

func isSorted<T: Comparable>(array: Array<T>) -> Bool {
    guard array.count > 1 else { return false }
    for i in 1..<array.count {
        if array[i-1] > array[i] {
            return false
        }
    }

    return true
}
