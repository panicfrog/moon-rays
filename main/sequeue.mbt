pub trait Sequence  {
  next(Self) -> Option[Self]
}

pub fn forEach[T : Sequence](v : T, f : (T) -> Unit) -> Unit {
  let mut item = v
  f(v)
  while true {
    match item.next() {
      Some(next) => {
        f(next)
        item = next
      }
      None => { break }
    }
  }
}
