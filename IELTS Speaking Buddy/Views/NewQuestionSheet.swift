/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct NewQuestionSheet: View {
    @State private var newTest = IeltsTestQuestion.emptyTest
    @Binding var tests: [IeltsTestQuestion]
    @Binding var isPresentingNewScrumView: Bool

    var body: some View {
        NavigationStack {
            QuestionEditView(scrum: $newTest)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewScrumView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            tests.append(newTest)
                            isPresentingNewScrumView = false
                        }
                    }
                }
        }
    }
    }


struct NewScrumSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewQuestionSheet(tests: .constant(IeltsTestQuestion.sampleData), isPresentingNewScrumView: .constant(true))
    }
}
