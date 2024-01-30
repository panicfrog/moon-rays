// func genColors(width : Int, height : Int) -> Array[Color] {
// let b = 128
// let colors = Array::make(width * height, { r: 0, g: 0, b: 0 })
// let colors_len = colors.length()
// forEach(
// { index: 0, startPoint: { x: 0, y: 0 }, endPoint: { x: width, y: height } },
// fn(item) {
// let { index, startPoint, endPoint } = item
// let { x: sx, y: sy } = startPoint
// let { x: ex, y: ey } = endPoint
// if index < colors_len {
// let r = ((ex - sx).to_double() * 255.0 / ex.to_double()).to_int()
// let g = (sy.to_double() * 255.0 / ey.to_double()).to_int()
// colors[index] = { r, g, b }
// }
// },
// )
// colors
// }

type CStr

fn cstr_make(len : Int) -> CStr = "" "cstr_make"

fn cstr_free(cstr : CStr) = "" "cstr_free"

fn cstr_set_char(cstr : CStr, index : Int, c : Char) = "" "cstr_set_char"

fn ppm_row_handler(line : CStr) = "" "ppm_row_handler"

fn withCString(s : String, f : (CStr) -> Unit) {
  let len = s.length()
  let cstr = cstr_make(len)
  let mut i = 0
  while i < len {
    cstr_set_char(cstr, i, s[i])
    i = i + 1
  }
  f(cstr)
  cstr_free(cstr)
}

fn init {
  // image
  let aspect_ratio = 16.0 / 9.0
  let width = 400
  let mut height = (width.to_double() / aspect_ratio).to_int()
  if height < 1 {
    height = 1
  }

  // Camera
  let focal_length = 1.0
  let viewportHeight = 2.0
  let viewportWidth = viewportHeight * width.to_double() / height.to_double()
  let camera_center = @lib.Vec3::{ x: 0.0, y: 0.0, z: 0.0 }

  // Calculate the vectors across the horizontal and down the vertical viewport edges.
  let viewportU = @lib.Vec3::{ x: viewportWidth, y: 0.0, z: 0.0 }
  let viewportV = @lib.Vec3::{ x: 0.0, y: -viewportHeight, z: 0.0 }

  // Calculate the horizontal and vertical delta vectors from pixel to pixel.
  let pixelDeltaU = viewportU.div(width.to_double())
  let pixelDeltaV = viewportV.div(height.to_double())

  // Calculate the location of the upper left pixel.
  let viewportTopLeft = camera_center - { x: 0.0, y: 0.0, z: focal_length } - viewportU.div(
      2.0,
    ) - viewportV.div(2.0)
  let pixel00Loc = viewportTopLeft + (pixelDeltaU + pixelDeltaV).mul(0.5)
  fn pixelColor(w : Int, h : Int) -> Array[@lib.Color] {
    let colors = Array::make(w * h, @lib.Color::{ r: 0, g: 0, b: 0 })
    let colors_len = colors.length()
    @lib.forEach(
      @lib.SquareIter::{
        index: 0,
        startPoint: @lib.Point::{ x: 0, y: 0 },
        endPoint: @lib.Point::{ x: w, y: h },
      },
      fn(item) {
        let { x: sx, y: sy } = item.startPoint
        let index = item.index
        if index < colors_len {
          let center = pixel00Loc + pixelDeltaU.mul(sx.to_double()) + pixelDeltaV.mul(
              sy.to_double(),
            )
          let direction = center - camera_center
          let ray = @lib.Ray::{ origin: camera_center, direction }
          colors[index] = ray.rayColor()
        }
      },
    )
    colors
  }

  let ppm = @lib.genPPM(width, height, pixelColor)
  // ppm.print()
  withCString(ppm.header(), ppm_row_handler)
  @lib.forEach(
    ppm.to_seq(),
    fn(p) {
      let content = p.color().to_string()
      withCString(content, ppm_row_handler)
    },
  )
  ()
}
