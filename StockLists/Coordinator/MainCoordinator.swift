import UIKit
import Pure

class MainCoordinator: Coordinator, FactoryModule {
    struct Dependency {
        let stockListControllerFactory : () -> StockListController
        let stockDetailControllerFactory : (Stock) -> StockDetailController
        let selctDateControllerFactory : (Stock) -> SelectDateController
    }
    var navigationController: UINavigationController?
    
    let rootViewController : StockListController
    let stockDetailControllerFactory : (Stock) -> StockDetailController
    let selctDateControllerFactory : (Stock) -> SelectDateController
    
    required init(dependency: Dependency, payload: ()) {
        rootViewController  = dependency.stockListControllerFactory()
        stockDetailControllerFactory =  dependency.stockDetailControllerFactory
        selctDateControllerFactory = dependency.selctDateControllerFactory
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.setViewControllers([rootViewController], animated: false)
    }
    func StockCellTabbed(item : Stock) {
        let vc = stockDetailControllerFactory(item)
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
    func dateInputTextFieldTapped(item : Stock) {
        let vc = selctDateControllerFactory(item)
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
}
