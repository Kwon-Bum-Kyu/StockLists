import UIKit
import Pure

class StockDetailController: BaseViewController, FactoryModule {
    struct Dependency {
        let stock : Stock
        let viewModel : StockDetailViewModel
    }
    let selfView = StockDetailView()
    let stock : Stock
    let viewModel : StockDetailViewModel
    var coordinator : MainCoordinator?
    var dateText : String?
    required init(dependency : Dependency , payload : ()) {
        stock = dependency.stock
        viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad(symbol: stock.symbol ?? "", stock: stock)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.$dateText.sink{text in
            print("222222 : \(text)")
            self.selfView.bottomView.dateInputView.textField.text = "21345"
        }.store(in: &subscriber)
//        print(viewModel.dateText)
//        self.selfView.bottomView.dateInputView.textField.text = viewModel.dateText
        enableScrollWhenKeyboardAppeared(scrollView: selfView.scrollView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeListeners()
    }
   
    override func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Detail"
        view.addSubview(selfView)
        selfView.translatesAutoresizingMaskIntoConstraints = false
        selfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        selfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        selfView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        selfView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        selfView.bottomView.dateInputView.textField.delegate = self
    }
    
    func bind() {
        viewModel.$timeSeriesMonthlyAdjusted.sink{ timeSeriesMonthlyAdjusted in
            guard let timeSeriesMonthlyAdjusted = timeSeriesMonthlyAdjusted else {return}
            print("timeSeriesMonthlyAdjusteds : \(timeSeriesMonthlyAdjusted)"  )
        }.store(in: &subscriber)
        
        viewModel.$stock.sink{ stock in
            guard let stock = stock else {return}
            self.selfView.topView.configureUI(stock: stock)
            if let currency = stock.currency {
                self.selfView.bottomView.configureUI(currency: currency)
            }
            
        }.store(in: &subscriber)
        
        viewModel.$errorMessage.sink{errorMessage in
            guard let errorMessage = errorMessage else { return }
            print("errorMessage11 : \(errorMessage)")
        }.store(in: &subscriber)
        
        viewModel.$loading.sink{loading in
            self.selfView.loadingView.isHidden = !loading
        }.store(in: &subscriber)
        
        
        
    }
}

extension StockDetailController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField : UITextField) -> Bool {
        
        if textField == selfView.bottomView.dateInputView.textField {
            coordinator?.dateInputTextFieldTapped(item: stock)
            return false
        }
        return true
    }
}
