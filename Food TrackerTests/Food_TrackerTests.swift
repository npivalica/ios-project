//
//  Food_TrackerTests.swift
//  Food TrackerTests
//
//  Created by student on 1/21/21.
//

import XCTest
@testable import Food_Tracker

class Food_TrackerTests: XCTestCase {

//MARK : Meal Class Tests
//new test case, vraca meal object kada mu se proslede ispravni parametri
    func testMealInitializationSucceeds() {
        //nula rejting
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        //maksimum rejting
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
// new test case, vraca nil kadas se posalje negativna ocena ili prazno ime
    func testMealInitializationFails() {
        //negativna ocena
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        //ocena preko maksimuma
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
        
        //prazan string
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
    }

}
