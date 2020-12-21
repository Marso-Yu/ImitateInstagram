//
//  InstagramCollectionViewController.swift
//  ImitateInstagram
//
//  Created by Marso on 2020/12/21.
//

import UIKit

private let reuseIdentifier = "InstagramCollectionViewCell"

class InstagramCollectionViewController: UICollectionViewController {
    @IBSegueAction func showDetail(_ coder: NSCoder) -> InstagramDetailViewController? {
        //guard let row = collectionView.indexPathsForSelectedItems else {return nil}
        return InstagramDetailViewController.init(coder: coder, items: items)
    }
    var items = [InstagramResponse.Graphql.User.Edge_owner_to_timeline_media.Edges]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        fetchItem()
        
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
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? InstagramCollectionViewCell else { return UICollectionViewCell()}

        let item = items[indexPath.item]
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
    
    func fetchItem(){
        let urlStr = "https://www.instagram.com/machiko324/?__a=1"
        if let url = URL(string: urlStr){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .iso8601
                if let data = data{
                    do {
                        let searchResponse = try decoder.decode(InstagramResponse.self, from: data)
                        self.items = searchResponse.graphql.user.edge_owner_to_timeline_media.edges
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                            print(self.items)
                        }
                    } catch  {
                        print(error)
                    }

                }
            }.resume()
        }
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


