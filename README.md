# Swift + JSON
Since the first days of Swift, developers have been exploring strategies for dealing with JSON. While some call this "JSON Parsing", with [few](https://github.com/bignerdranch/Freddy) [exceptions](https://github.com/vdka/JSON) most people rely on `NSJSONSerialization` for the actual parsing. Most of the effort has gone into finding the best way to map JSON objects (dictionaries and arrays) into model objects (structs, classes, enums).

## A Convergence of Ideas
<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">&quot;I believe there&#39;s a JSON platonic ideal and all Swift implementations converge towards it&quot;</p>&mdash; (quoted on Twitter, original author unknown) </blockquote>

Many projects have emerged to take on this challenge, employing various approaches and philosophies. It's interesting that several of these projects have taken a very similar approach, ostensibly independent of each other. Here are some examples:

* [Marshal](https://github.com/utahiosmac/Marshal)
* [Mapper](https://github.com/lyft/mapper)
* [Unbox](https://github.com/JohnSundell/Unbox)
* [Decodable](https://github.com/Anviking/Decodable)
* [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper)
* [Gloss](https://github.com/hkellaway/Gloss)
* [Genome](https://github.com/LoganWright/Genome)

The power of the approach taken by these projects lies in the ability to easily map not only primitive JSON types, but also custom types and objects in a type safe manner.

For example, the goal is to be able to do something like this: 

```swift
let title:String = try json.value(for: "header.title")
let users:[User] = try json.value(for: "users")
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

struct Program {
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
        startTs = try? json.value(for: "StartTs")
        endTs = try? json.value(for: "EndTs")
        startTsStr = try json.value(for: "StartTs")
        recordId = try json.value(for: "RecordId")
        status = (try? json.value(for: "Status")) ?? .Unknown
        recGroup = (try? json.value(for: "RecGroup")) ?? .Unknown
    }
}

extension Program: Unmarshaling {
    public init(object json: MarshaledObject) throws {
        title = try json.value(for: "Title")
        chanId = try json.value(for: "Channel.ChanId")
        startTime = try json.value(for: "StartTime")
        endTime = try json.value(for: "EndTime")
        description = try json.value(for: "Description")
        subtitle = try json.value(for: "SubTitle")
        recording = try json.value(for: "Recording")
        season = (try json.value(for: "Season") as String?).flatMap({Int($0)})
        episode = (try json.value(for: "Episode") as String?).flatMap({Int($0)})
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
    public init(unboxer: Unboxer) throws {
        startTs = unboxer.unbox(key: "StartTs", formatter:NSDate.ISO8601SecondFormatter)
        endTs = unboxer.unbox(key: "EndTs", formatter:NSDate.ISO8601SecondFormatter)
        startTsStr = try unboxer.unbox(key: "StartTs")
        recordId = try unboxer.unbox(key: "RecordId")
        status = unboxer.unbox(key: "Status") ?? .Unknown
        recGroup = unboxer.unbox(key: "RecGroup") ?? .Unknown
    }
}

extension Program: Unboxable {
    public init(unboxer: Unboxer) throws {
        title = try unboxer.unbox(key: "Title")
        chanId = try unboxer.unbox(keyPath: "Channel.ChanId")
        startTime = try unboxer.unbox(key: "StartTime", formatter:NSDate.ISO8601SecondFormatter)
        endTime = try unboxer.unbox(key: "EndTime", formatter:NSDate.ISO8601SecondFormatter)
        description = unboxer.unbox(key: "Description")
        subtitle = unboxer.unbox(key: "SubTitle")
        recording = try unboxer.unbox(key: "Recording")
        season = unboxer.unbox(key: "Season")
        episode = unboxer.unbox(key: "Episode")
    }
}

// Extract an array of Programs
let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! UnboxableDictionary
let programs:[Program] = try! unbox(dictionary: dict, atKeyPath: "ProgramList.Programs")
```

###Decodable

```swift
extension Recording : Decodable {
    public static func decode(_ json: Any) throws -> Recording {
        return try Recording(
            startTsStr: json => "StartTs",
            status: Status(rawValue: json => "Status") ?? .Unknown,
            recordId: json => "RecordId",
            recGroup: RecGroup(rawValue: json => "RecGroup") ?? .Unknown
        )
    }
}

extension Program: Decodable {
    public static func decode(_ json: Any) throws -> Program {
        return try Program(
            title: json => "Title",
            chanId: json => "Channel" => "ChanId",
            startTime = json => "StartTime",
            endTime = json => "EndTime",
            description: json => "Description",
            subtitle: json => "SubTitle",
            recording: json => "Recording",
            season: Int(json => "Season" as String),
            episode: Int(json => "Episode" as String)
        )
    }
}

// Extract an array of Programs
let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
let programs:[Program] = try! dict => "ProgramList" => "Programs"
```

### Gloss
```swift
extension Recording: Decodable {
  public init?(json: JSON) {
    self.startTsStr = "StartTs" <~~ json ?? ""
    self.recordId   = "RecordId" <~~ json ?? ""
    self.status     = "Status" <~~ json ?? Status.Unknown
    self.recGroup   = "RecGroup" <~~ json ?? RecGroup.Unknown
  }
}

extension Program: Decodable {
    public init?(json: JSON) {
        title       = "Title" <~~ json ?? ""
        chanId      = "channel.ChanId" <~~ json ?? ""
        description = "Description" <~~ json
        subtitle    = "SubTitle" <~~ json
        season      = "Season" <~~ json
        episode     = "Episode" <~~ json
        recording   = ("Recording" <~~ json)!
    }
}

// Extract an array of Programs
let dict: [String: Any] = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
let programs: [Program] = "ProgramList.Programs" <~~ dict ?? []
```

### Genome

```swift
extension Recording: MappableObject {
    public init(map: Map) throws {
        startTsStr = try map.extract("StartTs")
        status = try map.extract("Status") { Status(rawValue: $0) ?? .Unknown }
        recordId = try map.extract("RecordId")
        recGroup = try map.extract("RecGroup") { RecGroup(rawValue: $0) ?? .Unknown }
    }
    public func sequence(_ map: Map) throws { }
}

extension Program: MappableObject {
    public init(map: Map) throws {
        title = try map.extract("Title") { $0 ?? "" }
        chanId = try map.extract("channel", "ChanId") { $0 ?? "" }
        description = try map.extract("Description")
        subtitle = try map.extract("SubTitle")
        season = try map.extract("Season")
        episode = try map.extract("Episode")
        recording = try Recording(node: try map.extract("Recording"))
    }
    public func sequence(_ map: Map) throws { }
}

// Extract an array of Programs
let json = try! data.makeNode()
let programs: [Program] = try! [Program](node: json["ProgramList", "Programs"]!)
```

##Analysis
You can immediately see the similarities between the three projects. I won't get into the details of how they work here. You can read more about each project, or read Jason Larsen's 
[three](http://jasonlarsen.me/2015/06/23/no-magic-json.html) 
[blog](http://jasonlarsen.me/2015/06/23/no-magic-json-pt2.html) 
[posts](http://jasonlarsen.me/2015/10/16/no-magic-json-pt3.html).

Most of these JSON mappers can handle `NSURL`s. They can also handle `NSDate`s with the help of formatters. Marshal and Mapper automatically handle enums with raw types. Unbox requires enums to conform to a special protocol. The power of these projects lies in the ability to make the JSON mapper aware of new types, whether they be simple fields that can be transformed from a string such as dates, or more complex types and even nested types like our Program and Recording above. 
##Type Safety

Many of these projects provide a measure of type safety at compile time. The compiler is aware of what types are supported, so you can't attempt to extract a type that the JSON extractor can't handle. For example, the compiler won't let you try this:

`let name: UIView = try json.value(for: "firstName")`

This code will fail to compile because `UIView` does not conform to the necessary protocol. All of the projects in the Shootout support this compile-time safety except for ObjectMapper and Gloss.
##Protocol Extensions vs. Wrappers

Many of these frameworks work by wrapping a dictionary in another object. Marshal differs in that it is implemented as a protocol with a protocol extension. Both `NSDictionary` and `Dictionary<String, Any>` conform to the protocol. Other types can easily conform to the protocol simply by providing an implementation for `optionalAny(for key: KeyType)`.
##What about SwiftyJSON?

SwiftyJSON was one of the earliest projects to help Swift developers deal with JSON. Compared to more recent projects, SwiftyJSON is verbose and error prone. It doesn't take advantage of Swift's type system to enable safety, error handling, and expressive code. As you'll see below, the performance is quite bad as well.
##What about Argo?

Argo requires two additional dependencies (Curry and Runes) which feels kind of heavy. The liberal use of custom operators is off-putting to many developers. When trying to map to the two model objects above with Argo, the Swift compiler emitted the dreaded error `Expression was too complex to be solved in reasonable time`. As a result Argo is more rigid and the model objects had to be changed to get things to work. Argo was the worst-performing framework tested. Because the model objects had to be changed to get Argo to work, the master branch does not have support for Argo. A separate `argo` branch is available if someone would like to see how it works.
##Performance
Now that we have all of the JSON mappers processing the same JSON file, we can compare the performance of each. While measuring performance I noticed that a lot of time was spent in date parsing. Since this was common across all implementations, I removed the dates from the model objects to get a better comparison of the performance of the JSON mappers themselves.

This graph shows time spent in each of the mappers as well as time spent in `NSJSONSerialization` for a reference.


![Performance Graph](https://raw.githubusercontent.com/bwhiteley/JSONShootout/master/images/performance.png)

###* A Note About vdka/json and Freddy
You might notice that the "JSON" and "Freddy" bars in the graph are different from the rest. These projects use their own JSON deserializers instead of `NSJSONSerialization`. 

##That Thing on the Swift Blog
There was a Swift blog post about [working with JSON in Swift](https://developer.apple.com/swift/blog/?id=37). The concluding section seems to discourage the use of a JSON framework and instead use the features available in the Swift language itself. However, the post is referring specifically to abstractions that use reflection to automatically map between dictionaries and model objects. None of the frameworks evaluated here do that, but instead favor explicitness. The error handling example from the Swift blog post demonstrates why using a `guard let` approach to JSON is a bad idea for any significant amount of JSON processing. It is very verbose, repetitive, and error prone. The frameworks evaluated here provide a concise and declarative way to work with JSON while avoiding "magic."

##Conclusion
If you are looking for a Swift JSON mapper, you might want to clone JSONShootout and compare these frameworks side-by-side yourself. 
### Installation
1. Clone the project
2. Run `carthage bootstrap --no-build`
3. Open the workspace
4. Run the unit tests in the JSONShootoutTests target

##Contributing
If you would like to add another framework for comparison, submit a pull request after making the following changes: 

1. Add the new framework to the `Cartfile`.
2. Run `carthage update --no-build`.
3. Drag the new framework project to the top level of the workspace.
4. Add the new framework to the Linked Frameworks and Libraries section of the ModelObjects target.
5. Add the new framework to the Linked Frameworks and Libraries section of the JSONShootout target. 
6. Add the new framework to the Embedded Binaries section of the JSONShootout target.
7. Make sure there are no duplicates in Linked Frameworks and Libraries (Xcode bug).
8. Check the project file (`JSONShootout.xcodeproj/project.pbxproj`). There should be no references to `Carthage` or user-specific derived data paths. See [this bug](http://www.openradar.me/radar?id=6091575503355904) for details.
9. Add new extensions to `Program` and `Recording`. See the existing files for an example. 
10. Add a new unit test file. See existing files for an example.

<sub>Full Disclosure: I contribute to the Marshal project.</sub>
