//
//  SignUpPage.swift
//  Varisty
//
//  Created by Christian Grinling on 21/11/2020.
//

import UIKit
import Firebase

protocol ChoiceDelegate: AnyObject {
    func changeValuecourse(value: String)
    func changeValueuniversity(value: String)
    func setEmailEnding(value: String)
}

protocol ProfileViewControllerProtocol {
    func setCroppedImage(_ croppedImage: UIImage)
}

class SignUpPage: UIViewController, ChoiceDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ProfileViewControllerProtocol {
    
    func setCroppedImage(_ croppedImage: UIImage) {
        profilePicture.image = croppedImage
    }
    
    func changeValueuniversity(value: String) {
        uni = value
        universityfield.text = uni
    }
 
    func changeValuecourse(value: String) {
        course = value
        coursefield.text = course
    }
    
    func setEmailEnding(value: String) {
        emailEnding = value
        emailEndingLabel.text = emailEnding
    }
    
    
    var uni: String?
    var course: String?
    var emailEnding: String?
    var profilePicChanged = false
    
    var logoColour = UIColor.white//UIColor(red: 0.32, green: 0.42, blue: 0.93, alpha: 1.00)
    var logoImageColour = UIColor(red: 0.32, green: 0.42, blue: 0.93, alpha: 1.00)
    let borderwidth = CGFloat(3)
    let cornervalue = CGFloat(24)
    let grayColour = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
    
