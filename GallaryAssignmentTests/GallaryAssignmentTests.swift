import XCTest
@testable import GallaryAssignment

class GallaryAssignmentTests: XCTestCase {
    func testWhenGetGalleryServiceSuccessShouldReturnGalleryModel() {
        let galleryService = MockGalleryService()
        let viewModel = GalleryViewModel(galleryService: galleryService)
        XCTAssertEqual(viewModel.galleryModel?.count, 1)
        XCTAssertTrue(viewModel.errorModel == nil)
        
    }
    
    func testWhenGetGalleryServiceFailShouldReturnErrorModel() {
        let galleryService = MockGalleryServiceFail()
        let viewModel = GalleryViewModel(galleryService: galleryService)
        XCTAssertTrue(viewModel.galleryModel ==  nil)
        XCTAssertEqual(viewModel.errorModel?.title, "Sorry")
        XCTAssertEqual(viewModel.errorModel?.message, "Internal server error, please try again later")
    }

}

