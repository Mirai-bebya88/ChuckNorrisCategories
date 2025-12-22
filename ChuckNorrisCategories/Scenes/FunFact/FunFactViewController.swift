//
//  FunFactViewController.swift
//  ChuckNorrisCategories
//
//  Created by elene malakmadze on 16.12.25.
//

import UIKit

class FunFactViewController: UIViewController {
    
    
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var funFactContent: UILabel!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    var category: FunFactCategory = .animal
    var pageIndex: Int = 0
    var totalPages: Int = 0
    
    private var apiManager: FunFactsAPIManagerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryLabel.text = "⭐\(getCategoryName())⭐"
        
        pageControl.numberOfPages = totalPages
        pageControl.currentPage = pageIndex
        
        fetchFunFacts(with: category)
    }
    
    
    @IBAction func funFactButtonTapped(_ sender: UIButton) {
        fetchFunFacts(with: category)
    }
    
    func fetchFunFacts(with type: FunFactCategory = .animal) {
        apiManager = FunFactsAPIManager()
        
        apiManager?.fetchFunFacts(with: type) { result in
            switch result {
            case .success(let funFact):
                self.funFactContent.text = funFact.value
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCategoryName() -> String {
        switch category {
        case .animal: return "Animal"
        case .dev: return "Dev"
        case .travel: return "Travel"
        }
    }
}

