pub struct Ray {
  origin : Vec3
  direction : Vec3
}

// func newRay(origin : Vec3, direction : Vec3) -> Ray {
// return { origin, direction }
// }

fn at(self : Ray, t : Double) -> Vec3 {
  return self.origin + self.direction.mul(t)
}

fn hitSphere(self : Ray, center : Vec3, radius : Double) -> Double {
  let oc = self.origin - center
  let a = self.direction.dot(self.direction)
  let b = 2.0 * oc.dot(self.direction)
  let c = oc.dot(oc) - radius * radius
  let discriminant = b * b - 4.0 * a * c
  if discriminant < 0.0 {
    -1.0
  } else {
    (-b - sqrt(discriminant)) / (2.0 * a)
  }
}

fn rayColor(self : Ray) -> Color {
  let times = self.hitSphere({ x: 0.0, y: 0.0, z: -1.0 }, 0.5)
  if times > 0.0 {
    let u = self.at(times) - { x: 0.0, y: 0.0, z: -1.0 }
    fromVec3({ x: u.x + 1.0, y: u.y + 1.0, z: u.z + 1.0 }.mul(0.5))
  } else {
    let unitDirection = self.direction.unitVector()
    let t = 0.5 * (unitDirection.y + 1.0)
    let vecColor = { x: 1.0, y: 1.0, z: 1.0 }.mul(1.0 - t) + {
        x: 0.5,
        y: 0.7,
        z: 1.0,
      }.mul(t)
    fromVec3(vecColor)
  }
}

