//
//  MySimulation.swift
//  Grid-Simulations
//
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation

let MY_SIMULATION_ACTIVE = true
let MY_SIMULATION_PALETTE: [Character?] = ["🐻", "🐼", "🌿", "💀", nil, nil, nil, nil]

public class MySimulation: Simulation {
    var newGrid: [[Character?]] = []
    
    public override func setup() {
        grid = [[Character?]](repeating: [Character?](repeating: nil, count: 10), count: 10)
        for x in 0..<8 {
            for y in 0..<10 {
                // Ten percent chance of each cell
                if randomChance(percentage: 40) {
                    grid[x][y] = "🐻"
                }
                if randomChance(percentage: 10) {
                    grid[x][y] = "🐼"
                }
                if randomChance(percentage: 45) {
                    grid[x][y] = "🌿"
                }
            }
        }
    }
    
    public override func update() {
        newGrid = grid
        let countPanda = count(emoji: "🐼")
        let countBear = count(emoji: "🐻")
        for x in 0..<grid.count {
            for y in 0..<grid[x].count {
                
                let cell = grid[x][y]
                
                if cell == nil {
                    if randomChance(percentage: 15) {
                        newGrid[x][y] = "🐻"
                    }
                    if randomChance(percentage: 40) {
                        newGrid[x][y] = "🌿"
                    }
                    if randomChance(percentage: countPanda * 1.2){
                        newGrid[x][y] = "🐼"
                    }
                    if randomChance(percentage: countBear / 1.5){
                        newGrid[x][y] = "🐻"
                    }
                }
                if cell == "🐼" {
                    if !neighborsContain(emoji: "🌿" , x: x, y: y, count: 1) {
                        if randomChance(percentage: 80) {
                            newGrid[x][y] = "💀"
                        }
                    }
                }
                if cell == "🐻" {
                    if !neighborsContain(emoji: "🌿" , x: x, y: y, count: 2) {
                        if randomChance(percentage: 80) {
                        newGrid[x][y] = "💀"
                        }
                    }
                }
                if cell == "🌿" {
                    if neighborsContain(emoji: "🐻" , x: x, y: y, count: 2) || neighborsContain(emoji: "🐼" , x: x, y: y, count: 1) {
                        newGrid[x][y] = nil

                    }
                }
                if cell == "💀" {
                    newGrid[x][y] = nil
                }
            }
        }
        
        grid = newGrid
    }
    
    func count(emoji: Character?) -> Double {
        var count = 0
        for x in 0..<grid.count {
            for y in 0..<grid[x].count {
                if grid[x][y] == emoji {
                    count = count + 1
                }
            }
        }
        return Double(count)
    }
    
    func moveToNeighbor(emoji: Character?, x:Int, y:Int) {
        getNeighborPositions(x: x - 1, y: y + 1)
        getNeighborPositions(x: x - 1, y: y)
        getNeighborPositions(x: x - 1, y: y - 1)
        getNeighborPositions(x: x, y: y + 1)
        getNeighborPositions(x: x, y: y)
        getNeighborPositions(x: x, y: y - 1)
        getNeighborPositions(x: x + 1, y: y + 1)
        getNeighborPositions(x: x + 1, y: y)
        getNeighborPositions(x: x - 1, y: y - 1)
    }

    
    func randomChance(percentage: Double) -> Bool {
        return Double(randomZeroToOne() * 100) < percentage
    }
    
    func neighborsContain(emoji: Character?, x: Int, y: Int, count: Int = 1) -> Bool {
        let neighborPositions = getNeighborPositions(x: x, y: y)
        var currentCount = 0
        for neighbor in neighborPositions {
            if grid[neighbor.x][neighbor.y] == emoji {
                currentCount = currentCount + 1
            }
        }
        return currentCount >= count
    }
    
    
    
    func positionOfNeighboring(emoji: Character?, x: Int, y: Int) -> (x: Int, y: Int)? {
        let neighborPositions = getNeighborPositions(x: x, y: y).shuffled()
        for neighbor in neighborPositions {
            if grid[neighbor.x][neighbor.y] == emoji {
                return neighbor
            }
        }
        return nil
    }
    
    func getNeighborPositions(x originX: Int, y originY: Int) -> [(x: Int, y: Int)] {
        var neighbors: [(x: Int, y: Int)] = []
        for x in (originX - 1)...(originX + 1) {
            for y in (originY - 1)...(originY + 1) {
                if isLegalPosition(x: x, y: y) {
                    if !(x == originX && y == originY) {
                        neighbors.append((x, y))
                    }
                }
            }
        }
        return neighbors
    }
    
    func isLegalPosition(x: Int, y: Int) -> Bool {
        if x >= 0 && x < grid.count && y >= 0 && y < grid[0].count {
            return true
        } else {
            return false
        }
    }
}
