//
//  TVChannelsView.swift
//  Limex
//
//  Created by m.shirokova on 17.01.2023.
//

import UIKit

protocol TVChannelsViewDelegate {
    func updateView()
    func reloadTableData()
}

final class TVChannelsView: UIView, TVChannelsViewDelegate {
    let tableView = UITableView()
    private let searchStackView = UIStackView()
    private let tabsStackView = UIStackView()
    private let tabLine = CALayer()
    private let imageView = UIImageView()
    private let searchTextField = UITextField()
    override func layoutSubviews() {
        super.layoutSubviews()
        addSwitchingTabLine()
    }
    func configure() {
        TVChannelFilterStateModel.shared.tvChannelsViewDelegate = self
        addSubview(searchStackView)
        addSubview(tabsStackView)
        addSubview(tableView)
        backgroundColor = UIColor.backgroundView
        configureSearchView()
        configureTabsStackView()
        configureTableView()
    }
    func updateView() {
        updateTabsTextColor()
        reloadTableData()
    }
    private func updateTabsTextColor() {
        guard let tabs = tabsStackView.subviews as? [TVChannelFilterButton] else {
            return
        }
        for tab in tabs {
            tab.setTitleColor(tab.titleColor(), for: .normal)
        }
    }
    private func addSwitchingTabLine() {
        guard let tabs = tabsStackView.subviews as? [TVChannelFilterButton],
              let tab = tabs.filter({ $0.isTVChannelFilterTypeEnabled() == true }).first else {
            return
        }
        tabLine.frame = CGRect(x: 0.0, y: tab.frame.height - 1, width: tab.frame.width, height: 3.0)
        tabLine.backgroundColor = UIColor.lineColor.cgColor
        tab.layer.addSublayer(tabLine)
    }
    func reloadTableData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    private func configureSearchView() {
        searchStackView.distribution = .fillProportionally
        searchStackView.axis = .horizontal
        searchStackView.backgroundColor = UIColor.backgroundSearchView
        searchStackView.clipsToBounds = true
        searchStackView.layer.cornerRadius = 16.0
        searchStackView.spacing = 10.0
        searchStackView.addArrangedSubview(imageView)
        searchStackView.addArrangedSubview(searchTextField)
        createSearchViewConstraints()
        configureImageView()
        configureSearchTextFieldView()
    }
    private func configureImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Images.shape.rawValue)
        createImageViewConstraints()
    }
    private func configureSearchTextFieldView() {
        searchTextField.textColor = UIColor.textSearchField
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: Texts.placeholderSearchField.rawValue,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.textPlaceholderSearchField])
        createSearchTextFieldConstraints()
    }
    private func configureTabsStackView() {
        tabsStackView.distribution = .fillProportionally
        tabsStackView.axis = .horizontal
        createTabsStackViewConstraints()
        let tabAll = TVChannelFilterButton()
        tabAll.tvChannelFilterType = TVChannelFilterTypeModel.all
        let tabFavourite = TVChannelFilterButton()
        tabFavourite.tvChannelFilterType = TVChannelFilterTypeModel.favourites
        tabsStackView.addArrangedSubview(tabAll)
        tabsStackView.addArrangedSubview(tabFavourite)
    }
    private func configureTableView() {
        tableView.backgroundColor = UIColor.backgroundTableView
        tableView.separatorStyle = .none
        updateView()
        createTableViewConstraints()
    }
    private func createSearchViewConstraints() {
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        searchStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12.0).isActive = true
        searchStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12.0).isActive = true
        searchStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 12.0).isActive = true
        searchStackView.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
    }
    private func createTabsStackViewConstraints() {
        tabsStackView.translatesAutoresizingMaskIntoConstraints = false
        tabsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8.0).isActive = true
        tabsStackView.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -8.0).isActive = true
        tabsStackView.topAnchor.constraint(equalTo: searchStackView.bottomAnchor, constant: 8.0).isActive = true
        tabsStackView.heightAnchor.constraint(equalToConstant: 56.0).isActive = true
        tabsStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2).isActive = true
    }
    private func createTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0.0).isActive = true
        tableView.topAnchor.constraint(equalTo: tabsStackView.bottomAnchor, constant: 8.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0).isActive = true
    }
    private func createImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 18.21).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 18.21).isActive = true
        imageView.leftAnchor.constraint(equalTo: searchStackView.leftAnchor, constant: 15.0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: searchStackView.centerYAnchor, constant: 0.0).isActive = true
    }
    private func createSearchTextFieldConstraints() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.rightAnchor.constraint(lessThanOrEqualTo: searchStackView.rightAnchor, constant: -35.0).isActive = true
        searchTextField.centerYAnchor.constraint(equalTo: searchStackView.centerYAnchor, constant: 0.0).isActive = true
    }
}
