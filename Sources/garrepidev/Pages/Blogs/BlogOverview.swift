import Foundation
import HyperSwift

public struct BlogOverview: HTMLPage {
    public var href: String = "/blog"
    public var title: String = "garreπ | blog"
    
    public var posts: [Post]!
    public var blogDetailPages: [BlogDetail]!
    
    
    public init(_ posts: [Post]? = nil) {
        self.posts = posts ?? []
        self.blogDetailPages = self.posts.compactMap { BlogDetail(with: $0) }
    }
    
    public func render() -> HTMLComponent {
        Div(GClasses.blogCardsGrid.rawValue) {
            posts.compactMap { $0 }.map{ PostCard($0) }
        }
        .rawCSS("display", "grid")
        .rawCSS("grid-gap", "3rem")
        .rawCSS("justify-content", "center")
        .rawCSS("grid-template-columns", "80%")
        .margin(top: 20, right: 40, bottom: 40, left: 20)
    }
}
