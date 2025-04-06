import SwiftUI
import UIKit

struct ATTView: View {
    var body: some View {
        AttributedTextView(
            attributedText: NSAttributedString(
                " https://example.com",
                attributes: [.font: UIFont.systemFont(ofSize: 16)]
            )
            .addingLink("https://example.com", url: URL(string: "https://example.com")!)
        ) { url in
            // タップ時の処理
            print("リンクがタップされました: \(url)")
        }
        .padding()
    }
}

struct AttributedTextView: UIViewRepresentable {
    let attributedText: NSAttributedString
    let linkTapped: (URL) -> Void

    func makeUIView(context: Context) -> UITextView {
        let textView = LinkOnlyTextView()
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.delegate = context.coordinator
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
        ]

        // ハイライト表示の設定
        textView.delaysContentTouches = true

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = attributedText
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(linkTapped: linkTapped)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        let linkTapped: (URL) -> Void

        init(linkTapped: @escaping (URL) -> Void) {
            self.linkTapped = linkTapped
        }

        func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            linkTapped(URL)
            return false
        }
    }
}

// NSAttributedStringにリンクを追加する簡易extension
extension NSAttributedString {
    convenience init(_ string: String, attributes: [NSAttributedString.Key: Any]?) {
        self.init(string: string, attributes: attributes)
    }

    func addingLink(_ substring: String, url: URL) -> NSAttributedString {
        let mutableAttributed = NSMutableAttributedString(attributedString: self)
        let range = (self.string as NSString).range(of: substring)
        if range.location != NSNotFound {
            mutableAttributed.addAttribute(.link, value: url, range: range)
        }
        return mutableAttributed
    }
}

class LinkOnlyTextView: UITextView {
    override var canBecomeFirstResponder: Bool { false }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // 全ての編集メニューを非表示にする
        return false
    }

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // 長押し（UILongPressGestureRecognizer）を無効化する
        if gestureRecognizer is UILongPressGestureRecognizer {
            return false
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}

#Preview {
    ATTView()
}
