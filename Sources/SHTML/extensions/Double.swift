//
//  Double.swift
//  SHTML
//
//  Created by Hanna Skairipa on 2/12/26.
//

extension Double {
    var px: CSSLength { CSSLength(self, .px) }
    var rem: CSSLength { CSSLength(self, .rem) }
    var em: CSSLength { CSSLength(self, .em) }
    var percent: CSSLength { CSSLength(self, .percent) }
}
