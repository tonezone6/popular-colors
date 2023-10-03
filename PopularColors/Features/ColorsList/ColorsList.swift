//
//  SwiftUIView.swift
//  TestableCoordinators
//
//  Created by Alex S. on 01/09/2023.
//

import SwiftUI

struct ColorsList: View {
  @ObservedObject var model: ColorsListModel
  
  var body: some View {
    Group {
      if model.colors.isEmpty {
        ZStack {
          Color(uiColor: .systemGroupedBackground)
            .ignoresSafeArea()
          VStack {
            Text("No colors found")
              .font(.subheadline)
              .foregroundColor(.secondary)
            Button("Add color") {
              model.addColorButtonTapped()
            }
            .buttonStyle(.bordered)
          }
        }
      } else {
        List(model.sorted) { color in
          PopularColorRow(color: color)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
            .onTapGesture {
              model.colorTapped(color)
            }
        }
      }
    }
    .navigationTitle("Popular colors")
    .toolbar {
      if model.colors.count > 0 {
        ToolbarItem {
          Button(action: { model.addColorButtonTapped() }) {
            Image(systemName: "plus")
              .resizable()
              .scaledToFit()
          }
        }
      }
    }
  }
}

struct PopularColorRow: View {
  let color: PopularColor
  
  var body: some View {
    HStack {
      Circle()
        .fill(color.color)
        .frame(height: 40)
      VStack(alignment: .leading) {
        Text(color.name)
        Text("Rating: \(color.rating)")
          .foregroundColor(.secondary)
          .font(.footnote)
      }
      Spacer()
      Image(systemName: "chevron.right")
        .resizable()
        .fontWeight(.bold)
        .scaledToFit()
        .frame(height: 12)
        .foregroundColor(.gray.opacity(0.5))
    }
  }
}

struct ColorsList_Previews: PreviewProvider {
  static var previews: some View {
    ColorsList(
      model: ColorsListModel(colors: PopularColor.allColors)
    )
  }
}
