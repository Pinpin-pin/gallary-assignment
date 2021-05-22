import Foundation

struct Gallery: Hashable {
    let id: Int?
    let name: String?
    let positiveVotesCount: Int?
    let description: String?
    let image: Array<ImageObject>?
}

struct ImageObject: Hashable {
    let url: String?
}
