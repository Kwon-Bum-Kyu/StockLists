struct AppDependency {
    let mainCoordinator : MainCoordinator
    
}
extension AppDependency {
    static func resolve() -> AppDependency{
        let stockRepository :  StockRepository = StockRepositoryImpi()
        
        let stockListControllerFactory: () -> StockListController = {
            let useCase = StockUseCase(stockRepository: stockRepository)
            let viewModel = StockListViewModel(useCase: useCase)
            return .init(dependency: .init(viewModel: viewModel))
        }
        
        let stockDetailControllerFactory: (Stock) -> StockDetailController = { stock in
            let usecase : StockDetailUseCase = .init(stockRepository: stockRepository)
            let viewModel : StockDetailViewModel = .init(usecase: usecase)
            
            return .init(dependency: .init(stock: stock, viewModel: viewModel))
        }
        
        let selctDateControllerFactory: (Stock) -> SelectDateController = { stocks in
            let usecase : StockDetailUseCase = .init(stockRepository: stockRepository)
            let viewModel : StockDetailViewModel = .init(usecase: usecase)
            let viewModels : StockDetailController = .init(dependency: .init(stock: stocks, viewModel: viewModel))
            return .init(dependency: .init(stock: stocks, viewModel: viewModels))
        }
        
        let mainCoordinator : MainCoordinator = .init(dependency : .init(stockListControllerFactory: stockListControllerFactory, stockDetailControllerFactory: stockDetailControllerFactory, selctDateControllerFactory: selctDateControllerFactory))
        
        return .init(mainCoordinator: mainCoordinator)
    }
}
    
