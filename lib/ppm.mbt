struct PPM {
  width : Int
  height : Int
  colors : Array[Color]
}

// func newPPM(width : Int, height : Int, colors : Array[Color]) -> PPM {
// { width, height, colors }
// }

pub struct PPMSeq {
  ppm : PPM
  index : Int
  length : Int
}

pub fn color(self : PPMSeq) -> Color {
  let { ppm, index, .. } = self
  ppm.colors[index]
}

pub fn next(self : PPMSeq) -> Option[PPMSeq] {
  let { ppm, index, length } = self
  if index < length - 1 {
    let v = { ppm, index: index + 1, length }
    Some(v)
  } else {
    None
  }
}

pub fn to_seq(self : PPM) -> PPMSeq {
  { ppm: self, index: 0, length: self.colors.length() }
}

pub fn header(self : PPM) -> String {
  let { width, height, .. } = self
  "P3\n\(width) \(height)\n255\n\n"
}

pub fn genPPM(width : Int, height : Int, f : (Int, Int) -> Array[Color]) -> PPM {
  let colors = f(width, height)
  { width, height, colors }
}

pub fn to_string(self : PPM) -> String {
  let mut content = self.header()
  forEach(
    self.to_seq(),
    fn(p) {
      let c = p.color()
      content = "\(content)\(c)"
    },
  )
  content
}

pub fn print(self : PPM) -> Unit {
  print(self.header())
  forEach(self.to_seq(), fn(p) { print(p.color()) })
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
