//
//  TaskDetalsView.swift
//  sampleCoordinator
//
//  Created by mohebro on 09.12.2021.
//

import UIKit

protocol TaskDetalsViewInterface: UIViewController {
    func initialSetup()
    
    func set(title: String)
    func set(detail: String)

    var onViewWillDisappear: (() -> ())? { get set }
    var onDelete: (() -> ())? { get set }
    var onTitleChanged: ((String) -> ())? { get set }
    var onDetailChanged: ((String) -> ())? { get set }
}

class TaskDetalsView: UIViewController {
    var onViewWillDisappear: (() -> ())?
    var onDelete: (() -> ())?
    var onTitleChanged: ((String) -> ())?
    var onDetailChanged: ((String) -> ())?
    
    var presenter: TaskDetalsPresenterInterface!
    
    // MARK: - Properties
            
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onViewWillDisappear?()
    }

    // MARK: - Setups


    
    // MARK: - Actions

    @IBAction func deleteAction(_ sender: Any) {
        onDelete?()
    }
    
    @IBAction func titleTextFieldChanged(_ sender: UITextField) {
        onTitleChanged?(sender.text ?? "")
    }
    
}



extension TaskDetalsView: TaskDetalsViewInterface {
    func set(title: String) {
        titleTextField.text = title
    }
    
    func set(detail: String) {
        detailTextView.text = detail
    }
    
    
    func initialSetup() {
        self.navigationItem.title = ""
    }
    
}

extension TaskDetalsView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        onDetailChanged?(textView.text ?? "")
    }
}
