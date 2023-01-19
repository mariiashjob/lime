//
//  TVChannelFilterLabel.swift
//  Limex
//
//  Created by m.shirokova on 17.01.2023.
//

import UIKit

final class TVChannelFilterButton: UIButton {
    private var tvChannelFilterStateModelDelegate = TVChannelFilterStateModel.shared
    var tvChannelFilterType: TVChannelFilterTypeModel? {
        didSet {
            setTitle(tvChannelFilterType?.rawValue, for: .normal)
            setTitleColor(titleColor(), for: .normal)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    func titleColor() -> UIColor {
        isTVChannelFilterTypeEnabled() ? UIColor.textEnableTab : UIColor.textDisableTab
    }
    func isTVChannelFilterTypeEnabled() -> Bool {
        tvChannelFilterStateModelDelegate.isTVChannelFilterTypeSelected(tvChannelFilterType)
    }
    private func setup() {
        titleLabel?.textAlignment = .center
        addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)
        createLabelConstraints()
    }
    private func createLabelConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 20.0).isActive = true
    }
    @objc func didButtonTapped(_ sender: UIButton) {
        tvChannelFilterStateModelDelegate.switchOnTVChannelFilterState(tvChannelFilterType)
    }
}
