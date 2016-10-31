
public struct User {
  public let id: String
  public let index: Int
  public let guid: String
  public let isActive: Bool
  public let balance: String
  public let picture: String
  public let age: Int
  public let eyeColor: Color
  public let name: String
  public let gender: Gender
  public let company: String
  public let email: String
  public let phone: String
  public let address: String
  public let about: String
  public let registered: String
  public let latitude: Double
  public let longitude: Double
  public let tags: [String]
  public let friends: [Friend]
  public let greeting: String
  public let favoriteFruit: String

  public enum Color: String {
    case red, green, blue, brown
  }

  public enum Gender: String {
    case male, female
  }

  public struct Friend {
    public let id: Int
    public let name: String
  }
}
