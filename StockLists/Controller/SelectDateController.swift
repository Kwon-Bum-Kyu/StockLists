import UIKit
import Pure

class SelectDateController: BaseViewController, FactoryModule {
    struct Dependency {
        let stock : Stock
        let viewModel : StockDetailController
    }
    let stockDateView = StockDateView()
    let stock : Stock
    let viewModel : StockDetailController
    var coordinator : MainCoordinator?
    let dateFormat = DateFormatter()

    required init(dependency : Dependency , payload : ()) {
        stock = dependency.stock
        viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func configureUI() {
        view.backgroundColor = .systemBackground
        title = "DateSelect"
        view.addSubview(stockDateView)
        stockDateView.translatesAutoresizingMaskIntoConstraints = false
        stockDateView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stockDateView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        stockDateView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        stockDateView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stockDateView.datePicker.addTarget(self, action: #selector(handleDatePicker(_:)) , for: .valueChanged)
//        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
    }
    
    // MARK: - Selectors
    @objc
    private func handleDatePicker(_ sender: UIDatePicker) {
        print("ssss : \(type(of: sender.date))")
        dateFormat.string(from: sender.date)
        print("dateFormat : \(dateFormat.string(from: sender.date))")
        viewModel.changeDateText(text: "12345")
//        viewModel.dateFormator.string(from: sender.date)
        print(sender.date)
    }
   
    
}
