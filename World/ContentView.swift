//
//  ContentView.swift
//  World
//
//  Created by Tim Yoon on 7/24/22.
//

import SwiftUI
protocol Locatable {
    var row : Int { set get }
    var col : Int { set get }
    func moveTo(row: Int, col: Int)
}
extension Locatable {
    mutating func moveTo(row: Int, col: Int){
        let r = abs(row) % Constants.rowMax
        let c = abs(col) % Constants.colMax
        self.row = r
        self.col = c
    }
}

struct MobileEntity : Identifiable{
    var id = UUID()
    var row: Int = 0
    var col: Int = 0
    private (set) var hp = 0
    mutating func setHp(to newhp: Int) {
        hp = newhp
    }
    mutating func moveTo(row: Int, col: Int){
        let r = abs(row) % Constants.rowMax
        let c = abs(col) % Constants.colMax
        self.row = r
        self.col = c
    }
    init(){
        row = 0
        col = 0
    }
}

struct Constants {
    static var rowMax = 9
    static var colMax = 5
}
struct Locus : Identifiable {
    var id = UUID()
    var entities = [MobileEntity]()
}

class WorldVM : ObservableObject {
    var grid : [[Locus]] = Array(repeating: Array(repeating: Locus(), count: Constants.colMax), count: Constants.rowMax)
    init(){
        grid[1][1].entities.append(MobileEntity())
    }
}

struct EntitiesView: View {
    @State private var entities : [MobileEntity]
    var body: some View {
        HStack {
            ForEach(0..entities.count)
        }
    }
}
struct WorldView: View {
    @ObservedObject var vm : WorldVM
    var body: some View {
        
        VStack (spacing: 1){
            ForEach(0..<Constants.rowMax, id: \.self){ row in
                HStack (spacing: 1){
                    ForEach(0..<Constants.colMax, id: \.self){ col in
                        Rectangle()
                            .overlay {
                                
                            }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .background(.green)
    }
}
struct ContentView: View {
    @StateObject var vm = WorldVM()
    var body: some View {
        WorldView(vm: vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
