//
//  UploadCourses.swift
//  Varisty
//
//  Created by Christian Grinling on 13/12/2020.
//

import Foundation
import UIKit
import Firebase

class UploadCourses: UIViewController {

    var courses = ["Accounting & Finance", "Anatomy, Developmental & Human Biology", "Ancient History", "Biochemistry", "Biomedical Engineering", "Biomedical Science", "Business Management", "Chemistry", "Chemistry with Biomedicine", "Classical Studies", "Classical Studies & Comparative Literature", "Classical Studies with English", "Classics", "Comparative Literature", "Comparative Literature with Film Studies", "Computer Science", "Computer Science (Artificial Intelligence)", "Computer Science with Management", "Culture, Media & Creative Industries", "Dental Therapy & Hygiene", "Dentistry", "Digital Culture", "Economics", "Economics & Management", "Electronic Engineering", "English", "English & Modern Languages", "English Language & Linguistics", "English Law & American Law", "English Law & French Law", "English Law & German Law", "English Law & Hong Kong Law", "English Law & Spanish Law", "English Law with Australian Law", "English with Film Studies", "Enhanced Support Dentistry Programme", "European Politics", "European Studies", "Extended Medical Degree Programme", "Film Studies", "General Engineering", "Geography", "Geography and Environmental Science", "Global Health", "Global Health & Social Medicine", "Health Care Management", "History", "History & Modern Languages", "History & Political Economy", "History and International Relations", "Imaging Sciences", "International Development", "International Management", "International Relations", "Law", "Law with European Legal Studies", "Law with Hong Kong Law", "Law with North American Legal Studies", "Law with Transnational Legal Studies", "Liberal Arts", "Management & Modern Languages", "Mathematics", "Mathematics & Philosophy", "Mathematics with Management & Finance", "Mathematics with Statistics", "Medical Genetics", "Medical Physiology", "Medicine", "Midwifery", "Modern Languages", "Molecular Genetics", "Music", "Neuroscience", "Neuroscience and Psychology", "Nursing", "Nutritional Sciences", "Pharmacology", "Pharmacy", "Philosophy", "Philosophy & Modern Languages", "Philosophy, Politics & Economics", "Physics", "Physics & Philosophy", "Physics with Astrophysics and Cosmology", "Physics with Biophysics", "Physics with Theoretical Physics", "Physiology", "Physiotherapy", "Political Economy", "Politics", "Politics, Philosophy & Law", "Primary Care", "Psychology", "Regenerative Medicine & Innovation Technology", "Religion, Philosophy & Ethics", "Religion, Politics & Society", "Social Sciences", "Sport & Exercise Medical Sciences", "War Studies", "War Studies & History", "Women's Health"]

    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Firestore.firestore().collection("Courses").document("King's College London")
        for course in courses {
            ref.setData([course: 1], merge: true) { (error) in
                print("Uploaded ", course)
            }
        }
        print("Complete")
    }
}
