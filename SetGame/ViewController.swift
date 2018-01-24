//
//  ViewController.swift
//  SetGame
//
//  Created by wesam Khallaf on 1/10/18.
//  Copyright © 2018 wesam Khallaf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
     let setCardDesk:SetCardDeck = SetCardDeck()
    
    
     var selectedViews :[SetCardView] = [SetCardView]()
    
     var numberOfViewsWithBorderLine = 0
    var ScoreValue : Double = 0.0 {
        didSet {
            self.scoreLabel.text = ("Score = \(ScoreValue)")
        }
    }
    
     lazy var animator = UIDynamicAnimator(referenceView: view)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        replaceMatchedCard.isEnabled = false
        
        let  hiddenViewClosure : (_ :UIView) -> Void = { view in
            
            if let view = view as? SetCardView
            {
                view.isFaceUp = false
                view.isHidden = true
            }
            
        }
        
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.6,
                                                       delay: 0.1,
                                                       options: [.beginFromCurrentState , .curveEaseInOut],
                                                       animations: { [weak self ]  in
                                                        self?.firstRow.subviews.forEach { self?.configerureView($0) }
                                                         self?.secondRow.subviews.forEach {  self?.configerureView($0) }
                                                         self?.thirdRow.subviews.forEach {  self?.configerureView($0) }
                                                         self?.fourthRow.subviews.forEach(hiddenViewClosure)
                                                         self?.fifthRow.subviews.forEach(hiddenViewClosure)
                                                         self?.sixthRow.subviews.forEach(hiddenViewClosure)
        },
                                                       completion: nil)
        
        
        /*
        firstRow.subviews.forEach { configerureView($0) }
        secondRow.subviews.forEach { configerureView($0) }
        thirdRow.subviews.forEach { configerureView($0) }
        fourthRow.subviews.forEach(hiddenViewClosure)
        fifthRow.subviews.forEach(hiddenViewClosure)
        sixthRow.subviews.forEach(hiddenViewClosure)
 */
        
    }
    
    private func configerureView (_ aView : UIView)
    {
        
        
        if let view = aView as? SetCardView
            
        {
        view.isFaceUp = true
        
        let card = setCardDesk.drawCard()
        print("the number of the card is \(card.number)")
        view.color = card.colour
        view.symbolAdapter = card.shape
        view.shaddingAdapter = card.shadding
        
        view.number = card.number
            
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector (self.handleTap(_:))))
        }
        
        }
    
   @objc private func handleTap(_ sender :UITapGestureRecognizer) {
    
    
    if sender.view?.alpha == 1 {
    
    if self.numberOfViewsWithBorderLine == 3
    {
        self.removeSelectionfromAllViews()
    }
    
    if let  view = sender.view as? SetCardView
        {
        
      
        view.layer.borderColor = UIColor.cyan.cgColor
        view.layer.borderWidth = 3.0
            self.selectedViews.append(view)
               if self.selectedViews.count == 3
            {
                checkMathchedAndUpdateScoreWithView(view)
                
            }
              else {self.numberOfViewsWithBorderLine = 0 }
        }
      }
    }
    
   private func checkMathchedAndUpdateScoreWithView(_ view:SetCardView){
        
    if succeededSelection(view: view  ) {
    view.layer.borderColor = UIColor.green.cgColor
        self.numberOfViewsWithBorderLine = 3
        
        self.ScoreValue += 10.0
        
        replaceMatchedCard.isEnabled = true
        
        for setCardView in self.selectedViews {
            
            // here we can add animation
            setCardView.alpha = 0.5
        }
        
      }
    else {
        view.layer.borderColor = UIColor.red.cgColor
        self.numberOfViewsWithBorderLine = 3
        self.ScoreValue -= 5.0
       
        
    }
     self.selectedViews.removeAll()
    
    
    }
    
    private func succeededSelection(view  thirdView: SetCardView ) ->Bool
    {
       
 
        
        var matchedNumber : Bool = false
        var matchedColor : Bool = false
        var matchedSymbol: Bool = false
        var matchedShade : Bool = false
        
        // check required number
        if self.selectedViews[0].number == self.selectedViews[1].number
        {
            if thirdView.number == self.selectedViews[0].number
            {
                matchedNumber = true
                
                
            }
        }
        
        if self.selectedViews[0].number != self.selectedViews[1].number
        {
            if (thirdView.number != self.selectedViews[0].number && thirdView.number != self.selectedViews[1].number)
            {
                matchedNumber = true
                
            }
        }
        
        // shadding
        
        if self.selectedViews[0].shaddingAdapter == self.selectedViews[1].shaddingAdapter
        {
            if thirdView.shaddingAdapter == self.selectedViews[0].shaddingAdapter
            {
                matchedShade = true
                
            }
        }
        
        if self.selectedViews[0].shaddingAdapter != self.selectedViews[1].shaddingAdapter
        {
            if (thirdView.shaddingAdapter != self.selectedViews[0].shaddingAdapter && thirdView.shaddingAdapter != self.selectedViews[1].shaddingAdapter)
            {
                matchedShade = true
                
            }
        }
        
        // symbole
        if self.selectedViews[0].symbolAdapter == self.selectedViews[1].symbolAdapter
        {
            if thirdView.symbolAdapter == self.selectedViews[0].symbolAdapter
            {
                matchedSymbol = true
                
            }
        }
        
        if self.selectedViews[0].symbolAdapter != self.selectedViews[1].symbolAdapter
        {
            if (thirdView.symbolAdapter != self.selectedViews[0].symbolAdapter && thirdView.symbolAdapter != self.selectedViews[1].symbolAdapter)
            {
                matchedSymbol = true
                
            }
        }
        // color
        
        if self.selectedViews[0].color == self.selectedViews[1].color
        {
            if thirdView.color == self.selectedViews[0].color
            {
                matchedColor = true
                
            }
        }
        
        if self.selectedViews[0].color != self.selectedViews[1].color
        {
            if (thirdView.color != self.selectedViews[0].color && thirdView.color != self.selectedViews[1].color)
            {
                matchedColor = true
                
                
                
            }
        }
        
        
        if ( matchedColor && matchedSymbol && matchedShade && matchedNumber == true) {
            return true
        }
        
        
        
            
       
        
        
        
        
        return false
    }
    
    
    private func removeSelectionfromAllViews()
    
    {
        //var i = 0
        for view in self.view.subviews
        {
            
            for subView in view.subviews
            {
                
                for setView in subView.subviews {
                
                
                 print (" border width is \(subView.layer.borderWidth) \n")
                if setView.layer.borderWidth != 1.0
                {
                    print (" detected border width")
                    setView.layer.borderColor = UIColor.clear.cgColor
                    setView.layer.borderWidth = 1.0
                }
            
              }
           }
        }
        
       // print (" no of subViews is \(i) ")
        
    }

    
    @IBAction func drawNewCards(_ sender: UIButton)
   
    
   
    {
        
        
        let hiddenViews = findAvailableHiddenCaerdView()
        
        if hiddenViews.count < 3 {
            sender.isEnabled = false
        }
        
        else {
        for i in 0...3 {
            /*
            
             UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.6,
                                                            delay: 0.1,
                                                            options: [.beginFromCurrentState , .curveEaseInOut ,.transitionFlipFromTop],
                                                            animations: { hiddenViews[i].isHidden = false
                                                                           self.configerureView(hiddenViews[i])
                                                                
             },
                                                            completion: nil)
         */
           //
            /*
            let snapBehaviour = UISnapBehavior(item: hiddenViews[i], snapTo: hiddenViews[i].frame.origin)
                snapBehaviour.damping = 0.5
                animator.addBehavior(snapBehaviour)
            
            //snapBehaviour.add
            self.configerureView(hiddenViews[i])
 */
            
            
         
          UIView.transition(with: hiddenViews[i]
            , duration: 0.6
            , options: [.transitionFlipFromLeft]
            , animations: {
                hiddenViews[i].isHidden = false
                //snapBehaviour.add
                self.configerureView(hiddenViews[i])
          }, completion: nil)
          
            hiddenViews[i].isHidden = false
            hiddenViews[i].setNeedsDisplay()
            
             }
        
        }
        
    }
   
    
    private func findAvailableHiddenCaerdView() -> [SetCardView]
    {
     
        var setcardViewArray = [SetCardView]()
     
     
            for view  in fourthRow.subviews
            {
                if let setView = view as? SetCardView
                {
     
                    if  view.isHidden == true  { setcardViewArray.append(setView) }
     
     
                  }
           }
        
        
        
        for view  in fifthRow.subviews
        {
            if let setView = view as? SetCardView
            {
     
                if  view.isHidden == true  { setcardViewArray.append(setView) }
     
     
            }
        }
        for view  in sixthRow.subviews
        {
            if let setView = view as? SetCardView
            {
     
                if  view.isHidden == true  { setcardViewArray.append(setView) }
     
     
            }
        }
     
     
   
        return setcardViewArray
    }

    @IBAction func replaceMatched(_ sender: UIButton)
    {
        
        
        
        for view in self.view.subviews
        {
            
            for subView in view.subviews
            {
                
                for setView in subView.subviews {
                    //i += 1
                    
                    if let setViewcard =  setView as? SetCardView {
                    if setView.alpha != 1
                    {
                        // here add animation
                        
                        setViewcard.isFaceUp = true
                        
                        let card = setCardDesk.drawCard()
                        setViewcard.number = card.number
                        setViewcard.color = card.colour
                        setViewcard.symbolAdapter = card.shape
                        setViewcard.shaddingAdapter = card.shadding
                        setViewcard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector (self.handleTap(_:))))
                        
                        setViewcard.alpha = 1
                        sender.isEnabled = false
                    }
                }
            }
            }
        }
        
        if setCardDesk.cards.count == 0 {
            
            sender.setTitle("No more Cards", for: .normal)
            sender.isEnabled = false
            
        }
       
        
        
    }
    
    
    @IBOutlet weak var replaceMatchedCard: UIButton!
    
    @IBOutlet weak var firstRow: UIStackView!
    
    @IBOutlet weak var secondRow: UIStackView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var thirdRow: UIStackView!
    
    @IBOutlet weak var fourthRow: UIStackView!
    @IBOutlet weak var fifthRow: UIStackView!
    
    @IBOutlet weak var sixthRow: UIStackView!
    
    
}




