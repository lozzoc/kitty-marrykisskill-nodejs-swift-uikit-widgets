//
//  ZipcodeCatDetailsView.swift
//  Mkk-iOS
//
//  Created by Conner Maddalozzo on 5/19/23.
//

import SwiftUI

struct ZipcodeCatDetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var imageSelected: Int = -1
    @State var sirname: String = ""
    @State var selectedImage: Int = -1
    @State var selectedImageData: Data? = nil
    var urls: [String]
    let kitty: ZipcodeCat
    
    @State var imageUrls: [String] = []
    @ObservedObject var viewModel: ZipcodeAdoptions.ViewModel
    
    
    
    init( kitty: ZipcodeCat) {
        self.urls = ["https://placekitten.com/400/400"]
        self.kitty = kitty
        self.viewModel = ZipcodeAdoptions.ViewModel(with: kitty)
    }
    
    @State var metrics: GeometryProxy?
    var body: some View {
        GeometryReader { proxy in
            
            ScrollView {
                VStack(spacing: 24) {
                    sceneView
                        .padding(.horizontal, 16)
                    requiredToysView
                    
                    breedinfo
                        .padding(.horizontal, 16)
                    description
                        .padding(.horizontal, 16)
                }
                
            }.onAppear {
                metrics = proxy
            }
            .background(Color("dark-purple"))
            
        }
    }
    
    private var sceneView: some View {
        ZStack {
            SceneKitView(
                scene: viewModel.nonObservables.scene,
                onNodeSelected: { _ in },
                delegate: viewModel.nonObservables.sceneDelegate
            )
            .background()
            .cornerRadius(8)

            .padding(8)
            
            .frame(height: UIScreen.main.bounds.height * 0.25)
            if viewModel.observables.isSceneLoading == .success(true) {
                KMKLoadingIndicator(bodyText: "Neighboorhood scene resources Loading")
            }
        }
    }
    
    var toysNeeded: [ToyType] {
        ToyType.allCases.map { return $0 }.filter { return $0 != .unknown   }
    }
    
    var toysAlreadyExisting: [ToyItemUsed] {
        return []
    }

    var columnscolums: [GridItem] = Array.init(repeating: .init(.fixed((UIScreen.main.bounds.width-10)/3)), count: 3)

    
    
    var requiredToysView: some View {
        
        VStack {
            KMKSwiftUIStyles.i.renderSectionHeader(with: "Current toys in use on site")
                .padding(.top, 50)
            ForEach(toysNeeded, id: \.self) { toy in
                if let matchingToy = toysAlreadyExisting.first(where: { lhs in
                    lhs.type == toy
                }) {
                    RequiredToyTableCellView(ds: matchingToy)
                } else {
                    RequiredToyTableCellView(ds: .init(dateAdded: 0, type: toy, hits: 0))
                }
            }
        }
        .background()
        .cornerRadius(8)
        
        .overlay(
            KMKSwiftUIStyles.i.renderDashboardTileBorder())
        .padding([.trailing,.leading], 7)
    }
    
    var breedinfo: some View {
        VStack(spacing: 0) {
            HStack {
                KMKSwiftUIStyles.i.renderSectionHeader(with: "Kitty Breed")
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 16)
                    .padding(.bottom, 24)
                    .padding(.top, 16)
                Spacer()
            }
            
            VStack(spacing: 0) {
                ForEach(0..<section1Details.count, id: \.self) {
                    EmojiSectionView(screenWidth: metrics?.size.width ?? 69, ds: section1Details[$0])
                }
                ForEach(0..<emojieSectionDetails.count, id: \.self) {
                    EmojiSectionView(screenWidth: metrics?.size.width ?? 69, ds: emojieSectionDetails[$0])
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            
        }
        .background()
        .cornerRadius(8)
        .padding(.horizontal, 24)

    }
    
    var description: some View {
        
        VStack(spacing: 0) {
            HStack {
                KMKSwiftUIStyles.i.renderSectionHeader(with: "Kitty Breed")
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 16)
                    .padding(.bottom, 24)
                    .padding(.top, 16)
                Spacer()
            }
            
            Text(longText)
                .multilineTextAlignment(.leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            
        }
        .background()
        .cornerRadius(8)
        .padding(.horizontal, 24)
    }
    
    var breed: KittyBreed? {
        return kitty.breed
    }
    
    var  longText: String {
        self.breed?.description ?? "desc"
    }
    
    var emojieSectionDetails: [RowCellDataSource] {
        guard let stats = self.breed else {
            return []
        }
        
        var details = [RowCellDataSource]()
        
        details.append((name: "Intelligence", value: stats.intelligence, stringValue:"🧠", varient: 0))
        details.append((name: "Stranger Friendly", value: stats.stranger_friendly, stringValue:"🧟‍♂️", varient: 0))
        details.append((name: "Energy Lvl", value: stats.energy_level, stringValue:"⚡️", varient: 0))
        details.append((name: "Dog Friendly", value: stats.dog_friendly, stringValue:"🐶", varient: 0))
        
        return details
    }
    
    var  section1Details: [RowCellDataSource] {
        guard let stats = self.breed else {
            return []
        }
        var details = [RowCellDataSource]()
        details.append((name: "Name", value: stats.intelligence, stringValue: stats.name, varient: 1))
        details.append((name: "Country Of Origin", value: stats.intelligence, stringValue:stats.origin, varient: 1))
        details.append((name: "Lifespan", value: stats.intelligence, stringValue:"\(stats.life_span) years", varient: 1))
        details.append((name: "Shedding Lvl", value: stats.shedding_level, stringValue:"🐾", varient: 0))
        
       return details
    }
}

struct ZipcodeCatDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZipcodeCatDetailsView(kitty: ZipcodeCat.previews[0])
                .previewLayout(.fixed(width: 500, height: 1690)) // Set the desired height
//            ConfirmOrDiscardView(urls: ["https://placekitty.com/690/690"], kitty: KittyBreed.previews)
//                .environmentObject(KittyPFPViewModel())
//                .preferredColorScheme(.dark)
        }
    }
}
