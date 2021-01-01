//
//  InstagramCollectionViewController.swift
//  ImitateInstagram
//
//  Created by Marso on 2020/12/21.
//

import UIKit

private let reuseIdentifier = "InstagramCollectionViewCell"

class InstagramCollectionViewController: UICollectionViewController {
    var instagramData: InstagramResponse?
    var instagramPostPicture =  [InstagramResponse.Graphql.User.Edge_owner_to_timeline_media.Edges]()
    //var insagramPostCaption = [InstagramResponse.Graphql.User.Edge_owner_to_timeline_media.Edges.Node.Edge_media_to_caption.Edges]()
    @IBSegueAction func showPostDetail(_ coder: NSCoder) -> InstagramPostDetailCollectionViewController? {
        guard let row = collectionView.indexPathsForSelectedItems?.first?.row else {return nil}
        //print("row:\(row)")
        return InstagramPostDetailCollectionViewController.init(coder: coder, instagramData: instagramData!, indexPath: row)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        fetchInstagramData()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return instagramPostPicture.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? InstagramCollectionViewCell else { return UICollectionViewCell()}

        let item = instagramPostPicture[indexPath.item]
        URLSession.shared.dataTask(with: item.node.display_url) { (data, response, error) in
                if let data = data{
                    DispatchQueue.main.async {
                        cell.showImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        
        
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let resuableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "InstagramHeaderCollectionViewReusableView", for: indexPath) as? InstagramHeaderCollectionReusableView else {return UICollectionReusableView()}
        
        if let profilPicUrl = self.instagramData?.graphql.user.profile_pic_url_hd {
            URLSession.shared.dataTask(with: profilPicUrl) { (data, response, error) in
                if let data = data{
                    do {
                        DispatchQueue.main.async {
                            resuableView.profilePicImageView.layer.cornerRadius = resuableView.profilePicImageView.frame.width / 2
                            resuableView.profilePicImageView.image = UIImage(data: data)
                        }
                    } catch  {
                        print(error)
                    }
                }
            }.resume()
        }
        
        if let postsCount = self.instagramData?.graphql.user.edge_owner_to_timeline_media.count,
            let followCount = self.instagramData?.graphql.user.edge_followed_by.count,
            let followingCount = self.instagramData?.graphql.user.edge_follow.count,
            let fullName = self.instagramData?.graphql.user.full_name,
            let biography = self.instagramData?.graphql.user.biography
        {
            resuableView.postsLabel.text = "\(postsCount)"
//            resuableView.followersLabel.adjustsFontSizeToFitWidth = true
//            resuableView.followersLabel.minimumScaleFactor = 0.5
            resuableView.followersLabel.text = "\(followCount)"
            
            resuableView.followingLabel.text = "\(followingCount)"
            
//            resuableView.fullNameLabel.adjustsFontSizeToFitWidth = true
//            resuableView.fullNameLabel.minimumScaleFactor = 0.5
            resuableView.fullNameLabel.text = "\(fullName)"
            
            resuableView.biographyTextView.isEditable = false
            resuableView.biographyTextView.text = "\(biography)"
            
        }
        
        return resuableView
    }
    
    func fetchInstagramData(){
        let urlStr = "https://www.instagram.com/machiko324/?__a=1"
        if let url = URL(string: urlStr){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                if let data = data{
                    do {
                        let searchResponse = try decoder.decode(InstagramResponse.self, from: data)
                        self.instagramData = searchResponse
                        DispatchQueue.main.async {
                            self.collatingOfData()
                            self.navigationItem.title = self.instagramData?.graphql.user.username
                            self.navigationItem.backButtonTitle = "返回"
                            self.collectionView.reloadData()
//                            print(self.items)
                        }
                    } catch  {
                        print(error)
                    }
                }
            }.resume()
        }
    }

    func collatingOfData(){
        self.instagramPostPicture = (self.instagramData?.graphql.user.edge_owner_to_timeline_media.edges)!
//        print(self.instagramData?.graphql.user.edge_owner_to_timeline_media.edges[0].node.edge_media_to_caption.edges[0].node.text)
//        print(self.instagramData?.graphql.user.edge_owner_to_timeline_media.edges[0].node.edge_media_to_comment.count)
//        print(self.instagramData?.graphql.user.edge_owner_to_timeline_media.edges[0].node.edge_liked_by.count)
//        print(self.instagramData?.graphql.user.edge_owner_to_timeline_media.edges[0].node.taken_at_timestamp)

    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


