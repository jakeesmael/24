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

// This is the wrong way to do this.
// Right way is to split the array at each possible split and solve recursively

// ((a+b)+c)+d
func eval1(nums: [Double], ops: [String]) -> Double {
    return eval(eval(eval(nums[0], op: ops[0], num2: nums[1]), op: ops[1], num2: nums[2]), op: ops[2], num2: nums[3])
}

// (a+(b+c))+d
func eval2(nums: [Double], ops: [String]) -> Double {
    return eval(eval(nums[0], op: ops[0], num2: eval(nums[1], op: ops[1], num2: nums[2])), op: ops[2], num2: nums[3])
}

// (a+b)+(c+d)
func eval3(nums: [Double], ops: [String]) -> Double {
    return eval(eval(nums[0], op: ops[0], num2: nums[1]), op: ops[1], num2: eval(nums[2], op: ops[2], num2: nums[3]))
}

// a+((b+c)+d)
func eval4(nums: [Double], ops: [String]) -> Double {
    return eval(nums[0], op: ops[0], num2: eval(eval(nums[1], op: ops[1], num2: nums[2]), op: ops[2], num2: nums[3]))
}

// a+(b+(c+d))
func eval5(nums: [Double], ops: [String]) -> Double {
    return eval(nums[0], op: ops[0], num2: eval(nums[1], op: ops[1], num2: eval(nums[2], op: ops[2], num2: nums[3])))
}

func eval(num1: Double, op: String, num2: Double) -> Double {
    var value = 0.0
    switch op {
    case "+":
        value = num1 + num2
    case "-":
        value = num1 - num2
    case "*":
        value = num1 * num2
    case "/":
        value = num1 / num2
    default:
        print("This message should never happen!")
    }
    return value
}

func evaluate(nums: [Double], ops: [String]) -> Bool{
    return true
}

//return (abs(24 - value) < 0.001)

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
            
            if evaluate(dig, ops: opr) {
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
        if i != k {
            swap(&lst[i], &lst[k])
        }
        permute(&lst, res: &res, k: k + 1)
        if i != k {
            swap(&lst[k], &lst[i])
        }
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

//eval5([8.0, 3.0, 8.0, 3.0], ops: ["/", "-", "/"])


