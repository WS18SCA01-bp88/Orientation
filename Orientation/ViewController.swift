//
//  ViewController.swift
//  Orientation
//
//  Created by Balmes Pavlov on 12/13/18.
//  Copyright © 2018 Balmes Pavlov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /*
     There are two ways to get the orientation to update the label.
     Method 1: Use a NotificationCenter observer and point it to a selector (objc method)
     Method 2: override the method viewWillTransition. However this does not seem to trigger on all orientations, only Portrait, Landscape Left and Landscape Right.
     
     If you want to use one method over the other, you'll need to comment out code.
     For method 1: comment out the method "override func viewWillTransition"
     For method 2: comment out the method "NotificationCenter.default.addObserver"
     
     I'm using method 1 below. To learn more about NotificationCenter and selectors: https://learnappmaking.com/notification-center-how-to-swift/
     
     I also added a new method to detect motion shaking.
     */
    
    @IBOutlet weak var orientationLabel: UILabel!
    
    @IBOutlet weak var motionShakeCountLabel: UILabel!
    
    var motionShakeCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        updateTextLabel()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onOrientationDidChange),
            name: UIDevice.orientationDidChangeNotification,
            object: nil)
    }
    
    @objc func onOrientationDidChange(_ notification: NSNotification) {
        updateTextLabel()
        print("Notification: \(notification)")
    }
    
    func updateTextLabel() {
        orientationLabel.textAlignment = .center
        switch UIDevice.current.orientation {
        case .faceDown:
            orientationLabel.text = "Face Down"
        case .faceUp:
            orientationLabel.text = "Face Up"
        case .landscapeLeft:
            orientationLabel.text = "Landscape Left"
        case .landscapeRight:
            orientationLabel.text = "Landscape Right"
        case .portrait:
            orientationLabel.text = "Portrait"
        case .portraitUpsideDown:
            orientationLabel.text = "Portrait Upside Down"
        case .unknown:
            orientationLabel.text = "Unknown"
        }
        
        motionShakeCountLabel.textAlignment = .center
        motionShakeCountLabel.text = "Motion Shake Count: \(motionShakeCount)"
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        switch motion {
        case .motionShake:
            motionShakeCount += 1
            motionShakeCountLabel.text = "Motion Shake Count: \(motionShakeCount)"
        default:
            break
        }
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        updateTextLabel()
//    }
}

