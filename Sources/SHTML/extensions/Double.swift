//
//  Double.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

public extension Double {
    var px: CSSLength { CSSLength(self, .px) }
    var rem: CSSLength { CSSLength(self, .rem) }
    var em: CSSLength { CSSLength(self, .em) }
    var percent: CSSLength { CSSLength(self, .percent) }
    var vh: CSSLength { CSSLength(self, .vh) }
    var vw: CSSLength { CSSLength(self, .vw) }
}

public extension Int {
    var px: CSSLength { CSSLength(Double(self), .px) }
    var rem: CSSLength { CSSLength(Double(self), .rem) }
    var em: CSSLength { CSSLength(Double(self), .em) }
    var percent: CSSLength { CSSLength(Double(self), .percent) }
    var vh: CSSLength { CSSLength(Double(self), .vh) }
    var vw: CSSLength { CSSLength(Double(self), .vw) }
}
