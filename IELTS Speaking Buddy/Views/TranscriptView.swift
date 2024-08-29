/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct TranscriptView: View {
    let transcript: Transcript

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                if let transcript = transcript.transcript {
                    Text("Transcript")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                }
            }
        }
        .navigationTitle(Text(transcript.date, style: .date))
        .padding()
    }
}

extension Transcript {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map { $0.name })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var history: Transcript {
        Transcript(attendees: [
            IeltsTestQuestion.Attendee(name: "Jon"),
            IeltsTestQuestion.Attendee(name: "Darla"),
            IeltsTestQuestion.Attendee(name: "Luis")
        ],
                transcript: "Darla, would you like to start today? Sure, yesterday I reviewed Luis' PR and met with the design team to finalize the UI...")
    }
    
    static var previews: some View {
        TranscriptView(transcript: history)
    }
}
