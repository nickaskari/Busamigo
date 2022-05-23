import UIKit
import MapKit
import Foundation

protocol test {
    var something: String {
        get
    }
   
    func doSomething() -> Int
}

struct test2: test {
    var something: String
    
    func doSomething() -> Int {
        return 69
    }
}

struct ok {
    var val: test
    
    init(arg: test) {
        self.val = arg
    }
}

let kok = test2(something: "F@st")
let kok2 = ok(arg: kok)
print(kok2.val.something + "--" + "\(kok2.val.doSomething())")


