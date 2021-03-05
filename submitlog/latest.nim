import sequtils, strutils

proc map*[T, S](s: openArray[T], op: proc(x: T, i: int): S{.closure.}):
                                                        seq[S]{.inline.} =
  runnableExamples:
    let
      a = @[1, 2, 3, 4]
      b = a.map(proc(x: int, i: int): string = $x & $i)
    assert b == @["10", "21", "32", "43"]
  result.newSeq(s.len)
  for i in 0..<s.len:
    result[i] = op(s[i], i)

proc ipt*(): string {.inline.} = stdin.readLine()
proc ipt*[T](op: proc(x: string): T{.closure.}): T{.inline.} = ipt().op()

proc ipts*(): seq[string]{.inline.} = ipt().split(' ')
proc ipts*[T](op: proc(x: string): T{.closure.}): seq[T]{.inline.} = ipts().map(op)
proc ipts*[T](op: proc(x: string, i: int): T{.closure.}): seq[T]{.
    inline.} = ipts().map(op)


import
  strutils,
  sequtils,
  sugar

proc log(x: string) =
  when defined(debug):
    echo "[Log] " & x

when isMainModule:
  log("hello, world")
