//
//  NavigationController+StepProgressBar.swift
//  Pods
//
//  Created by Anton Halenda on 10.10.17.
//
//

import UIKit
fileprivate let progressBarBottomOffset: CGFloat = 2.0

public extension UINavigationController {
    

    /* ====================================================================== */
    // MARK: - Properties
    /* ====================================================================== */
    
    /**
     Default is 2.0
     */
    open var progressHeight: CGFloat {
        get { return progressBar.frame.height }
        set {
            progressBar.frame.origin.y = navigationBar.frame.height - (newValue + progressBarBottomOffset)
            progressBar.frame.size.height = newValue
        }
    }
    
    /**
     The current progress is represented by a floating-point value between 0.0 and 1.0,
     inclusive, where 1.0 indicates the completion of the task. The default value is 0.0.
     */
    open var progress: Int {
        get { return progressBar.progress }
        set { progressBar.progress = newValue }
    }
    
    fileprivate var progressBar: StepProgressBar {
        for subview in navigationBar.subviews {
            if let progressBar = subview as? StepProgressBar {
                return progressBar
            }
        }
        
        let defaultHeight = CGFloat(2)
        let frame = CGRect(
            x: 0,
            y: navigationBar.frame.height - (defaultHeight + progressBarBottomOffset),
            width: navigationBar.frame.width,
            height: defaultHeight
        )
        let progressBar = StepProgressBar(frame: frame)
        progressBar.backgroundColor = .clear
        progressBar.alpha = 0
        
        navigationBar.addSubview(progressBar)
        
        progressBar.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        
        UIView.animate(withDuration: 0.25) {
            progressBar.alpha = 1
        }
        return progressBar
    }
    
    /* ====================================================================== */
    // MARK: - Public Methods
    /* ====================================================================== */
    
    /**
     Adjusts the current progress shown by the receiver, optionally animating the change.
     
     - parameter progress: The new progress value.
     - parameter animated: true if the change should be animated, false if the change should happen immediately.
     */
    
    open func setProgressBarProgress(_ progress: Int) {
        progressBar.progress = progress
    }

    open func setupProgressBar(color: UIColor, bgColor: UIColor, stepsCount: Int, currentStep: Int = 0, stepsOffset: CGFloat, progressHeight: CGFloat = 2) {
        progressBar.color = color
        progressBar.bgColor = bgColor
        progressBar.backgroundColor = .clear
        progressBar.stepsCount = stepsCount
        progressBar.progress = currentStep
        progressBar.stepsOffset = stepsOffset
        self.progressHeight = progressHeight
        
        if let shadow = findShadowImage(under: navigationBar) {
            shadow.isHidden = true
        }
    }
    open func removeProgressBar() {
        progressBar.removeFromSuperview()
    }
    
    open func previousStep() {
        progressBar.previous()
    }
    
    open func nextStep() {
        progressBar.next()
    }
    
    private func findShadowImage(under view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1 {
            return (view as! UIImageView)
        }
        
        for subview in view.subviews {
            if let imageView = findShadowImage(under: subview) {
                return imageView
            }
        }
        return nil
    }
}
