//
//  Extenstion.swift
//  OAuth2
//
//  Created by Adir Burke on 1/12/20.
//

import Foundation

enum DecodingError : Error {
    case InvalidJSON
    case InvalidString
}

extension String {
    public func jsonDecode() throws -> Any {
        guard let data = self.data(using: .utf8) else { throw DecodingError.InvalidString }
        return try JSONSerialization.jsonObject(with: data, options: [])
    }
    
    public var stringByEncodingURL: String {
        var ret = ""
        var g = utf8.makeIterator()
        while let c = g.next() {
            if c.shouldURLEncode {
                ret.append(String(Character(UnicodeScalar(37))))
                ret.append(c.hexString)
            } else {
                ret.append(String(Character(UnicodeScalar(c))))
            }
        }
        return ret
    }
}

extension UInt8 {
    var shouldURLEncode: Bool {
        let cc = self
        return ( ( cc >= 128 )
            || ( cc < 33 )
            || ( cc >= 34  && cc < 38 )
            || ( ( cc > 59  && cc < 61) || cc == 62 || cc == 58)
            || ( ( cc >= 91  && cc < 95 ) || cc == 96 )
            || ( cc >= 123 && cc <= 126 )
            || self == 43 )
    }
    
    // same as String(self, radix: 16)
    // but outputs two characters. i.e. 0 padded
    var hexString: String {
        var s = ""
        let b = self >> 4
        s.append(String(Character(UnicodeScalar(b > 9 ? b - 10 + 65 : b + 48))))
        let b2 = self & 0x0F
        s.append(String(Character(UnicodeScalar(b2 > 9 ? b2 - 10 + 65 : b2 + 48))))
        return s
    }
}
