# Fibonacci Series & Anargams Algorithms

#### Question I. Write a function/method utilizing Swift to determine whether two strings are anagrams or not (examples of anagrams: debit card/bad credit, punishments/nine thumps, etc.)
Answer:

```
func findAnargams(firstString: String, secondString: String) -> Bool {
    var first = firstString
    var second = secondString
    
    first.removeAll { !$0.isLetter }
    second.removeAll { !$0.isLetter }
    return first.sorted() == second.sorted()
}

findAnargams(firstString: "debit card", secondString: "bad credit") -> true
findAnargams(firstString: "punishments", secondString: "nine thumps") -> false
```

#### Question II. Write a method in Swift to generate the nth Fibonacci number (1, 1, 2, 3, 5, 8, 13, 21, 34) 

A. recursive approach
```
func fibonaccinumber(nth: Int, n1: Int = 0, n2: Int = 1) -> Int {
    if nth <= 0 {
        print("nth value should be positive non-zero number")
        return 0
    } else {
        if nth == 1 {
            return n2
        } else {
            return fibonaccinumber(nth: nth - 1,
                                   n1: n2, n2: (n1 + n2))
        }
    }
}

fibonaccinumber(nth: 9) Output: 34
```
B. iterative approach

```
func fibonaccinumber(nth: Int) -> Int {
    var item1 = 0
    var item2 = 1
    
    if nth <= 0 {
        print("nth value should be positive non-zero number")
    } else {
        for _ in 0..<nth {
            let temp = item1 + item2
            item1 = item2
            item2 = temp
        }
    }
    return item1
}

fibonaccinumber(nth: 9) Output: 34
```
