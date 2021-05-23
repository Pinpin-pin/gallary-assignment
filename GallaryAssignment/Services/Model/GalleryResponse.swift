
import Foundation

struct GalleryListResponse: Decodable {
    let currentPage: Int?
    let totalPage: Int?
    let photos: Array<GalleryResponse>?
    
    private enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case totalPage = "total_pages"
        case photos
    }
}
struct GalleryResponse: Decodable {
    let id: Int?
    let name: String?
    let positiveVotesCount: Int?
    let description: String?
    let imageUrls: Array<String>?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case positiveVotesCount = "positive_votes_count"
        case description
        case imageUrls = "image_url"
    }
}
