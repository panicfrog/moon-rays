struct Color {
  r : Int
  g : Int
  b : Int
}

func to_string(self : Color) -> String {
  let { r, g, b } = self
  "\(r) \(g) \(b)\n"
}

struct PPM {
  width : Int
  height : Int
  colors : Array[Color]
}

// func newPPM(width : Int, height : Int, colors : Array[Color]) -> PPM {
// { width, height, colors }
// }

func genPPM(width : Int, height : Int, f : (Int, Int) -> Array[Color]) -> PPM {
  let colors = f(width, height)
  { width, height, colors }
}

func genColors(width : Int, height : Int) -> Array[Color] {
  let b = 128
  let colors = Array::make(width * height, { r: 0, g: 0, b: 0 })
  let colors_len = colors.length()
  forEach(
    { index: 0, startPoint: { x: 0, y: 0 }, endPoint: { x: width, y: height } },
    fn(item) {
      let { index, startPoint, endPoint } = item
      let { x: sx, y: sy } = startPoint
      let { x: ex, y: ey } = endPoint
      if index < colors_len {
        let r = ((ex - sx).to_float64() * 255.0 / ex.to_float64()).to_int()
        let g = (sy.to_float64() * 255.0 / ey.to_float64()).to_int()
        colors[index] = { r, g, b }
      }
    },
  )
  colors
}

func to_string(self : PPM) -> String {
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

func print(self : PPM) -> Unit {
  let { width, height, colors } = self
  println("P3\n\(width) \(height)\n255\n")
  var index = 0
  while index < colors.length() {
    let c = colors[index]
    println(c)
    index = index + 1
  }
}

enum Option[T] {
  None
  Some(T)
}

interface Sequence  {
  next(Self) -> Option[Self]
}

func forEach[T : Sequence](v : T, f : (T) -> Unit) -> Unit {
  var item = v
  f(v)
  var has_next = true
  while has_next {
    match item.next() {
      Some(next) => {
        f(next)
        item = next
        has_next = true
      }
      None => {
        has_next = false
      }
    }
  }
}

struct Point {
  x : Int
  y : Int
}

// 半闭半开区间

struct SquareIter {
  index : Int
  startPoint : Point
  endPoint : Point
}

func next(self : SquareIter) -> Option[SquareIter] {
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

func init {
  let ppm = genPPM(400, 300, genColors)
  ppm.print()
}

