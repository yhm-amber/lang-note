
// https://play.rust-lang.org/?version=stable&code=%0D%0Afn+main%28%29+%0D%0A%7B%0D%0A%09%2F%2F+collect+with+no+take%0D%0A%09%7B%0D%0A%09%09let+a+%3D+std%3A%3Aiter%3A%3Asuccessors%28Some%281_u16%29%2C+%7Cn%7C+n.checked_mul%2810%29%29%3B%0D%0A%09%09let+x+%3D+a.collect%3A%3A%3CVec%3C_%3E%3E%28%29%3B%0D%0A%09%09assert_eq%21%28%0D%0A%09%09%09x%2C+%26%5B1%2C+10%2C+100%2C+1000%2C+10000%5D%29%3B%0D%0A%09%09println%21%28%220%3A+%7B%3A%3F%7D%22%2C+x%29%3B%0D%0A%09%7D%0D%0A%09%0D%0A%09%2F%2F+take+then+collect%0D%0A%09%7B%0D%0A%09%09let+a+%3D+std%3A%3Aiter%3A%3Asuccessors%28Some%281_u16%29%2C+%7Cn%7C+n.checked_mul%282%29%29%3B%0D%0A%09%09let+x+%3D+a.take%285%29.collect%3A%3A%3CVec%3C_%3E%3E%28%29%3B%0D%0A%09%09assert_eq%21%28%0D%0A%09%09%09x%2C+%26%5B1%2C+2%2C+4%2C+8%2C+16%5D%29%3B%0D%0A%09%09println%21%28%221%3A+%7B%3A%3F%7D%22%2C+x%29%3B%0D%0A%09%7D%0D%0A%09%0D%0A%09%2F%2F+take+then+collect+but+use+*+op%0D%0A%09%7B%0D%0A%09%09let+a+%3D+std%3A%3Aiter%3A%3Asuccessors%28Some%281%29%2C+%7Cn%7C+Some%28n+*+2%29%29%3B%0D%0A%09%09let+x+%3D+a.take%285%29.collect%3A%3A%3CVec%3C_%3E%3E%28%29%3B%0D%0A%09%09assert_eq%21%28%0D%0A%09%09%09x%2C+%26%5B1%2C+2%2C+4%2C+8%2C+16%5D%29%3B%0D%0A%09%09println%21%28%222%3A+%7B%3A%3F%7D%22%2C+x%29%3B%0D%0A%09%7D%0D%0A%09%0D%0A%09%2F%2F+test+checked_mul%0D%0A%09%7B%0D%0A%09%09assert_eq%21%28%0D%0A%09%09%0912_u16.checked_mul%2820%29%2C+Some%2812_u16*20%29%29%3B%0D%0A%09%09println%21%28%223%3A+%7B%3A%3F%7D%22%2C+12_u16.checked_mul%2820%29%29%3B%0D%0A%09%7D%0D%0A%7D%0D%0A
// https://play.rust-lang.org/?version=stable&gist=fc6483fa6474e1bec27ff5dd0ee8b465

fn main() 
{
	// collect with no take
	{
		let a = std::iter::successors(Some(1_u16), |n| n.checked_mul(10));
		let x = a.collect::<Vec<_>>();
		assert_eq!(
			x, &[1, 10, 100, 1000, 10000]);
		println!("0: {:?}", x);
	}
	
	// take then collect
	{
		let a = std::iter::successors(Some(1_u16), |n| n.checked_mul(2));
		let x = a.take(5).collect::<Vec<_>>();
		assert_eq!(
			x, &[1, 2, 4, 8, 16]);
		println!("1: {:?}", x);
	}
	
	// take then collect but use * op
	{
		let a = std::iter::successors(Some(1), |n| Some(n * 2));
		let x = a.take(5).collect::<Vec<_>>();
		assert_eq!(
			x, &[1, 2, 4, 8, 16]);
		println!("2: {:?}", x);
	}
	
	// test checked_mul
	{
		assert_eq!(
			12_u16.checked_mul(20), Some(12_u16*20));
		println!("3: {:?}", 12_u16.checked_mul(20));
	}
}
