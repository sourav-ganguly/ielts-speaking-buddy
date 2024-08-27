/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct MeetingTimerView: View {
    let speaker: Speaker
    let percentElapsed: Int
    let isRecording: Bool
    let theme: Theme
    
    private var currentSpeaker: String {
        speaker.name
    }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is speaking")
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
                        .accessibilityLabel(isRecording ? "with transcription" : "without transcription")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
            .overlay  {
//                Circle()
//                    .stroke(theme.mainColor, lineWidth: 16)
//                    .padding(12)

                PercentageArc(currentPercent: percentElapsed)
                    .stroke(theme.mainColor, lineWidth: 12)
            }
            .padding(.horizontal)
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var speakers: [Speaker] {
        [Speaker(name: "Bill", isCompleted: true), Speaker(name: "Cathy", isCompleted: false), Speaker(name: "Cathy", isCompleted: false)]
    }
    
    static var previews: some View {
        MeetingTimerView(speaker: Speaker(name: "Abc", isCompleted: false), percentElapsed: 15, isRecording: true, theme: .yellow)
    }
}
