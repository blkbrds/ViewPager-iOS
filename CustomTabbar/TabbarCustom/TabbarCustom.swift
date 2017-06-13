//
//  TabbarCustom.swift
//  CustomTabbar
//
//  Created by Tuan Mai A. on 5/8/17.
//  Copyright © 2017 Tuan Mai A. All rights reserved.
//

protocol TabbarCustomDatasource {
//    func numberItemInTabbar() -> Int
    func viewForItemInTabbar(index: Int, isSelect: Bool) -> UIView?
    func sizeForItemInTabbar(index: Int) -> CGSize
}

protocol TabbarCustomDelegate {
    func didSelectItemInTabbar(index: Int)
}

import UIKit

@IBDesignable class TabbarCustom: UIView {
    
    var datasource: TabbarCustomDatasource?
    var delegate: TabbarCustomDelegate?
    
    private var bagets:[Int] = []
    
    var numberItem = 0
    var indexSelect: Int = 0 {
        didSet {
            reloadTabbar()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.red
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func reloadTabbar() {
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        setup()
    }
    func setup() {
        guard let datasource = datasource else { return }
        var sizeWidthCustom: CGFloat = 0.0
        var totalItemCustomSize: Int = 0
        for index in 0 ..< numberItem {
            if datasource.sizeForItemInTabbar(index: index) != CGSize.zero {
                 sizeWidthCustom += datasource.sizeForItemInTabbar(index: index).width
                totalItemCustomSize += 1
            }
        }
        var currentPoint = CGPoint(x: 0, y: 0)
        for index in 0 ..< numberItem {
            var sizeItem = datasource.sizeForItemInTabbar(index: index)
            if sizeItem == CGSize.zero {
                sizeItem = CGSize(width: (frame.width - sizeWidthCustom) / CGFloat(numberItem - totalItemCustomSize), height: frame.height)
            } else {
                currentPoint = CGPoint(x: currentPoint.x, y: currentPoint.y - (sizeItem.height - frame.height))
            }
            if let view = datasource.viewForItemInTabbar(index: index, isSelect: index == indexSelect) {
                view.frame = CGRect(origin: currentPoint, size: sizeItem)
                view.isUserInteractionEnabled = true
                view.tag = index
                addSubview(view)
                let button = UIButton(frame: view.frame)
                button.tag = index
                addSubview(button)
                button.addTarget(self, action: #selector(self.selectItem(_:)), for: .touchUpInside)
                currentPoint = CGPoint(x: currentPoint.x + sizeItem.width, y: 0)
            } else {
                let view = UIView()
                view.frame = CGRect(origin: currentPoint, size: sizeItem)
                view.isUserInteractionEnabled = true
                view.tag = index
                addSubview(view)
                
                let label = UILabel(frame: view.bounds)
                label.textAlignment = .center
                label.text = "Item: \(index)"
                view.addSubview(label)
                let button = UIButton(frame: view.frame)
                button.tag = index
                addSubview(button)
                button.addTarget(self, action: #selector(self.selectItem(_:)), for: .touchUpInside)
                currentPoint = CGPoint(x: currentPoint.x + sizeItem.width, y: 0)
            }
        }
    }
    
    @objc func selectItem(_ sender: UIButton) {
        delegate?.didSelectItemInTabbar(index: sender.tag)
    }
    
    func setbaget(index: Int, value: Int) {
        if index < numberItem {
            
        }
    }
}

extension TabbarCustomDatasource {
    func sizeForItemInTabbar(index: Int) -> CGSize {
        return CGSize.zero
    }
    
    func viewForItemInTabbar(index: Int, isSelect: Bool) -> UIView? {
        return nil
    }
}

extension TabbarCustomDelegate {
    func didSelectItemInTabbar(index: Int) {
        
    }
}
