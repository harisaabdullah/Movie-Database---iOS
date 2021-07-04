//
//  Job_Interview_ProjectTests.swift
//  Job Interview ProjectTests
//
//  Created by Haris Abdullah on 6/30/21.
//

import XCTest
@testable import Job_Interview_Project

class Job_Interview_ProjectTests: XCTestCase {

    
    func testOutletsAttachedProperly(){
        let viewController = getPopularViewController()
        XCTAssertNotNil(viewController.tableView)
    }
    
    func testDelegatesAttachedProperly(){
        let viewController = getPopularViewController()
        XCTAssertNotNil(viewController.viewModel.delegate)
    }
    func getPopularViewController() -> PopularMoviesListViewController{
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "PopularMoviesListViewController") as! PopularMoviesListViewController
        viewController.loadViewIfNeeded()
        return viewController
    }
    
    
}
