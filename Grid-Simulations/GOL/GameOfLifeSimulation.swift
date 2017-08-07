//
//  GameOfLifeSimulation.swift
//  Grid-Simulations
//
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation

public class GameOfLifeSimulation: Simulation {

    public var liveChar: Character = "👾"

    func getAlive(grid: [[Character?]], column x: Int, row y: Int) -> Int {
        if x < 0 {
            return 0
        }
        if y < 0 {
            return 0
        }
        if x >= grid.count {
            return 0
        }
        if y >= grid[0].count {
            return 0
        }
        if grid[x][y] == nil {
            return 0
        }
        return 1
    }
    
    func countNeighbors(grid: [[Character?]], column x: Int, row y: Int) -> Int {
        var count = 0
        count = count + getAlive(grid: grid, column: x-1, row: y+1)
        count = count + getAlive(grid: grid, column: x, row: y+1)
        count = count + getAlive(grid: grid, column: x+1, row: y+1)
        count = count + getAlive(grid: grid, column: x+1, row: y)
        count = count + getAlive(grid: grid, column: x+1, row: y-1)
        count = count + getAlive(grid: grid, column: x, row: y-1)
        count = count + getAlive(grid: grid, column: x-1, row: y-1)
        count = count + getAlive(grid: grid, column: x-1, row: y)
        return count
    }
    
    public override func update() {
        var newGrid = grid
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                let cell = grid[x][y]
                let neighborCount = countNeighbors(grid: grid, column: x, row: y)
                if cell == nil {
                    if neighborCount == 3 {
                        newGrid[x][y] = "👾"
                    }
                } else {
                    if neighborCount < 2 {
                        newGrid[x][y] = nil
                    }
                    if neighborCount > 3 {
                        newGrid[x][y] = nil
                    }
                }
            }
        }
        grid = newGrid
    }
}
