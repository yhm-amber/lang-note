
mod pets 
{
	pub trait Dog 
	{
		fn run(&self) { println!("Dog running") }
		fn call(&self) { println!("Wang wang!") }
	}
	
	pub trait Cat 
	{
		fn run(&self) { println!("Cat running") }
		fn call(&self) { println!("Miao miao!") }
	}
	
	pub struct Pet;
	
	// 通过完全限定语法为同一类型实现多个 trait
	impl Dog for Pet 
	{
		// 这里可以覆盖默认实现
		// fn call(&self) { println!("Special dog call") }
	}
	
	impl Cat for Pet {}
}

fn main() 
{
	// 定义匿名函数（闭包）
	let dog_fn = |p: &dyn pets::Dog| 
	{
		p.call();
		p.run();
	};
	
	let cat_fn = |p: &dyn pets::Cat| 
	{
		p.call();
		p.run();
	};
	
	let animal = pets::Pet;
	
	// 调用时需明确指定 trait 对象类型
	println!("\nDog behavior:");
	dog_fn(&animal as &dyn pets::Dog); // 必须通过 as 转换
	
	println!("\nCat behavior:");
	cat_fn(&animal as &dyn pets::Cat);
	
	println!("\nDog call:");
	(&animal as &dyn pets::Dog).call();
}
