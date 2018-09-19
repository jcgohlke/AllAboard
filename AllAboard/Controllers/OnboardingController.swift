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

import Foundation

public struct OnboardingPayload
{
    let title: String
    let description: String
    let iconName: String
    let affirmativeButtonTitle: String
    var opposingButtonTitle: String?
    let affirmativeAction: () -> Bool
    let opposingAction: (() -> Bool)?
    let viewBackgroundColor: UIColor
    let buttonBackgroundColor: UIColor
    let textColor: UIColor
    
    public init(title: String, description: String, iconName: String, affirmativeButtonTitle: String, opposingButtonTitle: String?, affirmativeAction: @escaping () -> Bool, opposingAction: (() -> Bool)?, viewBackgroundColor: UIColor, buttonBackgroundColor: UIColor, textColor: UIColor)
    {
        self.title = title
        self.description = description
        self.iconName = iconName
        self.affirmativeButtonTitle = affirmativeButtonTitle
        self.opposingButtonTitle = opposingButtonTitle
        self.affirmativeAction = affirmativeAction
        self.opposingAction = opposingAction
        self.viewBackgroundColor = viewBackgroundColor
        self.buttonBackgroundColor = buttonBackgroundColor
        self.textColor = textColor
    }
}

public class OnboardingController
{
    
    fileprivate let screenSequence: [OnboardingPayload]
    fileprivate let navController = UINavigationController()
    fileprivate var currentScreenIndex = 0
    
    /// This init function will load the sequence of onboarding screens using an array of `OnboardingPayload` objects.
    ///
    /// - Parameter screens: Array of `OnboardingPayload` objects used to define the composition of the onboarding screen content and in what order they will appear.
    public init(screens sequence: [OnboardingPayload])
    {
        screenSequence = sequence
        navController.isNavigationBarHidden = true
    }
    
    /// This function will load the initial onboarding view, load it into the navigation controller and return the navigation controller.
    /// - Returns: A navigation controller which can be presented to start the onboarding UI sequence.
    public func loadInitialStack() -> UINavigationController
    {
        if let firstOVC = loadScreen()
        {
            navController.setViewControllers([firstOVC], animated: false)
        }
        return navController
    }
    
    /// This function will automatically load the next onboarding screen and push it onto the navigation stack.
    func advanceToNextScreen()
    {
        currentScreenIndex += 1
        if let nextVC = loadScreen()
        {
            navController.pushViewController(nextVC, animated: true)
        } else
        {
            navController.dismiss(animated: true, completion: nil)
        }
    }
    
    fileprivate func loadScreen() -> OnboardingViewController?
    {
        if currentScreenIndex < screenSequence.count
        {
            let payload = screenSequence[currentScreenIndex]
            let onboardingVC = OnboardingViewController(nibName: "OnboardingViewController", bundle: nil)
            onboardingVC.load(payload: payload)
            onboardingVC.onboardingController = self
            return onboardingVC
        }
        return nil
    }
}
