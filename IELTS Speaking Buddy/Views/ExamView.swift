/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
import AVFoundation

struct ExamView: View {
    @Binding var question: IeltsTestQuestion
    @StateObject var scrumTimer = ScrumTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    let speaker = Speaker(name: "Mr. Abdul", isCompleted: false)

    private var player: AVPlayer { AVPlayer.sharedDingPlayer }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(question.theme.mainColor)
            VStack {

                Text(question.questionSection)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)

                QuestionView(question: question.title)
                    .padding(.horizontal)

                QuestionTimerView(
                    speaker: speaker,
                    percentElapsed: scrumTimer.percentTimeElapsed,
                    isRecording: isRecording,
                    theme: question.theme
                )

                QuestionDetailTimerView(
                    secondsElapsed: scrumTimer.secondsElapsed,
                    secondsRemaining: scrumTimer.secondsRemaining,
                    theme: question.theme
                )
                .padding(.bottom)
            }
        }
        .padding()
        .foregroundColor(question.theme.accentColor)
        .onAppear {
            startScrum()
        }
        .onDisappear {
            endScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func startScrum() {
        scrumTimer.reset(lengthInMinutes: question.lengthInMinutes, attendees: question.attendees)
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
        scrumTimer.startScrum()
    }

    private func endScrum() {
        scrumTimer.stopScrum()
        speechRecognizer.stopTranscribing()
        isRecording = false

        getErrorInTranscript(speechRecognizer.transcript)
    }

    private func getErrorInTranscript(_ transcript: String) {
        let api = API()
        Task {
            do {
                let errorsInTranscript = try await api.createChatCompletion(prompt: "This is a IELTS exam speaking question. I am giving you a answer. Find out all grammar errors in the answer from the transcript below point by point: \(transcript)")
                print("Chat GPT output is \(errorsInTranscript ?? "")")

                let newHistory = Transcript(attendees: question.attendees,
                                            transcript: transcript,
                                            errorsInTranscript: errorsInTranscript)
                question.transcript.insert(newHistory, at: 0)

            } catch {
                print("Error: \(error)")
            }
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        ExamView(question: .constant(IeltsTestQuestion.sampleData[0]))
    }
}


struct QuestionView: View {
    let question: String

    var body: some View {
        Text(question)
            .font(.title)
            .frame(maxWidth: .infinity)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2)
            )
    }
}
