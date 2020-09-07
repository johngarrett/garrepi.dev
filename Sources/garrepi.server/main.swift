import PerfectHTTP
import HyperSwift
import PerfectHTTPServer
import garrepidev
import Foundation

func cssHandler(request: HTTPRequest, response: HTTPResponse) {
    response.setHeader(.contentType, value: "text/css")
    response.appendBody(string: CSSStyleSheet.generateStyleSheet())
    response.appendBody(string: """
        body {
            font-family: "SF Mono";
        }

        .g_sidebar a:hover {
            text-decoration: underline;
        }
        .g_project_card:hover {
            position: relative;
            top: -5px;
            left: -5px;
            box-shadow: 25px 35px 0px 0px rgba(0, 0, 0, 0.6);
        }
        pre {
            overflow: scroll;
        }
    """)
    response.completed()
}
func getBlogs(at folder: URL) -> [Post]? {
    guard let blogFiles = try? FileManager.default.contentsOfDirectory(atPath: folder.path) else {
        print("[CRITICAL] could not generate blogs from \(folder.path)")
        return nil
    }
    return blogFiles.compactMap { Post(from: folder.appendingPathComponent($0), href: $0.replacingOccurrences(of: ".md", with: ".html")) }
}
func getProjects(at folder: URL) -> [Project]? {
    guard let projectFiles = try? FileManager.default.contentsOfDirectory(atPath: folder.path) else {
        print("[CRITICAL] could not generate projects from \(folder.path)")
        return nil
    }
    return projectFiles.compactMap { Project(from: folder.appendingPathComponent($0), href: $0.replacingOccurrences(of: ".md", with: ".html")) }
}

var routes = Routes()

let stylesheets = [
    "<link rel=\"stylesheet\" href=\"/styles.css\" type=\"text/css\">"
]
let head = Head(title: "garreπ", stylesheets: stylesheets)
var blogs:[Post] = []
for _ in 1...15 {
    getBlogs(at: URL(fileURLWithPath: "/Users/garrepi/dev/johngarrett.github.io/blog-posts"))?.forEach {
        blogs.append($0)
    }
}
let blogOverview = BlogOverview(blogs)

var projects:[Project] = []
for _ in 1...15 {
    getProjects(at: URL(fileURLWithPath: "/Users/garrepi/dev/johngarrett.github.io/project-posts"))?.forEach {
        projects.append($0)
    }
}
let projectsOverview = ProjectsOverview(projects)

let gHandler = GHandler(head, About(), blogOverview, projectsOverview)

routes.add(method: .get, uri: "/styles.css", handler: cssHandler)
routes.add(method: .get, uri: "/about/*", handler: gHandler.aboutHandler)
routes.add(method: .get, uri: "/blog/*", handler: gHandler.blogHandler)
routes.add(method: .get, uri: "/projects/*", handler: gHandler.projectHandler)
routes.add(method: .get, uri: "/images/*", handler: gHandler.imgHandler)
routes.add(method: .get, uri: "/*", handler: gHandler.generalHandler)

try HTTPServer.launch(
    name: "localhost",
    port: 8181,
    routes: routes,
    responseFilters: [
        (PerfectHTTPServer.HTTPFilter.contentCompression(data: [:]), HTTPFilterPriority.high)
    ]
)
