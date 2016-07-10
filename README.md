# Swift + JSON
Since the first days of Swift, developers have been exploring strategies for dealing with JSON. While some call this "JSON Parsing", with few exceptions most people rely on `NSJSONSerialization` for the actual parsing. Most of the effort has gone into finding the best way to map JSON objects (dictionaries and arrays) into model objects (structs, classes, enums).
## A Convergence of Ideas
Many projects have emerged to take on this challenge, employing various approaches and philosophies. It's interesting that three of these projects have taken a very similar approach, ostensibly independent of each other. These three are:

* [Marshal](https://github.com/utahiosmac/Marshal)
* [Mapper](https://github.com/lyft/mapper)
* [Unbox](https://github.com/JohnSundell/Unbox)

The power of the approach taken by these projects lies in the ability to easily map not only primitive JSON types, but also custom types and objects in a type safe manner.

For example, the goal is to be able to do something like this: 

```swift
let title:String = try json.valueForKey("header.title")
let users:[User] = try json.valueForKey("users")
```

All of the frameworks listed above leverage Swift's powerful type system to handle all of the details. 

## A Detailed Look

I put together a small project to compare these Swift JSON mappers. Let's look at some objects from a Digital Video Recorder feed:
### The Objects

```swift
struct Recording {
    let startTs:NSDate?
    let endTs:NSDate?
    let startTsStr:String
    let status:Status // enum
    let recordId:String
    let recGroup:RecGroup // enum
}

public struct Program {
    let title:String
    let chanId:String
    let startTime:NSDate
    let endTime:NSDate
    let description:String?
    let subtitle:String?
    let recording:Recording // nested object
    let season:Int?
    let episode:Int?
}
```

Now let's look at how these objects would be extracted with each of the JSON mappers. We'll ignore proper error handling for this exercise. 
###Marshal
```swift
extension Recording: Unmarshaling {
    public init(object json:MarshaledObject) throws {
        startTs = try? json.valueForKey("StartTs")
        endTs = try? json.valueForKey("EndTs")
        startTsStr = try json.valueForKey("StartTs")
        recordId = try json.valueForKey("RecordId")
        status = (try? json.valueForKey("Status")) ?? .Unknown
        recGroup = (try? json.valueForKey("RecGroup")) ?? .Unknown
    }
}

extension Program: Unmarshaling {
    public init(object json: MarshaledObject) throws {
        title = try json.valueForKey("Title")
        chanId = try json.valueForKey("Channel.ChanId")
        startTime = try json.valueForKey("StartTime")
        endTime = try json.valueForKey("EndTime")
        description = try json.valueForKey("Description")
        subtitle = try json.valueForKey("SubTitle")
        recording = try json.valueForKey("Recording")
        season = (try json.valueForKey("Season") as String?).flatMap({Int($0)})
        episode = (try json.valueForKey("Episode") as String?).flatMap({Int($0)})
    }
}

// Extract an array of Programs
let json = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
let programs:[Program] = try json.valueForKey("ProgramList.Programs")
```

###Mapper

```swift
extension Recording: Mappable {
    public init(map: Mapper) throws {
        startTs =  map.optionalFrom("StartTs")
        endTs =  map.optionalFrom("EndTs")
        startTsStr = try map.from("StartTs")
        recordId = try map.from("RecordId")
        status = map.optionalFrom("Status") ?? .Unknown
        recGroup = map.optionalFrom("RecGroup") ?? .Unknown
    }
}

extension Program: Mappable {
    public init(map: Mapper) throws {
        title = try map.from("Title")
        chanId = try map.from("Channel.ChanId")
        startTime = try map.from("StartTime")
        endTime = try map.from("EndTime")
        description = try map.from("Description")
        subtitle = try map.from("SubTitle")
        recording = try map.from("Recording")
        season = (try map.from("Season") as String?).flatMap({Int($0)})
        episode = (try map.from("Episode") as String?).flatMap({Int($0)})
    }
}

// Extract an array of Programs
let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
let mapper = Mapper(JSON: dict)
let programs:[Program] = try! mapper.from("ProgramList.Programs")
```

###Unbox

```swift
extension Recording: Unboxable {
    public init(unboxer: Unboxer) {
        startTs = unboxer.unbox("StartTs", formatter:NSDate.ISO8601SecondFormatter)
        endTs = unboxer.unbox("EndTs", formatter:NSDate.ISO8601SecondFormatter)
        startTsStr = unboxer.unbox("StartTs")
        recordId = unboxer.unbox("RecordId")
        status = unboxer.unbox("Status") ?? .Unknown
        recGroup = (unboxer.unbox("RecGroup")) ?? .Unknown
    }
}

extension Program: Unboxable {
    public init(unboxer: Unboxer) {
        title = unboxer.unbox("Title")
        chanId = unboxer.unbox("Channel.ChanId", isKeyPath: true)
        startTime = unboxer.unbox("StartTime", formatter:NSDate.ISO8601SecondFormatter)
        endTime = unboxer.unbox("EndTime", formatter:NSDate.ISO8601SecondFormatter)
        description = unboxer.unbox("Description")
        subtitle = unboxer.unbox("SubTitle")
        recording = unboxer.unbox("Recording")
        season = (unboxer.unbox("Season") as String?).flatMap({Int($0)})
        episode = (unboxer.unbox("Episode") as String?).flatMap({Int($0)})
    }
}

// Extract an array of Programs
let programs:[Program] = try! Unboxer.performCustomUnboxingWithData(data) { unboxer in
    let programs:[Program] = unboxer.unbox("ProgramList.Programs", isKeyPath:true)
    return programs
}
```
##Analysis
You can immediately see the similarities between the three projects. I won't get into the details of how they work here. You can read more about each project, or read Jason Larson's 
[three](http://jasonlarsen.me/2015/06/23/no-magic-json.html) 
[blog](http://jasonlarsen.me/2015/06/23/no-magic-json-pt2.html) 
[posts](http://jasonlarsen.me/2015/10/16/no-magic-json-pt3.html).

All three of the JSON mappers can handle `NSURL`s. They can also handle `NSDate`s with the help of formatters. Marshal and Mapper automatically handle enums with raw types. Unbox requires enums to conform to a special protocol. The power of all three projects lies in the ability to make the JSON mapper aware of new types, whether they be simple fields that can be transformed from a string such as dates, or more complex types and even nested types like our Program and Recording above. 
##Type Safety

Marshal and Unbox have an advantage over Mapper because the compiler is aware of what types are supported, so you can't attempt to extract a type that the JSON extractor can't handle. For example, this will compile with Mapper, even though it can never succeed at runtime:

`let name:UIView = try map.from("firstName")`

With Marshal and Unbox however, the corresponding code will fail to compile because `UIView` does not conform to the necessary protocol. As a result, Marshal and Unbox are more type safe.
##Protocol Extensions vs. Wrappers

Both Unbox and Mapper work by wrapping a dictionary in another object. Marshal differs in that it is implemented as a protocol with a protocol extension. Both `NSDictionary` and `Dictionary<String, AnyObject>` conform to the protocol. Any other type implementing `subscript` can conform to the protocol as well. 
##Performance
Now that we have all three JSON mappers processing the same JSON file, we can compare the performance of each. I also threw in SwiftyJSON, one of the earliest Swift projects for handling JSON. While measuring perfornamce I noticed that a lot of time was spent in date parsing. Since this was common across all implementations, I removed the dates from the model objects to get a better comparison of the performance of the JSON mappers themselves.

This graph shows time spent in each of the mappers as well as time spent in `NSJSONSerialization` for a reference.


![Performance Graph](https://raw.githubusercontent.com/bwhiteley/JSONShootout/master/images/performance.png)

As you can see, Marshal and Mapper are virtually identical while Unbox and SwiftyJSON are significantly slower. 

##Conclusion
If you are looking for a Swift JSON mapper, you might want to clone JSONShootout and compare these frameworks side-by-side yourself. 
### Installation
1. Clone the project
2. Run `carthage bootstrap --no-build`
3. Open the workspace
4. Run the unit tests in the JSONShootoutTests target



<sub>Full Disclosure: I contribute to the Marshal project.</sub>
