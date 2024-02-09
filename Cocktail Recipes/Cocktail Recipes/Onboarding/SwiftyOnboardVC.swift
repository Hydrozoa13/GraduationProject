//
//  SwiftyOnboardVC.swift
//  Cocktail Recipes
//
//  Created by Евгений Лойко on 6.02.24.
//

import UIKit

class SwiftyOnboardVC: UIViewController {
    
    var swiftyOnboard: SwiftyOnboard!
    
    var titleArray: [String] = ["Welcome, Dear Friend!",
                                "Make a choice",
                                "Enjoyed a cocktail?",
                                "It will be here",
                                "Explore",
                                "Cheers!"]
    
    var subTitleArray: [String] = ["This app will help you to find out\nhow to make a cocktail",
                                   "Discover all the details",
                                   "Add it to the favorites\nby pressing the button",
                                   "Once you have more\nthan 2 favorite recipes\ntap & hold to see the list",
                                   "Tap & hold to see\nwhich cocktails you can make\nusing the ingredient",
                                   "Enjoy your weekend"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swiftyOnboard = SwiftyOnboard(frame: view.frame)
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
        swiftyOnboard.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    @objc func handleSkip() {
        swiftyOnboard?.goToPage(index: titleArray.count - 1, animated: true)
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = sender.tag
        swiftyOnboard?.goToPage(index: index + 1, animated: true)
    }
}

extension SwiftyOnboardVC: SwiftyOnboardDelegate, SwiftyOnboardDataSource {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int { titleArray.count }
    
    func swiftyOnboardBackgroundColorFor(_ swiftyOnboard: SwiftyOnboard, atIndex index: Int) -> UIColor? {
        #colorLiteral(red: 0.1176468208, green: 0.1176472232, blue: 0.1262352169, alpha: 1)
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = SwiftyOnboardPage()
        
        view.imageView.image = UIImage(named: "onboard\(index)")
    
        view.title.font = UIFont(name: "Academy Engraved LET", size: 31)
        view.subTitle.font = UIFont.systemFont(ofSize: 22)
        
        view.title.text = titleArray[index]
        view.subTitle.text = subTitleArray[index]
        
        return view
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()
        
        overlay.skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        
        overlay.continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        overlay.continueButton.setTitleColor(#colorLiteral(red: 0.5386385322,
                                                           green: 0.6859211922,
                                                           blue: 0,
                                                           alpha: 1), for: .normal)
        
        overlay.skipButton.setTitleColor(UIColor.lightGray, for: .normal)
        overlay.skipButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let currentPage = lrint(position)
        
        overlay.pageControl.currentPage = currentPage
        overlay.continueButton.tag = currentPage
        
        if currentPage < (titleArray.count - 1) {
            overlay.continueButton.setTitle("Continue", for: .normal)
            overlay.skipButton.setTitle("Skip", for: .normal)
            overlay.skipButton.isHidden = false
        } else {
            overlay.continueButton.setTitle("Get Started!", for: .normal)
            overlay.skipButton.isHidden = true
        }
    }
}
