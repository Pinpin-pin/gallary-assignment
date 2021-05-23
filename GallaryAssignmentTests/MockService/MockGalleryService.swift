import Foundation
@testable import GallaryAssignment

class MockGalleryService: GalleryServiceProtocol {
    func getGalleryData(feature: String, page: Int,
                        onSuccess: @escaping (GalleryListResponse) -> Void,
                        onError: @escaping () -> Void) {
        let galleryResponse = [GalleryResponse(id: 1032485439,
                                               name: "Springtime",
                                               positiveVotesCount: 4264,
                                               description: "Berlin. Reinhardtstraße 58",
                                               imageUrls: ["https://drscdn.500px.org/photo/1032485078/q%3D50_h%3D450/v2?sig=18d048a2655fc3fda0a900db123edbaea13455efa1f1bffa45f43f10cf9f49c9"])]
        let galleryListResponse = GalleryListResponse(currentPage: 1, totalPage: 201, photos: galleryResponse)
        onSuccess(galleryListResponse)
    }
}

class MockGalleryServiceFail: GalleryServiceProtocol {
    func getGalleryData(feature: String, page: Int,
                        onSuccess: @escaping (GalleryListResponse) -> Void,
                        onError: @escaping () -> Void) {
        onError()
    }
    
}
