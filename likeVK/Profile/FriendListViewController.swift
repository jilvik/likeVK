//
//  FriendListTableViewController.swift
//  likeVK
//
//  Created by Jambau on 03.11.2020.
//

import UIKit

class FriendListViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var scanQrButton: UIButton!
    @IBOutlet weak var addFriendButton: UIButton!
    @IBOutlet weak var thirdFriendRequestImageView: UIImageView!
    @IBOutlet weak var secondFriendRequestImageView: UIImageView!
    @IBOutlet weak var firstFriendRequestImageView: UIImageView!
    @IBOutlet weak var friendRequestCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var dataBaseService = DataBaseService.commonService
    let IDENTIFIER: String = "HorizontalUserPreviewTableViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: IDENTIFIER, bundle: nil), forCellReuseIdentifier: IDENTIFIER)
        
        setupSearchTextField()
        setup(for: scanQrButton)
        setup(for: addFriendButton)
        setupFriendsResquestImageViewBatch(for: [firstFriendRequestImageView, secondFriendRequestImageView, thirdFriendRequestImageView])
        setupFriendRequestCountLabel()
        enrichFriendRequestes()
    }
    
    private func setupSearchTextField() {
        searchTextField.layer.cornerRadius = 10
        searchTextField.setLeftImage(image: UIImage(systemName: "magnifyingglass")!, color: UIColor.systemGray4, size: 15)
    }
    
    private func setup(for button: UIButton) {
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.systemGray6.cgColor
        button.layer.borderWidth = 0.7
        button.layer.shadowColor = UIColor.systemGray.cgColor
        button.layer.shadowOffset = CGSize(width: 10, height: 10)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 20
        button.layer.masksToBounds = false
    }
    
    private func setupFriendsResquestImageViewBatch(for batch: [UIImageView]) {
        for imageView in batch {
            imageView.layer.cornerRadius = 30
            imageView.layer.borderWidth = 2
            imageView.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    private func setupFriendRequestCountLabel() {
        friendRequestCountLabel.layer.cornerRadius = 15
    }
    
    private func enrichFriendRequestes() {
        let reversedArray: [User] = dataBaseService.friendRequestes.reversed()
        thirdFriendRequestImageView.image = reversedArray[0].profilePhoto
        secondFriendRequestImageView.image = reversedArray[1].profilePhoto
        firstFriendRequestImageView.image = reversedArray[2].profilePhoto
        
        friendRequestCountLabel.text = String(dataBaseService.friendRequestes.count)
    }
}

extension FriendListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount: Int
        switch section {
            case 0:
                rowCount = dataBaseService.important.count
            case 1:
                rowCount = 3
            default:
                rowCount = dataBaseService.myFriends.count
            }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title: String
        switch section {
            case 0:
                title = "Important"
            case 1:
                title = "Potential friends"
            default:
                title = "My friends"
            }
        return title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER) as! HorizontalUserPreviewTableViewCell
        switch indexPath.section {
            case 0:
                cell.profilePhotoImageView.image = dataBaseService.important[indexPath.row].profilePhoto
                cell.surnameNameTextLabel.text = dataBaseService.important[indexPath.row].name + " " + dataBaseService.important[indexPath.row].surname
                cell.cityTextLabel.text = dataBaseService.important[indexPath.row].city
            case 1:
                cell.profilePhotoImageView.image = dataBaseService.potential[indexPath.row].profilePhoto
                cell.surnameNameTextLabel.text = dataBaseService.potential[indexPath.row].name + " " + dataBaseService.potential[indexPath.row].surname
                cell.cityTextLabel.text = dataBaseService.potential[indexPath.row].city
            default:
                cell.profilePhotoImageView.image = dataBaseService.myFriends[indexPath.row].profilePhoto
                cell.surnameNameTextLabel.text = dataBaseService.myFriends[indexPath.row].name + " " + dataBaseService.myFriends[indexPath.row].surname
                cell.cityTextLabel.text = dataBaseService.myFriends[indexPath.row].city
            }
        cell.actionImageView.image = UIImage(systemName: "message")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let borderView = UIView()
        let headerLabel = UILabel(frame:CGRect(x: 10, y: 15, width: tableView.bounds.width, height: tableView.bounds.size.height))
        let headerView = UIView()
        
        borderView.backgroundColor = UIColor.systemGray6
        borderView.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        borderView.frame = CGRect(x: 10, y: 5, width: tableView.bounds.width, height: 1)

        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.textColor = UIColor.black
        headerLabel.font = .boldSystemFont(ofSize: 17)
        headerLabel.sizeToFit()

        headerView.backgroundColor = UIColor.white
        headerView.addSubview(headerLabel)
        headerView.addSubview(borderView)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "GoToFriendProfile", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToFriendProfile" {
            let friendViewController = segue.destination as! FriendViewController
            let indexPath = sender as! IndexPath
            var friend: User
            switch indexPath.section {
            case 0:
                friend = dataBaseService.important[indexPath.row]
            case 1:
                friend = dataBaseService.potential[indexPath.row]
            default:
                friend = dataBaseService.myFriends[indexPath.row]
            }
            
            friendViewController.user = friend
        }
    }
}
