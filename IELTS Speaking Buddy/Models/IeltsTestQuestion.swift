/*
 See LICENSE folder for this sample’s licensing information.
 */

import Foundation

enum QuestionSection {
    case speakingPartOne
    case speakingCueCard
    case speakingPartTwo
}

struct IeltsTestQuestion: Identifiable, Codable {
    let id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var questionSection = "Speaking Cue Card"
    var lengthInMinutesAsDouble: Double {
        get {
            Double(lengthInMinutes)
        }
        set {
            lengthInMinutes = Int(newValue)
        }
    }
    var theme: Theme
    var transcript: [Transcript] = []
    var transcriptErrors: [String] = []

    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension IeltsTestQuestion {
    struct Attendee: Identifiable, Codable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    static var emptyTest: IeltsTestQuestion {
        IeltsTestQuestion(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
    }
}

extension IeltsTestQuestion {
    static let sampleData: [IeltsTestQuestion] =
    [
        IeltsTestQuestion(title: "Tell me about the place you grow up. a b c d e f g h i j k l m n" ,
                          attendees: ["Cathy"],
                          lengthInMinutes: 1,
                          theme: .orange),
        IeltsTestQuestion(title: "Tell me about the time you helped someone.",
                          attendees: ["Katie"],
                          lengthInMinutes: 2,
                          theme: .orange),
        IeltsTestQuestion(title: "Speaking Part 3",
                          attendees: ["Chella"],
                          lengthInMinutes: 3,
                          theme: .poppy)
    ]
}
