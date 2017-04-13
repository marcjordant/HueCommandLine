//
//  HueAction.swift
//  HueCommandLine
//
//  Created by Marc Jordant on 14/04/17.
//  Copyright © 2017 Marc Jordant. All rights reserved.
//

import Foundation

class HueAction
{
  var key = ""
  var hueCalls: [HueCall] = []
  
  func start() -> Void
  {
    call()
  }

  fileprivate func call(at index: Int = 0) -> Void
  {
    guard hueCalls.count > index else {
      return
    }
    
    hueCalls[index].callHue { error in
      guard error == nil else {
        return
      }
      
      self.call(at: index + 1)
    }
  };
  
  
  static func loadActions(settingsFile: String = "settings.plist") -> [HueAction]
  {
    var hueActions: [HueAction] = []
    
    let data = NSArray(contentsOfFile: settingsFile)
    
    for ac in data as! Array<Dictionary<String, AnyObject>> {
      let hueAction = HueAction()
      hueAction.key = ac["key"] as! String

      let calls = ac["calls"] as! Array<Dictionary<String, AnyObject>>
      for call in calls {
        let hueCall = HueCall(host: call["host"] as! String,
                              userName: call["userName"] as! String,
                              address: call["address"] as! String,
                              httpMethod: call["httpMethod"] as! String,
                              httpBody: call["httpBody"] as? String)
        hueAction.hueCalls += [hueCall]
      }
      
      hueActions += [hueAction]
    }
    
    return hueActions
  }
}
