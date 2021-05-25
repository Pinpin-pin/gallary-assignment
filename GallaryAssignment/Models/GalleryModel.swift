import Foundation
import UIKit

struct GalleryModel {
    func toModel(galleryPhotos: Array<GalleryResponse>, offset: Int) -> Array<GalleryItem> {
        var newItems: Array<GalleryItem> = []
        for (index, item) in galleryPhotos.enumerated() {
            if ((index + offset) % 4 == 0 && index + offset != 0) {
                newItems.append(ImageInsertion())
            }
            
            let galleryItem = Gallery(id: item.id,
                                      name: item.name,
                                      positiveVotesCount: item.positiveVotesCount,
                                      description: item.description,
                                      imageUrl: item.imageUrls?.first)
            newItems.append(galleryItem)
        }
        
        return newItems
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
