//
//  UIButton+Extension.swift
//  WeiSnowMan
//
//  Created by ChenRukun on 2018/03/10.
//  Copyright © 2018年 ChenTerry. All rights reserved.
//

import UIKit
extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
    convenience init(withHex hex:String) {
        var cString:String = hex.uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.index(after: cString.startIndex))
        }
        
        if (cString.characters.count != 6) {
            self.init(red:0/255, green:0/255, blue:0/255, alpha:1.0)
            return
        }
        
        let rString = cString.substring(to: cString.index(cString.startIndex, offsetBy: 2))
        let gString = cString.substring(with: cString.index(cString.startIndex, offsetBy: 2)..<cString.index(cString.startIndex, offsetBy: 4))
        let bString = cString.substring(with: cString.index(cString.startIndex, offsetBy: 4)..<cString.index(cString.startIndex, offsetBy: 6))
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner.init(string:rString).scanHexInt32(&r)
        Scanner.init(string:gString).scanHexInt32(&g)
        Scanner.init(string:bString).scanHexInt32(&b)
        
        
        self.init(red:CGFloat(r)/255, green:CGFloat(g)/255, blue:CGFloat(b)/255, alpha:1.0)
    }
}
extension UIImage {
    
    ///对指定图片进行拉伸
    func resizableImage(name: String) -> UIImage {
        
        var normal = UIImage(named: name)!
        let imageWidth = normal.size.width * 0.5
        let imageHeight = normal.size.height * 0.5
        normal = resizableImage(withCapInsets: UIEdgeInsetsMake(imageHeight, imageWidth, imageHeight, imageWidth))
        
        return normal
    }
    
    /**
     *  压缩上传图片到指定字节
     *
     *  image     压缩的图片
     *  maxLength 压缩后最大字节大小
     *
     *  return 压缩后图片的二进制
     */
    func compressImage(image: UIImage, maxLength: Int) -> NSData? {
        
        let newSize = self.scaleImage(image: image, imageLength: 300)
        let newImage = self.resizeImage(image: image, newSize: newSize)
        
        var compress:CGFloat = 0.9
        var data = UIImageJPEGRepresentation(newImage, compress)
        
        while (data?.count)! > maxLength && compress > 0.01 {
            compress -= 0.02
            data = UIImageJPEGRepresentation(newImage, compress)
        }
        
        return data as NSData?
    }
    
    /**
     *  通过指定图片最长边，获得等比例的图片size
     *
     *  image       原始图片
     *  imageLength 图片允许的最长宽度（高度）
     *
     *  return 获得等比例的size
     */
    func  scaleImage(image: UIImage, imageLength: CGFloat) -> CGSize {
        
        var newWidth:CGFloat = 0.0
        var newHeight:CGFloat = 0.0
        let width = image.size.width
        let height = image.size.height
        
        if (width > imageLength || height > imageLength){
            
            if (width > height) {
                
                newWidth = imageLength;
                newHeight = newWidth * height / width;
                
            }else if(height > width){
                
                newHeight = imageLength;
                newWidth = newHeight * width / height;
                
            }else{
                
                newWidth = imageLength;
                newHeight = imageLength;
            }
            
        }
        return CGSize(width: newWidth, height: newHeight)
    }
    
    /**
     *  获得指定size的图片
     *
     *  image   原始图片
     *  newSize 指定的size
     *
     *  return 调整后的图片
     */
    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIButton
{
    // 虽然以下方法可以快速创建一个UIButton对象, 但是Swift风格不是这样写的
    // 在Swift开发中, 如果想快速创建一个对象, 那么可以提供一个便利构造器(便利构造方法)
    // 只要在普通构造方法前面加上一个convenience, 那么这个构造方法就是一个便利构造方法
    // 注意: 如果定义一个便利构造器, 那么必须在便利构造器中调用指定构造器(没有加convenience单词的构造方法)
    
    /*
     class func create(imageName: String, backImageName: String) -> UIButton
     {
     let btn = UIButton()
     // 1.设置背景图片
     btn.setBackgroundImage(UIImage(named: imageName), forState: UIControlState.Normal)
     btn.setBackgroundImage(UIImage(named: imageName + "highlighted"), forState: UIControlState.Highlighted)
     
     // 2.设置普通图片
     btn.setImage(UIImage(named:backImageName), forState: UIControlState.Normal)
     btn.setImage(UIImage(named: backImageName + "highlighted"), forState: UIControlState.Highlighted)
     
     btn.sizeToFit()
     
     return btn
     }
     */
    
    /*
     定义便利构造器步骤:
     1.编写一个构造方法
     2.在构造方法前面加上 convenience
     3.在构造方法中调用当前类的其他"非便利构造器"初始化对象
     */
    convenience init(imageName: String, backImageName: String)
    {
        self.init()
        
        // 1.设置背景图片
        setBackgroundImage(UIImage(named: imageName), for: UIControlState.normal)
        setBackgroundImage(UIImage(named: imageName + "highlighted"), for: UIControlState.highlighted)
        
        // 2.设置普通图片
        setImage(UIImage(named:backImageName), for: UIControlState.normal)
        setImage(UIImage(named: backImageName + "highlighted"), for: UIControlState.highlighted)
        
        sizeToFit()
    }
    
    
    
}
