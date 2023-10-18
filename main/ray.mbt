pub struct Ray {
  origin : Vec3
  direction : Vec3
}

// func newRay(origin : Vec3, direction : Vec3) -> Ray {
// return { origin, direction }
// }

// func at(ray : Ray, t : Float64) -> Vec3 {
// return ray.origin + ray.direction.mul(t)
// }

func hitSphere(self : Ray, center : Vec3, radius : Float64) -> Bool {
  let oc = self.origin - center
  let a = self.direction.dot(self.direction)
  let b = 2.0 * oc.dot(self.direction)
  let c = oc.dot(oc) - radius * radius
  let discriminant = b * b - 4.0 * a * c
  return discriminant >= 0.0
}

func rayColor(self : Ray) -> Color {
  if self.hitSphere({ x: 0.0, y: 0.0, z: -1.0 }, 0.5) {
    // fromVec3({ x: 1.0, y: 0.0, z: 0.0 })
    { r: 255, g: 0, b: 0 }
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

