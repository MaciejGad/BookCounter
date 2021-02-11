//
//  File 2.swift
//  
//
//  Created by Maciej Gad on 11/02/2021.
//

import Foundation

private var standardError = FileHandle.standardError

extension FileHandle: TextOutputStream {
  public func write(_ string: String) {
    guard let data = string.data(using: .utf8) else { return }
    self.write(data)
  }
}

func errorPrint(_ item: Any) {
    print(item, to: &standardError)
}
