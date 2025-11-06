import Foundation

extension Bundle {
  static func swizzleInfoDictionary() {
    guard #available(iOS 26.0, *) else { return }

    let originalSelector = #selector(getter: infoDictionary)
    let swizzledSelector = #selector(getter: swizzledInfoDictionary)

    guard let original = class_getInstanceMethod(Self.self, originalSelector),
          let swizzled = class_getInstanceMethod(Self.self, swizzledSelector) else {
        return
    }

    method_exchangeImplementations(original, swizzled)
  }

  @objc private var swizzledInfoDictionary: NSDictionary? {
    let dict = NSMutableDictionary(
      dictionary: self.swizzledInfoDictionary ?? [:]
    )

    // Liquid Glass をオフにする場合 (true)
     dict["UIDesignRequiresCompatibility"] = true

    // Liquid Glass をオンにする場合 (false)
    // dict["UIDesignRequiresCompatibility"] = false

    // オン・オフを UserDefaults で管理する場合
//    dict["UIDesignRequiresCompatibility"]
//      = !UserDefaults.standard.bool(forKey: "isLiquidGlassEnabled")

    return dict
  }
}
