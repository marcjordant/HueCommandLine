//
//  main.swift
//  HueCommandLine
//
//  Created by Marc Jordant on 14/04/17.
//  Copyright © 2017 Marc Jordant. All rights reserved.
//

import Foundation

let actions = HueAction.loadActions()

func printHelp() -> Void
{
  print("Please use one of :")
  for action in actions {
    print("\t\(action.key)")
  }
}

guard CommandLine.arguments.count > 1 else {
  print("No action specified !")
  printHelp()
  exit(-1)
}

var found = false
for action in actions {
  if action.key == CommandLine.arguments[1] {
    found = true
    action.start()
    break
  }
}

if !found {
  print("unknown command: \(CommandLine.arguments[1])")
  printHelp()
  exit(-1)
}
