//
//  QuestionSectionPickerView.swift
//  IELTS Speaking Buddy
//
//  Created by Sourav on 29/8/24.
//
import SwiftUI


struct QuestionSectionPickerView: View {
    @Binding var selectedOption: String

    let options = ["Speaking Part 1", "Speaking Cue Card", "Speaking Part 3"]

    var body: some View {
        Picker("Section", selection: $selectedOption) {
            ForEach(options, id: \.self) { option in
                Text(option).tag(option)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}
