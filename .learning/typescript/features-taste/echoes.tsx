console.log( '--------' )

const echoes0 = 
(waves: {[key: string]: (env: {[key: string]: any}) => any})
: {[key: string]: any} =>
    Object.entries(waves).reduce
    (
        (envs, [fn, f]) => ({... envs, [fn]: f(envs)}) ,
        {} as {[key: string]: any}
    ) ;

const ffs =
{
    f1: (env: { [key: string]: Function }) => (n: number): number => 1 + n ,
    f2: (env: { [key: string]: Function }) => (x: number): number => env.f1(x * 2) ,
} ;

console.log( echoes0(ffs).f2(3) )

const xx =
{
    x0: (env: { [key: string]: any }) => 
        
        1 ,
    
    f: (env: { [key: string]: any }) => 
        
        (s: string)
        : number => s.length ,
    
    f2: (env: { [key: string]: any }) => 
        
        (s: string, n: number)
        : Promise<number> => Promise.resolve(env.f(s) + n - env.x0) ,
} ;

const echoes =
<T = {[key: string]: any},> (waves: {[key: string]: (env: T) => any}): T =>
    Object.entries(waves).reduce
    (
        (envs, [fn, f]) => ({... envs, [fn]: f(envs)}) ,
        {} as T
    ) ;

// echoes<{f2: ReturnType<typeof xx.f2>}>(xx).f2('a',3).then(r => console.log(r));
// echoes(xx).f2('a',3).then( (r: number) => console.log(r) );

namespace Echoes
{
    export 
    const echoes =
    <T = {[key: string]: any},> (waves: {[key: string]: (env: T) => any})
    : T =>
        Object.entries(waves).reduce
        (
            (envs, [fn, f]) => ({... envs, [fn]: f(envs)}) ,
            {} as T
        ) ;

    export 
    const call = 
    <T extends Record<K, (...args: any) => any>, K extends keyof T>
    (obj: T, key: K): { [P in K]: ReturnType<T[P]>; }[K] =>
        echoes<{[P in K]: ReturnType<T[P]>}>(obj)[key] ;
    
} ;

Echoes.echoes<{f2: ReturnType<typeof xx.f2>}>(xx).f2('a',3).then(r => console.log(r));
Echoes.echoes(xx).f2('a',3).then( (r: number) => console.log(r) );

Echoes.call(xx,'f2')('a',3).then(r => console.log(r));


// console.log( '------' )

// const arr = [[1,2], [2,3], [3,5], [4,7]];
// const sum = arr.reduce((acc, [k,v]) => acc + v - k, 2);
// console.log(sum);

// const o = {a: 1, b: 2}; const o2 = {... o, ['c']: 3} ; console.log(o2)

// console.log( Object.entries(o) )

// const e = [["a", 1], ["b", 2]] ;
// const x = e.reduce( (acc, [k,v]) => ({... acc, [k + 'x']: v}), o )



