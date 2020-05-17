//
//  ViewController.swift
//  TabLayoutDemo
//
//  Created by Ravi Mishra  on 16/05/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentSelectedBtn = 0

    @IBOutlet weak var tabButton1: UIButton!
    @IBOutlet weak var tabButton2: UIButton!
    @IBOutlet weak var tabButton3: UIButton!
    @IBOutlet weak var tabContainerView: UIView!
    @IBOutlet weak var tabContentView: UIView!
    var pageVC = MyPageViewController(transitionStyle:
    UIPageViewController.TransitionStyle.scroll, navigationOrientation:
    UIPageViewController.NavigationOrientation.horizontal, options: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        addCorner(view: tabButton1)
        addCorner(view: tabButton2)
        addCorner(view: tabButton3)
        addCorner(view: tabContainerView)
        updateButtons(selectedBtn: tabButton1, unselectedBtn1: tabButton2, unselectedBtn2: tabButton3)
        
        // Add pageview controller
        self.addChild(pageVC)
        self.tabContentView.addSubview(pageVC.view)
         NotificationCenter.default.addObserver(self, selector: #selector(self.changeIndex(_:)), name: NSNotification.Name(rawValue: "updateTabs"), object: nil)
    
    }
    @objc func changeIndex(_ notification: NSNotification){
           if let dict = notification.userInfo as NSDictionary? {
               if let index = dict["index"] as? Int{
                   switch index {
                   case 0:
                    updateButtons(selectedBtn: tabButton1, unselectedBtn1: tabButton2, unselectedBtn2: tabButton3)
                    currentSelectedBtn = 0

                   case 1:
                    updateButtons(selectedBtn: tabButton2, unselectedBtn1: tabButton1, unselectedBtn2: tabButton3)
                    currentSelectedBtn = 1

                   case 2:
                    updateButtons(selectedBtn: tabButton3, unselectedBtn1: tabButton1, unselectedBtn2: tabButton2)
                    currentSelectedBtn = 2


                   default:
                    updateButtons(selectedBtn: tabButton3, unselectedBtn1: tabButton1, unselectedBtn2: tabButton2)
                    currentSelectedBtn = 0
                }
            }
        }
    }

    func addCorner(view: UIView){
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.height/2
    }
    
    @IBAction func tab1Clicled(_sender: UIButton){
        updateButtons(selectedBtn: tabButton1, unselectedBtn1: tabButton2, unselectedBtn2: tabButton3)
        pageVC.changeViewController(currentIndex: currentSelectedBtn, nextIndex: 0)
        currentSelectedBtn=0
        
    }
    @IBAction func tab2Clicled(_sender: UIButton){
        updateButtons(selectedBtn: tabButton2, unselectedBtn1: tabButton1, unselectedBtn2: tabButton3)
        pageVC.changeViewController(currentIndex: currentSelectedBtn, nextIndex: 1)
        currentSelectedBtn=1
        
    }
    @IBAction func tab3Clicled(_sender: UIButton){
        updateButtons(selectedBtn: tabButton3, unselectedBtn1: tabButton2, unselectedBtn2: tabButton1)
        pageVC.changeViewController(currentIndex: currentSelectedBtn, nextIndex: 2)
        currentSelectedBtn=2
        
    }
  
    func updateButtons(selectedBtn: UIButton, unselectedBtn1: UIButton, unselectedBtn2: UIButton){
        selectedBtn.setTitleColor(.white, for: .normal)
        selectedBtn.setTitleColor(.white, for: .selected)
        selectedBtn.backgroundColor = .black
        unselectedBtn1.setTitleColor(.black, for: .normal)
        unselectedBtn1.setTitleColor(.black, for: .selected)
        unselectedBtn1.backgroundColor = .clear
        
        unselectedBtn2.setTitleColor(.black, for: .normal)
        unselectedBtn2.setTitleColor(.black, for: .selected)
        unselectedBtn2.backgroundColor = .clear
    }
}

