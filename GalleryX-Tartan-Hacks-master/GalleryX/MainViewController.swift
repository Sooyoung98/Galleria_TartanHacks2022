import Foundation
import UIKit
import ARKit
import SceneKit
import FirebaseStorage
import SVGKit

public var items : [UIImage] = []
public var tempItems: [UIImage] = []
public var count = 180
public var imgcount = 4
public var flag = 0

class MainViewController: UIViewController {

    @IBOutlet weak var UploadNewImage: UIButton!
    @IBOutlet weak var ImageCollectionView: UICollectionView!
    @IBOutlet weak var BlueprintImage: UIImageView!
    @IBOutlet weak var FirstImageView: UIImageView!
    @IBOutlet weak var SecondImageView: UIImageView!
    @IBOutlet weak var ThirdImageView: UIImageView!
    @IBOutlet weak var ExtraView: UIView!
    
    @IBOutlet weak var QRView: UIView!
    
    @IBOutlet weak var QRConfirm: UIButton!
    
    @IBOutlet weak var QRButton: UIImageView!
    @IBOutlet weak var VRButton: UIButton!
    
    @IBOutlet weak var QRsub: UIView!
    var selectedFinger = 0
    
    var imageViewItems : [UIImageView] = []
    var documentsUrl: URL {
        return FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlPath = Bundle.main.url(forResource: "Bowl", withExtension: "usd") else {
            return
        }
        
        let mdlAsset = MDLAsset(url: urlPath)
      
        //let first  = UIImage(named: "1.jpg")!
        //let second =  UIImage(named: "2.jpg")!
        //let third =  UIImage(named: "3.jpg")!
        //items.append(first)
        //items.append(second)
        //items.append(third)
 
        //ImageCollectionView.layer.borderWidth = 2
        //ImageCollectionView.layer.borderColor = CGColor(red: 167/255, green: 155/255, blue: 135/255, alpha: 1.0)
        
        setDragAndDropSettings()
      
        ImageCollectionView.dataSource = self
        ImageCollectionView.delegate = self
        
        if let flowLayout = ImageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            
        }
        
        ImageCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 60)
        
        UploadNewImage.layer.cornerRadius = 5
        ExtraView.layer.cornerRadius = 20
        QRButton.layer.cornerRadius = 30
        QRButton.layer.borderWidth=3
        QRButton.layer.borderColor = UIColor.black.cgColor
        VRButton.layer.cornerRadius = 5
        
        FirstImageView.layer.borderWidth=3
        FirstImageView.layer.borderColor = UIColor.black.cgColor
        SecondImageView.layer.borderWidth=3
        SecondImageView.layer.borderColor = UIColor.black.cgColor
        ThirdImageView.layer.borderWidth=3
        ThirdImageView.layer.borderColor = UIColor.black.cgColor
        
        UploadNewImage.layer.shadowColor = UIColor.black.cgColor
        UploadNewImage.layer.shadowOffset = CGSize(width: 10, height: 10)
        UploadNewImage.layer.shadowRadius = 3.0
        UploadNewImage.layer.shadowOpacity = 0.5
        UploadNewImage.layer.masksToBounds = false
        
        VRButton.layer.shadowColor = UIColor.black.cgColor
        VRButton.layer.shadowOffset = CGSize(width: 10, height: 10)
        VRButton.layer.shadowRadius = 3.0
        VRButton.layer.shadowOpacity = 0.5
        VRButton.layer.masksToBounds = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("hihi")
        self.navigationController?.isNavigationBarHidden = true
       
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        ImageCollectionView.reloadData()
        QRView.isHidden = true
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(tapGesture1))
        QRButton.addGestureRecognizer(tap1)
        QRButton.isUserInteractionEnabled = true
        QRsub.layer.cornerRadius = 10
        QRConfirm.layer.cornerRadius = 10
    }
        
    

    @objc func tapGesture1() {
        QRView.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    @IBAction func ConfClicked(_ sender: Any) {
        QRView.isHidden = true
    }
    

    
    func setDragAndDropSettings(){
        let dragInteraction1 = UIDragInteraction(delegate: self)
        dragInteraction1.isEnabled = true

        let dragInteraction2 = UIDragInteraction(delegate: self)
        dragInteraction2.isEnabled = true

        let dragInteraction3 = UIDragInteraction(delegate: self)
        dragInteraction3.isEnabled = true

        let dropInteraction1 = UIDropInteraction(delegate: self)
        let dropInteraction2 = UIDropInteraction(delegate: self)
        let dropInteraction3 = UIDropInteraction(delegate: self)

        ImageCollectionView.dragDelegate = self
        ImageCollectionView.dragInteractionEnabled = true



        FirstImageView.isUserInteractionEnabled = true
        SecondImageView.isUserInteractionEnabled = true
        ThirdImageView.isUserInteractionEnabled = true

        self.view.isUserInteractionEnabled = true
//        subView.isUserInteractionEnabled = true
//        imageView.isUserInteractionEnabled = true

        //Add Drop interaction for DropImageView
        FirstImageView.addInteraction(dropInteraction1)
        SecondImageView.addInteraction(dropInteraction2)
        ThirdImageView.addInteraction(dropInteraction3)

    }

    private func load(fileName: String) -> UIImage? {
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
    @IBAction func UploadImage(_ sender: Any) {

    }
    @IBAction func onVRGalleryPress(_ sender: Any) {
        
        getURL(img: FirstImageView.image ?? UIImage(), name: "11.jpg")
        getURL(img: SecondImageView.image ?? UIImage(), name: "22.jpg")
        flag = 1
        getURL(img: ThirdImageView.image ?? UIImage(), name: "33.jpg")
        
        
       
    }


    func getURL(img:UIImage, name: String){
        let imageData = img.pngData()
        let storageRef = Storage.storage().reference().child(name)
        if let uploadData = imageData{
            storageRef.putData(uploadData, metadata: nil
            , completion: { (metadata, error) in

                if error != nil {

                    print("error")
                    print(error)

                }else{
                    storageRef.downloadURL(completion: { (url, error) in
                        print("Image URL: \(url!)")
                        if (flag == 1){
                            if let url = URL(string: "https://mygame.page/galleria") {
                                UIApplication.shared.open(url)
                            }
                            flag = 0
                        }

                    })
                }

            })
        }
    }



}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDragDelegate, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(indexPath.item)

        return CGSize(width:100, height: 100)
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCellID", for: indexPath) as! ImageCell

        if (items.count>=(indexPath.item+1)){
            cell.actualImageView.image = items[indexPath.item]
            imageViewItems.append(cell.actualImageView)
        }else{
            cell.actualImageView.image = UIImage(named: "hhh")
            imageViewItems.append(cell.actualImageView)
        }
        //cell.actualImageView.image = items[indexPath.row]
        //imageViewItems.append(cell.actualImageView)
        cell.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 0.0
        cell.layer.masksToBounds = false

        return cell

    }



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 8
    }

    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        if (items.count<indexPath.row+1){
            return []
        }
        let item = items[indexPath.row]
        let itemProvider = NSItemProvider(object: item as UIImage)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        selectedFinger = indexPath.row + 1
        return [dragItem]
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return items.count
        if (items.count>5){
            return items.count
        }
        return 5
    }

}

extension MainViewController: UIDropInteractionDelegate{
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
            let location = session.location(in: self.view)
            let dropOperation: UIDropOperation?
            if session.canLoadObjects(ofClass: UIImage.self) {
                if  FirstImageView.frame.contains(location) {
                    dropOperation = .copy
                    selectedFinger = 1
                } else if  SecondImageView.frame.contains(location) {
                    dropOperation = .copy
                    selectedFinger = 2

                } else if  ThirdImageView.frame.contains(location) {
                    dropOperation = .copy
                    selectedFinger = 3

                } else {
                    dropOperation = .cancel
                    selectedFinger = 0
                }
            } else {
                dropOperation = .cancel
                selectedFinger = 0
            }
            return UIDropProposal(operation: dropOperation!)
        }
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {

        if session.canLoadObjects(ofClass: UIImage.self) {
            session.loadObjects(ofClass: UIImage.self) { (items) in
                if let images = items as? [UIImage] {
                    switch self.selectedFinger{

                    case 1 :
                        self.FirstImageView.image = images.last
                        break

                    case 2 :
                        self.SecondImageView.image = images.last
                        break

                    case 3 :
                        self.ThirdImageView.image = images.last
                        break

                    default:
                        print("exit")
                    }

                }
            }
        }
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnd session: UIDropSession){

    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnter session: UIDropSession){

    }
}


extension MainViewController: UIDragInteractionDelegate{
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        if let imageView = interaction.view as? UIImageView{
            guard let image = imageView.image else {return []}
            let provider = NSItemProvider(object: image)
            let item = UIDragItem.init(itemProvider: provider)
            return[item]
        }
        return []
    }


}

class ImageCell : UICollectionViewCell{
    
   
    @IBOutlet weak var actualImageView: UIImageView!
    
    
}
