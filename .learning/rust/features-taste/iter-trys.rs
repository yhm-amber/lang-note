
// https://play.rust-lang.org/?version=stable&gist=2a85b72d55102447c32d090f2b9c3aeb
// https://play.rust-lang.org/?version=stable&code=%0D%0Afn+main%28%29+%0D%0A%7B%0D%0A%09%2F%2F+collect+with+no+take%0D%0A%09%7B%0D%0A%09%09let+a+%3D+std%3A%3Aiter%3A%3Asuccessors%28Some%281_u16%29%2C+%7Cn%7C+n.checked_mul%2810%29%29%3B%0D%0A%09%09let+x+%3D+a.collect%3A%3A%3CVec%3C_%3E%3E%28%29%3B%0D%0A%09%09assert_eq%21%28%0D%0A%09%09%09x%2C+%26%5B1%2C+10%2C+100%2C+1000%2C+10000%5D%29%3B%0D%0A%09%09println%21%28%220%3A+%7B%3A%3F%7D%22%2C+x%29%3B+%2F%2F%3E+0%3A+%5B1%2C+10%2C+100%2C+1000%2C+10000%5D%0D%0A%09%7D%0D%0A%09%0D%0A%09%2F%2F+take+then+collect%0D%0A%09%7B%0D%0A%09%09let+a+%3D+std%3A%3Aiter%3A%3Asuccessors%28Some%281_u16%29%2C+%7Cn%7C+n.checked_mul%282%29%29%3B%0D%0A%09%09let+x+%3D+a.take%285%29.collect%3A%3A%3CVec%3C_%3E%3E%28%29%3B%0D%0A%09%09assert_eq%21%28%0D%0A%09%09%09x%2C+%26%5B1%2C+2%2C+4%2C+8%2C+16%5D%29%3B%0D%0A%09%09println%21%28%221%3A+%7B%3A%3F%7D%22%2C+x%29%3B+%2F%2F%3E+1%3A+%5B1%2C+2%2C+4%2C+8%2C+16%5D%0D%0A%09%7D%0D%0A%09%0D%0A%09%2F%2F+take+then+collect+but+use+*+op%0D%0A%09%7B%0D%0A%09%09let+a+%3D+std%3A%3Aiter%3A%3Asuccessors%28Some%281%29%2C+%7Cn%7C+Some%28n+*+2%29%29%3B%0D%0A%09%09let+x+%3D+a.take%285%29.collect%3A%3A%3CVec%3C_%3E%3E%28%29%3B%0D%0A%09%09assert_eq%21%28%0D%0A%09%09%09x%2C+%26%5B1%2C+2%2C+4%2C+8%2C+16%5D%29%3B%0D%0A%09%09println%21%28%222%3A+%7B%3A%3F%7D%22%2C+x%29%3B+%2F%2F%3E+2%3A+%5B1%2C+2%2C+4%2C+8%2C+16%5D%0D%0A%09%7D%0D%0A%09%0D%0A%09%2F%2F+test+checked_mul%0D%0A%09%7B%0D%0A%09%09assert_eq%21%28%0D%0A%09%09%0912_u16.checked_mul%2820%29%2C+Some%2812_u16*20%29%29%3B%0D%0A%09%09println%21%28%223%3A+%7B%3A%3F%7D%22%2C+12_u16.checked_mul%2820%29%29%3B+%2F%2F%3E+3%3A+Some%28240%29%0D%0A%09%7D%0D%0A%09%0D%0A%09%2F%2F+std%3A%3Aiter%3A%3Asuccessors+like+Stream.iterate+in+elixir%0D%0A%09%0D%0A%09%2F%2F+with+map%2C+like+Stream.unfold+in+elixir%0D%0A%09%7B%0D%0A%09%09let+fib+%3D+std%3A%3Aiter%3A%3Asuccessors%28%0D%0A%09%09%09%09Some%28%280%2C+1%29%29%2C+%0D%0A%09%09%09%09%7C%26%28a%2C+b%29%7C+Some%28%28b%2C+a+%2B+b%29%29%29%0D%0A%09%09%09.map%28%7C%28a%2C+_%29%7C+a%29%3B%0D%0A%09%09println%21%28%22fib+13%3A+%7B%3A%3F%7D%22%2C+fib.take%2813%29.collect%3A%3A%3CVec%3C_%3E%3E%28%29%29%3B%0D%0A%09%09%2F%2F%3E+fib+13%3A+%5B0%2C+1%2C+1%2C+2%2C+3%2C+5%2C+8%2C+13%2C+21%2C+34%2C+55%2C+89%2C+144%5D%0D%0A%09%7D%0D%0A%09%0D%0A%09%2F%2F+pair+the+iter%0D%0A%09fn+iter_pair%3CI%3E%28iter%3A+%26I%29+-%3E+Option%3C%28I%3A%3AItem%2C+I%29%3E%0D%0A%09where%0D%0A%09%09I%3A+std%3A%3Aiter%3A%3AIterator+%2B+std%3A%3Aclone%3A%3AClone%2C%0D%0A%09%7B%0D%0A%09%09let+mut+iter_clone+%3D+iter.clone%28%29%3B%0D%0A%09%09iter_clone.next%28%29.map%28%7Chead%7C+%28head%2C+iter_clone%29%29%0D%0A%09%7D%0D%0A%09%0D%0A%09%7B%0D%0A%09%09let+fib+%3D+std%3A%3Aiter%3A%3Asuccessors%28%0D%0A%09%09%09%09Some%28%280%2C+1%29%29%2C+%0D%0A%09%09%09%09%7C%26%28a%2C+b%29%7C+Some%28%28b%2C+a+%2B+b%29%29%29%0D%0A%09%09%09.map%28%7C%28a%2C+_%29%7C+a%29%3B%0D%0A%09%09%0D%0A%09%09if+let+Some%28%28head%2C+tail%29%29+%3D+iter_pair%28%26fib%29+%0D%0A%09%09%7B%0D%0A%09%09%09println%21%28%220%3A+head%3A+%7B%7D%22%2C+head%29%3B+%2F%2F%3E+0%3A+head%3A+0%0D%0A%09%09%09println%21%28%220%3A+tail+13%3A+%7B%3A%3F%7D%22%2C+tail.take%2813%29.collect%3A%3A%3CVec%3C_%3E%3E%28%29%29%3B%0D%0A%09%09%09%2F%2F%3E+0%3A+tail+13%3A+%5B1%2C+1%2C+2%2C+3%2C+5%2C+8%2C+13%2C+21%2C+34%2C+55%2C+89%2C+144%2C+233%5D%0D%0A%09%09%09println%21%28%220%3A+fib+13%3A+%7B%3A%3F%7D%22%2C+fib.take%2813%29.collect%3A%3A%3CVec%3C_%3E%3E%28%29%29%3B%0D%0A%09%09%09%2F%2F%3E+0%3A+fib+13%3A+%5B0%2C+1%2C+1%2C+2%2C+3%2C+5%2C+8%2C+13%2C+21%2C+34%2C+55%2C+89%2C+144%5D%0D%0A%09%09%7D%0D%0A%09%7D%0D%0A%09%0D%0A%09%2F%2F+pair+the+iter+%28other+style%29%0D%0A%09trait+Iterador%3A+std%3A%3Aiter%3A%3AIterator+%2B+std%3A%3Aclone%3A%3AClone+%0D%0A%09%7B%0D%0A%09%09fn+pair%28%26self%29+-%3E+Option%3C%28Self%3A%3AItem%2C+Self%29%3E+%0D%0A%09%09%7B%0D%0A%09%09%09iter_pair%28self%29%0D%0A%09%09%7D%0D%0A%09%7D%0D%0A%09impl%3CT%3A+std%3A%3Aiter%3A%3AIterator+%2B+std%3A%3Aclone%3A%3AClone%3E+Iterador+for+T+%7B%7D%0D%0A%09%0D%0A%09%7B%0D%0A%09%09let+fib+%3D+std%3A%3Aiter%3A%3Asuccessors%28%0D%0A%09%09%09%09Some%28%280%2C+1%29%29%2C+%0D%0A%09%09%09%09%7C%26%28a%2C+b%29%7C+Some%28%28b%2C+a+%2B+b%29%29%29%0D%0A%09%09%09.map%28%7C%28a%2C+_%29%7C+a%29%3B%0D%0A%09%09%0D%0A%09%09if+let+Some%28%28head%2C+tail%29%29+%3D+fib.pair%28%29%0D%0A%09%09%7B%0D%0A%09%09%09println%21%28%221%3A+head%3A+%7B%7D%22%2C+head%29%3B+%2F%2F%3E+1%3A+head%3A+0%0D%0A%09%09%09println%21%28%221%3A+tail+13%3A+%7B%3A%3F%7D%22%2C+tail.take%2813%29.collect%3A%3A%3CVec%3C_%3E%3E%28%29%29%3B%0D%0A%09%09%09%2F%2F%3E+1%3A+tail+13%3A+%5B1%2C+1%2C+2%2C+3%2C+5%2C+8%2C+13%2C+21%2C+34%2C+55%2C+89%2C+144%2C+233%5D%0D%0A%09%09%09println%21%28%221%3A+fib+13%3A+%7B%3A%3F%7D%22%2C+fib.take%2813%29.collect%3A%3A%3CVec%3C_%3E%3E%28%29%29%3B%0D%0A%09%09%09%2F%2F%3E+1%3A+fib+13%3A+%5B0%2C+1%2C+1%2C+2%2C+3%2C+5%2C+8%2C+13%2C+21%2C+34%2C+55%2C+89%2C+144%5D%0D%0A%09%09%7D%0D%0A%09%7D%0D%0A%09%0D%0A%09%2F%2F+define+iterate%0D%0A%09fn+iter_iterate%3CT%2C+F%3E%28init%3A+T%2C+mut+f%3A+F%29+-%3E+impl+Iterador%3CItem+%3D+T%3E%0D%0A%09where%0D%0A%09%09T%3A+std%3A%3Aclone%3A%3AClone%2C%0D%0A%09%09F%3A+FnMut%28T%29+-%3E+T+%2B+std%3A%3Aclone%3A%3AClone%2C%0D%0A%09%7B%0D%0A%09%09std%3A%3Aiter%3A%3Asuccessors%28Some%28init.clone%28%29%29%2C+move+%7Cx%7C+Some%28f%28x.clone%28%29%29%29%29%0D%0A%09%7D%0D%0A%09%0D%0A%09%7B%0D%0A%09%09let+fib+%3D+iter_iterate%28%0D%0A%09%09%09%09%280%2C+1%29%2C+%0D%0A%09%09%09%09%7C%28a%2C+b%29%7C+%28b%2C+a+%2B+b%29%29%0D%0A%09%09%09.map%28%7C%28a%2C+_%29%7C+a%29%3B%0D%0A%09%09if+let+Some%28%28head%2C+tail%29%29+%3D+fib.pair%28%29%0D%0A%09%09%7B%0D%0A%09%09%09println%21%28%222%3A+head%3A+%7B%7D%22%2C+head%29%3B+%2F%2F%3E+2%3A+head%3A+0%0D%0A%09%09%09println%21%28%222%3A+tail+13%3A+%7B%3A%3F%7D%22%2C+tail.take%2813%29.collect%3A%3A%3CVec%3C_%3E%3E%28%29%29%3B%0D%0A%09%09%09%2F%2F%3E+2%3A+tail+13%3A+%5B1%2C+1%2C+2%2C+3%2C+5%2C+8%2C+13%2C+21%2C+34%2C+55%2C+89%2C+144%2C+233%5D%0D%0A%09%09%09println%21%28%222%3A+fib+13%3A+%7B%3A%3F%7D%22%2C+fib.take%2813%29.collect%3A%3A%3CVec%3C_%3E%3E%28%29%29%3B%0D%0A%09%09%09%2F%2F%3E+2%3A+fib+13%3A+%5B0%2C+1%2C+1%2C+2%2C+3%2C+5%2C+8%2C+13%2C+21%2C+34%2C+55%2C+89%2C+144%5D%0D%0A%09%09%7D%0D%0A%09%7D%0D%0A%09%0D%0A%09%2F%2F+define+unfold%0D%0A%09fn+iter_unfold%3CT%2C+S%2C+F%3E%28init%3A+S%2C+mut+f%3A+F%29+-%3E+impl+Iterador%3CItem+%3D+T%3E%0D%0A%09where%0D%0A%09%09F%3A+FnMut%28S%29+-%3E+%28T%2C+S%29+%2B+std%3A%3Aclone%3A%3AClone%2C%0D%0A%09%09S%3A+std%3A%3Aclone%3A%3AClone%2C+T%3A+std%3A%3Aclone%3A%3AClone%0D%0A%09%7B%0D%0A%09%09std%3A%3Aiter%3A%3Asuccessors%28%0D%0A%09%09%09%09Some%28f%28init.clone%28%29%29%29%2C+%0D%0A%09%09%09%09move+%7C%26%28_%2C+ref+s%29%7C+Some%28f%28s.clone%28%29%29%29%29%0D%0A%09%09%09.map%28%7C%28value%2C+_%29%7C+value%29%0D%0A%09%7D%0D%0A%09%0D%0A%09%7B%0D%0A%09%09let+fib+%3D+iter_unfold%28%280%2C+1%29%2C+%7C%28a%2C+b%29%7C+%28a%2C+%28b%2C+a+%2B+b%29%29%29%3B%0D%0A%09%09if+let+Some%28%28head%2C+tail%29%29+%3D+fib.pair%28%29%0D%0A%09%09%7B%0D%0A%09%09%09println%21%28%223%3A+head%3A+%7B%7D%22%2C+head%29%3B+%2F%2F%3E+3%3A+head%3A+0%0D%0A%09%09%09println%21%28%223%3A+tail+13%3A+%7B%3A%3F%7D%22%2C+tail.take%2813%29.collect%3A%3A%3CVec%3C_%3E%3E%28%29%29%3B%0D%0A%09%09%09%2F%2F%3E+3%3A+tail+13%3A+%5B1%2C+1%2C+2%2C+3%2C+5%2C+8%2C+13%2C+21%2C+34%2C+55%2C+89%2C+144%2C+233%5D%0D%0A%09%09%09println%21%28%223%3A+fib+13%3A+%7B%3A%3F%7D%22%2C+fib.take%2813%29.collect%3A%3A%3CVec%3C_%3E%3E%28%29%29%3B%0D%0A%09%09%09%2F%2F%3E+3%3A+fib+13%3A+%5B0%2C+1%2C+1%2C+2%2C+3%2C+5%2C+8%2C+13%2C+21%2C+34%2C+55%2C+89%2C+144%5D%0D%0A%09%09%7D%0D%0A%09%7D%0D%0A%7D%0D%0A

