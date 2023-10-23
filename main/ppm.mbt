struct PPM {
  width : Int
  height : Int
  colors : Array[Color]
}

// func newPPM(width : Int, height : Int, colors : Array[Color]) -> PPM {
// { width, height, colors }
// }

pub fn genPPM(width : Int, height : Int, f : (Int, Int) -> Array[Color]) -> PPM {
  let colors = f(width, height)
  { width, height, colors }
}

pub fn to_string(self : PPM) -> String {
  let { width, height, colors } = self
  var content = "P3\n\(width) \(height)\n255\n"
  var index = 0
  while index < colors.length() {
    let c = colors[index]
    content = "\(content)\(c)"
    index = index + 1
  }
  content
}

pub fn print(self : PPM) -> Unit {
  let { width, height, colors } = self
  println("P3\n\(width) \(height)\n255\n")
  var index = 0
  while index < colors.length() {
    let c = colors[index]
    println(c)
    index = index + 1
  }
}

pub struct Point {
  x : Int
  y : Int
}

// 半闭半开区间

pub struct SquareIter {
  index : Int
  startPoint : Point
  endPoint : Point
}

pub fn next(self : SquareIter) -> Option[SquareIter] {
  let { index, startPoint, endPoint } = self
  if startPoint.y >= endPoint.y || startPoint.x >= endPoint.x {
    return None
  } else {
    let nextPoint = if startPoint.x < endPoint.x - 1 {
      Option::Some({ x: startPoint.x + 1, y: startPoint.y })
    } else if startPoint.y < endPoint.y - 1 {
      Option::Some({ x: 0, y: startPoint.y + 1 })
    } else {
      Option::None
    }
    match nextPoint {
      Some(p) => {
        let v = { index: index + 1, startPoint: p, endPoint }
        Some(v)
      }
      None => None
    }
  }
}

