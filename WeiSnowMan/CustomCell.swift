//
//  cellController.swift
//  WeiSnowMan
//
//  Created by ChenRukun on 2018/03/13.
//  Copyright © 2018年 ChenTerry. All rights reserved.
//

import UIKit
import SDWebImage

class CustomCell: UITableViewCell, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UICollectionViewDataSource
{
    //图片数据
    var images:[XQWBStatusPicture] = []
    
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var createDate: UILabel!
    
    //@IBOutlet weak var iv: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //collectionView的高度约束
    //@IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置collectionView的代理
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // 注册CollectionViewCell
        //        self.collectionView!.register(UINib(nibName:"MyCollectionViewCell", bundle:nil),
        //                                      forCellWithReuseIdentifier: "myCell")
    }
    
    //返回collectionView的单元格数量
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    //加载数据
    func reloadData(images:[XQWBStatusPicture]) {
        //保存图片数据
        //images[0].thumbnail_pic
        
        self.images = images
        
        //collectionView重新加载数据
        self.collectionView.reloadData()
        
        //更新collectionView的高度约束
        //let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
        
        //collectionViewHeight.constant = contentSize.height
    }
    //返回对应的单元格
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell",
                                                       for: indexPath) as! MyCollectionViewCell
        
        let url = NSURL(string: (images[indexPath.item].thumbnail_pic)!)!
        
        do {
            let imageData1 = try NSData(contentsOf: url as URL, options: NSData.ReadingOptions.mappedIfSafe)
            let imgg:UIImage = UIImage(data:imageData1 as Data)!
            
            let iData:Data? = UIImageJPEGRepresentation(imgg, 0.3)! as Data
            //let iData:Data? = UIImage().compressImage(image: imgg,maxLength: 5120) as Data?
            
            cell.imageView.image = UIImage(data:iData! as Data)
            
            cell.addSubview(imageView!)
            
            
            
            
        } catch {
            //throw
            // エラー処理
        }
        
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        var image:UIImage! = UIImage()
        var heigth = CGFloat(0)
        if (images.count>0){
            do {
                let url = NSURL(string: (images[indexPath.item].thumbnail_pic)!)!
                let imageData1 = try NSData(contentsOf: url as URL, options: NSData.ReadingOptions.mappedIfSafe)
                image = UIImage(data:imageData1 as Data)!
            } catch {
                //throw
                // エラー処理
            }
            
            heigth = image.size.height
        }
        
        let frame  = self.collectionView.frame;
        var width = frame.width
        width = CGFloat(width/3)
        
        return CGSize(width: width, height: heigth)
        
    }
}
