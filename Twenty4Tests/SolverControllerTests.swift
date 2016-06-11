//
//  SolverControllerTests.swift
//  Twenty4
//
//  Created by Jake Esmael on 6/6/16.
//  Copyright © 2016 Jake Esmael. All rights reserved.
//

import XCTest
@testable import Twenty4

//extension _ArrayType where Generator.Element == Double {
//    var intArray: [Int] {
//        return flatMap{ Int($0) }
//    }
//}

class SolverControllerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testEval() {
        var tests = [(num1: Double, op: String, num2: Double, ans: Double)]()
        tests = [(3.0, "*", 13.0, 13.0*3.0), (7.0, "+", 4.0, 7.0+4.0), (10.0, "-", 2.0, 10.0-2.0),
                    (9.0, "/", 3.0, 9.0/3.0), (5.0, "/", 2.0, 5.0/2.0)]
        for test in tests {
            XCTAssert(eval(test.num1, op: test.op, num2: test.num2) == test.ans, "Failed eval for: \(test.num1)\(test.op)\(test.num2)")
        }
    }

    // ((a+b)+c)+d
    func testEval1() {
        var tests = [(nums: [Double], ops: [String], ans: Double)]()
        tests = [([3.0, 7.0, 5.0, 2.0], ["*", "+", "-"], 24.0), ([6.0, 3.0, 10.0, 4.0], ["+", "+", "-"], 15.0),
                    ([3.0, 7.0, 5.0, 2.0], ["-", "*", "+"], -18.0), ([7.0, 2.0, 12.0, 1.0], ["*", "-", "-"], 1.0),
                    ([10.0, 8.0, 4.0, 3.0], ["+", "-", "+"], 17.0), ([2.0, 11.0, 9.0, 2.0], ["/", "+", "+"], (2.0/11.0)+9.0+2.0),
                    ([5.0, 6.0, 11.0, 10.0], ["/", "-", "/"], ((5.0/6.0)-11.0)/10.0)]
        for test in tests {
            XCTAssert(eval1(test.nums, ops: test.ops) == test.ans, "Failed eval1 for: ((\(test.nums[0])\(test.ops[0])\(test.nums[1]))\(test.ops[1])\(test.nums[2]))\(test.ops[2])\(test.nums[3]))")
        }
    }
    
    // (a+(b+c))+d
    func testEval2() {
        var tests = [(nums: [Double], ops: [String], ans: Double)]()
        tests = [([3.0, 7.0, 5.0, 2.0], ["*", "+", "-"], (3.0*(7.0+5.0))-2.0), ([6.0, 3.0, 10.0, 4.0], ["+", "+", "-"], 15.0),
                 ([3.0, 7.0, 5.0, 2.0], ["-", "*", "+"], -30.0), ([7.0, 2.0, 12.0, 1.0], ["*", "-", "-"], -71.0),
                 ([10.0, 8.0, 4.0, 3.0], ["+", "-", "+"], 17.0), ([2.0, 11.0, 9.0, 2.0], ["/", "+", "+"], (2.0/(11.0+9.0))+2.0)]
        for test in tests {
            XCTAssert(eval2(test.nums, ops: test.ops) == test.ans, "Failed eval1 for: (\(test.nums[0])\(test.ops[0])(\(test.nums[1])\(test.ops[1])\(test.nums[2])))\(test.ops[2])\(test.nums[3])")
        }
    }
    
    // (a+b)+(c+d)
    func testEval3() {
        var tests = [(nums: [Double], ops: [String], ans: Double)]()
        tests = [([3.0, 7.0, 5.0, 2.0], ["*", "+", "-"], (3.0*7.0)+(5.0-2.0)), ([6.0, 3.0, 10.0, 4.0], ["+", "+", "-"], 15.0),
                 ([3.0, 7.0, 5.0, 2.0], ["-", "*", "+"], -28.0), ([7.0, 2.0, 12.0, 1.0], ["*", "-", "-"], 3.0),
                 ([10.0, 8.0, 4.0, 3.0], ["+", "-", "+"], 11.0), ([2.0, 11.0, 9.0, 2.0], ["/", "+", "+"], (2.0/11.0)+(9.0+2.0))]
        for test in tests {
            XCTAssert(eval3(test.nums, ops: test.ops) == test.ans, "Failed eval1 for: (\(test.nums[0])\(test.ops[0])\(test.nums[1]))\(test.ops[1])(\(test.nums[2])\(test.ops[2])\(test.nums[3]))")
        }
    }
    
    // a+((b+c)+d)
    func testEval4() {
        var tests = [(nums: [Double], ops: [String], ans: Double)]()
        tests = [([3.0, 7.0, 5.0, 2.0], ["*", "+", "-"], 30.0), ([6.0, 3.0, 10.0, 4.0], ["+", "+", "-"], 15.0),
                 ([3.0, 7.0, 5.0, 2.0], ["-", "*", "+"], -34.0), ([7.0, 2.0, 12.0, 1.0], ["*", "-", "-"], -77.0),
                 ([10.0, 8.0, 4.0, 3.0], ["+", "-", "+"], 17.0), ([2.0, 11.0, 9.0, 2.0], ["/", "+", "+"], 2.0/22.0)]
        for test in tests {
            XCTAssert(eval4(test.nums, ops: test.ops) == test.ans, "Failed eval1 for: \(test.nums[0])\(test.ops[0])((\(test.nums[1])\(test.ops[1])\(test.nums[2]))\(test.ops[2])\(test.nums[3]))")
        }
    }
    
    // a+(b+(c+d))
    func testEval5() {
        var tests = [(nums: [Double], ops: [String], ans: Double)]()
        tests = [([3.0, 7.0, 5.0, 2.0], ["*", "+", "-"], 30.0), ([6.0, 3.0, 10.0, 4.0], ["+", "+", "-"], 15.0),
                 ([3.0, 7.0, 5.0, 2.0], ["-", "*", "+"], -46.0), ([7.0, 2.0, 12.0, 1.0], ["*", "-", "-"], -63.0),
                 ([10.0, 8.0, 4.0, 3.0], ["+", "-", "+"], 11.0), ([2.0, 11.0, 9.0, 2.0], ["/", "+", "+"], 2.0/22.0)]
        for test in tests {
            XCTAssert(eval5(test.nums, ops: test.ops) == test.ans, "Failed eval1 for: \(test.nums[0])\(test.ops[0])(\(test.nums[1])\(test.ops[1])(\(test.nums[2])\(test.ops[2])\(test.nums[3])))")
        }
    }
    
    func testIsSolvable() {
        var tests = [[Double]]()
        tests = [[3.0, 3.0, 8.0, 8.0], [1.0, 1.0, 1.0, 1.0], [6.0, 6.0, 6.0, 6.0], [9.0, 7.0, 13.0, 3.0], [13.0, 12.0, 11.0, 10.0]]
        let answers = [true, false, true, true, true]
        for (test, ans) in zip(tests, answers) {
            var t = test
            var solutions = isSolvable(&t)
            print("Solutions for \(t.intArray): \(solutions)")
            XCTAssert((solutions.count > 0) == ans, "Failed for \(t.intArray)")
        }
    }
}
