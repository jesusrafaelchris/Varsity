//
//  UniversityChoice.swift
//  Varisty
//
//  Created by Christian Grinling on 26/11/2020.
//

import UIKit
import Firebase

class UniversityChoice: UITableViewController, UISearchResultsUpdating {
    
    var filteredUniversity: [String]?
    weak var delegate: ChoiceDelegate?
    let searchController = UISearchController(searchResultsController: nil)
    var uni: String?
    var UnfilteredUniversity = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UniCell")
        tableView.tableHeaderView = searchController.searchBar
        getunis()

    }
    
    
    func getunis() {
        let uniRef = Firestore.firestore().collection("Universities").document("Total")
        uniRef.getDocument { (document, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                guard let data = document?.data() else {return}
                let universities = data.keys
                let universitiesSorted = universities.sorted()
                for university in universitiesSorted {
                    self.UnfilteredUniversity.append(university)
                }
                DispatchQueue.main.async {
                    self.filteredUniversity = self.UnfilteredUniversity
                    self.tableView.reloadData()
                    }
            }
        }

    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredUniversity = UnfilteredUniversity.filter { uni in
                return uni.lowercased().contains(searchText.lowercased())
            }
            
        } else {
            filteredUniversity = UnfilteredUniversity
        }
    DispatchQueue.main.async {
        self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let UnfilteredUniversity = filteredUniversity else {
            return 0
        }
        return UnfilteredUniversity.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UniCell")! as UITableViewCell
        if let UnfilteredUniversity = filteredUniversity {
            let Uni = UnfilteredUniversity[indexPath.row]
            cell.textLabel!.text = Uni
        }
        return cell
    }
    
    func getEmailEnding(university: String, completion: @escaping (_ email: String) -> Void) {
        let emailref = Firestore.firestore().collection("UniversityEmails").document(university)
        emailref.getDocument { (document, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                guard let data = document?.data() else {return}
                guard let emailEnding = data["Email"] as? String else {return}
                completion(emailEnding)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.isActive = false
        let cell = tableView.cellForRow(at: indexPath)!
        let choice = cell.textLabel!.text ?? ""
        
        if let delegate = self.delegate {
            getEmailEnding(university: choice) { (emailEnding) in
                delegate.setEmailEnding(value: emailEnding)
            }
            delegate.changeValueuniversity(value: choice)
        }
        self.dismiss(animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
