import Foundation

class ProjectCard: HTMLComponent {
    init(title: String, codeTag: CodeTag, text: String, imgURL: String) {
        let card =
            HTMLComponent(.div, attributes: ["class": "g_card"]) {
                HTMLComponent(.div, attributes: ["class": "g_horizontal"]) {
                    HTMLComponent(.header1) { title }
                        .font(weight: "bold", size: 25, family: "SF Mono")
                    codeTag
                }
                Paragraph(text)
                Image(url: imgURL)
                    .margin(right: 5, left: 5, .percentage)
                    .width(90, .percentage)
                    .maxHeight(250)
                    .objectFit(.cover)
            }
            .wordWrap(.brk)
            .maxWidth(500)
            .minHeight(200)
            .borderRadius(15)
            .backgroundColor(GColors.white)
            .padding(right: 20, left: 20)
            .margin(top: 10, right: 10, left: 10)
            .shadow(y: 2, spread: 4, blur: 16, color: GColors.cardShadow)
        
        super.init(.empty, [card])
    }
}

class CodeTag: HTMLComponent {
    init(_ language: String) {
        let tag =
            HTMLComponent(.div) {
                HTMLComponent(.paragraph) { language }
                    .margin(top: 2, right: 10, bottom: 2, left: 10)
                    .textAlign(.center)
                    .color(GColors.white)
                    .font(weight: "bold", size: 13, family: "SF Mono")
            }
            .backgroundColor(CSSColor("#FFD6AF"))
            .borderRadius(8)
            .whiteSpace(.nowrap)
        
        super.init(.empty, [tag])
    }
}
