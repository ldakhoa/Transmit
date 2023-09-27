import Foundation

struct Episode: Identifiable {
    let id: Int
    let name: String
    let description: String
    let uploadDate: String
}

extension Episode {
    static let mockData: [Episode] = [
        Episode(id: 5, name: "Bill Lumbergh", description: "He’s going to need you to go ahead and come in on Saturday, but there’s a lot more to the story than you think.", uploadDate: "February 24, 2022"),
        Episode(id: 4, name: "Shooter McGavin", description: "When golf-obsessed terrorists kidnapped his family and held them hostage in exchange for a Golden Jacket, Shooter had no choice but to win the tour at any cost.", uploadDate: "February 17, 2022"),
        Episode(id: 3, name: "The Wet Bandits", description: "The Christmas of 1989 wasn’t the first time Harry and Marv crossed paths with the McCallisters. The real story starts in 1973, when Peter tripped Marv in the highschool locker room.", uploadDate: "February 10, 2022"),
        Episode(id: 2, name: "Hank Scorpio", description: "What looks to outsiders like a malicious plan to conquer the east coast, was actually a story of liberation and freedom if you get it straight from the source.", uploadDate: "February 3, 2022"),
        Episode(id: 1, name: "Skeletor", description: "You know him as an evil supervillain, but his closest friends call him Jeff, and he's just doing his best to find his way in a world that doesn't know what to do with a talking skeleton.", uploadDate: "January 27, 2022")
    ]
}
