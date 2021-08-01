//
//  RatingControl.swift
//  Food Tracker
//
//  Created by student on 1/28/21.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
//MARK : Properties
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 40.0, height: 40.0){
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
//MARK : Initialization
    override init(frame : CGRect){
        super.init(frame:frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder:coder)
        setupButtons()
    }
//MARK : Button action
    @objc func ratingButtonTapped(button : UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
//MARK : Private Methods
    private func setupButtons(){
        
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        //creating the buttons
        for index in 0..<starCount {
            //create the button
            let button = UIButton()
            //button.backgroundColor = UIColor.red
            // Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])    			
            //Constraints
            button.translatesAutoresizingMaskIntoConstraints = false;
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //accesibility
            button.accessibilityLabel = "Set \(index + 1) star rating"
            //action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            //Add to stack
            addArrangedSubview(button)
            
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
            //hint string
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            }
            else {
                hintString = nil
            }
            //calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set"
            }
            //assigning
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
    
    
    
    
    
}
