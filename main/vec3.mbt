struct Vec3 {
  x : Float64
  y : Float64
  z : Float64
}

func length(self : Vec3) -> Float64 {
  return sqrt(self.length_squared())
}

func length_squared(self : Vec3) -> Float64 {
  return self.x * self.x + self.y * self.y + self.z * self.z
}

pub func op_add(self : Vec3, b : Vec3) -> Vec3 {
  return { x: self.x + b.x, y: self.y + b.y, z: self.z + b.z }
}

func op_sub(self : Vec3, b : Vec3) -> Vec3 {
  return { x: self.x - b.x, y: self.y - b.y, z: self.z - b.z }
}

// func op_mul(self : Vec3, b : Vec3) -> Vec3 {
// return { x: self.x * b.x, y: self.y * b.y, z: self.z * b.z }
// }

func mul(self : Vec3, t : Float64) -> Vec3 {
  return { x: self.x * t, y: self.y * t, z: self.z * t }
}

func div(self : Vec3, t : Float64) -> Vec3 {
  return self.mul(1.0 / t)
}

func dot(self : Vec3, b : Vec3) -> Float64 {
  return self.x * b.x + self.y * b.y + self.z * b.z
}

// func cross(self : Vec3, b : Vec3) -> Vec3 {
// return {
// x: self.y * b.z - self.z * b.y,
// y: self.z * b.x - self.x * b.z,
// z: self.x * b.y - self.y * b.x,
// }
// }

func unitVector(self : Vec3) -> Vec3 {
  self.div(self.length())
}

