pub interface Sequence  {
  next(Self) -> Option[Self]
}

pub func forEach[T : Sequence](v : T, f : (T) -> Unit) -> Unit {
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

