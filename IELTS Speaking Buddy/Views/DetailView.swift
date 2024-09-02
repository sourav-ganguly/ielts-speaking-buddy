/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct DetailView: View {
    @Binding var scrum: IeltsTestQuestion
    @State private var editingScrum = IeltsTestQuestion.emptyTest

    @State private var isPresentingEditView = false

    var body: some View {
        List {
            Section(header: Text("Question Info")) {
                NavigationLink(destination: ExamView(question: $scrum)) {
                    Label("Start the test", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }

                HStack {
                    Label("Question", systemImage: "pencil.line")
                    Spacer()
                    Text("\(scrum.title)")
                        .lineLimit(1)
                        .frame(maxWidth: 150)
                }

                HStack {
                    Label("Section", systemImage: "list.bullet.rectangle.portrait")
                    Spacer()
                    Text("\(scrum.questionSection)")
                        .lineLimit(1)
                        .frame(maxWidth: 150)
                }

                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)

                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }

            Section(header: Text("Transcripts")) {
                if scrum.transcript.isEmpty {
                    Label("No transcripts yet", systemImage: "calendar.badge.exclamationmark")
                }
                ForEach(scrum.transcript) { history in
                    NavigationLink(destination: TranscriptView(transcript: history)) {
                        HStack {
                            Image(systemName: "calendar")
                            Text(history.date, style: .date)
                        }
                    }
                }
            }
        }
        .navigationTitle(scrum.questionSection)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                editingScrum = scrum
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                QuestionEditView(scrum: $editingScrum)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                scrum = editingScrum
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(scrum: .constant(IeltsTestQuestion.sampleData[0]))
        }
    }
}
