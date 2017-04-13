#!/usr/bin/swift

let dir = "/Users/mj/BitBar"

print("💡")
print("---")
print("Home Hue lights")
print("Select an action in the sub menus")

print("---")
print("Office")
print("--Low|bash=\"\(dir)/hue/run.sh\" param1=OfficeLow terminal=false")
print("--High|bash=\"\(dir)/hue/run.sh\" param1=OfficeHigh terminal=false")
print("--Night|bash=\"\(dir)/hue/run.sh\" param1=OfficeNightLight terminal=false")
print("-- ⎯⎯⎯⎯⎯")
print("--Off|bash=\"\(dir)/hue/run.sh\" param1=OfficeOff terminal=false")

print("---")
print("Night lights")
print("--On|bash=\"\(dir)/hue/run.sh\" param1=NightLightOn terminal=false")
print("-- ⎯⎯⎯⎯⎯")
print("--Off|bash=\"\(dir)/hue/run.sh\" param1=NightLightOff terminal=false")
