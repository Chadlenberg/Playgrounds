import Foundation

enum RideType {
    case Family
    case Kids
    case Thrill
    case Scary
    case Relaxing
    case Water
}

struct Ride {
    let name: String
    let types: Set<RideType>
    let waitTime: Double
}


var x = 3
// other stuff...
x = 4

let parkRides = [
    Ride(name: "Raging Rapids", types: [.Family, .Thrill,.Water], waitTime: 45.0),
    Ride(name: "Crazy Funhouse", types: [.Family], waitTime: 10.0),
    Ride(name: "Spinning Tea Cups", types: [.Kids], waitTime: 15.0),
    Ride(name: "Spooky Hollow", types: [.Family, .Thrill], waitTime: 30.0),
    Ride(name: "Thunder Coaster", types: [.Family, .Thrill], waitTime: 60.0),
    Ride(name: "Grand Carousel", types: [.Family, .Kids], waitTime: 15.0),
    Ride(name: "Bumper Boats", types: [.Family, .Water], waitTime: 25.0),
    Ride(name: "Mountain Railroad", types: [.Family, .Relaxing], waitTime: 0.0)
]


// parkRides[0] = Ride(name: "functional Programing", types: [.Thrill], waitTime: 5.0)

/*func sortedNames(rides: [Ride]) -> [String] {
    var sortedRides = rides
    
    // 1 - Looping over all the rides passed into the function
    for (index, sortedRide) in sortedRides.enumerated() {
        // 2 - Performing an insertion sort
        for j in stride(from: index, to: -1, by: -1) {
            if sortedRide.name.localizedCompare(sortedRides[j].name) == .orderedAscending {
                sortedRides.remove(at: j + 1)
                sortedRides.insert(sortedRide, at: j)
            }
        }
    }
    
    // 3 - Gathering the names of the sorted rides
    var sortedNames = [String]()
    for ride in sortedRides {
        sortedNames.append(ride.name)
    }
    
    
    print(sortedNames)
    return sortedNames
}*/

// sortedNames(rides: parkRides)

var originalNames = [String]()
for ride in parkRides {
    originalNames.append(ride.name)
}
print(originalNames)


func waitTimeIsShort(ride:Ride) -> Bool {
    return ride.waitTime < 15.0
}

waitTimeIsShort(ride: parkRides[5])

var shortWaitTimes = parkRides.filter(waitTimeIsShort)
print(shortWaitTimes)

shortWaitTimes = parkRides.filter { $0.waitTime < 15.0 }
print(shortWaitTimes)

let rideNames = parkRides.map {$0.name}
print(rideNames)

print(rideNames.sorted(by: <))

let averageWaitTime = parkRides.reduce(0.0) { (average, ride) in average + (ride.waitTime/Double(parkRides.count))}
print(" The average wait time is \(averageWaitTime)")


func ridesWithWaitTimeUnder(waitTime: Double, fromRides rides: [Ride]) -> [Ride] {
    return rides.filter { $0.waitTime < waitTime }
}

var shortWaitRides = ridesWithWaitTimeUnder(waitTime: 15.0, fromRides: parkRides)
assert(shortWaitRides.count == 2, "Count of short wait Rides should be 2")
print(shortWaitRides)


extension Ride: Comparable {}

func <(lhs: Ride, rhs: Ride) -> Bool {
    return lhs.waitTime < rhs.waitTime
}

func ==(lhs: Ride, rhs: Ride) -> Bool {
    return lhs.name == rhs.name
}

/*func quicksort<T: Comparable>(elements: [T]) -> [T] {
    
    if elements.count > 1 {
        var element = elements
        let first = elements.first
        let pivot = element.remove(at: 0)
        return quicksort(elements: element.filter {$0 <= pivot} as! [_]) + [pivot] + quicksort(elements: element.filter { $0 > pivot })
    }
    return elements
} */

func quicksort<T: Comparable>(elements: [T]) -> [T] {
    var elements = elements
    if elements.count > 1 {
        let pivot = elements.remove(at: 0)
        return quicksort(elements: elements.filter { $0 <= pivot }) + [pivot] + quicksort(elements: elements.filter { $0 > pivot })
    }
    return elements
}

var ridesOfInterest = [Ride]()
for ride in parkRides {
    var typeMatch = false
    for type in ride.types {
        if type == .Family {
            typeMatch = true
            break
        }
    }
    if typeMatch && ride.waitTime < 20.0 {
        ridesOfInterest.append(ride)
    }
}

var sortedRidesOfInterest = quicksort(ridesOfInterest)

print(sortedRidesOfInterest)





