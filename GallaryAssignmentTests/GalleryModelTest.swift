import XCTest
@testable import GallaryAssignment

class GalleryModelTest: XCTestCase {
    func testMapGalleryResponse() {
        let galleryResponse: Array<GalleryResponse> = [GalleryResponse(id: 1032485439,
                                               name: "Springtime",
                                               positiveVotesCount: 4264,
                                               description: "Berlin. Reinhardtstraße 58",
                                               imageUrls: ["https://drscdn.500px.org/photo/1032485078/q%3D50_h%3D450/v2?sig=18d048a2655fc3fda0a900db123edbaea13455efa1f1bffa45f43f10cf9f49c9"]),
                               GalleryResponse(id: 1032485439,
                                               name: "Springtime",
                                               positiveVotesCount: 4264,
                                               description: "Berlin. Reinhardtstraße 58",
                                               imageUrls: ["https://drscdn.500px.org/photo/1032485078/q%3D50_h%3D450/v2?sig=18d048a2655fc3fda0a900db123edbaea13455efa1f1bffa45f43f10cf9f49c9"])]
        let galleryList = GalleryListResponse(currentPage: 1, totalPage: 2, photos: galleryResponse)
        let model = GalleryModel().toModel(galleryListResponse: galleryList)
        XCTAssertEqual(model?.currentPage, 1)
        XCTAssertEqual(model?.totalPage, 2)
        XCTAssertEqual(model?.photos.count, 2)
        XCTAssertEqual(model?.photos[0].imageUrl, galleryResponse[0].imageUrls?[0])
    }
    
    func testMapGalleryResponseWithNoImage() {
        let galleryResponse: Array<GalleryResponse> = [GalleryResponse(id: 1032485439,
                                               name: "Springtime",
                                               positiveVotesCount: 4264,
                                               description: "Berlin. Reinhardtstraße 58",
                                               imageUrls: [])]
        let galleryList = GalleryListResponse(currentPage: 1, totalPage: 2, photos: galleryResponse)
        let model = GalleryModel().toModel(galleryListResponse: galleryList)
        XCTAssertEqual(model?.photos.count, 1)
        XCTAssertEqual(model?.photos[0].imageUrl, nil)
    }
    
}
