//
//  CardView.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

@IBDesignable
public class CardView: UIView {

    let titleLabel = UILabel()
    let timeLabel = UILabel()
    let ownerLabel = UILabel()
    let viewLayer = CAShapeLayer()
    let contentView = UIView()

    func setupView() {
        self.contentView.addSubview(titleLabel)

        self.contentView.addSubview(timeLabel)

        self.contentView.addSubview(ownerLabel)

        self.timeLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 20)
        self.timeLabel.textAlignment = .center
        self.timeLabel.alpha = 1

        self.titleLabel.frame = CGRect(x: 0, y: 16, width: self.frame.width, height: 30)
        self.titleLabel.textAlignment = .center
        self.titleLabel.alpha = 1

        self.ownerLabel.frame = CGRect(x: 0, y: 36, width: self.frame.width, height: 30)
        self.ownerLabel.textAlignment = .center
        self.ownerLabel.alpha = 1
    }

    func removeContent() {
        UIView.animate(withDuration: 0.1, animations: {
            self.titleLabel.alpha = 0
            self.ownerLabel.alpha = 0
            self.timeLabel.alpha = 0
        }) { (completion) in
            self.titleLabel.removeFromSuperview()
            self.timeLabel.removeFromSuperview()
            self.ownerLabel.removeFromSuperview()
        }
    }

    @IBInspectable public var fillColor: UIColor = .white

    var fromTop = true

    public override func draw(_ rect: CGRect) {

        viewLayer.frame = rect
        let path = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        let square = UIBezierPath(roundedRect: path, cornerRadius: 20)
        contentView.frame = path

        viewLayer.path = square.cgPath
        viewLayer.fillColor = fillColor.cgColor

        self.addSubview(contentView)
        self.contentView.layer.addSublayer(viewLayer)
        if fromTop {
            appearingAnimationFromTop()
        } else {
            appearingAnimationFromBottom()
        }
    }


    func appearingAnimationFromTop() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.setupView()
        }
        let duration = CFTimeInterval(0.3)
        let originalPos = viewLayer.position

        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.fromValue = [self.frame.midX, self.frame.minY - self.frame.height]
        positionAnimation.toValue = originalPos
        positionAnimation.duration = duration
        positionAnimation.isRemovedOnCompletion = false
        positionAnimation.fillMode = .forwards
        viewLayer.add(positionAnimation, forKey: "positionTop")

        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = Double.pi/4
        rotationAnimation.toValue = 0
        rotationAnimation.duration = duration

        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = 0
        alphaAnimation.toValue = 1
        alphaAnimation.duration = duration + 1
        viewLayer.add(alphaAnimation, forKey: "alphaAnimationTop")
        CATransaction.commit()
    }

    func appearingAnimationFromBottom() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.setupView()
        }
        let duration = CFTimeInterval(0.4)
        let originalPos = viewLayer.position

        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.fromValue = [self.frame.midX, self.frame.maxY]
        positionAnimation.toValue = originalPos
        positionAnimation.duration = duration
        positionAnimation.isRemovedOnCompletion = false
        positionAnimation.fillMode = .forwards
        viewLayer.add(positionAnimation, forKey: "positionBot")
        CATransaction.commit()
    }

    func removingFromBottom() {
        self.removeContent()
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            super.removeFromSuperview()
        }
        let duration = CFTimeInterval(0.4)
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.toValue = [self.frame.midX, self.frame.maxY]
        positionAnimation.duration = duration
        positionAnimation.isRemovedOnCompletion = false
        positionAnimation.fillMode = .forwards
        viewLayer.add(positionAnimation, forKey: "positionBotRemove")
        CATransaction.commit()
    }

    func removingFromTop() {
        self.removeContent()
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            super.removeFromSuperview()
        }
        let duration = CFTimeInterval(0.4)
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.toValue = [self.frame.midX, -self.frame.height]
        positionAnimation.duration = duration
        positionAnimation.isRemovedOnCompletion = false
        positionAnimation.fillMode = .forwards
        viewLayer.add(positionAnimation, forKey: "positionTopRemove")

        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = 1
        alphaAnimation.toValue = 0
        alphaAnimation.duration = duration
        viewLayer.add(alphaAnimation, forKey: "alphaAnimationTopRemove")
        CATransaction.commit()
    }

    public override func removeFromSuperview() {
        if fromTop {
            removingFromTop()
        } else {
            removingFromBottom()
        }
    }
}
