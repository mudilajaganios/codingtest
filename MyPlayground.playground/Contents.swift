import UIKit

//func findAnargams(firstString: String, secondString: String) -> Bool {
//    var first = firstString
//    var second = secondString
//
//    first.removeAll { !$0.isLetter }
//    second.removeAll { !$0.isLetter }
//    return first.sorted() == second.sorted()
//}
//
//findAnargams(firstString: "debit card", secondString: "bad credit")
//findAnargams(firstString: "punishments", secondString: "nine thumps")

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

fibonaccinumber(nth: 9)
