/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct QuestionEditView: View {
    @Binding var scrum: IeltsTestQuestion
    @State private var newAttendeeName = ""

    var body: some View {
        Form {
            Section(header: Text("Question Info")) {

                TextField("Add Question", text: $scrum.title)

                QuestionSectionPickerView(selectedOption: $scrum.questionSection)

                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 1...30, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }

                ThemePicker(selection: $scrum.theme)
            }
        }
    }
}


struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionEditView(scrum: .constant(IeltsTestQuestion.sampleData[0]))
    }
}