    lazy var picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        //picker.allowsEditing = true
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        return picker
    }()
    
    lazy var Signuplabel: UILabel = {
        let Signuplabel = UILabel()
        Signuplabel.text = "Sign up"
        Signuplabel.font = UIFont.systemFont(ofSize: 35, weight: UIFont.Weight.bold)
        Signuplabel.textColor = .black
        Signuplabel.translatesAutoresizingMaskIntoConstraints = false
        return Signuplabel
    }()
    
    lazy var profilePicture: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person.crop.circle.badge.plus")?.withTintColor(logoImageColour, renderingMode: .alwaysOriginal)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 60
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        //image.layer.borderWidth = 2
        //image.backgroundColor = .red
        return image
     }()
    
    lazy var namefield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Full name"
        textfield.backgroundColor = grayColour
        textfield.layer.borderColor = logoColour.cgColor
        textfield.layer.borderWidth = borderwidth
        textfield.layer.cornerRadius = cornervalue
        textfield.addPadding()
        textfield.layer.masksToBounds = true
        return textfield
    }()
    
    lazy var universityfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Please Select Your University"
        textfield.backgroundColor = grayColour
        textfield.layer.borderColor = logoColour.cgColor
        textfield.layer.borderWidth = borderwidth
        textfield.layer.cornerRadius = cornervalue
        textfield.addPadding()
        textfield.layer.masksToBounds = true
        return textfield
    }()
    
    lazy var coursefield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Please Select Your Course"
        textfield.backgroundColor = grayColour
        textfield.layer.borderColor = logoColour.cgColor
        textfield.layer.borderWidth = borderwidth
        textfield.layer.cornerRadius = cornervalue
        textfield.layer.masksToBounds = true
        textfield.addPadding()
        return textfield
    }()
    
    lazy var emailfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Email"
        textfield.backgroundColor = grayColour
        textfield.layer.borderColor = logoColour.cgColor
        textfield.layer.borderWidth = borderwidth
        textfield.layer.cornerRadius = cornervalue
        textfield.layer.masksToBounds = true
        textfield.addPadding()
        return textfield
    }()
    
    lazy var emailEndingContainerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = logoImageColour
        return view
    }()
    
    lazy var emailEndingLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        //label.text = "@kcl.ac.uk"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var passwordfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Password"
        textfield.backgroundColor = grayColour
        textfield.layer.borderColor = logoColour.cgColor
        textfield.layer.borderWidth = borderwidth
        textfield.layer.cornerRadius = cornervalue
        textfield.layer.masksToBounds = true
        textfield.isSecureTextEntry = true
        textfield.addPadding()
        return textfield
    }()
    
    let yearbuttonRoundness = CGFloat(18)
    
    let year1Colour = UIColor(red: 0.27, green: 0.38, blue: 0.95, alpha: 1.00)
    let year2Colour = UIColor(red: 0.10, green: 0.24, blue: 0.99, alpha: 1.00)
    let year3Colour = UIColor(red: 0.04, green: 0.15, blue: 0.75, alpha: 1.00)
    let year4Colour = UIColor(red: 0.02, green: 0.10, blue: 0.52, alpha: 1.00)
    
    lazy var year1button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = year1Colour
        button.layer.masksToBounds = true
        button.layer.cornerRadius = yearbuttonRoundness
        button.addYearTitle(text: "Year 1")
        button.addTarget(self, action: #selector(year1selected), for: .touchUpInside)
        return button
    }()
    
    var year1Selected = false
    var year2Selected = false
    var year3Selected = false
    var year4Selected = false
    
    lazy var year2button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = year2Colour
        button.layer.masksToBounds = true
        button.layer.cornerRadius = yearbuttonRoundness
        button.addYearTitle(text: "Year 2")
        button.addTarget(self, action: #selector(year2selected), for: .touchUpInside)
        return button
    }()
    
    lazy var year3button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = year3Colour
        button.layer.masksToBounds = true
        button.layer.cornerRadius = yearbuttonRoundness
        button.addYearTitle(text: "Year 3")
        button.addTarget(self, action: #selector(year3selected), for: .touchUpInside)
        return button
    }()
    
    lazy var year4button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = year4Colour
        button.layer.masksToBounds = true
        button.layer.cornerRadius = yearbuttonRoundness
        button.addYearTitle(text: "Year 4")
        button.addTarget(self, action: #selector(year4selected), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = NSLayoutConstraint.Axis.horizontal
        stackview.distribution = UIStackView.Distribution.equalSpacing
        stackview.alignment = UIStackView.Alignment.center
        stackview.spacing = 5
        return stackview
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = logoImageColour
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        universityfield.delegate = self
        coursefield.delegate = self
        setupgestures()
    }

    
    func setupgestures() {
        
       let UniGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ShowUnis(gesture:)))
       let CourseGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ShowCourses(gesture:)))
        let chooseProfilePictureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChangeProfileImage(gesture:)))
        
        self.universityfield.isUserInteractionEnabled = true
        self.coursefield.isUserInteractionEnabled = true
        self.profilePicture.isUserInteractionEnabled = true
        UniGestureRecognizer.numberOfTapsRequired = 1
        CourseGestureRecognizer.numberOfTapsRequired = 1
        chooseProfilePictureRecognizer.numberOfTapsRequired = 1
        
        self.universityfield.addGestureRecognizer(UniGestureRecognizer)
        self.coursefield.addGestureRecognizer(CourseGestureRecognizer)
        self.profilePicture.addGestureRecognizer(chooseProfilePictureRecognizer)
        signUpButton.addTarget(self, action: #selector(signup), for: .touchUpInside)
    }
    
    @objc func ShowUnis(gesture: UITapGestureRecognizer) {
        let uniChoices = UniversityChoice()
        uniChoices.delegate = self
        navigationController?.present(uniChoices, animated: true, completion: nil)
    }
    
    @objc func ShowCourses(gesture: UITapGestureRecognizer) {
        let courseChoices = CourseChoice()
        if uni == nil {
            AlertofError("Please try again.", "Please select a University")
        }
        else {
            courseChoices.delegate = self
            courseChoices.uni = uni
            navigationController?.present(courseChoices, animated: true, completion: nil)
        }
    }
    
    @objc func ChangeProfileImage(gesture: UITapGestureRecognizer) {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum){
        present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let originalImage = info[.originalImage] as? UIImage{
            selectedImageFromPicker = originalImage
            }
        if let selectedImage = selectedImageFromPicker {
            profilePicture.image = selectedImage
            profilePicChanged = true
            //let cropView = CropViewController()
            //cropView.Image = selectedImage
            //cropView.delegate = self
            dismiss(animated: true, completion: nil)
            //navigationController?.modalPresentationStyle = .fullScreen
            //navigationController?.present(cropView, animated: true, completion: nil)
            }
        }
 
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func signup() {
        
        self.showSpinner(onView: self.view)
        
        print("pressed")
        var year = 0

        if year1Selected == true {
        year = 1
        }
        else if year2Selected == true {
        year = 2
        }
        else if year3Selected == true {
        year = 3
        }
        else if year4Selected == true {
        year = 4
        }
        
        if namefield.text?.isEmpty == true {
            AlertofError("Please try again", "Name needed")
            self.removeSpinner()
            return
        }
        
        if universityfield.text?.isEmpty == true {
            AlertofError("Please try again", "University needed")
            self.removeSpinner()
            return
        }
        
        if coursefield.text?.isEmpty == true {
            AlertofError("Please try again", "Course needed")
            self.removeSpinner()
            return
        }
        
        if year == 0 {
            AlertofError("Please try again", "Year needed")
            self.removeSpinner()
            return
        }
        
        if profilePicChanged == false {
            AlertofError("Please try again", "Please choose a profile picture")
            self.removeSpinner()
            return
        }
        
        guard let name = namefield.text else {return}
        guard let university = universityfield.text else {return}
        guard let course = coursefield.text else {return}
        guard let email = emailfield.text else {return}
        guard let emailEnd = emailEndingLabel.text else {return}
        guard let password = passwordfield.text else {return}
        
        let EmailFull = (email + emailEnd).trimmingCharacters(in: .whitespacesAndNewlines)
        
        print(name, university, course, EmailFull, year)
        
        Auth.auth().createUser(withEmail: EmailFull, password: password) { [weak self] authResult, error in
            guard let strongself = self else {return}
            if let error = error as NSError? {
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed:
              // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
                strongself.AlertofError("Please try again", "Our server isn't having the best time right now.")
                strongself.removeSpinner()
                return
            case .emailAlreadyInUse:
              // Error: The email address is already in use by another account.
                strongself.AlertofError("Please try again", "Email Already In Use")
                strongself.removeSpinner()
                return
            case .invalidEmail:
              // Error: The email address is badly formatted.
                strongself.AlertofError("Please try again", "Email address is badly formatted")
                strongself.removeSpinner()
                return
            case .weakPassword:
              // Error: The password must be 6 characters long or more.
                strongself.AlertofError("Please try again", "Password must be 6 characters long or more")
                strongself.removeSpinner()
                return
            default:
                print("Error: \(error.localizedDescription)")
                strongself.removeSpinner()
                return
            }
          } else {
    
                guard let uid = Auth.auth().currentUser?.uid else {return}

                //upload user info - completion:send email.
                let userDataDocument = Firestore.firestore().collection("user-data").document(uid)
                
                let usersDocumentCourse =
                    Firestore.firestore().collection("users").document(university).collection(course).document(uid)
                
                let usersDocumentTotal = Firestore.firestore().collection("users").document(university).collection("Total").document(uid)
                
                let batch = Firestore.firestore().batch()
                
                strongself.uploadProfilePicture(uid: uid) { [weak self] (profilePictureURL) in
                    
                let data:[String : Any] = [
                "name": name,
                "University": university,
                "Course": course,
                "uid": uid,
                "profilePictureURL": profilePictureURL,
                "Created": FieldValue.serverTimestamp(),
                "Year": year
                ]
                
                strongself.addDisplayNameAndProfilePicture(name: name, url: profilePictureURL)
            
                batch.setData(data, forDocument: userDataDocument, merge: true)
            
                batch.setData(data, forDocument: usersDocumentTotal, merge: true)
                
                batch.setData(data, forDocument: usersDocumentCourse, merge: true)
                
                batch.commit { (error) in
                    if error != nil {
                        strongself.Alert(error!.localizedDescription)
                        strongself.removeSpinner()
                    }
                    else {
                        //success - send email
                Auth.auth().currentUser?.sendEmailVerification { (error) in
                    strongself.removeSpinner()
                    print("Sent email")
                    //alert that theyve been sent an email - on okay button clicked pop to root.
                    let alertController = UIAlertController(title: "Success", message: "Check your email (maybe your spam too) to verify your email.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: { action in
                        //run your function here
                        strongself.goBackToLandingPage()
                    })
                    alertController.addAction(defaultAction)
                    strongself.present(alertController, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func addDisplayNameAndProfilePicture(name:String, url:String) {
        guard let user = Auth.auth().currentUser else {return}
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.photoURL = URL(string: url)
            changeRequest.commitChanges { error in
             if let error = error {
                print(error.localizedDescription)
             } else {
               print("Added Display Name and email")
            }
        }
    }
    
    func uploadProfilePicture(uid: String, completion: @escaping (_ url: String) -> Void ) {
        guard let imageData: Data = self.profilePicture.image?.jpegData(compressionQuality: 0.1) else {
            return
        }

        let metaDataConfig = StorageMetadata()
        metaDataConfig.contentType = "image/jpg"

        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child(uid).child("ProfilePicture").child(imageName)

        storageRef.putData(imageData, metadata: metaDataConfig){ (metaData, error) in
            if let error = error {
                print(error.localizedDescription)

                return
            }

            storageRef.downloadURL(completion: { (url: URL?, error: Error?) in
                guard let profilepicURL = url?.absoluteString else {return}
                completion(profilepicURL)
            })
        }
    }
    
    func goBackToLandingPage() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func year1selected() {
        
        if year1Selected == false {
            year1Selected = true
            year2Selected = false
            year3Selected = false
            year4Selected = false
            year1button.setHighlighted()
            year2button.setNormal(colour: year2Colour)
            year3button.setNormal(colour: year3Colour)
            year4button.setNormal(colour: year4Colour)
        }
        
        else if year1Selected == true {
            year1Selected = false
            year1button.setNormal(colour: year1Colour)
        }
        
    }
    
    @objc func year2selected() {
        
        if year2Selected == false {
            year2Selected = true
            year1Selected = false
            year3Selected = false
            year4Selected = false
            year2button.setHighlighted()
            year1button.setNormal(colour: year1Colour)
            year3button.setNormal(colour: year3Colour)
            year4button.setNormal(colour: year4Colour)
        }
        
        else if year2Selected == true {
            year2Selected = false
            year2button.setNormal(colour: year2Colour)
        }
    }
    
    @objc func year3selected() {
        if year3Selected == false {
            year3Selected = true
            year1Selected = false
            year2Selected = false
            year4Selected = false
            year3button.setHighlighted()
            year1button.setNormal(colour: year1Colour)
            year2button.setNormal(colour: year2Colour)
            year4button.setNormal(colour: year4Colour)
        }
        
        else if year3Selected == true {
            year3Selected = false
            year3button.setNormal(colour: year3Colour)
        }
    }
    
    @objc func year4selected() {
        
        if year4Selected == false {
            year4Selected = true
            year2Selected = false
            year3Selected = false
            year1Selected = false
            year4button.setHighlighted()
            year1button.setNormal(colour: year1Colour)
            year2button.setNormal(colour: year2Colour)
            year3button.setNormal(colour: year3Colour)
        }
        
        else if year4Selected == true {
            year4Selected = false
            year4button.setNormal(colour: year4Colour)
        }
    }
    
    func setupView() {
        let height = CGFloat(50)
        view.addSubview(Signuplabel)
        view.addSubview(profilePicture)
        view.addSubview(namefield)
        view.addSubview(universityfield)
        view.addSubview(coursefield)
        view.addSubview(emailfield)
        emailfield.addSubview(emailEndingContainerView)
        emailEndingContainerView.addSubview(emailEndingLabel)
        view.addSubview(passwordfield)
        stackView.addArrangedSubview(year1button)
        stackView.addArrangedSubview(year2button)
        stackView.addArrangedSubview(year3button)
        stackView.addArrangedSubview(year4button)
        view.addSubview(stackView)
        view.addSubview(signUpButton)

        
        NSLayoutConstraint.activate([
            
            Signuplabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            Signuplabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            //Signuplabel.heightAnchor.constraint(equalToConstant: 45),
            
            profilePicture.topAnchor.constraint(equalTo: Signuplabel.bottomAnchor, constant: 20),
            profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePicture.heightAnchor.constraint(equalToConstant: 120),
            profilePicture.widthAnchor.constraint(equalToConstant: 120),
            
            namefield.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 20),
            namefield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            namefield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            namefield.heightAnchor.constraint(equalToConstant: height),
            
            universityfield.topAnchor.constraint(equalTo: namefield.bottomAnchor, constant: 20),
            universityfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            universityfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            universityfield.heightAnchor.constraint(equalToConstant: height),
            
            coursefield.topAnchor.constraint(equalTo: universityfield.bottomAnchor, constant: 20),
            coursefield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            coursefield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            coursefield.heightAnchor.constraint(equalToConstant: height),
            
            emailfield.topAnchor.constraint(equalTo: coursefield.bottomAnchor, constant: 20),
            emailfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            emailfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            emailfield.heightAnchor.constraint(equalToConstant: height),
            
        ])
        emailEndingLabel.rightAnchor.constraint(equalTo: emailEndingContainerView.rightAnchor, constant: -5).isActive = true
        emailEndingLabel.leftAnchor.constraint(equalTo: emailEndingContainerView.leftAnchor, constant: 5).isActive = true
                UIView.animate(withDuration: 0.5) {
                    self.emailEndingContainerView.layoutIfNeeded()
                }
        
        NSLayoutConstraint.activate([
            
            emailEndingContainerView.rightAnchor.constraint(equalTo: emailfield.rightAnchor),
            emailEndingLabel.heightAnchor.constraint(equalTo: emailfield.heightAnchor),
           
            //emailEndingLabel.widthAnchor.constraint(equalTo: emailfield.widthAnchor, multiplier: 0.4),
            emailEndingLabel.heightAnchor.constraint(equalTo: emailEndingContainerView.heightAnchor),
            
            passwordfield.topAnchor.constraint(equalTo: emailfield.bottomAnchor, constant: 20),
            passwordfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            passwordfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            passwordfield.heightAnchor.constraint(equalToConstant: height),
            
            stackView.topAnchor.constraint(equalTo: passwordfield.bottomAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 40),
            
            year1button.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
            year1button.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.9),
            
            year2button.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
            year2button.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.9),
            
            year3button.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
            year3button.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.9),
            
            year4button.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
            year4button.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.9),
            
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            signUpButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
        
        
        ])
        
    }
}

extension UITextField {

    func addPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
    }
}

extension UIButton {
    
    func addYearTitle(text:String) {
        self.setTitle(text, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
    }
    
    func setHighlighted() {
        self.backgroundColor = .white
        self.setTitleColor(UIColor(red: 0.32, green: 0.42, blue: 0.93, alpha: 1.00), for: .normal)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 0.32, green: 0.42, blue: 0.93, alpha: 1.00).cgColor
    }
    
    func setNormal(colour: UIColor) {
        self.backgroundColor = colour
        self.setTitleColor(.white, for: .normal)
        self.layer.borderWidth = 0
        self.layer.borderColor = nil
    }
    
}

extension SignUpPage: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == universityfield || textField == coursefield {
            return false //do not show keyboard nor cursor
        }
        return true
    }
}


extension UIViewController {
    
    func AlertofError(_ error:String, _ Message:String){
        let alertController = UIAlertController(title: "\(error)", message: "\(Message)", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func Alert(_ field:String){
       let alertController = UIAlertController(title: "\(field) Needed", message: "Please type in \(field)", preferredStyle: .alert)
       let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
       alertController.addAction(defaultAction)
       self.present(alertController, animated: true, completion: nil)
    }
}
