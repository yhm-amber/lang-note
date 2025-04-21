
{
	use std::io::BufRead as _;
	
	fn main() -> 
		std::io::Result<()> 
	{
		std::io::stdin().lock().lines()
			.map_while(|line| line.ok())
			.scan(Vec::new(), |acc, line| 
			{
				match line.trim() 
				{
					"|" => None, 
					s if !s.is_empty() => 
					{
						acc.push(s.to_owned());
						Some(acc.join("|"))
					}, 
					_ => Some(String::new()), 
				}
			})
			.take_while(|s| !s.is_empty())
			.for_each(|output| println!("{output}"));
		
		Ok(())
	}
}



{
	use std::io::BufRead as _;
	
	fn main() -> std::io::Result<()> 
	{
		let stdin = std::io::stdin();
		let mut handle = stdin.lock();
		let mut inputs = Vec::new();
		
		loop 
		{
			let mut buffer = String::new();
			
			match handle.read_line(&mut buffer) 
			{
				Ok(0) => break, 
				Ok(_) => 
				{
					let input = buffer.trim();
					if input == "|" {break;}
					if !input.is_empty() {inputs.push(input.to_string());}
					if !inputs.is_empty() {println!("{}", inputs.join("|"));}
				}, 
				Err(e) => return Err(e),
			}
		}
		
		Ok(())
	}
}


