import SwiftUI

struct IngredientMeassuremnt {
    let nameIngredient: String
    let measurement: String
}

struct DessertDetailView: View {
    
    @StateObject var model: DessertDetailViewModel
    let id: String
    
    init(id: String, manager: MealManager) {
        self.id = id
        _model = .init(wrappedValue: DessertDetailViewModel(manager: manager))
    }
    
    var body: some View {
        VStack {
            switch model.state {
                
            case .initial, .loading:
                ProgressView()
            case .loaded(let mealDetail):
                MealDetailView(model: mealDetail)
            case .failed(let error):
                Text(error.localizedDescription)
            }
            Spacer()
        }
        .task {
            await model.fetchMealDetail(id)
        }
    }
    

}

#Preview {
    DessertDetailView(id: "1", manager: DI.Preview.mealManager)
}
