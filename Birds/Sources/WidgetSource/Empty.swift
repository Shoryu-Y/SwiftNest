import Foundation
import WidgetKit

public struct WidgetSource {
    public init() {}
    
    public func hoge() {
        WidgetCenter.shared.reloadAllTimelines()
    }
}
