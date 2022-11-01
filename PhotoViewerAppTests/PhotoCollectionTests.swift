//
//  PhotoCollectionTests.swift
//  PhotoViewerAppTests
//
//  Created by Przemek on 01/11/2022.
//

import XCTest
@testable import PhotoViewerApp

final class PhotoCollectionTests: XCTestCase {
    var viewModel: PhotoCollectionViewModel!

    override func setUpWithError() throws {
        viewModel = PhotoCollectionViewModel(photoManager: MockPhotoManager())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testFetchPhotos() throws {
        XCTAssertEqual(viewModel.photosCount, 0)
        viewModel.fetchPhotos()
        XCTAssertEqual(viewModel.photosCount, 2)
    }
    
    func testGetPhoto() throws {
        viewModel.fetchPhotos()
        let asset = viewModel.getPhoto(at: 0)
        XCTAssertNotNil(asset)
    }
    func testFetchAsset() throws {
        viewModel.fetchPhotos()
        var nilableImage: UIImage?
        viewModel.fetchImageAsset(0, contentMode: .aspectFit, targetSize: nil, options: nil) { image in
             nilableImage = image
        }
        XCTAssertNotNil(nilableImage)
    }

}
