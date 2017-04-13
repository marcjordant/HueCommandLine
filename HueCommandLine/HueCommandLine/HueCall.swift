//
//  HueCall.swift
//  HueCommandLine
//
//  Created by Marc Jordant on 14/04/17.
//  Copyright © 2017 Marc Jordant. All rights reserved.
//

import Foundation

struct HueCall {
  let host: String
  let userName: String
  let address: String
  let httpMethod: String
  let httpBody: String?
  
  func url() -> URL?
  {
    return URL(string: "http://\(host)/api/\(userName)\(address)")
  }
  
  func callHue(_ completionBlock: @escaping(_ error: Error?) -> Void) -> Void
  {
    guard let url = url() else {
      completionBlock(NSError(domain: "HueSettings", code: 1, userInfo: ["reason" : "bad url"]))
      return
    }
    
    let request = NSMutableURLRequest(url: url)
    request.httpMethod = httpMethod
    
    if let body = httpBody {
      request.httpBody = body.data(using: .utf8)
    }
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    var done = false
    let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
      if let err = error {
        completionBlock(err)
        done = true
      }
      else {
        if let data = data, let string = String(data: data, encoding: String.Encoding.utf8) {
          print("\(string)")
        }
      }
      completionBlock(nil)
      done = true
    }
    task.resume()
    
    while(!done)
    {
      RunLoop.current.run(mode: RunLoopMode.defaultRunLoopMode, before: Date(timeIntervalSinceNow: 1))
    }
  }
}
