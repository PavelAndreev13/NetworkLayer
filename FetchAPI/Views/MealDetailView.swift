import SwiftUI

struct MealDetailView: View {
    
    let model: MealDetail
    
    var body: some View {
            VStack(spacing: 24) {
                
                AsyncImage(url: model.thumb) { image in
                    image.resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(15.0)
                                    
                } placeholder: {
                    ProgressView()
                }
              
                VStack {
                    Text(model.instructions)
                        .font(.body)
                    ForEach(model.ingredients, id: \.id) { ingredient in
                        HStack(spacing: 16) {
                            Text(ingredient.name)
                                .font(.caption)
                            Spacer()
                            Text(ingredient.measure)
                                .font(.caption)
                        }
                    }
                }
            
            .navigationTitle(model.name)
            .padding()
        }
    }
}

#Preview {
    MealDetailView(
        model: MealDetail(
            name: "Spicy Arrabiata Penne",
            thumb: URL(string: "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg"),
            instructions: "Bring a large pot of water to a boil. Add kosher salt to the boiling water",
            ingredients: [
                MealDetail.Ingredient(id: 1, name: "penne rigate", measure: "1 teaspon"),
                MealDetail.Ingredient(id: 2, name: "pasta", measure: "1 teaspon"),
                MealDetail.Ingredient(id: 3, name: "sugar", measure: "1 tablespoon"),
                MealDetail.Ingredient(id: 4, name: "flour", measure: "1 kg"),
            
            ])
    )
}
