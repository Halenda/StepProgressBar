//
//  NavigationProgressBarViewController.swift
//  StepProgressBar
//
//  Created by Anton Halenda on 10.10.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class NavigationProgressBarViewController: UIViewController, HasProgressBar {
    //MARK: - Variables
    var stepsCount: Int = 0
    var currentStep: Int = 0
    
    //MARK: - Actions
    @IBAction func backPress(_ sender: Any) {
        self.navigationController?.previousStep()
    }
    
    @IBAction func nextPress(_ sender: Any) {
        self.navigationController?.nextStep()
    }
    
    //MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setupProgressBar(color: .orange, bgColor: .white, stepsCount: stepsCount, currentStep: currentStep, stepsOffset: 3, progressHeight: 4)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.removeProgressBar()
    }
}
