//
//  ViewController.swift
//  M06P01-果冻效果
//
//  Created by 罗培克 on 6/22/15.
//  Copyright © 2015 lpk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var pageControl: KYAnimatedPageControl = KYAnimatedPageControl(frame: CGRectMake(20, 450, 280, 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.pageCount = 8
        pageControl.unSelectedColor = UIColor.darkGrayColor()
        pageControl.selectedColor = UIColor.redColor()
        pageControl.shouldShowProgressLine = true
        pageControl.bindScrollView = collectionView
        
        pageControl.indicatorStyle = IndicatorStyleGooeyCircle
        pageControl.indicatorSize = 20
        pageControl.swipeEnable = true
        
        view.addSubview(pageControl)
        
        // WARNING: - 闭包和 block
//        pageControl.didSelectIndexBlock = ^(index: NSInteger) {
//            print("did select index \(index)")
//        }
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageControl.pageCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let demoCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! DemoCell
        demoCell.numberLabel.text = "\(indexPath.item + 1)"
        
        return demoCell
    }
    
    // MARK:- UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 果冻动画
        pageControl.indicator.animateIndicatorWithScrollView(scrollView, andIndicator: pageControl)
        
        if scrollView.dragging || scrollView.tracking || scrollView.decelerating {
            pageControl.pageControlLine.animateSelectedLineWithScrollView(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        pageControl.indicator.lastContentOffset = scrollView.contentOffset.x
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        pageControl.indicator.restoreAnimation(1.0 / Double(pageControl.pageCount))
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        pageControl.indicator.lastContentOffset = scrollView.contentOffset.x
    }
}

