//
//  ViewController.swift
//  FKContest_2
//
//  Created by Arthur Narimanov on 3/4/23.
//

import UIKit

class ViewController: UIViewController {
    lazy var firstButton = Button(title: "First Button")
    lazy var secondButton = Button(title: "Second Medium Button")
    lazy var thirdButton = Button(title: "Third")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        thirdButton.tapAction(self.showPopup())
    }
    
    func showPopup() {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemYellow
        present(vc, animated: true, completion: nil)
    }
}

private extension ViewController {
    func setupUI() {
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(thirdButton)
        
        NSLayoutConstraint.activate([
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 12),
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 12),
        ])
    }
    
}

class Button: UIButton {
    @objc
    private var tapClosure: (() -> Void)?
    
    convenience init(title: String) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // animation when tap
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.1, delay: 0, options: [.allowUserInteraction, .curveEaseIn]) {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.1, delay: 0, options: [.allowUserInteraction, .curveEaseOut]) {
            self.transform = .identity
        }
    }
    
    // change backgroundColor
    override func tintColorDidChange() {
        super.tintColorDidChange()
        backgroundColor = tintAdjustmentMode == .normal ? .systemBlue : .systemGray
    }
    
    func tapAction(_ closure: @autoclosure @escaping () -> Void) {
        tapClosure = closure
        setNeedsUpdateConfiguration()
        self.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
    }
}

private extension Button {
    func setupUI() {
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 8
        self.layer.cornerCurve = .continuous
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
        
        setImage(UIImage(systemName: "arrow.right.circle.fill")!, for: .normal)
        setImage(UIImage(systemName: "arrow.right.circle.fill")!, for: .highlighted)
        imageView?.tintColor = .white
        semanticContentAttribute = .forceRightToLeft
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    }
    
    @objc
    func tapOnButton() {
        tapClosure?()
    }
}

