//
//  PercentageArc.swift
//  IELTS Speaking Buddy
//
//  Created by Sourav on 27/8/24.
//
import SwiftUI

struct PercentageArc: Shape {
    
    let currentPercent: Int

    private var degreesPerPercent: Double {
        3.6
    }
    private var startAngle: Angle {
        Angle(degrees: -90.0)
    }
    private var endAngle: Angle {
        Angle(degrees: Double(currentPercent) * degreesPerPercent - 90.0)
    }

    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}
