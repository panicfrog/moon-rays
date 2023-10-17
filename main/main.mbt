struct Color {
  r: Int
  g: Int
  b: Int
}

func to_string(self: Color) -> String {
  let {r, g, b} = self
  "\(r) \(g) \(b)\n"
}

enum Option[X] {
  None
  Some(X)
}

func genColors(width: Int, height: Int) -> Array[Color] {
  let b = 128
  let colors = Array::make(width * height, { r: 0, g: 0, b: 0} )
  fn next(w: Int, h: Int, index: Int) -> Option[(Int, Int, Int)] {
    if w < width - 1 {
      if h < height - 1 {
        Some((w, h + 1, index + 1))
      } else {
        Some((w + 1, 0, index + 1))
      }
    } else {
      None
    }
  }
  let colors_len = colors.length()
  var n = Option::Some(0, 0, 0)
  var notEnd = true
  while notEnd {
    match n {
      Some(w, h, i) => {
        if (i < colors_len) {
          colors[i] = {r: w, g: h, b: b}
        }
        n = next(w, h, i)
      }
      _ => {
        notEnd = false
      }
    }
  }
  colors
}

pub func iter[X](self: List[X], f: (X) -> Unit) -> Unit {
  match self {
    Nil => ()
    Cons(x, rest) => { f(x); iter(rest, f) }
  }
}


func init {
  let image_width = 256
  let image_height = 256
  println("P3\n\(image_width) \(image_height)\n255\n")
  let colors = genColors(image_width, image_height)
  var len = 0
  while len < colors.length() {
    let c = colors[len]
    println("\(c)")
    len = len + 1
  }
}
