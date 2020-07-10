//
//  CardsController.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class CardsController: UIView {
    public weak var dataSource: CardsControllerDataSource?
    private var heightOffsetOfCards: CGFloat = 70
    private let numberOfVisibleCards = 3
    private var visibleCards:[CardView] = []

    private var panGesture: UIPanGestureRecognizer?

    override func draw(_ rect: CGRect) {
        if let pan = panGesture {
            removeGestureRecognizer(pan)
        }
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        self.panGesture = panGesture
        addGestureRecognizer(panGesture)
        createAllCards()
    }

    private var previousIndex: Int = 0
    private var _index: Int = 0
    private var index: Int {
        get {
            return  _index
        }
        set {
            if newValue == _index {
                return
            }
            let rows = dataSource?.numberOfRows() ?? 0
            if newValue < max(-2, visibleCards.count * -1) {
                direction = .downOnly
                return
            } else if newValue > rows - numberOfVisibleCards {
                if (rows >= numberOfVisibleCards) || rows == 2 && newValue > 0 || rows == 1 {
                    direction = .upOnly
                    return
                }
            }
            direction = .upDown
            previousIndex = _index
            _index = newValue
            updateVisibleCards()
        }
    }

    fileprivate func createAllCards() {
        guard let dataSource = dataSource else {
            return
        }

        for i in index ..< index + min(numberOfVisibleCards, dataSource.numberOfRows()) {
            let card = dataSource.cardForIndex(i)
            card.frame = CGRect(x: 0, y: heightOffsetOfCards + (CGFloat(i) * heightOffsetOfCards), width: frame.width, height: frame.height)
            visibleCards.append(card)
            addSubview(card)
        }
    }

    func reloadData() {
        for cards in visibleCards {
            cards.removeFromSuperview()
        }
        visibleCards = []
        createAllCards()
    }

    fileprivate func updateVisibleCards() {
        guard let dataSource = dataSource else  {
            return
        }

        if index > previousIndex {
            let dsIndex: Int
            if index > 0 {
                visibleCards.removeFirst().removeFromSuperview()
            }
            if index <= 0 {
                dsIndex = previousIndex + dataSource.numberOfRows()
            } else {
                dsIndex = previousIndex + numberOfVisibleCards
            }
            let card = dataSource.cardForIndex(dsIndex)
            card.fromTop = false
            addSubview(card)
            visibleCards.append(card)
        } else {
            visibleCards.removeLast().removeFromSuperview()
            if index >= 0 {
                let card = dataSource.cardForIndex(index)
                card.fromTop = true
                addSubview(card)
                sendSubviewToBack(card)
                visibleCards.insert(card, at: 0)
            }
        }

        if visibleCards.count == 1 {
            return
        }
        for i in 0 ..< visibleCards.count {
            let card = visibleCards[i]
            card.frame = CGRect(x: 0, y: heightOffsetOfCards + (CGFloat(i) * heightOffsetOfCards), width: frame.width, height: frame.height)
        }
    }

    private var initalPoint: CGPoint?
    private var direction: ScrollDirection = .upDown
    @objc func handleSwipe(_ panGesture: UIPanGestureRecognizer) {
        var velocity = abs(panGesture.velocity(in: self).y)
        if velocity > 8{
            velocity = 8
        }

        let translation = panGesture.translation(in: self)
        if panGesture.state == .began {
            initalPoint = translation
        }
        let direction: CGFloat = (initalPoint?.y ?? translation.y) - translation.y > 0 ? -1 : 1
        if Int(direction) == self.direction.rawValue {
            return
        }

        var cardsCopy: [CardView] = []
        cardsCopy.append(contentsOf: visibleCards)

        for card in cardsCopy {
            let oldFrame = card.frame
            let newY = oldFrame.minY + (direction * velocity)

            UIView.animate(withDuration: 0.5) {
                card.frame = CGRect(x: oldFrame.minX, y: newY, width: oldFrame.width, height: oldFrame.height)
            }
        }

        if (visibleCards.first?.frame.minY ?? frame.height)/2 < 0 {
            index += 1
        } else if (visibleCards.last?.frame.minY ?? 0) > frame.height/2 {
            index -= 1
        }
    }
}

fileprivate enum ScrollDirection: Int {
    case upDown = 0
    case upOnly = -1
    case downOnly = 1
}
