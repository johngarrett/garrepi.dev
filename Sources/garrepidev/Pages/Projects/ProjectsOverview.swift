import Foundation
import HyperSwift

public struct ProjectsOverview: HTMLPage {
    public var projects: [Project]!
    public var projectDetailPages: [ProjectDetail]!
    public var href = "/projects"
    public var title = "garreπ | projects"
    
    public init(_ projects: [Project]? = nil) {
        self.projects = projects ?? []
        self.projectDetailPages = self.projects.compactMap { ProjectDetail(with: $0) }
    }
    
    public func render() -> HTMLComponent {
        Div(GClasses.projectCardsGrid.rawValue) {
            projects.compactMap { $0 }.map { ProjectCard(from: $0) }
        }
        .display(.grid)
        .gridGap(2, .rem)
        .padding(20)
        .margin(bottom: 20)
        .rawCSS("grid-template-columns", "repeat(auto-fit, minmax(400px, 1fr));")
    }
}
