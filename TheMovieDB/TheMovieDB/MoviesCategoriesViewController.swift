//
//  MoviesCategoriesViewController.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 2/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class MoviesCategoriesViewController: UIViewController {
    var onDidChange : ((_ movileListType: MoviesListType) -> Void)?
    @IBOutlet var tableView : UITableView!
    fileprivate let cellIdentifier = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: cellIdentifier)
    }
    
}

extension MoviesCategoriesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoviesListType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        
        cell.textLabel?.text = String(describing: MoviesListType.allCases[indexPath.row])
        return cell
    }
}

extension MoviesCategoriesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        onDidChange?(MoviesListType.allCases[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}

