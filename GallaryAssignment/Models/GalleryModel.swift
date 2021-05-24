import Foundation
import UIKit
struct GalleryModel {
    func toModel(galleryListResponse: GalleryListResponse) -> GalleryList? {
        guard let gallery = galleryListResponse.photos?.map({ item in
            Gallery(id: item.id,
                    name: item.name,
                    positiveVotesCount: item.positiveVotesCount,
                    description: item.description,
                    imageUrl: item.imageUrls?.first)
        }) else { return nil }
        return GalleryList(currentPage: galleryListResponse.currentPage,
                           totalPage: galleryListResponse.totalPage,
                           photos: gallery)
    }
}

enum GalleryFeature: String {
    case popular
}
struct GalleryList {
    let currentPage: Int?
    let totalPage: Int?
    let photos: Array<Gallery>
}

protocol GalleryItem {}

struct Gallery: GalleryItem {
    let id: Int?
    let name: String?
    let positiveVotesCount: Int?
    let description: String?
    let imageUrl: String?
}

struct ImageInsertion: GalleryItem {
    let image = UIImage(named: "gallery-image-insertion")
}

struct LoadMoreGallery {
    var currentPage: Int = 0
    var totalPage: Int = 0
}
