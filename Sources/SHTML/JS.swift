public enum JS {
    public static func log(_ message: String) {
        #if arch(wasm32)
        withUTF8(message) { ptr, len in
            shtml_js_log(ptr, len)
        }
        #else
        print(message)
        #endif
    }

    public static func setInnerHTML(elementID: String, html: String) {
        #if arch(wasm32)
        withUTF8(elementID) { idPtr, idLen in
            withUTF8(html) { htmlPtr, htmlLen in
                shtml_js_set_inner_html(idPtr, idLen, htmlPtr, htmlLen)
            }
        }
        #else
        _ = elementID
        _ = html
        #endif
    }
}

#if arch(wasm32)
@_silgen_name("shtml_js_log")
private func shtml_js_log(_ ptr: UnsafePointer<UInt8>, _ len: Int32)

@_silgen_name("shtml_js_set_inner_html")
private func shtml_js_set_inner_html(
    _ idPtr: UnsafePointer<UInt8>,
    _ idLen: Int32,
    _ htmlPtr: UnsafePointer<UInt8>,
    _ htmlLen: Int32
)

private func withUTF8(_ string: String, _ body: (UnsafePointer<UInt8>, Int32) -> Void) {
    let count = Int32(string.utf8.count)
    string.withCString { cString in
        let ptr = UnsafeRawPointer(cString).assumingMemoryBound(to: UInt8.self)
        body(ptr, count)
    }
}
#endif
