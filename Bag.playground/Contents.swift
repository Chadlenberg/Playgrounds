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
    
    // 1: provides a way to add elements to the bag: 2 parameters - generic type element and optional number of occurances
    mutating func add(_ member: Element, occurances: Int = 1) {
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
var shoppingCart = Bag<String>()
shoppingCart.add("Banana")
shoppingCart.add("Orange", occurances: 2)
shoppingCart.add("Banana")
shoppingCart.remove("Orange")