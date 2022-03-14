//
//  CourseChoice.swift
//  Varisty
//
//  Created by Christian Grinling on 26/11/2020.
//

import UIKit
import Firebase

class CourseChoice: UITableViewController, UISearchResultsUpdating {
    
    var filteredCourse: [String]?
    weak var delegate: ChoiceDelegate?
    let searchController = UISearchController(searchResultsController: nil)
    var uni: String?
    var UnfilteredCourse = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CourseCell")
        tableView.tableHeaderView = searchController.searchBar
        getcourses()

    }
    
    func getcourses() {
        guard let University = uni else {return}
        let courseRef = Firestore.firestore().collection("Courses").document(University)
        courseRef.getDocument { (document, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                guard let data = document?.data() else {return}
                let courses = data.keys
                let coursesSorted = courses.sorted()
                for course in coursesSorted {
                    self.UnfilteredCourse.append(course)
                }
                DispatchQueue.main.async {
                    self.filteredCourse = self.UnfilteredCourse
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredCourse = UnfilteredCourse.filter { uni in
                return uni.lowercased().contains(searchText.lowercased())
            }
            
        } else {
            filteredCourse = UnfilteredCourse
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
        guard let UnfilteredCourse = filteredCourse else {
            return 0
        }
        return UnfilteredCourse.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell")! as UITableViewCell
        if let UnfilteredCourse = filteredCourse {
            let course = UnfilteredCourse[indexPath.row]
            cell.textLabel!.text = course
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.isActive = false
        let cell = tableView.cellForRow(at: indexPath)!
        let choice = cell.textLabel!.text ?? ""
        if let delegate = self.delegate {
            delegate.changeValuecourse(value: choice)
        }
        self.dismiss(animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
