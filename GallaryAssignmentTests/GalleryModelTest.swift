import XCTest
@testable import GallaryAssignment

class GalleryModelTest: XCTestCase {
    func testWhenMapGalleryResponseShouldReturnCorrectGalleryModel() {
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
        let model = GalleryModel().toModel(galleryPhotos: galleryList.photos ?? [], offset: 0)
        XCTAssertEqual(model.count, 2)
        XCTAssertEqual((model[0] as! Gallery).imageUrl, galleryResponse[0].imageUrls?[0])
    }
    
    func testWhenMapGalleryResponseWithNoImageShouldReturnNilImage() {
        let galleryResponse: Array<GalleryResponse> = [GalleryResponse(id: 1032485439,
                                                                       name: "Springtime",
                                                                       positiveVotesCount: 4264,
                                                                       description: "Berlin. Reinhardtstraße 58",
                                                                       imageUrls: [])]
        let galleryList = GalleryListResponse(currentPage: 1, totalPage: 2, photos: galleryResponse)
        let model = GalleryModel().toModel(galleryPhotos: galleryList.photos ?? [], offset: 2)
        XCTAssertEqual(model.count, 1)
        XCTAssertEqual((model[0] as! Gallery).imageUrl, nil)
    }
    
    func testWhenOffsetIsEqual4ShouldReturnInsertionImage() {
        let galleryResponse: Array<GalleryResponse> = [GalleryResponse(id: 1032485439,
                                                                       name: "Springtime",
                                                                       positiveVotesCount: 4264,
                                                                       description: "Berlin. Reinhardtstraße 58",
                                                                       imageUrls: [])]
        let galleryList = GalleryListResponse(currentPage: 1, totalPage: 2, photos: galleryResponse)
        let model = GalleryModel().toModel(galleryPhotos: galleryList.photos ?? [], offset: 4)
        XCTAssertEqual(model.count, 2)
        XCTAssertTrue((model[0] as! ImageInsertion).image != nil)
    }
    
    func testWhenOffsetIsEqual3ShouldReturnInsertionImageBetweenCell() {
        let galleryResponse: Array<GalleryResponse> = [GalleryResponse(id: 1032485439,
                                                                       name: "Springtime",
                                                                       positiveVotesCount: 4264,
                                                                       description: "Berlin. Reinhardtstraße 58",
                                                                       imageUrls: []),
                                                       GalleryResponse(id: 1032485440,
                                                                       name: "Springtime 2",
                                                                       positiveVotesCount: 4264,
                                                                       description: "Berlin. Reinhardtstraße 58",
                                                                       imageUrls: [])]
        let galleryList = GalleryListResponse(currentPage: 1, totalPage: 2, photos: galleryResponse)
        let model = GalleryModel().toModel(galleryPhotos: galleryList.photos ?? [], offset: 3)
        XCTAssertEqual(model.count, 3)
        XCTAssertTrue((model[0] as! Gallery).name == "Springtime")
        XCTAssertTrue((model[1] as! ImageInsertion).image != nil)
        XCTAssertTrue((model[2] as! Gallery).name == "Springtime 2")
    }
    
}
