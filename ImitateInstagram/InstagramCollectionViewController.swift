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
    var insagramPicUrl = [InstagramResponse.Graphql.User.Edge_owner_to_timeline_media.Edges]()
    
    @IBSegueAction func showDetail(_ coder: NSCoder) -> InstagramDetailViewController? {
        guard let row = collectionView.indexPathsForSelectedItems?.first?.row else {return nil}
        print("row:\(row)")
        return InstagramDetailViewController.init(coder: coder, insagramPicUrl: insagramPicUrl[row])
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
        return insagramPicUrl.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? InstagramCollectionViewCell else { return UICollectionViewCell()}

        let item = insagramPicUrl[indexPath.item]
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
    
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        
//        return InstagramHeaderCollectionReusableView
//    }
    
    func fetchInstagramData(){
        let urlStr = "https://www.instagram.com/machiko324/?__a=1"
        if let url = URL(string: urlStr){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .iso8601
                if let data = data{
                    do {
                        let searchResponse = try decoder.decode(InstagramResponse.self, from: data)
                        self.instagramData = searchResponse
                        DispatchQueue.main.async {
                            self.collatingOfData()
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
        self.insagramPicUrl = (self.instagramData?.graphql.user.edge_owner_to_timeline_media.edges)!
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


