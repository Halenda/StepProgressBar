//
//  SetupViewController.swift
//  StepProgressBar
//
//  Created by Anton Halenda on 10.10.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

protocol HasProgressBar {
    var stepsCount: Int {get set}
    var currentStep: Int {get set}
}

class SetupViewController: UIViewController {
    //MARK: - Private vars
    fileprivate var stepsCount: Int! {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.stepsCountLabel.text = "Steps count: \(self.stepsCount!)"
            }
        }
    }
    fileprivate var currentStep: Int! {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.currentStepLabel.text = "Current step: \(self.currentStep!)"
            }
        }
    }
    
    @IBAction func stepsCountChanged(_ sender: UIStepper) {
        stepsCount = Int(sender.value)
    }
    
    @IBAction func currentStepChanged(_ sender: UIStepper) {
        currentStep = Int(sender.value)
    }
    
    //MARK: - Outlets
    @IBOutlet fileprivate weak var stepsCountLabel: UILabel!
    @IBOutlet fileprivate weak var currentStepLabel: UILabel!
    @IBOutlet fileprivate weak var stepsCountStepper: UIStepper!
    @IBOutlet fileprivate weak var currentStepStepper: UIStepper!

    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stepsCount = Int(stepsCountStepper.value)
        currentStep = Int(currentStepStepper.value)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard var destination = segue.destination as? HasProgressBar  else {
            print("Destination controller is not conforms to HasProgressBar protocol")
            return
        }
        
        destination.currentStep = currentStep
        destination.stepsCount = stepsCount
    }
}
