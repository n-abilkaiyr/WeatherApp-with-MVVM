//
//  HeaderView.swift
//  WeatherAppMVVM
//
//  Created by Abilkaiyr Nurzhan on 05.02.2022.
//

import UIKit

class HeaderView: UIView {
    
    var delegate: WeatherViewController?

    private lazy var currLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 20, weight:  .regular)
        textField.placeholder = "Search city..."
        textField.textAlignment = .right
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemFill
        textField.returnKeyType = .go
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [currLocationButton, searchTextField, searchButton])
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(horizontalStackView)
    }
    
    private func setupConstraints() {
        
        // buttons constraints
        NSLayoutConstraint.activate([
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            currLocationButton.widthAnchor.constraint(equalToConstant: 40),
            currLocationButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // sv constraints
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
    }
    
    @objc func searchButtonTapped() {
        searchTextField.endEditing(true)
    }
    
    @objc func locationButtonTapped() {
        delegate?.fetchCurrentLocationWeather()
    }
    
    
}

extension HeaderView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let text = textField.text, text != "" {
            return true
        }
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.fetchWeather(for: textField.text!)
        textField.text = ""
    }
    
   
}
