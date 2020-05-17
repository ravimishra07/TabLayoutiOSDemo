//
//  MyPageViewController.swift
//  TabLayoutDemo
//
//  Created by Ravi Mishra on 17/05/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import UIKit

class MyPageViewController: UIPageViewController {
    fileprivate var items: [UIViewController] = []
var currentIndex = 0
    let controllerIdentifierArray = ["TabViewController1","TabViewController2","TabViewController3"]
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newColoredViewController(controllerIdentifier: controllerIdentifierArray[0]), self.newColoredViewController(controllerIdentifier: controllerIdentifierArray[1]),self.newColoredViewController(controllerIdentifier: controllerIdentifierArray[2])]}()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    private func newColoredViewController(controllerIdentifier: String) -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: controllerIdentifier)
        return vc
    }
    
    
    /// Update pagecontroller by passing current tab's index
    /// - Parameters:
    ///   - index: tab we are moving to
    ///   - direction: direction of swipe
    func setControllerWithIndex(index: Int,direction: UIPageViewController.NavigationDirection ){
        setViewControllers([orderedViewControllers[index]], direction: direction, animated: true, completion: nil)
        
    }
    
    /// Compares current index with next index user swiped to and decided whether to forwrd or backwords
    /// - Parameters:
    ///   - currentIndex: index of tab we are currently on
    ///   - nextIndex: index of tab we are moving to
    func changeViewController(currentIndex: Int, nextIndex: Int){
        switch nextIndex {
        case 0:
            if nextIndex>currentIndex{
                setControllerWithIndex(index:0,direction: .forward)
            }else{
                setControllerWithIndex(index :0,direction: .reverse)
            }
        case 1:
            if nextIndex>currentIndex{
                setControllerWithIndex(index :1,direction: .forward)
            }else{
                setControllerWithIndex(index :1,direction: .reverse)
            }
        case 2:
            if nextIndex>currentIndex{
                setControllerWithIndex(index :2,direction: .forward)
            }else{
                setControllerWithIndex(index :2,direction: .reverse)
            }
        default:
            if nextIndex>currentIndex{
                setControllerWithIndex(index :0,direction: .forward)
            }else{
                setControllerWithIndex(index:0,direction: .reverse)
            }
        }
    }
    
   

}
extension MyPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        <#code#>
//    }
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
    
}

extension MyPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageViewController.viewControllers?.first,
                let index = orderedViewControllers.firstIndex(of: currentViewController) {
                currentIndex = index
                let indexDict:[String: Int] = ["index": currentIndex]
                
                // Post a notification
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateTabs"), object: nil, userInfo: indexDict)
            }
        }
        
    }
}
