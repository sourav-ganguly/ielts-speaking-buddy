/*
 See LICENSE folder for this sample’s licensing information.
 */

import Foundation

struct Transcript: Identifiable, Codable {
    let id: UUID
    let date: Date
    var attendees: [IeltsTestQuestion.Attendee]
    var transcript: String?
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [IeltsTestQuestion.Attendee], transcript: String? = nil) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.transcript = transcript
    }
}
