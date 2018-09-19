//
//  OnboardingController.swift
//  AllAboard
//
//  Created by Ben Gohlke on 12/19/17.
//  MIT License
//  Copyright (c) 2017 Ben Gohlke
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

public class OnboardingViewController: UIViewController
{
    
    @IBOutlet fileprivate weak var iconImageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var affirmativeButton: UIButton!
    @IBOutlet fileprivate weak var opposingButton: UIButton!
    
    fileprivate var payload: OnboardingPayload?
    var onboardingController: OnboardingController?
        
    override public func viewDidLayoutSubviews()
    {
        // Add a gradient background
//        let gradLayerBg = CAGradientLayer()
//        gradLayerBg.colors = [payload?.darkGradientBackgroundColor.cgColor, payload?.lightGradientBackgroundColor.cgColor]
//        gradLayerBg.frame = view.bounds
//        view.layer.insertSublayer(gradLayerBg, at: 0)
        
        affirmativeButton.layer.cornerRadius = 4.0
        
        if let pl = payload
        {
            titleLabel.textColor = pl.textColor
            descriptionLabel.textColor = pl.textColor
            affirmativeButton.backgroundColor = pl.buttonBackgroundColor
//            iconImageView.image = UIImage(named: pl.iconName)!
            titleLabel.text = pl.title
            descriptionLabel.text = pl.description
            affirmativeButton.setTitle(pl.affirmativeButtonTitle, for: .normal)
            if let opposingTitle = pl.opposingButtonTitle
            {
                opposingButton.setTitle(opposingTitle, for: .normal)
            } else
            {
                opposingButton.isHidden = true
            }
        }
    }
    
    func load(payload: OnboardingPayload)
    {
        self.payload = payload
    }
    
    // MARK: - Action Handlers
    
    @IBAction func affirmativeButtonTapped(_ sender: UIButton)
    {
        if let viewInfo = payload, viewInfo.affirmativeAction()
        {
            if let onboardingVC = onboardingController
            {
                onboardingVC.advanceToNextScreen()
            }
        }
    }
    
    @IBAction func opposingButtonTapped(_ sender: UIButton)
    {
        if let viewInfo = payload, let opposingAction = viewInfo.opposingAction
        {
            if opposingAction()
            {
                if let onboardingVC = onboardingController
                {
                    onboardingVC.advanceToNextScreen()
                }
            }
        }
    }
}

