import UIKit

class StockDateView: BaseView {
    let datePicker = UIDatePicker()
//    let usecase : StockDetailUseCase = .init(stockRepository: stockRepository)
//    let viewModel : StockDetailViewModel = .init(usecase: usecase)
    
    override func configureUI() {
  
        setAttributes()
        setContraints()
    }
    func setAttributes() {
            datePicker.preferredDatePickerStyle = .automatic
            datePicker.datePickerMode = .date
            datePicker.locale = Locale(identifier: "ko-KR")
            datePicker.timeZone = .autoupdatingCurrent
            
    }
    private func setContraints() {
        addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
//        datePicker.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        datePicker.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
   
    
}
