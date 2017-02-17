//
//  MovieListTableView.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 2/8/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class MovieListTableView: UITableView  {
    fileprivate let cellIdentifier = String(describing: MovieListTableCell.self)
    weak var listDelegate: MovieListViewDelegate?
    
    init(frame: CGRect) {
        super.init(frame: frame, style: .plain)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
}

// MARK: Configuration
private extension MovieListTableView {
    func configure() {
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        
        self.delegate = self
        self.dataSource = self
        self.separatorInset = .zero
        clipsToBounds = false
        self.register(nib,
                      forCellReuseIdentifier: cellIdentifier)
    }
}

// MARK: MovieListView
extension MovieListTableView: MovieListView {
    func cell(atIndex index: Int) -> MovieListCell? {
        return cellForRow(at: IndexPath(row: index, section: 0)) as? MovieListCell
    }
}

// MARK: UITableViewDataSource
extension MovieListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDelegate?.numberOfCells() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        
        listDelegate?.configure(cell: cell as! MovieListTableCell, atIndex: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
}

// MARK: UITableViewDelegate
extension MovieListTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listDelegate?.didSelectRow(atIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
