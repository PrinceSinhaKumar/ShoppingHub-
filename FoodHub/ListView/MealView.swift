//
//  MealView.swift
//  FoodHub
//
//  Created by Priyanka Mathur on 01/05/24.
//

import SwiftUI
struct MealListView: View {
    // Define some example data for the list
    let items = ["Apple", "Banana", "Orange", "Grapes", "Watermelon"]
    @EnvironmentObject var coordinator: NavigationCoordinatorManager<Router>
    @StateObject private var viewModel = MealListViewModel()

    var body: some View {
        ZStack {
            GradientView(gradientColor: [AppColor.AppOrange.color!, AppColor.AppOrange.color!]).edgesIgnoringSafeArea(.all)
            List {
                ForEach(items, id: \.self) { item in
                    MealView()
                        .listRowBackground(Color.clear)
                }
                .background(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .listRowSeparator(.hidden)
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
            viewModel.fetchData()
        }
    }
}
#Preview {
    MealListView()
}

struct MealView: View {
    var body: some View {
        ZStack(alignment: .topLeading){
            HStack {
                MealDescriptionView()
                    .padding([.top, .bottom], 10)
                    .padding(.leading ,100)
                
            }
            .background(AppColor.AppWhiteSecond.swiftUIColor)
            .clipShape(.rect(cornerRadius: 20))
            .padding([.leading, .top, .bottom])
            MealImageView()
                .padding(.top, -30)
        }
        .background(Color.clear)
    }
}

#Preview {
    MealView()
}

struct MealImageView: View {
    var body: some View {
        Image(.image)
            .resizable()
            .scaledToFit()
            .frame(width: 120)
            .clipShape(Circle())
    }
}

#Preview {
    MealImageView()
}

struct MealDescriptionView: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                HStack {
                    Rectangle()
                        .fill(AppColor.AppOrange.swiftUIColor)
                        .frame(width: 5, height: 30)
                    .clipShape(.capsule)
                    .padding(.leading , 0)
                    .padding(.trailing, -1)
                    Text("Burger")
                        .font(AppFontSUI.fontSUI(with: 15, family: OpenSans.regular))
                        .foregroundStyle(AppColor.AppOrange.swiftUIColor)
                }
                Spacer()
                HStack {
                    Button(action: {
                        //todo action
                    }, label: {
                        Image(systemName: "link.circle")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundStyle(AppColor.AppOrange.swiftUIColor)
                    })
                    Button(action: {
                        //todo action
                    }, label: {
                        Image(systemName: "heart")
                            .font(.title)
                            .fontWeight(.light)
                            .foregroundStyle(AppColor.AppOrange.swiftUIColor)
                    })
                }
                .padding(.trailing , -3)
            }
            Text("Duck Confit")
                .font(AppFontSUI.fontSUI(with: 18, family: OpenSans.bold))
            HStack {
                Image(.cooking)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.leading , -8)
                Spacer()
                Image(.soupBowl)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 2)
                Text("9")
                    .font(AppFontSUI.fontSUI(with: 15, family: OpenSans.light))
                    .foregroundColor(AppColor.AppBlackTitle.swiftUIColor)
            }

        }
        .padding([.trailing, .leading])
    }
}

#Preview {
    MealDescriptionView()
}

