//
//  SolverController.swift
//  Twenty4
//
//  Created by Jake Esmael on 6/1/16.
//  Copyright © 2016 Jake Esmael. All rights reserved.
//

import Foundation
//: Playground - noun: a place where people can play

import UIKit

import Darwin
import Foundation

var solution = ""

print("24 Game")
print("Generating 4 digits...")

func randomDigits() -> [Int] {
    return [8, 3, 6, 9]
    var result = [Int]()
    for _ in 0 ..< 4 {
        result.append(Int(arc4random_uniform(9)+1))
    }
    return result
}

// Choose 4 digits
let digits = randomDigits()

print("Make 24 using these digits : ")

for digit in digits {
    print("\(digit) ")
}
print()

// get input from operator
var input = NSString(data:NSFileHandle.fileHandleWithStandardInput().availableData, encoding:NSUTF8StringEncoding)!

var enteredDigits = [Double]()

var enteredOperations = [Character]()

let inputString = input as String

// store input in the appropriate table
for character in inputString.characters {
    switch character {
    case "1", "2", "3", "4", "5", "6", "7", "8", "9":
        let digit = String(character)
        enteredDigits.append(Double(Int(digit)!))
    case "+", "-", "*", "/":
        enteredOperations.append(character)
    case "\n":
        print()
    default:
        print("Invalid expression")
    }
}

// check value of expression provided by the operator
var value = 0.0
enteredDigits = []
for digit in digits {
    Double(digit)
    enteredDigits.append(Double(digit))
}
Double(4)
enteredDigits

if enteredDigits.count == 4 && enteredOperations.count == 3 {
    value = enteredDigits[0]
    for (i, operation) in enteredOperations.enumerate() {
        switch operation {
        case "+":
            value = value + enteredDigits[i+1]
        case "-":
            value = value - enteredDigits[i+1]
        case "*":
            value = value * enteredDigits[i+1]
        case "/":
            value = value / enteredDigits[i+1]
        default:
            print("This message should never happen!")
        }
    }
}

func evaluate(dPerm: [Double], oPerm: [String]) -> Bool {
    var value = 0.0
    
    if dPerm.count == 4 && oPerm.count == 3 {
        value = dPerm[0]
        for (i, operation) in oPerm.enumerate() {
            switch operation {
            case "+":
                value = value + dPerm[i+1]
            case "-":
                value = value - dPerm[i+1]
            case "*":
                value = value * dPerm[i+1]
            case "/":
                value = value / dPerm[i+1]
            default:
                print("This message should never happen!")
            }
        }
    }
    return (abs(24 - value) < 0.001)
}

func isSolvable(inout digits: [Double]) -> Bool {
    
    var result = false
    var dPerms = [[Double]]()
    permute(&digits, res: &dPerms, k: 0)
    
    let total = 4 * 4 * 4
    var oPerms = [[String]]()
    permuteOperators(&oPerms, n: 4, total: total)
    
    
    for dig in dPerms {
        for opr in oPerms {
            var expression = ""
            
            if evaluate(dig, oPerm: opr) {
                for digit in dig {
                    expression += "\(digit)"
                }
                
                for oper in opr {
                    expression += oper
                }
                
                solution = beautify(expression)
                result = true
            }
        }
    }
    return result
}

func permute(inout lst: [Double], inout res: [[Double]], k: Int) -> Void {
    for i in k ..< lst.count {
        swap(&lst[i], &lst[k])
        permute(&lst, res: &res, k: k + 1)
        swap(&lst[k], &lst[i])
    }
    if k == lst.count {
        res.append(lst)
    }
}

// n=4, total=64, npow=16
func permuteOperators(inout res: [[String]], n: Int, total: Int) -> Void {
    let posOperations = ["+", "-", "*", "/"]
    let npow = n * n
    for i in 0 ..< total {
        res.append([posOperations[(i / npow)], posOperations[((i % npow) / n)], posOperations[(i % n)]])
    }
}

func beautify(infix: String) -> String {
    let newString = infix as NSString
    
    var solution = ""
    
    solution += newString.substringWithRange(NSMakeRange(0, 1))
    solution += newString.substringWithRange(NSMakeRange(12, 1))
    solution += newString.substringWithRange(NSMakeRange(3, 1))
    solution += newString.substringWithRange(NSMakeRange(13, 1))
    solution += newString.substringWithRange(NSMakeRange(6, 1))
    solution += newString.substringWithRange(NSMakeRange(14, 1))
    solution += newString.substringWithRange(NSMakeRange(9, 1))
    
    return solution
}

if value != 24 {
    print("The value of the provided expression is \(value) instead of 24!")
    enteredDigits
    if isSolvable(&enteredDigits) {
        print("A possible solution could have been " + solution)
    } else {
        print("Anyway, there was no known solution to this one.")
    }
} else {
    print("Congratulations, you found a solution!")
}