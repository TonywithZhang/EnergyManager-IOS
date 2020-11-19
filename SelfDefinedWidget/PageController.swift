//
//  PageController.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/10/21.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI

struct PageController: UIViewControllerRepresentable{
    let pages = loginPageImages.map{
        UIHostingController(
            rootView: Image($0)
                .resizable()
        )
    }
    
    func makeCoordinator() -> PageDataSource {
        PageDataSource(pages: pages)
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let controller = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
            )
        controller.dataSource = context.coordinator
        return controller
    }
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        uiViewController.setViewControllers([pages[0]], direction: .forward, animated: true)
    }
    
    class PageDataSource : NSObject,UIPageViewControllerDataSource{
        let pages : [UIViewController]
        init(pages : [UIViewController]) {
            self.pages = pages
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            let currentIndex = pages.firstIndex(of: viewController)!
            return currentIndex == 0 ? pages.last : pages[currentIndex - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            let currentIndex = pages.firstIndex(of: viewController)!
            return currentIndex == pages.count - 1 ? pages.first : pages[currentIndex + 1]
        }
        
        
    }
}

struct PageController_Previews: PreviewProvider {
    static var previews: some View {
        PageController()
    }
}
let loginPageImages = ["159600","honor_labels","pile","roof_photo","smart_led"]
