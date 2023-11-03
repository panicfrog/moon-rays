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

struct HitRecord {
  mut p: Vec3
  mut normal: Vec3
  mut t: Double
  mut front_face: Bool
}
fn set_face_normal(self: HitRecord, ray: Ray, outward_normal: Vec3) {
  self.front_face = ray.direction.dot(outward_normal) < 0.0
  self.normal = if self.front_face { outward_normal } else { {x: 0.0, y: 0.0, z: 0.0} - outward_normal }
}

interface hittable {
  hit(Self, Ray, Double, Double, HitRecord) -> Bool;
}

struct Sphere {
  center: Vec3
  radius: Double
}

fn hit(self: Sphere, ray: Ray, ray_tmin: Double, ray_tmax: Double, rec: HitRecord) -> Bool {
  let oc = ray.origin - self.center
  let a = ray.direction.length_squared()
  let half_b = oc.dot(ray.direction)
  let c = oc.length_squared() - self.radius * self.radius

  let discriminant = half_b * half_b - a * c
  if discriminant < 0.0 {
    return false
  }
  let sqrtd = sqrt(discriminant)

  var root = (-half_b - sqrtd) / a
  if root <= ray_tmin || ray_tmax <= root {
    root = (-half_b + sqrtd) / a
    if root < ray_tmin || ray_tmax <= root {
      return false
    }
  }
  rec.t = root
  rec.p = ray.at(rec.t)
  let outward_normal = (rec.p - self.center).div(self.radius)
  rec.set_face_normal(ray, outward_normal)
  true
}
