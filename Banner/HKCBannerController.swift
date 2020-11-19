//
//  HKCBanner.swift
//  ykd_demo
//
//  Created by Z Soul on 2019/12/21.
//  Copyright © 2019 Z Soul. All rights reserved.
//

import SwiftUI

class HKCBannerController: UIViewController {
//    @ObservedObject final var banner_url_dd: Banner_Data
    // 数据源
//    @State public  var pictures: [String] = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        createCyclePicture1(pic: pictures)
    }
    func createCyclePicture1(pic: [String]) {
        
        let cyclePictureView: HKCycleView = HKCycleView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 180))
        
        cyclePictureView.setUrlsGroup(pic)
        
        cyclePictureView.itemSize = CGSize(width: UIScreen.main.bounds.width-80, height: (UIScreen.main.bounds.width-80)*360/750)
        
        cyclePictureView.itemSpacing = 30
        
        cyclePictureView.itemZoomScale = 1.1
        
        cyclePictureView.pageControlItemSize = CGSize.zero
        
        cyclePictureView.backgroundColor = UIColor.clear
        
        cyclePictureView.pageControlCurrentItemRadius = 20
        //元素图片圆角大小
        cyclePictureView.itemCornerRadius = 10
        
        cyclePictureView.timeInterval = 3
        
        cyclePictureView.didSelectedItem = { index in
            
            print("dianjil\(index+1 )zhang picture")
        }
      
        self.view.addSubview(cyclePictureView)
    }
    func createCyclePicture1(pic: [UIImage?]) {
        
        let cyclePictureView: HKCycleView = HKCycleView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 180))
        
        cyclePictureView.setImagesGroup(pic)
        
        cyclePictureView.itemSize = CGSize(width: UIScreen.main.bounds.width-80, height: (UIScreen.main.bounds.width-80)*500/750)
        //height: (UIScreen.main.bounds.width-80)*360/750)
        cyclePictureView.itemSpacing = 30
        
        cyclePictureView.itemZoomScale = 1.1
        
        cyclePictureView.pageControlItemSize = CGSize.zero
        
        cyclePictureView.backgroundColor = UIColor.clear
        
        cyclePictureView.pageControlCurrentItemRadius = 20
        //元素图片圆角大小
        cyclePictureView.itemCornerRadius = 10
        
        cyclePictureView.timeInterval = 3
        
        cyclePictureView.didSelectedItem = { index in
            
            print("dianjil\(index+1 )zhang picture")
        }
      
        self.view.addSubview(cyclePictureView)
    }
}
