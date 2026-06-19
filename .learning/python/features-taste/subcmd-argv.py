#!/usr/bin/env python3

if __name__ == '__main__':
	from sys import argv
	_script_name = argv.pop(0)
	from result import Ok, Err, as_result
	match as_result(IndexError)(list.pop)(argv, 0):
		case Ok('subcmd_a') | Ok('a'):
			print('sub: a')
			pass
		case Ok('subcmd_b') | Ok('b'):
			print('sub: b')
			pass
		case Ok('help') | Ok('h') | Err(IndexError(args = ('pop from empty list',))):
			print('h')
			pass  # show help
		case Ok(x):
			print(f'not found such sub command: {x}')
			print('h')
			pass  # show subs here
		case Ok(e):
			print(f'met error: {e}')
	...


