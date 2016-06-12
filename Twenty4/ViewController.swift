//
//  ViewController.swift
//  Twenty4
//
//  Created by Jake Esmael on 5/31/16.
//  Copyright © 2016 Jake Esmael. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var num1: UILabel!
  @IBOutlet weak var num2: UILabel!
  @IBOutlet weak var num3: UILabel!
  @IBOutlet weak var num4: UILabel!
  var currNum: Int = 0
  let cards = ["A":1.0,"J":11.0,"Q":12.0,"K":13.0]
  var nums: [Double] = [0.0, 0.0, 0.0, 0.0]
  var solutions: [String] = []
    
  @IBOutlet weak var solutionLabel: UILabel!
  @IBOutlet weak var solutionsArea: UILabel!
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func pressButton(sender: UIButton) {
    let card = sender.currentTitle!
    let val = Array(cards.keys).contains(card) ? cards[card]! : Double(card)!
    var labels = [num1, num2, num3, num4]
    nums[currNum] = val
    labels[currNum].text = String(Int(val))
    if currNum == 3 {
      solve()
    }
    currNum = (currNum+1)%4
  }
  
  func solve() {
    let solutions = isSolvable(&nums)
    solutionLabel.text = solutions.count > 0 ? "Solution: Yes" : "Solutions: No"
  }

  @IBAction func showSolutions() {
    solutions = isSolvable(&nums)
    let solString = solutions.joinWithSeparator(" ")
    solutionsArea.text = solString
  }
}

