//
//  Profile.swift
//  Varisty
//
//  Created by Christian Grinling on 10/11/2020.
//

import UIKit
import Firebase
import Nuke

class Profile: UIViewController {
    
    let grayColour = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
    var logoImageColour = UIColor(red: 0.32, green: 0.42, blue: 0.93, alpha: 1.00)
        
        lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isUserInteractionEnabled = false
            imageView.layer.masksToBounds = true
            imageView.backgroundColor = .red
            return imageView
        }()
        
        lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.bounces = true
            scrollView.isScrollEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.backgroundColor = .white
            return scrollView
        }()
        
        lazy var containerView: UIView = {
            let containerView = UIView()
            containerView.backgroundColor = .white
            containerView.layer.cornerRadius = 20
            containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            containerView.translatesAutoresizingMaskIntoConstraints = false
            return containerView
        }()
        
        lazy var nameField: UILabel = {
            let usernameField = UILabel()
            usernameField.translatesAutoresizingMaskIntoConstraints = false
            usernameField.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
            usernameField.adjustsFontSizeToFitWidth = true
            usernameField.minimumScaleFactor = 0.5
            usernameField.textAlignment = .center
            return usernameField
        }()
        
        lazy var countryFlag: UILabel = {
            let countryFlag = UILabel()
            countryFlag.translatesAutoresizingMaskIntoConstraints = false
            countryFlag.font = UIFont(name: "AppleColorEmoji", size: 40)
            countryFlag.adjustsFontSizeToFitWidth = true
            countryFlag.minimumScaleFactor = 0.5
            countryFlag.textAlignment = .center
            return countryFlag
        }()
        
        lazy var courseImageView: UIImageView = {
            let courseImageView = UIImageView()
            courseImageView.image = UIImage(named: "course")
            courseImageView.contentMode = .scaleAspectFill
            courseImageView.translatesAutoresizingMaskIntoConstraints = false
            return courseImageView
        }()
        
        lazy var CourseText: UILabel = {
            let CourseText = UILabel()
            CourseText.translatesAutoresizingMaskIntoConstraints = false
            CourseText.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.bold)
            CourseText.adjustsFontSizeToFitWidth = true
            CourseText.minimumScaleFactor = 0.5
            CourseText.textAlignment = .center
            CourseText.lineBreakMode = .byWordWrapping
            CourseText.numberOfLines = 0
            return CourseText
        }()
        
        lazy var UniImageView: UIImageView = {
            let UniImageView = UIImageView()
            UniImageView.image = UIImage(named: "uni")
            UniImageView.contentMode = .scaleAspectFill
            UniImageView.translatesAutoresizingMaskIntoConstraints = false
            return UniImageView
        }()
        
        lazy var UniversityText: UILabel = {
            let UniversityText = UILabel()
            UniversityText.translatesAutoresizingMaskIntoConstraints = false
            UniversityText.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.bold)
            UniversityText.adjustsFontSizeToFitWidth = true
            UniversityText.minimumScaleFactor = 0.5
            UniversityText.textAlignment = .center
            UniversityText.lineBreakMode = .byWordWrapping
            UniversityText.numberOfLines = 0
            return UniversityText
        }()
        
        lazy var FriendsImageView: UIImageView = {
            let FriendsImageView = UIImageView()
            FriendsImageView.image = UIImage(systemName: "person.2.fill")
            FriendsImageView.contentMode = .scaleAspectFit
            FriendsImageView.isUserInteractionEnabled = true
            FriendsImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showFriendsList)))
            FriendsImageView.translatesAutoresizingMaskIntoConstraints = false
            FriendsImageView.tintColor = .black
            return FriendsImageView
        }()
        
        lazy var FriendsText: UILabel = {
            let FriendsText = UILabel()
            FriendsText.translatesAutoresizingMaskIntoConstraints = false
            FriendsText.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.bold)
            FriendsText.adjustsFontSizeToFitWidth = true
            FriendsText.minimumScaleFactor = 0.5
            FriendsText.textAlignment = .center
            return FriendsText
        }()
        
        lazy var StackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = NSLayoutConstraint.Axis.horizontal
            stackView.distribution = UIStackView.Distribution.equalSpacing
            stackView.alignment = UIStackView.Alignment.center
            stackView.spacing = view.frame.width/9
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
    
        lazy var underStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = NSLayoutConstraint.Axis.horizontal
            stackView.distribution = UIStackView.Distribution.fillProportionally
            //stackView.alignment = UIStackView.Alignment.center
            //stackView.spacing = 0
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        lazy var BioText: UILabel = {
            let BioText = UILabel()
            BioText.translatesAutoresizingMaskIntoConstraints = false
            BioText.sizeToFit()
            BioText.layoutIfNeeded()
            BioText.numberOfLines = 0
            BioText.font = UIFont.systemFont(ofSize: 14)
            return BioText
        }()
    
        lazy var seperatorLineAbove: UIView = {
            let seperatorLineView = UIView()
            seperatorLineView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
            seperatorLineView.translatesAutoresizingMaskIntoConstraints = false
            return seperatorLineView
        }()
    
        lazy var seperatorLineBelow: UIView = {
            let seperatorLineView = UIView()
            seperatorLineView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
            seperatorLineView.translatesAutoresizingMaskIntoConstraints = false
            return seperatorLineView
        }()
    
        lazy var taggedButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(systemName: "crop")?.withTintColor(logoImageColour, renderingMode: .alwaysOriginal), for: .normal)
            return button
        }()
    
        lazy var postsButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(systemName: "square.grid.3x2")?.withTintColor(logoImageColour, renderingMode: .alwaysOriginal), for: .normal)
            return button
        }()
        
        lazy var RefreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.backgroundColor = .white
            refreshControl.tintColor = .systemGray
            refreshControl.addTarget(self, action: #selector(refreshUserData(_:)), for: .valueChanged)
            return refreshControl
        }()
    
        lazy var PostsContainerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    lazy var PostscollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "PostsCell")
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
        
        lazy var TaggedContainerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    lazy var TaggedcollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "TaggedCell")
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
        
        private func collectionViewLayout() -> UICollectionViewLayout {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0,
                                               left: 0,
                                               bottom: 0,
                                               right: 0)
            layout.scrollDirection = .vertical
            return layout
        }
        
        @objc func refreshUserData(_ sender: Any) {
            print("refresh")
           // picturesArray.removeAll()
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            getUserInfo()
            getFriendsCount()
            RefreshControl.endRefreshing()
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = grayColour
            scrollView.refreshControl = RefreshControl
            setupActions()
            setupView()
            getUserInfo()
            getFriendsCount()
            PostscollectionView.isScrollEnabled = false
            StackView.addVerticalSeparators(color: logoImageColour)
            TaggedContainerView.isHidden = true
            taggedButton.alpha = 0.4
        }
    
    func setupActions() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(LogOut))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit Profile", style: .done, target: self, action: #selector(EditProfile))
        postsButton.addTarget(self, action: #selector(showPosts), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(showTagged), for: .touchUpInside)
    }
    
    @objc func showPosts() {
        UIView.animate(withDuration: 0.2) {
            self.taggedButton.alpha = 0.4
            self.postsButton.alpha = 1
        }
        TaggedContainerView.isHidden = true
        PostsContainerView.isHidden = false
        
    }
    
    @objc func showTagged() {
        UIView.animate(withDuration: 0.2) {
            self.taggedButton.alpha = 1
            self.postsButton.alpha = 0.4
        }
        TaggedContainerView.isHidden = false
        PostsContainerView.isHidden = true
        
    }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.navigationBar.tintColor = .systemBlue
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = nil
        }

        @objc func EditProfile() {
            print("Edit profile")
            //let editprofilepage = EditProfilePage()
            //editprofilepage.modalPresentationStyle = .fullScreen
            //editprofilepage.profilepage = self
            //present(editprofilepage, animated: true , completion: nil)
        }

        @objc func LogOut() {
//        do { try Auth.auth().signOut() }
//        catch let signOutError as NSError {
//        print ("Error signing out: %@", signOutError)}
//                let startview = StartView()
//                let nav = UINavigationController(rootViewController: startview)
//                tabBarController?.selectedIndex = 0
//                nav.modalPresentationStyle = .fullScreen
//                self.present(nav, animated: false)
        }
        
        @objc func showFriendsList() {
            print("go to friends list")
            //let friendslist = FriendsList()
            //navigationController?.pushViewController(friendslist, animated: true)
        }
        
        override func viewDidLayoutSubviews() {
            let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
                rect = rect.union(view.frame)
            }
            scrollView.contentSize = contentRect.size

        }
        
        func setupView() {
            
            view.addSubview(scrollView)
            scrollView.addSubview(imageView)
            scrollView.addSubview(containerView)
            containerView.addSubview(nameField)
            StackView.addArrangedSubview(UniImageView)
            StackView.addArrangedSubview(courseImageView)
            StackView.addArrangedSubview(FriendsImageView)
            containerView.addSubview(StackView)
            containerView.addSubview(UniversityText)
            containerView.addSubview(CourseText)
            containerView.addSubview(FriendsText)
            containerView.addSubview(BioText)
            containerView.addSubview(seperatorLineAbove)
            containerView.addSubview(underStackView)
            underStackView.addArrangedSubview(postsButton)
            underStackView.addArrangedSubview(taggedButton)
            containerView.addSubview(countryFlag)
            containerView.addSubview(seperatorLineBelow)
            containerView.addSubview(PostscollectionView)
            
            
            containerView.addSubview(PostsContainerView)
            PostsContainerView.addSubview(PostscollectionView)
            containerView.addSubview(TaggedContainerView)
            TaggedContainerView.addSubview(TaggedcollectionView)

        //imageView constraints
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true

        //scrollview constraints
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
        //containerview constraints
            //containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            containerView.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant:  -15).isActive = true
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            containerView.bottomAnchor.constraint(equalTo: PostscollectionView.bottomAnchor).isActive = true
           

        //constrain UsernameField
            nameField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15).isActive = true
            nameField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            nameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
            nameField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5).isActive = true
            
        //constrain countryFlag
            countryFlag.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            countryFlag.leftAnchor.constraint(equalTo: nameField.rightAnchor, constant: 3).isActive = true
            countryFlag.centerYAnchor.constraint(equalTo: nameField.centerYAnchor).isActive = true
            countryFlag.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -3).isActive = true
     let imagesize = CGFloat(integerLiteral: 35)
        //courseImageView constraints
            courseImageView.heightAnchor.constraint(equalToConstant: imagesize).isActive = true
            courseImageView.widthAnchor.constraint(equalToConstant: imagesize).isActive = true
            
        //CourseText constraints
            CourseText.topAnchor.constraint(equalTo: StackView.bottomAnchor, constant: 10).isActive = true
            CourseText.centerXAnchor.constraint(equalTo: courseImageView.centerXAnchor).isActive = true
            CourseText.widthAnchor.constraint(equalTo: StackView.widthAnchor, multiplier: 1/3).isActive = true

        //UniImageView constraints
            UniImageView.heightAnchor.constraint(equalToConstant: imagesize).isActive = true
            UniImageView.widthAnchor.constraint(equalToConstant: imagesize).isActive = true
            
        //UniversityText constraints
            UniversityText.topAnchor.constraint(equalTo: StackView.bottomAnchor, constant: 10).isActive = true
            UniversityText.centerXAnchor.constraint(equalTo: UniImageView.centerXAnchor).isActive = true
            UniversityText.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 3).isActive = true
            UniversityText.widthAnchor.constraint(equalTo: StackView.widthAnchor, multiplier: 1/3).isActive = true
            
        //FriendsImageView constraints
            FriendsImageView.heightAnchor.constraint(equalToConstant: imagesize).isActive = true
            FriendsImageView.widthAnchor.constraint(equalToConstant: imagesize).isActive = true
        
        //FriendsText constraints
            FriendsText.topAnchor.constraint(equalTo: StackView.bottomAnchor, constant: 10).isActive = true
            FriendsText.centerXAnchor.constraint(equalTo: FriendsImageView.centerXAnchor).isActive = true
     
        //stackviewconstraints
            StackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            StackView.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 10).isActive = true
            
        //BioText constraints
            BioText.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            BioText.topAnchor.constraint(equalTo: CourseText.bottomAnchor, constant: 30).isActive = true
            BioText.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -40).isActive = true
            
        //seperatorline constraints
            seperatorLineAbove.topAnchor.constraint(equalTo: BioText.bottomAnchor).isActive = true
            seperatorLineAbove.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            seperatorLineAbove.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
            seperatorLineAbove.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
        //underStackView constraints
            underStackView.topAnchor.constraint(equalTo: seperatorLineAbove.bottomAnchor).isActive = true
            underStackView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
            underStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
        //seperatorline constraints
            seperatorLineBelow.topAnchor.constraint(equalTo: underStackView.bottomAnchor).isActive = true
            seperatorLineBelow.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            seperatorLineBelow.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
            seperatorLineBelow.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
        //postscontainerview
            PostsContainerView.topAnchor.constraint(equalTo: seperatorLineBelow.bottomAnchor,constant: 5).isActive = true
            PostsContainerView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
            PostsContainerView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
            //PostsContainerView.heightAnchor.constraint(equalTo: sc).isActive = true
            PostsContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            
            
        //postscollectionView constraints
            PostscollectionView.topAnchor.constraint(equalTo: PostsContainerView.topAnchor).isActive = true
            PostscollectionView.rightAnchor.constraint(equalTo: PostsContainerView.rightAnchor).isActive = true
            PostscollectionView.leftAnchor.constraint(equalTo: PostsContainerView.leftAnchor).isActive = true
            PostscollectionView.heightAnchor.constraint(equalTo: PostsContainerView.heightAnchor).isActive = true
            //PostscollectionView.bottomAnchor.constraint(equalTo: PostsContainerView.bottomAnchor).isActive = true
            
            //taggedcontainerview
                TaggedContainerView.topAnchor.constraint(equalTo: seperatorLineBelow.bottomAnchor,constant: 5).isActive = true
                TaggedContainerView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
                TaggedContainerView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
                //TaggedContainerView.heightAnchor.constraint(equalTo: TaggedContainerView.widthAnchor, multiplier: 1/3).isActive = true
                TaggedContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            
            //taggedcollectionView constraints
                TaggedcollectionView.topAnchor.constraint(equalTo: TaggedContainerView.topAnchor).isActive = true
                TaggedcollectionView.rightAnchor.constraint(equalTo: TaggedContainerView.rightAnchor).isActive = true
                TaggedcollectionView.leftAnchor.constraint(equalTo: TaggedContainerView.leftAnchor).isActive = true
            TaggedcollectionView.heightAnchor.constraint(equalTo: TaggedContainerView.heightAnchor).isActive = true
                //TaggedcollectionView.bottomAnchor.constraint(equalTo: TaggedContainerView.bottomAnchor).isActive = true
            
        }
        
        func getUserInfo() {
            print("gettinguserInfo")
            guard let uid = Auth.auth().currentUser?.uid else {return}
            let userReference = Firestore.firestore().collection("user-data").document(uid)
            userReference.getDocument { (document, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                else {
                    let data = document?.data()
                    guard let dictionary = data as [String:AnyObject]? else {return}
                    let user = userInfo(dictionary: dictionary)
                    self.nameField.text = user.name
                    self.UniversityText.text = user.University
                    self.CourseText.text = user.Course
                    if let url = user.profilePictureURL {
                        if let profilepictureurl = URL(string: url) {
                            Nuke.loadImage(with: profilepictureurl, into: self.imageView)
                        }
                    }
                }
            }
        }
        
        func getFriendsCount() {
            print("gettingfriends")
        }
    }

    extension Profile: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == self.PostscollectionView {
                return 3 // Replace with count of your data for collectionViewA
            }

            return 9 // Replace with count of your data for collectionViewB
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == self.PostscollectionView {
                let postcell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostsCell", for: indexPath) as! PostCell
                postcell.backgroundColor = .red

                // Set up cell
                return postcell
            }

            else {
                let taggedcell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaggedCell", for: indexPath) as! PostCell
                taggedcell.backgroundColor = .blue

                // ...Set up cell

                return taggedcell
            }
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1.5
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 1.5
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let columns: CGFloat = 3
            let spacing: CGFloat = 1.5
            let totalHorizontalSpacing = (columns - 1) * spacing

            let itemWidth = (collectionView.bounds.width - totalHorizontalSpacing) / columns
            let itemSize = CGSize(width: itemWidth, height: itemWidth)

            return itemSize
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            let image = picturesArray[indexPath.row]
//            let zoom = zoomedPhoto()
//            zoom.image = image
//            zoom.modalTransitionStyle = .crossDissolve
//            navigationController?.present(zoom, animated: true, completion: nil)
//
        }
}

extension UIStackView {
    func addVerticalSeparators(color : UIColor) {
        var i = self.arrangedSubviews.count
        while i > 1 {
            let separator = verticalCreateSeparator(color: color)
            insertArrangedSubview(separator, at: i-1)   // (i-1) for centers only
            separator.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
            i -= 1
        }
    }

    private func verticalCreateSeparator(color : UIColor) -> UIView {
        let separator = UIView()
        separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        separator.backgroundColor = color
        return separator
    }
}
