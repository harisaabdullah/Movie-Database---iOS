//
//  MoviesDetailTestViewController.swift
//  Job Interview ProjectTests
//
//  Created by Haris Abdullah on 7/4/21.
//

import XCTest
@testable import Job_Interview_Project

class MoviesDetailTestViewController: XCTestCase{
    
    
    func testOutletsAttachedProperly(){
        let viewController = getMovieDetailViewController()
        XCTAssertNotNil(viewController.dateLabel)
        XCTAssertNotNil(viewController.genresLabel)
        XCTAssertNotNil(viewController.movieTitleLabel)
        XCTAssertNotNil(viewController.overviewLabel)
        XCTAssertNotNil(viewController.popularMovieImageView)
    }
    
    func testDelegatesAttachedProperly(){
        let viewController = getMovieDetailViewController()
        XCTAssertNotNil(viewController.viewModel.delegate)
        XCTAssertNotNil(viewController.viewModelVideos.delegate)
    }
    func getMovieDetailViewController() -> MovieDetailViewController{
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        viewController.loadViewIfNeeded()
        return viewController
    }
}
