//
//  MealListView.swift
//  FoodHub
//
//  Created by Priyanka Mathur on 05/05/24.
//

import SwiftUI

struct MealListView: View {
    
    @EnvironmentObject var coordinator: NavigationCoordinatorManager<Router>
    @StateObject var viewModel: MealListViewModel
    var body: some View {
        ZStack {
            GradientView(gradientColor: [AppColor.AppOrange.color!, AppColor.AppOrange.color!]).edgesIgnoringSafeArea(.all)
            List {
                if !viewModel.isLoading {
                    ForEach(0..<10) { index in
                        ShimmerEffect()
                            .listRowBackground(Color.clear)
                    }
                    .background(Color.clear)
                    .listRowInsets(EdgeInsets(top: 50, leading: 10, bottom: 10, trailing: 10))
                    .listRowSeparator(.hidden)
                } else {
                    ForEach(viewModel.meals) { meal in
                        MealView(meal: meal)
                            .listRowBackground(Color.clear)
                            .shadow(color: AppColor.AppBlackTitle.swiftUIColor.opacity(0.2), radius: 10, x: 0, y: 5)
                    }
                    .background(Color.clear)
                    .listRowInsets(EdgeInsets(top: 17, leading: 10, bottom: -24, trailing: 10))
                    .listRowSeparator(.hidden)
                }
                
            }
            .scrollContentBackground(.hidden)
            .listStyle(InsetListStyle())
            .navigationTitle("Fruit List")
            .navigationBarItems(
                leading:
                    Button("Back") {
                        coordinator.pop()
                    }
            )
        }
        .task {
            viewModel.fetchMealList()
        }
    }
    
    @ViewBuilder
    private func ShimmerEffect() -> some View {
        VStack {
            HStack {
                ShimmerView()
                    .frame(width: 120)
                    .clipShape(Circle())
                    .padding(.top, -30)
                
                VStack {
                    ShimmerView()
                        .cornerRadius(5)
                        .frame(height: 20)
                    ShimmerView()
                        .cornerRadius(5)
                        .frame(height: 20)
                    ShimmerView()
                        .cornerRadius(5)
                        .frame(height: 20)
                }
            }
        }
    }
}
#Preview {
    MealListView(viewModel: MealListViewModel(model: MealListModel()))
}

