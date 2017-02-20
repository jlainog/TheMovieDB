//
//  MoviesCategoriesViewController.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 2/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class MoviesCategoriesViewController: UIViewController {
    var selectedListType : MoviesListType?
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
        let movieType = MoviesListType.allCases[indexPath.row]
        
        if let selectedListType = self.selectedListType {
            cell.accessoryType = movieType == selectedListType ? .checkmark : .none
        }
        
        cell.textLabel?.text = String(describing: movieType)
        return cell
    }
}

extension MoviesCategoriesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onDidChange?(MoviesListType.allCases[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}

