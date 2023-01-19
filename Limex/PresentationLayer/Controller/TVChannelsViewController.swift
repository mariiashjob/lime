//
//  ViewController.swift
//  Limex
//
//  Created by m.shirokova on 17.01.2023.
//

import UIKit

class TVChannelsViewController: UIViewController {
    private var tvChannels: [TVChannel] = []
    private var tvChannelsView: TVChannelsView! {
        guard isViewLoaded else { return nil }
        return (view as! TVChannelsView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tvChannelsView.configure()
        configureTableView()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tvChannels = TVChannelsViewModel.shared.filteredChannels()
        tvChannelsView.tableView.reloadData()
    }
}

private extension TVChannelsViewController {
    func configureTableView() {
        tvChannelsView.tableView.register(TVChannelTableViewCell.self, forCellReuseIdentifier: TVChannelTableViewCell.reuseIdentifier)
        tvChannelsView.tableView.delegate = self
        tvChannelsView.tableView.dataSource = self
        TVChannelsViewModel.shared.tvChannels() { channels in
            self.tvChannels = channels
        }
    }
}

extension TVChannelsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tvChannels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TVChannelTableViewCell.reuseIdentifier) as? TVChannelTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: tvChannels[indexPath.row], delegate: tvChannelsView)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
