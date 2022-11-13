//
//  ViewController.swift
//  Weather
//
//  Created by Вадим Сосновский on 22.09.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var currentIndex: Int = 0
    
    private var pageViewController: UIPageViewController!
    
    var citiesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cities = UserDefaultsManager.shared.cities {
            citiesArray = cities
        }

        setupPageViewController()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaultsManager.shared.cities?.count == nil {
            showAlertController()
        }
    }
}

// MARK: - @IBActions
extension MainViewController {
    @objc private func addCityTapped() {
        showAlertController()
    }
}

// MARK: - Setup Views
extension MainViewController {
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.view.backgroundColor = .mainBlue()
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = .mainWhite().withAlphaComponent(0.5)
        pageControl.currentPageIndicatorTintColor = .mainWhite()

        self.addChild(pageViewController)
        self.view.addSubview(self.pageViewController.view)
        
        let initialVC: UIViewController
        if citiesArray.count > 0 {
            guard let firstCityIndex = citiesArray.firstIndex(of: citiesArray[0]) else { return }
            initialVC = PageViewController(with: citiesArray[0], index: firstCityIndex)
            self.pageViewController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        }
        pageViewController?.didMove(toParent: self)
        
    }
    
    private func setupNavigationBar() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCityTapped))
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .mainWhite()
        
        navigationController?.navigationBar.barTintColor = .mainBlue()
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func showAlertController() {
        addCityAlertController(title: "Enter city name") { [weak self] (city) in
        
            self?.citiesArray.append(city)
            UserDefaultsManager.shared.cities = self?.citiesArray

            self?.pageViewController.reloadInputViews()
            guard let firstSityItem = self?.citiesArray[0] else { return }
            guard let firstCityIndex = self?.citiesArray.firstIndex(of: firstSityItem) else { return }
            let initialVC = PageViewController(with: firstSityItem, index: firstCityIndex)
            self!.pageViewController?.setViewControllers([initialVC], direction: .forward, animated: false, completion: nil)
        }
    }
}

// MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate
extension MainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? PageViewController else {
            return nil
        }
        
        var index = currentVC.index
        
        if index == 0 {
            return nil
        }
        
        index -= 1
        
        guard let currentCityIndex = citiesArray.firstIndex(of: citiesArray[index]) else { return nil }
        let vc: PageViewController = PageViewController(with: citiesArray[index], index: currentCityIndex)
        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentVC = viewController as? PageViewController else {
            return nil
        }
        
        var index = currentVC.index
        
        if index >= self.citiesArray.count - 1 {
            return nil
        }
        
        index += 1
        
        guard let currentCityIndex = citiesArray.firstIndex(of: citiesArray[index]) else { return nil }
        let vc: PageViewController = PageViewController(with: citiesArray[index], index: currentCityIndex)
        
        return vc
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return citiesArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
}
