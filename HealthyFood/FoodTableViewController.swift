import UIKit
import AFNetworking
 
struct Food {
    var image:String
    var name:String
    var links:String
}
 
class FoodCell: UITableViewCell {
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var detailBtn: UIButton!
}
 
class FoodTableViewController: UITableViewController {
 
    var foods:[Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let manager = AFHTTPRequestOperationManager()
        
        //manager.requestSerializer = AFJSONRequestSerializer(writingOptions: .fragmentsAllowed)
        manager.get("http://localhost:8080/foods", parameters: nil, success: { (opertaion, reponseObject) in
            
            if let json = reponseObject as? Array<Dictionary<String,Any>> {
                
                for item in json {
                    self.foods.append(Food(image: item["image"] as! String, name: item["name"] as! String, links: item["links"] as! String))
                }
                
                self.tableView.reloadData()
            }
            
            
            /* do{
                let data = reponseObject as? Data
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? Array<Dictionary<String,Any>> {
                    for item in json {
                        print(item["name"])
                    }
                }
            } catch let err {
                print(err        )
            } */
        }) { (operation, error) in
            print(error)
        }
        
    }
 
    // MARK: - Table view data source
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
 
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodcell", for: indexPath) as! FoodCell
        
        let food = foods[indexPath.row]
        DispatchQueue.main.async {
            let imageData:Data = Data(base64Encoded: food.image)!
              cell.foodImage.image = UIImage(data: imageData)
        }
        cell.foodName.text = food.name
        cell.detailBtn.addTarget(self, action: #selector(showDetail(sender:)), for: .touchUpInside)
        cell.detailBtn.tag = indexPath.row
        
        return cell
    }
    
    @objc func showDetail(sender: UIButton){
        let buttonTag = sender.tag
        
        let food = foods[buttonTag]
        
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let foodDetailViewController : FoodDetailViewController = mainStoryboard.instantiateViewController(identifier: "foodDetail") as! FoodDetailViewController
        foodDetailViewController.weburl =  food.links
        self.present(foodDetailViewController, animated: true)
    }
 
   
}


