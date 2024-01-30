fn sqrt(number : Double) -> Double {
  let precision = 0.0000001
  let mut guess = number / 2.0
  let mut prev_guess = guess + 2.0 * precision
  if number < 0.0 {
    return -1.0
  }
  if number == 0.0 || number == 1.0 {
    return number
  }
  while guess - prev_guess > precision || guess - prev_guess < -precision {
    prev_guess = guess
    guess = 0.5 * (guess + number / guess)
  }
  guess
}
