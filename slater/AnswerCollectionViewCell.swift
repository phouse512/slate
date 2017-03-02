//
//  AnswerCollectionViewCell.swift
//  slater
//
//  Created by Philip House on 2/18/17.
//  Copyright © 2017 phizzle. All rights reserved.
//

import UIKit

class AnswerCollectionViewCell: BaseCell {
    
    var answer: Answer? {
        didSet {
            answerLabel.text = answer?.text
        }
    }
    
    let answerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cleveland Cavaliers"
        label.numberOfLines = 2
        label.backgroundColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        return label
    }()
    
    let icon: UIView = {
        let icon = UIView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.layer.borderWidth = 2
        icon.layer.cornerRadius = 7
        icon.layer.borderColor = UIColor.blue.cgColor
        icon.backgroundColor = UIColor.white
        return icon
    }()

    
//    override var isHighlighted: Bool {
//        didSet {
//            answerLabel.backgroundColor = isHighlighted ? UIColor.green : UIColor.white
//        }
//    }
    
    override var isSelected: Bool {
        didSet {
            self.layer.borderWidth = isSelected ? 4 : 0
            self.layer.borderColor = icon.layer.borderColor
        }
    }
    
    
    
    override func setupViews() {
        super.setupViews()
        setupView()
        
        backgroundColor = UIColor.white
        layer.cornerRadius = 5
    }
    
    func setupView() {
        addSubview(answerLabel)
        addSubview(icon)
        
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: answerLabel)
        addConstraintsWithFormat(format: "H:[v0(20)]-10-|", views: icon)
        addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: answerLabel)
        addConstraintsWithFormat(format: "V:|-10-[v0(20)]", views: icon)
    }
}

class SquareUI: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView(frame: frame)
        addSubview(imageView)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
        let imageSize = CGSize(width: frame.width, height: frame.height)
        

        
        let image = drawCustomImage(size: imageSize)
        imageView.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawCustomImage(size: CGSize) -> UIImage? {
        print("here")
        let bounds = CGRect(origin: CGPoint.zero, size: size)
        let opaque = false
        let scale = CGFloat(0.0)
        
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        print("made it")
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(2.0)
        
        context.beginPath()
        context.move(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        context.addLine(to: CGPoint(x: bounds.minX, y: bounds.minY))
        context.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
        
    }
}
