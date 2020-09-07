import Foundation
import HyperSwift

public class Tag: HTMLComponent {
    let text: String
    public init(_ text: String) {
        self.text = text
        let tag: HTMLElement =
            Div {
                Paragraph(text)
                    .margin(top: 2, right: 10, bottom: 2, left: 10)
                    .textAlign(.center)
                    .color(GColors.white)
                    .font(weight: "bold", size: 13, family: "SF Mono")
            }
            .backgroundColor(CSSColor("#FFD6AF"))
            .whiteSpace(.nowrap)
            .shadow(x: 1, y: 2, color: GColors.tagShadow)
            .display(.inlineBlock)
            .margin(right: 5, left: 5, .px)
        
        super.init(.empty, [tag])
    }
}