//
//  ConnectButton.swift
//  CivicConnect
//
//  Created by Justin Guedes on 2018/08/30.
//

import Foundation

enum ConnectButtonState {
    case normal(String? ,UIImage?)
    case loading
}

/// Visual component for showing the Civic Styled Connect Button.
@objc(CCConnectButton) public class ConnectButton: UIButton {
    
    private let kRotationAnimationKey = "com.civic.connect.rotation.animation.key"
    
    private let connect: Connect
    private var type: ScopeRequestType
    private weak var delegate: ConnectDelegate?
    
    private var previousState: ConnectButtonState = .normal("CONNECT WITH CIVIC", logoImage)
    private var buttonState: ConnectButtonState = .normal("CONNECT WITH CIVIC", logoImage) {
        willSet {
            if case .loading = buttonState {
                return
            }
            
            previousState = buttonState
        }
        
        didSet {
            let title: String?
            let image: UIImage?
            switch buttonState {
            case let .normal(_title, _image):
                title = _title
                image = _image
                contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
                titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
                imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
                stopRotating(imageView)
            case .loading:
                title = .none
                image = ConnectButton.loadingImage
                contentEdgeInsets = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
                titleEdgeInsets = .zero
                imageEdgeInsets = .zero
                rotate(imageView, duration: 0.75)
            }
            
            setTitle(title, for: .normal)
            setImage(image, for: .normal)
        }
    }
    
    /// Initializes the `ConnectButton` with the `Connect` class and type of scope request.
    /// This method is only available for Objective C.
    ///
    /// - Parameters:
    ///   - connect: `Connect` instance to create the session.
    ///   - type: The type of scope request for the button.
    ///   - delegate: The delegate for the session.
    @available(*, obsoleted: 1)
    @objc(initWithConnect:type:delegate:) public convenience init(_ connect: Connect, type: ScopeRequestType = .basicSignup, delegate: CCConnectDelegate) {
        let wrapper = ObjConnectDelegateWrapper(delegate: delegate)
        self.init(connect, type: type, delegate: wrapper)
    }
    
    /// Initializes the `ConnectButton` with the `ConnectBundle` and type of scope request.
    /// This method is only available for Swift.
    ///
    /// - Parameters:
    ///   - bundle: `ConnectBundle` instance to create the `Connect` instance.
    ///   - type: The type of scope request for the button.
    ///   - delegate: The delegate for the session.
    public convenience init(_ bundle: ConnectBundle, type: ScopeRequestType = .basicSignup, delegate: ConnectDelegate) throws {
        let connect = try Connect.initialize(withBundle: bundle)
        self.init(connect, type: type, delegate: delegate)
    }
    
    /// Initializes the `ConnectButton` with the `Connect` class and type of scope request.
    /// This method is only available for Swift.
    ///
    /// - Parameters:
    ///   - connect: `Connect` instance to create the session.
    ///   - type: The type of scope request for the button.
    ///   - delegate: The delegate for the session.
    public init(_ connect: Connect, type: ScopeRequestType = .basicSignup, delegate: ConnectDelegate) {
        self.connect = connect
        self.type = type
        self.delegate = delegate
        super.init(frame: .zero)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
    
    /// Sets the title for the connect button.
    ///
    /// - Parameter title: Title to be applied to the button.
    @objc public func setConnectTitle(_ title: String?) {
        buttonState = .normal(title, ConnectButton.logoImage)
    }
    
    /// Sets the title and image for the connect button.
    ///
    /// - Parameters:
    ///   - title: Title to be applied to the button.
    ///   - image: Image to be applied to the button.
    @objc public func setConnectTitle(_ title: String?, image: UIImage?) {
        buttonState = .normal(title, image)
    }
    
    /// Sets the scope request type for the connect button.
    ///
    /// - Parameter type: Type for the connect button.
    @objc public func setType(_ type: ScopeRequestType) {
        self.type = type
    }
    
    private static var logoImage: UIImage? {
        let bundle = Bundle(for: ConnectButton.self)
        if let connectBundleUrl = bundle.url(forResource: "CivicConnect", withExtension: "bundle") {
            let connectBundle = Bundle(url: connectBundleUrl)
            return UIImage(named: "logo", in: connectBundle, compatibleWith: .none)
        }
        
        return .none
    }
    
    private static var loadingImage: UIImage? {
        let bundle = Bundle(for: ConnectButton.self)
        if let connectBundleUrl = bundle.url(forResource: "CivicConnect", withExtension: "bundle") {
            let connectBundle = Bundle(url: connectBundleUrl)
            return UIImage(named: "loading", in: connectBundle, compatibleWith: .none)
        }
        
        return .none
    }
    
    private func setupView() {
        backgroundColor = .init(red: 58.0 / 255, green: 176.0 / 255, blue: 62.0 / 255, alpha: 1)
        
        addTarget(self, action: #selector(ConnectButton.connectButtonTapped), for: .touchUpInside)
        setConnectTitle("CONNECT WITH CIVIC")
    }
    
    @objc private func connectButtonTapped() {
        if case .loading = buttonState {
            return
        }
        
        buttonState = .loading
        connect.connect(withType: type, delegate: self)
    }
    
    private func rotate(_ view: UIView?, duration: Double = 1) {
        guard let view = view, view.layer.animation(forKey: kRotationAnimationKey) == nil else {
            return
        }
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float(Double.pi * 2.0)
        rotationAnimation.duration = duration
        rotationAnimation.repeatCount = Float.infinity
        rotationAnimation.isRemovedOnCompletion = false
        
        view.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
    }
    
    private func stopRotating(_ view: UIView?) {
        guard let view = view, view.layer.animation(forKey: kRotationAnimationKey) != nil else {
            return
        }
        
        view.layer.removeAnimation(forKey: kRotationAnimationKey)
    }
    
}

extension ConnectButton: ConnectDelegate {
    
    public func connectDidFailWithError(_ error: ConnectError) {
        buttonState = previousState
        delegate?.connectDidFailWithError(error)
    }
    
    public func connectDidFinishWithUserData(_ userData: UserData) {
        buttonState = previousState
        delegate?.connectDidFinishWithUserData(userData)
    }
    
    public func connectDidChangeStatus(_ newStatus: ConnectStatus) {
        delegate?.connectDidChangeStatus(newStatus)
    }

    public func connectShouldFetchUserData(withToken token: String) -> Bool {
        let shouldFetchUserData = delegate?.connectShouldFetchUserData(withToken: token) ?? false
        if !shouldFetchUserData {
            buttonState = previousState
        }

        return shouldFetchUserData
    }
    
}
