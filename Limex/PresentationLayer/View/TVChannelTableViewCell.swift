//
//  TVChannelTableViewCell.swift
//  Limex
//
//  Created by m.shirokova on 17.01.2023.
//

import UIKit

final class TVChannelTableViewCell: UITableViewCell {
    static let reuseIdentifier = "TVChannelTableViewCell"
    var tvChannelsViewDelegate: TVChannelsViewDelegate?
    var tvChannel: TVChannel?
    private var tvChannelFilterStateModelDelegate = TVChannelFilterStateModel.shared
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundTableViewCell
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    private let textStackView: UIStackView = {
        let stakView = UIStackView()
        stakView.distribution = .fillProportionally
        stakView.axis = .vertical
        return stakView
    }()
    private let tvChannelNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.textTVName
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    private let tvCurrentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.textTVCurentProgram
        label.font = UIFont(name:"Roboto", size: 15.0)
        return label
    }()
    private let tvChannelImageView: DownloadedImageView = {
        let imageView = DownloadedImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let starImageView: StarImageView = {
        let imageView = StarImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: Images.star.rawValue)
        return imageView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: TVChannelTableViewCell.reuseIdentifier)
        backgroundColor = UIColor.backgroundTableView
        selectionStyle = .none
        contentView.addSubview(cellView)
        cellView.addSubview(tvChannelImageView)
        cellView.addSubview(textStackView)
        cellView.addSubview(starImageView)
        textStackView.addArrangedSubview(tvChannelNameLabel)
        textStackView.addArrangedSubview(tvCurrentLabel)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didStarImageTapped(tapGestureRecognizer:)))
        starImageView.isUserInteractionEnabled = true
        starImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        cellView.frame = CGRect(x: 10,
                                y: 10,
                                width: contentView.frame.width - 20,
                                height: contentView.frame.height - 20)
        tvChannelImageView.frame = CGRect(x: 8,
                                          y: cellView.frame.height/2 - 30,
                                          width: 60, height: 60)
        textStackView.frame = CGRect(x: 100,
                                     y: 10,
                                     width: cellView.frame.width / 2,
                                     height: cellView.frame.height - 20)
        starImageView.frame = CGRect(x: cellView.frame.width - 50,
                                     y: cellView.frame.height/2 - 12,
                                     width: 24,
                                     height: 24)
    }
    func configure(with model: TVChannel, delegate: TVChannelsViewDelegate) {
        self.tvChannelsViewDelegate = delegate
        self.tvChannel = model
        tvChannelNameLabel.text = model.name
        tvCurrentLabel.text = model.current.title
        tvChannelImageView.downloadImage(urlString: model.image)
        starImageView.addStarImage(tvChannelId: model.id)
    }
    @objc func didStarImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let tvChannelId = tvChannel?.id else {
            return
        }
        let tvChannelsFavouritesString = UserDefaultsPersistance.shared.tvChannelsFavourites
        var tvChannelsFavouritesSet = tvChannelsFavouritesString?.fromStringToArraySeparatedBySymbol() ?? Set<Int>()
        if tvChannelsFavouritesSet.contains(tvChannelId) {
            tvChannelsFavouritesSet.remove(tvChannelId)
            UserDefaultsPersistance.shared.tvChannelsFavourites = tvChannelsFavouritesSet.description
            starImageView.image = UIImage(named: Images.star.rawValue)
        } else {
            tvChannelsFavouritesSet.insert(tvChannelId)
            UserDefaultsPersistance.shared.tvChannelsFavourites = tvChannelsFavouritesSet.description
            starImageView.image = UIImage(named: Images.selectedStar.rawValue)
        }
    }
}
