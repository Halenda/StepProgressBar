//
//  ViewProgressBarViewController.swift
//  StepProgressBar
//
//  Created by Anton Halenda on 10.10.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import StepProgressBar

class ViewProgressBarViewController: UIViewController, HasProgressBar {
    var stepsCount: Int = 0
    var currentStep: Int = 0
    
    //MARK: - Outlets
    @IBOutlet fileprivate weak var progressView: StepProgressBar!
    
    //MARK: - Actions
    @IBAction func previous(_ sender: UIButton) {
        progressView.previous()
    }
    
    @IBAction func next(_ sender: UIButton) {
        progressView.next()
    }
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        progressView.stepsCount = stepsCount
        progressView.progress = currentStep
    }
}
