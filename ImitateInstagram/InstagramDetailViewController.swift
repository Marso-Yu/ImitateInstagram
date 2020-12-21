//
//  InstagramDetailViewController.swift
//  ImitateInstagram
//
//  Created by Marso on 2020/12/21.
//

import UIKit

class InstagramDetailViewController: UIViewController {
    @IBOutlet weak var showImageView: UIImageView!
    var items = [InstagramResponse.Graphql.User.Edge_owner_to_timeline_media.Edges]()
    init?(coder: NSCoder, items: [InstagramResponse.Graphql.User.Edge_owner_to_timeline_media.Edges]) {
        self.items = items
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.items)
//        let item = items[indexPath.item]
//        URLSession.shared.dataTask(with: item.node.display_url) { (data, response, error) in
//                if let data = data{
//                    DispatchQueue.main.async {
//                        cell.showImageView.image = UIImage(data: data)
//                    }
//                }
//            }.resume()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
