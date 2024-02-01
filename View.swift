

import Foundation
import UIKit


protocol AnyView{
    var presenter : AnyPresenter? {get set}
    //view un kendini gücenllemesi için gereken fonksiyonlar
    func update(with cryptos: [Crypto])
    func update(with errors: String)

}
class CryptoViewController:UIViewController,AnyView,UITableViewDelegate,UITableViewDataSource{
    var presenter: AnyPresenter?
    var cryptos : [Crypto] = []
    
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self,forCellReuseIdentifier: "cell")
        //ilk veriyi indirdiğimizde boş tableview gözükmesin diye
        table.isHidden=true
        return table
    }()
    
    
    private let messageLabel:UILabel = {
        let label=UILabel()
        label.isHidden=false
        label.text="Dowloading..."
        label.font=UIFont.systemFont(ofSize: 20)
        label.textColor=UIColor.red
        label.textAlignment = .center
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //oluşturdupumuz görünümleri bu şekilde ekliyourz
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        
        view.backgroundColor = .systemPink
        
        tableView.delegate=self
        tableView.dataSource=self
    }
    
    //stroyboardı sildik o yüzden sürekli bunu kullanmalıyız
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //ekranımız ne kadarsa tableview da o kadar
        tableView.frame=view.bounds
        messageLabel.frame=CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 25, width: 200, height: 50)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //cell.text vb şekilde kullanmamak için content oluşturucaz
        //üstte kriptonun adı alt tarafta değeri gözüksün diy eugrasmamıza gerek kalmadan
        var content=cell.defaultContentConfiguration()
        content.text=cryptos[indexPath.row].currency
        content.secondaryText=cryptos[indexPath.row].price
        cell.contentConfiguration=content
        cell.backgroundColor = .systemPink
        return cell
        
    }
    
    func update(with cryptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptos=cryptos
            self.messageLabel.isHidden=true
            self.tableView.reloadData()
            self.tableView.isHidden=false
        }
    }
    
    func update(with errors: String) {
        DispatchQueue.main.async {
            self.cryptos=[]
            self.tableView.isHidden=true
            self.messageLabel.text="ERROR"
            self.messageLabel.isHidden=false
        }

    }
    

    
}
