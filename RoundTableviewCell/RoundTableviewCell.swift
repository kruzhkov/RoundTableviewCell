//
//  RoundTableviewCell.swift
//  RoundTableviewCell
//
//  Created by ChenHao on 12/31/15.
//  Copyright © 2015 HarriesChen. All rights reserved.
//

import UIKit

@IBDesignable
public class RoundTableviewCell: UITableViewCell {

    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
        }
    }
    
    @IBInspectable var roundBackgroundColor: UIColor = UIColor(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1) {
        didSet {
        }
    }
    
    @IBInspectable var roundFrontColor: UIColor = UIColor.whiteColor() {
        didSet {
        }
    }
    
    @IBInspectable var selectedColor: UIColor = UIColor.grayColor() {
        didSet {
        }
    }

    let Margin: CGFloat = 20
    let shapeLayer = CAShapeLayer()
    let lineLayer = CALayer()
    let roundContentView: UIView = UIView()
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .None
        contentView.addSubview(roundContentView)
        roundContentView.translatesAutoresizingMaskIntoConstraints = false
        // align roundContentView from the left and right
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[view]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": roundContentView]));
        
        // align roundContentView from the top and bottom
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": roundContentView]));
        self.contentView.backgroundColor = roundBackgroundColor
    }

    override public func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setNeedsDisplay()
    }
    
    override public func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        setNeedsDisplay()
    }
    
    override public func didMoveToSuperview() {
        if let tableView = getTableview() {
            tableView.separatorStyle = .None
        }
    }
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        var pathRef: CGMutablePathRef = CGPathCreateMutable()
        var addLine = false
        if let tableview = getTableview(),
            let indexPath = tableview.indexPathForCell(self) {
                if indexPath.row == 0 && tableview.numberOfRowsInSection(indexPath.section) == 1 {
                    pathRef = CreateBothCornerPath()
                } else if indexPath.row == 0 {
                    pathRef = CreateTopCornerPath()
                } else if indexPath.row == tableview.numberOfRowsInSection(indexPath.section) - 1 {
                    pathRef = CreateBottomCornerPath()
                    addLine = true
                } else {
                    pathRef = CreateNoneCornerPath()
                    addLine = true
                }
        }
        
        if (addLine == true) {
            let lineHeight: CGFloat = (1.0 / UIScreen.mainScreen().scale)
            lineLayer.frame = CGRectMake(Margin + 20, lineHeight, bounds.size.width - 60, -lineHeight)
            lineLayer.backgroundColor = UIColor.grayColor().CGColor
            self.layer.addSublayer(lineLayer)
        } else {
            lineLayer.removeFromSuperlayer()
        }
        
        shapeLayer.path = pathRef
        self.contentView.layer.insertSublayer(shapeLayer, atIndex: 0)
        if selected || highlighted {
            shapeLayer.fillColor = selectedColor.CGColor
        } else {
            shapeLayer.fillColor = roundFrontColor.CGColor
        }
    }
    
    func getTableview() -> UITableView? {
        if let view = superview as? UITableView {
            return view
        } else {
            return superview?.superview as? UITableView
        }
    }

}

extension RoundTableviewCell {
    func CreateTopCornerPath() -> CGMutablePathRef {
        let pathRef: CGMutablePathRef = CGPathCreateMutable()
        
        let height = self.frame.height
        let width = self.frame.width
        
        CGPathMoveToPoint(pathRef, nil, Margin, height)
        CGPathAddLineToPoint(pathRef, nil, Margin, cornerRadius)
        CGPathAddArc(pathRef, nil, Margin + cornerRadius, cornerRadius, cornerRadius, CGFloat(M_PI), CGFloat(3/2.0 * M_PI), false)
        CGPathAddLineToPoint(pathRef, nil, width - Margin - cornerRadius, 0)
        CGPathAddArc(pathRef, nil, width - Margin - cornerRadius,cornerRadius, cornerRadius, CGFloat(3/2 * M_PI), CGFloat(2.0 * M_PI), false)
        CGPathAddLineToPoint(pathRef, nil, width - Margin, height)
        CGPathAddLineToPoint(pathRef, nil, Margin, height)
        return pathRef
    }
    
    func CreateBottomCornerPath() -> CGMutablePathRef {
        let pathRef: CGMutablePathRef = CGPathCreateMutable()
        
        let height = self.frame.height
        let width = self.frame.width
        CGPathMoveToPoint(pathRef, nil, Margin, 0)
        CGPathAddLineToPoint(pathRef, nil, width - Margin, 0)
        CGPathAddLineToPoint(pathRef, nil, width - Margin, height - cornerRadius)
        CGPathAddArc(pathRef, nil, width - Margin - cornerRadius, height - cornerRadius, cornerRadius, 0, CGFloat(1/2.0 * M_PI), false)
        CGPathAddLineToPoint(pathRef, nil, Margin, height)
        CGPathAddArc(pathRef, nil, Margin + cornerRadius, height - cornerRadius, cornerRadius, CGFloat(1/2 * M_PI), CGFloat(M_PI), false)
        CGPathAddLineToPoint(pathRef, nil, Margin, 0)
        return pathRef
    }
    
    func CreateBothCornerPath() -> CGMutablePathRef {
        let pathRef: CGMutablePathRef = CGPathCreateMutable()
        
        let height = self.frame.height
        let width = self.frame.width
        
        CGPathMoveToPoint(pathRef, nil, Margin, height - cornerRadius)
        CGPathAddLineToPoint(pathRef, nil, Margin, cornerRadius)
        CGPathAddArc(pathRef, nil, Margin + cornerRadius, cornerRadius, cornerRadius, CGFloat(M_PI), CGFloat(3/2.0 * M_PI), false)
        CGPathAddLineToPoint(pathRef, nil, width - Margin - cornerRadius, 0)
        CGPathAddArc(pathRef, nil, width - Margin - cornerRadius,cornerRadius, cornerRadius, CGFloat(3/2 * M_PI), CGFloat(2.0 * M_PI), false)
        CGPathAddLineToPoint(pathRef, nil, width - Margin, height - cornerRadius)
        CGPathAddArc(pathRef, nil, width - Margin - cornerRadius, height - cornerRadius, cornerRadius, 0, CGFloat(1/2.0 * M_PI), false)
        CGPathAddLineToPoint(pathRef, nil, Margin + cornerRadius, height)
        CGPathAddArc(pathRef, nil, Margin + cornerRadius, height - cornerRadius, cornerRadius, CGFloat(1/2 * M_PI), CGFloat(M_PI), false)
        return pathRef
    }
    
    func CreateNoneCornerPath() -> CGMutablePathRef {
        let pathRef: CGMutablePathRef = CGPathCreateMutable()
        let height = self.frame.height
        let width = self.frame.width
        CGPathMoveToPoint(pathRef, nil, Margin, 0)
        CGPathAddLineToPoint(pathRef, nil, width - Margin, 0)
        CGPathAddLineToPoint(pathRef, nil, width - Margin, height)
        CGPathAddLineToPoint(pathRef, nil, Margin, height)
        CGPathAddLineToPoint(pathRef, nil, Margin, 0)
        return pathRef
    }
}