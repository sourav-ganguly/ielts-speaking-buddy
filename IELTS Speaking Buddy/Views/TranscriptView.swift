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
                        .padding(.bottom, 2)
                        .foregroundColor(Color.blue)
                    Text(transcript)
                }

                if let errorsInTranscript = transcript.errorsInTranscript {
                    Text("Errors **and** Suggestions")
                        .font(.headline)
                        .padding(.top, 25)
                        .padding(.bottom, 2)
                        .foregroundColor(Color.red)
                    Text(errorsInTranscript)
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
                   transcript:
"""
My name of my hometown is Bakun this is a beautiful place the area is located within the division of Bhel this is not a village this is more like a small town but there is no traffic jam there is there a lot of trees and nature and we have a beautiful river we have bridge over the river sometimes we hang out with our friends on the bridge also there is a park just beside the river there is a long park and a few kilometre long and you can walk and enjoy enjoy the nature park
""",
                   errorsInTranscript:
"""
Here are the grammar errors found in your transcript:

1. "My name of my hometown is Bakun" should be "The name of my hometown is Bakun."
2. "this is a beautiful place" should be "It is a beautiful place." (to avoid starting multiple sentences in the same way).
3. "the area is located within the division of Bhel" should be "the area is located in the division of Bhel." (use 'in' for location).
4. "this is not a village this is more like a small town" should be "This is not a village; it is more like a small town." (use 'it' for clarity and separate independent clauses).
5. "but there is no traffic jam there is there a lot of trees" should be "but there are no traffic jams, and there are a lot of trees." (use 'are' with plural 'jams' and correct structure).
6. "and we have a beautiful river" is somewhat redundant after previous sentences; consider rephrasing it for clarity by connecting it better.
""")
    }

    static var previews: some View {
        TranscriptView(transcript: history)
    }
}
