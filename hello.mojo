fn main():
    test[2, "uno", "dos"]()


fn test[n: Int, *s: String]():
    for i in range(n):
        print(s[i])


fn greet[a: Int, b:Int](name: String) -> fn() escaping -> None:
    print(name)
    fn fun[n: Int]():
        @unroll
        for i in range(n):
            print("Hello, " + "!")
    return fun[a*b]