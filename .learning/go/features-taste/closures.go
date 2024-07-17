package main

import (
	"fmt"
)

func main() {
	// like this in Rust: (move |a: u8| move |b: u8| -> u8 {a + b}) (1) (2)
	// or like this in R: (\ (a) \ (b) a + b) (1) (2)
	x := func (a int) (func (int) (int)) {return func (b int) (int) {return a + b}} (1) (2)
	fmt.Println(x) // 3
}

// https://go.dev/play/p/8XQ2Js0GqHz
