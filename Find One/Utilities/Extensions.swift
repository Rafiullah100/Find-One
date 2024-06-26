//
//  Extensions.swift
//  Find 1
//
//  Created by MacBook Pro on 2/6/24.
//

import Foundation

import UIKit
extension UIView {
    
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor(named: "#084F24")?.cgColor ?? UIColor(), UIColor(named: "#327425")?.cgColor ?? UIColor()]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.addSublayer(gradientLayer)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }
    
    func showWithAnimation(delegate: UIViewController) {
        self.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
            delegate.view.addSubview(self)
        }
    }
    
    func hideWithAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
        }
    }
    
    func addBottomShadow() {
        layer.masksToBounds = false
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 1
    }
    
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowOpacity = 0.7
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
    }
    
    func edges(_ edges: UIRectEdge, to view: UIView, offset: UIEdgeInsets) {
        if edges.contains(.top) || edges.contains(.all) {
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: offset.top).isActive = true
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: offset.bottom).isActive = true
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset.left).isActive = true
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset.right).isActive = true
        }
    }
    
    func edges(_ edges: UIRectEdge, to layoutGuide: UILayoutGuide, offset: UIEdgeInsets) {
        if edges.contains(.top) || edges.contains(.all) {
            self.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: offset.top).isActive = true
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: offset.bottom).isActive = true
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: offset.left).isActive = true
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: offset.right).isActive = true
        }
    }
    
//    func addGradient() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.bounds
//        gradientLayer.colors = [UIColor(hex: "#327425"), UIColor(hex: "#084F24")]
//        self.layer.addSublayer(gradientLayer)
//    }
    
    func viewShadow(_ color: CustomColor? = .shadowColor) {
       layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
       layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
       layer.shadowOpacity = 0.5
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func removeShadow() {
            layer.shadowOffset = CGSize.zero
            layer.shadowColor = nil
            layer.shadowRadius = 0
            layer.shadowOpacity = 0
        }
}

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}



extension UITableViewCell{
    class func cellReuseIdentifier() -> String {
        return "\(self)"
    }
}

extension UICollectionViewCell{
    class func cellReuseIdentifier() -> String {
        return "\(self)"
    }
}

extension UIViewController {
    
    public func showAlert(title: String = "", message: String){
        guard !message.isEmpty else {
            return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func add(_ child: UIViewController, in container: UIView) {
        addChild(child)
        child.view.frame = container.bounds
        container.addSubview(child.view)
        child.didMove(toParent: self)
//        container.setNeedsLayout()
//        container.layoutIfNeeded()

//        child.viewWillAppear(false)
    }
    
    func add(_ child: UIViewController) {
        add(child, in: view)
    }
    
    func remove(from view: UIView) {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    func remove() {
        remove(from: view)
    }
    
    func removeChild(childVC: UIViewController) {
        childVC.willMove(toParent: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
    }
}


extension UIWindow {
    static var key: UIWindow! {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

extension String{
//    func localizeString() -> String {
//        let loc = UserDefaults.standard.selectedLanguage == AppLanguage.arabic.rawValue ? "ar" : "en"
//        let path = Bundle.main.path(forResource: loc, ofType: "lproj")
//        let bundle = Bundle(path: path!)
//        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
//    }
    
    func localizeString() -> String {
        let loc = UserDefaults.standard.selectedLanguage == AppLanguage.arabic.rawValue ? "ar" : "en"
        let path = Bundle.main.path(forResource: loc, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

extension UICollectionViewFlowLayout {
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
}

extension String{
    var asUrl: URL? {
        return URL(string: self)
    }
    
}

extension UITableView{
    func setEmptyView(_ message: String? = nil) {
        let image = UIImage(named: "")
        let emptyImageView = UIImageView(image: image)
        emptyImageView.contentMode = .scaleAspectFit
        if let _ = image {
            emptyImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        } else {
            emptyImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.textColor = .label
        titleLabel.font = UIFont(name: "Poppins-regular", size: 16)
        messageLabel.textColor = .label
        messageLabel.font = UIFont(name: "Poppins-regular", size: 14)
        titleLabel.text = message ?? "No Data Found!"
        messageLabel.text = ""
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        let containerStack = UIStackView(arrangedSubviews: [emptyImageView, titleLabel, messageLabel])
        containerStack.alignment = .center
        containerStack.axis = .vertical
        containerStack.distribution = .fill
        containerStack.spacing = 10
        
        let containerView = UIView()
        containerView.addSubview(containerStack)
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        containerStack.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7, constant: 0).isActive = true
        containerStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -20).isActive = true
        containerStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        self.backgroundView = containerView
    }
}

extension UICollectionView{
    func setEmptyView(_ message: String? = nil) {
        let image = UIImage(named: "")
        let emptyImageView = UIImageView(image: image)
        emptyImageView.contentMode = .scaleAspectFit
        if let _ = image {
            emptyImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        } else {
            emptyImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.textColor = .label
        titleLabel.font = UIFont(name: "Poppins-regular", size: 16)
        messageLabel.textColor = .label
        messageLabel.font = UIFont(name: "Poppins-regular", size: 14)
        titleLabel.text = message ?? LocalizationKeys.notFound.rawValue.localizeString()
        messageLabel.text = ""
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        let containerStack = UIStackView(arrangedSubviews: [emptyImageView, titleLabel, messageLabel])
        containerStack.alignment = .center
        containerStack.axis = .vertical
        containerStack.distribution = .fill
        containerStack.spacing = 10
        
        let containerView = UIView()
        containerView.addSubview(containerStack)
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        containerStack.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7, constant: 0).isActive = true
        containerStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -20).isActive = true
        containerStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        self.backgroundView = containerView
    }
}

extension Array {
    func at(_ index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


extension UIApplication {
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
        return viewController
    }
}

//extension String {
//    var htmlToAttributedString: NSAttributedString? {
//        guard let data = data(using: .utf8) else { return nil }
//        do {
//            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
//        } catch {
//            return nil
//        }
//    }
//    var htmlToString: String {
//        return htmlToAttributedString?.string ?? ""
//    }
//}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .justified
            mutableAttributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: mutableAttributedString.length))
            let font = UIFont(name: "Manrope-Regular", size: 12.0)
            mutableAttributedString.addAttribute(.font, value: font ?? UIFont(), range: NSRange(location: 0, length: mutableAttributedString.length))
            return mutableAttributedString
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension UITextField {
    func setInsetForText(insets: UIEdgeInsets) {
        guard let text = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.textAlignment

        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        attributedText.addAttribute(NSAttributedString.Key.font, value: self.font ?? UIFont.systemFont(ofSize: 12), range: NSMakeRange(0, attributedText.length))
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: self.textColor ?? UIColor.black, range: NSMakeRange(0, attributedText.length))

        let attributes = [
            NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: self.textColor ?? UIColor.black,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]

        let paddedText = NSAttributedString(string: " ", attributes: attributes).string.padding(toLength: Int(self.frame.width), withPad: " ", startingAt: 0)
        attributedText.replaceCharacters(in: NSMakeRange(0, text.count), with: paddedText)

        self.attributedText = attributedText
    }
}
