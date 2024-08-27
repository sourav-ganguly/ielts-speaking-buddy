//
//  to.swift
//  IELTS Speaking Buddy
//
//  Created by Sourav on 28/8/24.
//
import Foundation


/// A struct to keep track of meeting attendees during a meeting.
    struct Speaker: Identifiable {
        /// The attendee name.
        let name: String
        /// True if the attendee has completed their turn to speak.
        var isCompleted: Bool
        /// Id for Identifiable conformance.
        let id = UUID()
    }
