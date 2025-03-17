//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Srdjan Dobrota on 16.3.25..
//

import XCTest
@testable import Weather

final class WeatherTests: XCTestCase {
    
    let expectedInitialIds = "5391959,5128638,5780993"
    let expectedIdsAfterSelection = "5391959,5128638,5780993,2643743"
    let expectedIdsUnselect = "5128638,5780993"
    
    var weatherListViewModel: WeatherListViewModel!
    
    override func setUp() {
        super.setUp()
        
        weatherListViewModel = WeatherListViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialCityIds() {
        XCTAssertEqual(weatherListViewModel.getIDsFromCities(), expectedInitialIds)
    }
    
    func testSelectionCityIds() {
        weatherListViewModel.citiesArray[3].isSelected = true
        XCTAssertEqual(weatherListViewModel.getIDsFromCities(), expectedIdsAfterSelection)
    }
    
    func testUnselect() {
        weatherListViewModel.citiesArray[0].isSelected = false
        XCTAssertEqual(weatherListViewModel.getIDsFromCities(), expectedIdsUnselect)
    }
}
