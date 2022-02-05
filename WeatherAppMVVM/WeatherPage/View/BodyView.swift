//
//  BodyView.swift
//  WeatherAppMVVM
//
//  Created by Abilkaiyr Nurzhan on 05.02.2022.
//

import UIKit

class BodyView : UIView {
    
    private lazy var weatherConditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = #colorLiteral(red: 0.01637289487, green: 0.2667464912, blue: 0.2860773504, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView

    }()
    
    private lazy var tempUILabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = UIFont.systemFont(ofSize: 80, weight: .black)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var celciusLabel: UILabel = {
        let label = UILabel()
        label.text = "°C"
        label.font = UIFont.systemFont(ofSize: 100, weight: .light)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label

    }()
    
    private lazy var tempStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [tempUILabel, celciusLabel])
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 0
        return sv
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "no City"
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label

    }()
    
    private lazy var verticalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [weatherConditionImageView,
                                                tempStackView,
                                                cityLabel])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .trailing
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
        addSubview(verticalStackView)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            weatherConditionImageView.widthAnchor.constraint(equalToConstant: 120),
            weatherConditionImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
     func updateUI(with weather: WeatherModel) {
        weatherConditionImageView.image = UIImage(systemName: weather.conditonName)
        tempUILabel.text = weather.temperatureString
        cityLabel.text = weather.cityName
    }
}
