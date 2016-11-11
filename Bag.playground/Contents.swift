struct Bag<Element: Hashable> {
    // 1: Dictionary as Internal Data Structure
    fileprivate var contents = [Element: Int]()
    
    //2: Returns the number of unique Items
    var uniqueCount: Int {
        return contents.count
    }
    
    // 3: Returns the Total number of items
    var totalCount: Int {
        return contents.values.reduce(0) { $0 + $1 }
    }
    
    
    //: MARK initialization
    
    // 1: Empty Initialization method
    init(){}
    
    // 2: Accepts any Sequence of elements. the sequence must have a matching element type, Covers boty Array and Set Objects, iterates over the passed in sequence one element at a time
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        for element in sequence {
            add(element)
        }
    }
    
    // 3: For Tuple elements of type (Element, Int) like a dictionary. iterate over each sequence and add specified count
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Element, value: Int) {
        for (element, count) in sequence {
            add(element, occurances: count)
        }
    }
    // 1: provides a way to add elements to the bag: 2 parameters - generic type element and optional number of occurances
    mutating func add(_ member: Element, occurances: Int = 1) {
        
        
        precondition("\(shoppingCart)" == "\(shoppingCart.contents)", "Expected bag description to match its contents description")
        //2: takes a boolean as firs parameter, if false, execution will stop and the string will be output in the debug area.
        precondition(occurances > 0, "Can only add a positive number of occurrences")
        
        // 3: checks if element already exists in the bag, if yes increment count, if no, create new element
        if let currentCount = contents[member] {
            contents[member] = currentCount + occurances
        } else {
            contents[member] = occurances
        }
    }
    
    mutating func remove(_ member: Element, occurances: Int = 1) {
        
        // 1: Checks if Elements exists and has at least the number of occurances as being removed
        guard let currentCount = contents[member], currentCount >= occurances else {
            preconditionFailure("Removed non-existent elements")
        }
        
        // 2: Makes sure that the occurances to remove is greater than 0
        precondition(occurances > 0, "Can only remove a positive number of occurrences")
        
        //3:  checks if element exists and decrements the count, if the count drops to 0 it removes the element entirely.
        if currentCount > occurances {
            contents[member] = currentCount - occurances
        } else {
            contents.removeValue(forKey: member)
        }
    }
}
extension Bag: CustomStringConvertible {
    var description: String {
        return contents.description
    }
}

// array & dictionary literal init
extension Bag: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}

extension Bag: ExpressibleByDictionaryLiteral {
    init(dictionaryLiteral elements: (Element, Int)...) {
        // the map converts elements to the 'named' tuple the initializer expects.
        self.init(elements.map { (key: $0.0, value: $0.1) })
    }
}

//sequence init
extension Bag: Sequence {
    
    // 1: define typealias that conforms to interatorProtocol.dictionaryitorator (using this type because 'Bag' stores its underlying data in a dictionary)
    typealias Iterator = DictionaryIterator<Element, Int>
    
    // 2: returns iterator that can step through each element
    func makeIterator() -> Iterator {
        // 3: create iterator by performing makeiterator on contents
        return contents.makeIterator()
    }
}



var shoppingCart = Bag<String>()
shoppingCart.add("Banana")
shoppingCart.add("Orange", occurances: 2)
shoppingCart.add("Banana")
shoppingCart.remove("Orange")



let dataArray = ["Banana","Orange","Banana"]
let dataDictionary = ["Banana": 2, "Orange": 1]
let dataSet: Set = ["Banana", "Orange","Banana"]

/*var arrayBag = Bag(contents: dataArray)
precondition(arraybag.contents == dataDictionary, "Expected arrayBag contents to match \(dataDictionary))

var dictionaryBag = Bag(dataDictionary)
precondition(dictionaryBag.contents == dataDictionary, "Expected dictionaryBag contents to match \(dataDictionary)")
*/
var setBag = Bag(dataSet)
precondition(setBag.contents == ["Banana": 1, "Orange": 1], "Expected setBag contents to match \(["Banana": 1, "Orange": 1])")




// initialization protocols section

var arrayLiteralBag: Bag = ["Banana", "Orange", "Banana"]
precondition(arrayLiteralBag.contents == dataDictionary, "Expected arrayLiteralBag contents to match \(dataDictionary)")

var dictionaryLiteralBag: Bag = ["Banana": 2, "Orange": 1]
precondition(dictionaryLiteralBag.contents == dataDictionary, "Expected dictionaryLiteralBag contents to match \(dataDictionary)")




// Sequence
for element in shoppingCart {
    print(element)
}

for (element, count) in shoppingCart {
    print ("Element: \(element), Count: \(count)")
}



