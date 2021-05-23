import XCTest
@testable import GallaryAssignment

class GallaryAssignmentTests: XCTestCase {
    func testGetGalleryServiceSuccessShouldReturnGalleryModel() {
        let galleryService = MockGalleryService()
        let viewModel = GalleryViewModel(galleryService: galleryService)
        XCTAssertEqual(viewModel.galleryModel?.count, 1)
        XCTAssertTrue(viewModel.errorModel == nil)
        
    }
    
    func testGetGalleryServiceFailShouldReturnErrorModel() {
        let galleryService = MockGalleryServiceFail()
        let viewModel = GalleryViewModel(galleryService: galleryService)
        XCTAssertEqual(viewModel.galleryModel, nil)
        XCTAssertEqual(viewModel.errorModel?.title, "Sorry")
        XCTAssertEqual(viewModel.errorModel?.message, "Internal server error, please try again later")
    }
    
    func testWhenCreateGalleryViewModelShouldCallGetGallery() {
        let galleryService = MockGalleryServiceFail()
        let galleryViewModel = MockGalleryViewModel(galleryService: galleryService)
        XCTAssertEqual(galleryViewModel.countCallGallery, 1)
    }
    
}

