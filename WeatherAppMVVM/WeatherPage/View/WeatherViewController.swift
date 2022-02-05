//
//  WeatherViewController.swift
//  WeatherAppMVVM
//
//  Created by Abilkaiyr Nurzhan on 05.02.2022.
//

import UIKit

class WeatherViewController: UIViewController {
    private var viewModel: WeatherViewModelProtocol!
    private lazy var  updaterUICompeltion = { [unowned self] weather in
        self.bodyView.updateUI(with: weather)
    }
    private lazy var headerView: HeaderView = {
        let header = HeaderView()
        header.delegate = self
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private lazy var bodyView: BodyView = {
        let body = BodyView()
        body.translatesAutoresizingMaskIntoConstraints = false
        return body
    }()
    
    private lazy var mainStackView: UIStackView = {
        let emptyView = UIView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        
        let sv = UIStackView(arrangedSubviews: [headerView, bodyView, emptyView])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    
    
    override func viewDidLoad() {
       setupViews()
       setupContraints()
       viewModel = WeatherViewModel()
        viewModel.fetchCurrentLocationWeather { [unowned self] weather in
            self.bodyView.updateUI(with: weather)
        }
        
    }
}

extension WeatherViewController {
   
    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        
    }
    
    private func setupContraints() {
        // background image view
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // main stack view
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


extension WeatherViewController: WeatherViewControllerDelegate {
    func fetchCurrentLocationWeather() {
        viewModel.fetchCurrentLocationWeather(completion: updaterUICompeltion)
    }
    
    func fetchWeather(for cityName: String) {
        viewModel.fetchWeather(by: cityName, completion: updaterUICompeltion)
    }
    
}
