//
//  SectionHiddenBackground.swift
//  We Split
//
//  Created by vdcao on 4/4/23.
//

import SwiftUI

struct SectionHiddenBackground: ViewModifier {
    func body(content: Content) -> some View {
        content.onAppear {
            UISegmentedControl.appearance().selectedSegmentTintColor = .systemIndigo
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        }
        .onDisappear {
            UISegmentedControl.appearance().selectedSegmentTintColor = .systemIndigo
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        }
    }
}
