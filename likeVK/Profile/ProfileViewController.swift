//
//  ProfileViewController.swift
//  likeVK
//
//  Created by Jambau on 03.11.2020.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var mainPhotoImageView: UIImageView!
    @IBOutlet weak var nameSurnameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var userInfoContentView: UIView!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var degreeImageView: UIImageView!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var workplaceImageView: UIImageView!
    @IBOutlet weak var workplaceLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var friendsContentView: UIView!
    @IBOutlet weak var friendCountLabel: UILabel!
    @IBOutlet weak var friendRequestCountLabel: UILabel!
    @IBOutlet weak var friendListPreviewCollectionView: UICollectionView!
    @IBOutlet weak var photosContentView: UIView!
    @IBOutlet weak var photoCountLabel: UILabel!
    @IBOutlet weak var photoGalleryPreviewCollectionView: UICollectionView!
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var feedTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollContentViewHeight: NSLayoutConstraint!
    var dataBaseService = DataBaseService.commonService
    var photoGalleryService = PhotoGalleryService.commonGallery
    let VERTICAL_USER_PREVIEW_IDENTIFIER: String = "VerticalUserPreviewCollectionViewCell"
    let USER_PHOTO_PREVIEW_IDENTIFIER: String = "UserPhotoPreviewCollectionViewCell"
    let FEED_IDENTIFIER: String = "FeedTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendListPreviewCollectionView.delegate = self
        friendListPreviewCollectionView.dataSource = self
        friendListPreviewCollectionView.register(UINib(nibName: VERTICAL_USER_PREVIEW_IDENTIFIER, bundle: nil), forCellWithReuseIdentifier: VERTICAL_USER_PREVIEW_IDENTIFIER)
        photoGalleryPreviewCollectionView.delegate = self
        photoGalleryPreviewCollectionView.dataSource = self
        photoGalleryPreviewCollectionView.register(UINib(nibName: USER_PHOTO_PREVIEW_IDENTIFIER, bundle: nil), forCellWithReuseIdentifier: USER_PHOTO_PREVIEW_IDENTIFIER)
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(UINib(nibName: FEED_IDENTIFIER, bundle: nil), forCellReuseIdentifier: FEED_IDENTIFIER)
        
        setupMainPhotoImageView()
        setupEditButton()
        setupUserInfoLabels()
        setupTableViewHeight()
        addSeparators()
        enrichMyself()
    }
    
    private func setupMainPhotoImageView() {
        mainPhotoImageView.layer.cornerRadius = 45
    }
    
    private func setupEditButton() {
        editButton.layer.cornerRadius = 10
    }
    
    private func setupUserInfoLabels() {
        let myself = dataBaseService.myself
        if myself.city != nil {
            cityLabel.textColor = UIColor.systemGray
            cityImageView.tintColor = UIColor.systemGray
        }
        if myself.degree != nil {
            degreeLabel.textColor = UIColor.systemGray
            degreeImageView.tintColor = UIColor.systemGray
        }
        if myself.workplace != nil {
            workplaceLabel.textColor = UIColor.systemGray
            workplaceImageView.tintColor = UIColor.systemGray
        }
    }
    
    private func setupTableViewHeight() {
        let initialScrollViewHeight = scrollContentViewHeight.constant
        let initialFeedTableViewHeight = feedTableViewHeight.constant
        var feedCount: Int
        if dataBaseService.myself.feeds == nil {
            feedCount = 0
        } else {
            feedCount = dataBaseService.myself.feeds!.count
        }
        feedTableViewHeight.constant = feedTableView.rowHeight * CGFloat(feedCount)
        scrollContentViewHeight.constant = initialScrollViewHeight - initialFeedTableViewHeight + feedTableViewHeight.constant + 115
    }
    
    private func addSeparators() {
        addSeparatorToUserInfoContentView()
        addSeparatorToFriendsContentView()
        addSeparatorToPhotosContentView()
    }
    
    private func addSeparatorToUserInfoContentView() {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor.systemGray6
        separatorView.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        separatorView.frame = CGRect(x: 10, y: 0, width: 500, height: 1)
        
        userInfoContentView.addSubview(separatorView)
    }
    
    private func addSeparatorToFriendsContentView() {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor.systemGray6
        separatorView.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        separatorView.frame = CGRect(x: 10, y: 0, width: 500, height: 1)
        
        friendsContentView.addSubview(separatorView)
    }
    
    private func addSeparatorToPhotosContentView() {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor.systemGray6
        separatorView.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        separatorView.frame = CGRect(x: 10, y: 0, width: 500, height: 1)
        
        photosContentView.addSubview(separatorView)
    }
    
    private func enrichMyself() {
        let myself = dataBaseService.myself
        mainPhotoImageView.image = myself.profilePhoto
        nameSurnameLabel.text = myself.name + " " + myself.surname
        summaryLabel.text = myself.summary
        if myself.city != nil {
            cityLabel.text = "City: \(myself.city!)"
        }
        if myself.degree != nil {
            degreeLabel.text = "Degree: \(myself.degree!)"
        }
        if myself.workplace != nil {
            workplaceLabel.text = "Workplace: \(myself.workplace!)"
        }
        
        friendCountLabel.text = dataBaseService.myFriends.count.description
        friendRequestCountLabel.text = "\(dataBaseService.friendRequestes.count.description) requests"
        photoCountLabel.text = photoGalleryService.images.count.description
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCell(withIdentifier: FEED_IDENTIFIER, for: indexPath) as! FeedTableViewCell
        let myself = dataBaseService.myself
        if let feeds = myself.feeds {
            let feed = feeds[indexPath.row]
            cell.profilePhotoImageView.image = myself.profilePhoto
            cell.nameSurnameLabel.text = myself.name + " " + myself.surname
            cell.publicationDateLabel.text = getFormattedDate(date: feed.publicationDate!)
            cell.summaryTextLabel.text = feed.text
            cell.mainImageView.image = feed.image
            cell.likeButton.setTitle(feed.likeCount?.description, for: .normal)
        }
        
        return cell
    }
    
    private func getFormattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        timeFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date) + " at " + timeFormatter.string(from: date)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemsCount: Int
        if collectionView == friendListPreviewCollectionView {
            itemsCount = dataBaseService.myFriends.count
        } else {
            itemsCount = 6
        }
        return itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == friendListPreviewCollectionView {
            let cell = friendListPreviewCollectionView.dequeueReusableCell(withReuseIdentifier: VERTICAL_USER_PREVIEW_IDENTIFIER, for: indexPath) as! VerticalUserPreviewCollectionViewCell
            cell.profilePhotoImageView.image = dataBaseService.myFriends[indexPath.row].profilePhoto
            cell.nameTextLabel.text = dataBaseService.myFriends[indexPath.row].name
            cell.surnameTextLabel.text = dataBaseService.myFriends[indexPath.row].surname
            return cell
        } else {
            let cell = photoGalleryPreviewCollectionView.dequeueReusableCell(withReuseIdentifier: USER_PHOTO_PREVIEW_IDENTIFIER, for: indexPath) as! UserPhotoPreviewCollectionViewCell
            cell.imageView.image = photoGalleryService.images[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == friendListPreviewCollectionView {
            let hight = collectionView.frame.height - 10
            let width = hight * 0.7

            return CGSize(width: width, height: hight)
        } else {
            let hight = collectionView.frame.height
            let width = hight

            return CGSize(width: width, height: hight)
        }
    }
}
