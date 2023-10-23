struct Vec3 {
  x : Double
  y : Double
  z : Double
}

fn length(self : Vec3) -> Double {
  return sqrt(self.length_squared())
}

fn length_squared(self : Vec3) -> Double {
  return self.x * self.x + self.y * self.y + self.z * self.z
}

pub fn op_add(self : Vec3, b : Vec3) -> Vec3 {
  return { x: self.x + b.x, y: self.y + b.y, z: self.z + b.z }
}

fn op_sub(self : Vec3, b : Vec3) -> Vec3 {
  return { x: self.x - b.x, y: self.y - b.y, z: self.z - b.z }
}

// func op_mul(self : Vec3, b : Vec3) -> Vec3 {
// return { x: self.x * b.x, y: self.y * b.y, z: self.z * b.z }
// }

fn mul(self : Vec3, t : Double) -> Vec3 {
  return { x: self.x * t, y: self.y * t, z: self.z * t }
}

fn div(self : Vec3, t : Double) -> Vec3 {
  return self.mul(1.0 / t)
}

fn dot(self : Vec3, b : Vec3) -> Double {
  return self.x * b.x + self.y * b.y + self.z * b.z
}

// func cross(self : Vec3, b : Vec3) -> Vec3 {
// return {
// x: self.y * b.z - self.z * b.y,
// y: self.z * b.x - self.x * b.z,
// z: self.x * b.y - self.y * b.x,
// }
// }

fn unitVector(self : Vec3) -> Vec3 {
  self.div(self.length())
}

