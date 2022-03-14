//
//  CropViewController.swift
//  Varisty
//
//  Created by Christian Grinling on 26/11/2020.
//

import UIKit

class CropViewController: UIViewController, UIScrollViewDelegate {
    
    var Image: UIImage?
    var delegate: ProfileViewControllerProtocol?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = true
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .black
        return scrollView
    }()
    
    lazy var cropImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = Image
        return image
     }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let overlay = createOverlay(frame: view.frame,
                                    xOffset: view.frame.midX,
                                    yOffset: view.frame.midY,
                                    radius: 150.0)
        view.addSubview(overlay)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.bouncesZoom = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.decelerationRate = .fast
        let rightButton = UIBarButtonItem(title: "Confirm", style: .done, target: self, action: #selector(confirmButton))
        navigationItem.rightBarButtonItem = rightButton

    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return cropImage
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        centerScrollViewContents()
    }
    
    @objc func confirmButton() {
        self.dismiss(animated: true, completion: {
            //guard let image = self.cropImage.image else {return}
            //self.delegate?.setCroppedImage(image)
        })
    }

    private func centerScrollViewContents() {
        let frameHeight = cropImage.frame.size.height
        let frameWidth = cropImage.frame.size.width
        var point = CGPoint()
        if frameHeight < frameWidth {
            point.x = (frameWidth - scrollView.bounds.width)/2
        } else {
            
            point.y = (frameHeight - scrollView.bounds.height)/2
        }
        scrollView.setContentOffset(point, animated: false)
        scrollView.contentInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
    }
    
    func createOverlay(frame: CGRect,
                       xOffset: CGFloat,
                       yOffset: CGFloat,
                       radius: CGFloat) -> UIView {
        // Step 1
        let overlayView = UIView(frame: frame)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        // Step 2
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: xOffset, y: yOffset),
                    radius: radius,
                    startAngle: 0.0,
                    endAngle: 2.0 * .pi,
                    clockwise: false)
        path.addRect(CGRect(origin: .zero, size: overlayView.frame.size))
        // Step 3
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        // For Swift 4.2
        maskLayer.fillRule = .evenOdd
        // Step 4
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        overlayView.isUserInteractionEnabled = false
        return overlayView
    }
    
    func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(cropImage)
        
        NSLayoutConstraint.activate([
      
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
        scrollView.topAnchor.constraint(equalTo: view.topAnchor),
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        cropImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        cropImage.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        cropImage.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
        cropImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
        ])
    }

}
//presents image picker then pushes crop view then dismisses them both.