fn main() 
{
	// collect with no take
	{
		let a = std::iter::successors(Some(1_u16), |n| n.checked_mul(10));
		let x = a.collect::<Vec<_>>();
		assert_eq!(
			x, &[1, 10, 100, 1000, 10000]);
		println!("0: {:?}", x); //> 0: [1, 10, 100, 1000, 10000]
	}
	
	// take then collect
	{
		let a = std::iter::successors(Some(1_u16), |n| n.checked_mul(2));
		let x = a.take(5).collect::<Vec<_>>();
		assert_eq!(
			x, &[1, 2, 4, 8, 16]);
		println!("1: {:?}", x); //> 1: [1, 2, 4, 8, 16]
	}
	
	// take then collect but use * op
	{
		let a = std::iter::successors(Some(1), |n| Some(n * 2));
		let x = a.take(5).collect::<Vec<_>>();
		assert_eq!(
			x, &[1, 2, 4, 8, 16]);
		println!("2: {:?}", x); //> 2: [1, 2, 4, 8, 16]
	}
	
	// test checked_mul
	{
		assert_eq!(
			12_u16.checked_mul(20), Some(12_u16*20));
		println!("3: {:?}", 12_u16.checked_mul(20)); //> 3: Some(240)
	}
	
	// std::iter::successors like Stream.iterate in elixir
	
	// with map, like Stream.unfold in elixir
	{
		let fib = std::iter::successors(
				Some((0, 1)), 
				|&(a, b)| Some((b, a + b)))
			.map(|(a, _)| a);
		println!("fib 13: {:?}", fib.take(13).collect::<Vec<_>>());
		//> fib 13: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144]
	}
	
	// pair the iter
	fn iter_pair<I>(iter: &I) -> Option<(I::Item, I)>
	where
		I: std::iter::Iterator + std::clone::Clone,
	{
		let mut iter_clone = iter.clone();
		iter_clone.next().map(|head| (head, iter_clone))
	}
	
	{
		let fib = std::iter::successors(
				Some((0, 1)), 
				|&(a, b)| Some((b, a + b)))
			.map(|(a, _)| a);
		
		if let Some((head, tail)) = iter_pair(&fib) 
		{
			println!("0: head: {}", head); //> 0: head: 0
			println!("0: tail 13: {:?}", tail.take(13).collect::<Vec<_>>());
			//> 0: tail 13: [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233]
			println!("0: fib 13: {:?}", fib.take(13).collect::<Vec<_>>());
			//> 0: fib 13: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144]
		}
	}
	
	// pair the iter (other style)
	trait Iterador: std::iter::Iterator + std::clone::Clone 
	{
		fn pair(&self) -> Option<(Self::Item, Self)> 
		{
			iter_pair(self)
		}
	}
	impl<T: std::iter::Iterator + std::clone::Clone> Iterador for T {}
	
	{
		let fib = std::iter::successors(
				Some((0, 1)), 
				|&(a, b)| Some((b, a + b)))
			.map(|(a, _)| a);
		
		if let Some((head, tail)) = fib.pair()
		{
			println!("1: head: {}", head); //> 1: head: 0
			println!("1: tail 13: {:?}", tail.take(13).collect::<Vec<_>>());
			//> 1: tail 13: [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233]
			println!("1: fib 13: {:?}", fib.take(13).collect::<Vec<_>>());
			//> 1: fib 13: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144]
		}
	}
	
	// define iterate
	fn iter_iterate<T, F>(init: T, mut f: F) -> impl Iterador<Item = T>
	where
		T: std::clone::Clone,
		F: FnMut(T) -> T + std::clone::Clone,
	{
		std::iter::successors(Some(init.clone()), move |x| Some(f(x.clone())))
	}
	
	{
		let fib = iter_iterate(
				(0, 1), 
				|(a, b)| (b, a + b))
			.map(|(a, _)| a);
		if let Some((head, tail)) = fib.pair()
		{
			println!("2: head: {}", head); //> 2: head: 0
			println!("2: tail 13: {:?}", tail.take(13).collect::<Vec<_>>());
			//> 2: tail 13: [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233]
			println!("2: fib 13: {:?}", fib.take(13).collect::<Vec<_>>());
			//> 2: fib 13: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144]
		}
	}
	
	// define unfold
	fn iter_unfold<T, S, F>(init: S, mut f: F) -> impl Iterador<Item = T>
	where
		F: FnMut(S) -> (T, S) + std::clone::Clone,
		S: std::clone::Clone, T: std::clone::Clone
	{
		std::iter::successors(
				Some(f(init.clone())), 
				move |&(_, ref s)| Some(f(s.clone())))
			.map(|(value, _)| value)
	}
	
	{
		let fib = iter_unfold((0, 1), |(a, b)| (a, (b, a + b)));
		if let Some((head, tail)) = fib.pair()
		{
			println!("3: head: {}", head); //> 3: head: 0
			println!("3: tail 13: {:?}", tail.take(13).collect::<Vec<_>>());
			//> 3: tail 13: [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233]
			println!("3: fib 13: {:?}", fib.take(13).collect::<Vec<_>>());
			//> 3: fib 13: [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144]
		}
	}
}
