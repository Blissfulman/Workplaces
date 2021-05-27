//
//  ProfileSegmentedControl.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 10.05.2021.
//

import UIKit

final class ProfileSegmentedControl: UISegmentedControl {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        setTitleTextAttributes([.foregroundColor: Palette.middleGrey, .font: Fonts.bodyLarge], for: .normal)
        setTitleTextAttributes([.foregroundColor: Palette.black], for: .selected)
        setBackgroundImage(UIImage(), for: .normal, barMetrics: UIBarMetrics.default)
        setDividerImage(
            UIImage(),
            forLeftSegmentState: .normal,
            rightSegmentState: .normal,
            barMetrics: UIBarMetrics.default
        )
    }
}
