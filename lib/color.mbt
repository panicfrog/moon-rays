pub struct Color {
  r : Int
  g : Int
  b : Int
}

pub fn to_string(self : Color) -> String {
  let { r, g, b } = self
  "\(r) \(g) \(b)\n"
}

fn fromVec3(vec : Vec3) -> Color {
  let { x, y, z } = vec
  { r: (x * 255.0).to_int(), g: (y * 255.0).to_int(), b: (z * 255.0).to_int() }
}
