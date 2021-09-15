//
//  ViewController.swift
//  CryptoCoinConverter
//
//  Created by Тимур Гутиев on 07.09.2021.
//

import UIKit

class ViewController: UIViewController {

    let imageView: UIImageView = {
        let defaultImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        defaultImageView.image = UIImage(named: "Logo")
        return defaultImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
//        view.backgroundColor = .systemIndigo
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.7, execute: {() in self.animation()})
    }
        
 // MARK: - AnimationIncrementingPicture
    
    func animation() {
        UIView.animate(withDuration: 2.0, animations: {() in        // ДЛЯ АНИМИРОВАННОГО УВЕЛИЧЕНИЯ КАРТИНКИ
            let size = self.view.frame.size.width * 2.9
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.imageView.frame = CGRect(
                x: -(diffX/2), // this should keep the image centered
                y: diffY/2, // this should keep the image centered
                width: size,
                height: size
            )
        })
        
        UIView.animate(withDuration: 1.9, animations: {() in       // ДЛЯ АН-ИЯ ИСЧЕЗНОВЕНИЯ КАР-И И ПЕРЕХОДА НА ДР ЭКРАН
            self.imageView.alpha = 0
        }, completion: { (ok) in// ок - это булевое значение
            if ok {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.9) {// время до появления нового экрана после исчезновния картинки
                    guard let mainViewController = self.storyboard?.instantiateViewController(identifier: "second") as? HomeViewController else {
                        print("Wtf??")
                        return
                    }
                    mainViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve // опр-ет ан-ию пер-а п-д загр-ой viewController
                    mainViewController.modalPresentationStyle = .fullScreen // то как будет показан новый экран
                    self.present(mainViewController, animated: true)
                }
            }
        })
    }

    
    
    
    
    
    
}


