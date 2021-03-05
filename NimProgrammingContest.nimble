# Package

version       = "0.1.0"
author        = "panno"
description   = "Utilities for Programming contest and answers log"
license       = "MIT"
srcDir        = "src"
binDir        = "bin"
installExt    = @["nim"]
bin           = @["pc"]


# Dependencies

requires "nim >= 1.4.2"

import strformat, sugar, sequtils, strutils

task debug,"":
  exec(fmt"nim c -r -d:debug -o:{binDir}/{bin[0]} {srcDir}/{bin[0]}.nim")

task submit,"":
  let f = fmt"{srcDir}/{bin[0]}.nim".readfile().split('\n')
  var
    processing = false
    beginHead:int
    endHead:int
    title:string
  for i,s in f:
    if s == "# HEAD":
      processing = true
      beginHead = i
    if s == "# /HEAD":
      processing = false
      endHead = i
      break
    if processing:
      if s.find("TITLE") != -1:
        title = s.split()[2]

  var withoutHeader = newSeq[string]()
  for i in 0..<f.len:
    if beginHead <= i and i <= endHead:
     continue
    withoutHeader.add(f[i])

  "submitlog/latest.nim".writeFile fmt"{srcDir}/pkg/utils.nim".readfile() & "\n" & withoutHeader.join("\n")
  fmt"{srcDir}/{bin[0]}.nim".cpFile fmt"submitlog/{title}.nim"

  exec fmt"cat submitlog/latest.nim | xclip -i -selection clipboard"
