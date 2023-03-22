BaseView(baseState: viewModel.appState) {

}

import Combine

class BaseViewModel: ObservableObject {
    
    let appState: AppState = AppState()

    var cancellables = Set<AnyCancellable>()
    
    init() {
        print("init : \(self)")
    }
    
    deinit {
        print("deinit : \(self)")
    }
    
}
