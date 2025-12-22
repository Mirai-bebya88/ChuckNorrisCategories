import UIKit

class FunFactPageViewController: UIPageViewController {
    
    let categories: [FunFactCategory] = [.animal, .dev, .travel]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstVC = viewControllerAtIndex(0) {
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }
    
    func viewControllerAtIndex(_ index: Int) -> FunFactViewController? {
        guard index >= 0, index < categories.count else { return nil }
        
        let storyboard = UIStoryboard(name: "FunFact", bundle: nil)
        guard let contentVC = storyboard.instantiateViewController(withIdentifier: "FunFactViewController") as? FunFactViewController else {
            return nil
        }
        
        contentVC.category = categories[index]
        contentVC.pageIndex = index
        contentVC.totalPages = categories.count
        
        return contentVC
    }
}

extension FunFactPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let contentVC = viewController as? FunFactViewController else { return nil }
        let index = contentVC.pageIndex
        return viewControllerAtIndex(index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let contentVC = viewController as? FunFactViewController else { return nil }
        let index = contentVC.pageIndex
        return viewControllerAtIndex(index + 1)
    }
}
