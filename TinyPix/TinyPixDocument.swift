//
//  TinyPixDocument.swift
//  TinyPix
//
//  Created by Admin on 20.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class TinyPixDocument: UIDocument {
    
    private var bitmap: [UInt8]
    
    override init(fileURL url: URL) {
        bitmap = [0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80]
        super.init(fileURL: url)
    }
    
    func stateAt(row: Int, column: Int) -> Bool {
        let rowByte = bitmap[row]
        let result = UInt8(1 << column) & rowByte
        return result != 0
    }
    
    func setState(state: Bool, atRow row: Int, column: Int) {
        var rowByte = bitmap[row]
        if state {
            rowByte |= UInt8(1 << column)
        } else {
            rowByte &= ~UInt8(1 << column)
        }
        bitmap[row] = rowByte
    }
    
    func toggleStateAt(row: Int, column: Int) {
        let state = stateAt(row: row, column: column)
        setState(state: state, atRow: row, column: column)
    }
    
    override func contents(forType typeName: String) throws -> Any {
        print("Saving document to URL \(fileURL)")
        let bitmapData = NSData(bytes: bitmap, length: bitmap.count)
        return bitmapData
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        print("Loading document from URL \(fileURL)")
        if let bitmapData = contents as? NSData {
            bitmapData.getBytes(UnsafeMutablePointer<UInt8>(mutating: bitmap), length: bitmap.count)
        }
    }

}
