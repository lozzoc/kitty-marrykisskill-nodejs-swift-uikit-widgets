//
//  ConfirmOrDiscardView.swift
//  Mkk-iOS
//
//  Created by Conner M on 11/21/21.
//

import SwiftUI



struct ConfirmOrDiscardView: View {
    @State var imageSelected: Int = -1
    @State var sirname: String = ""
    @State var selectedImage: Int = -1
    @State var selectedImageData: Data? = nil
    @Binding var isPresented: Bool
    var onAdoptionClick: ((String,KittyBreed,Data) -> Void)?
    
    var emojieSectionDetails = [RowCellDataSource]()
    var section1Details = [RowCellDataSource]()
    let kitty: UnownedKittyInPlayground
    
    
    init(kitty: UnownedKittyInPlayground, isPresented: Binding<Bool>, onAdoptionClick: @escaping ((String,KittyBreed,Data) -> Void)) {
        self.kitty = kitty
        self._isPresented = isPresented

        self.onAdoptionClick = onAdoptionClick
       
        guard let statsLink = kitty.statsLink  else { return } 

        let stats = KittyBreed(fromRealm: statsLink)

        self.section1Details.append((name: "Name", value: stats.intelligence, stringValue: stats.name, varient: 1))
        self.section1Details.append((name: "Country Of Origin", value: stats.intelligence, stringValue:stats.origin, varient: 1))
        self.section1Details.append((name: "Lifespan", value: stats.intelligence, stringValue:"\(stats.life_span) years", varient: 1))
        self.section1Details.append((name: "Shedding Lvl", value: stats.shedding_level, stringValue:"🐾", varient: 0))
        
        self.emojieSectionDetails.append((name: "Intelligence", value: stats.intelligence, stringValue:"🧠", varient: 0))
        self.emojieSectionDetails.append((name: "Stranger Friendly", value: stats.stranger_friendly, stringValue:"🧟‍♂️", varient: 0))
        self.emojieSectionDetails.append((name: "Energy Lvl", value: stats.energy_level, stringValue:"⚡️", varient: 0))
        self.emojieSectionDetails.append((name: "Dog Friendly", value: stats.dog_friendly, stringValue:"🐶", varient: 0))
        
        
    }
    

    var body: some View {
        GeometryReader { metrics in
        List {
            Section {
                ForEach(0..<section1Details.count, id: \.self) {
                    EmojiSectionView(screenWidth: metrics.size.width, ds: section1Details[$0])
                }
            } header: {
                KMKSwiftUIStyles.i.renderSectionHeader(with: "Kitty Breed")
            }
            Section {
                Text(kitty.statsLink?.kitty_description ?? "Description")
            } header: {
                KMKSwiftUIStyles.i.renderSectionHeader(with: "Description")
            }
            Section {
                ForEach(0..<emojieSectionDetails.count, id: \.self) {
                    EmojiSectionView(screenWidth: metrics.size.width, ds: emojieSectionDetails[$0])
                }
            } header: {
                KMKSwiftUIStyles.i.renderSectionHeader(with: "Personality Traits")

            }
            
            Section {
                HStack{
                    Text("Name").foregroundColor(Color("form-label-color"))
                    Spacer()
                    TextField(
                        MOCK_NAMES.randomElement() ?? "Steven Burg McFartyPants",
                            text: $sirname
                        )
                }
                KMKImagePicker( selectedImage: $selectedImage, selectedImageData: $selectedImageData, width: metrics.size.width)
                
                
                    
            } header: {
                KMKSwiftUIStyles.i.renderSectionHeader(with: "Choose Form for Soul to materialize")
            }
            Section {
                Button {
                    guard sirname.count > 0, selectedImage != -1, let selectedImageData = selectedImageData, let statsLink = kitty.statsLink  else {return}
                    onAdoptionClick?(sirname, KittyBreed(fromRealm: statsLink), selectedImageData)
                    isPresented.toggle()
                } label: {
                    Text("Adopt this Kitty")
                        .padding()
                        .foregroundColor(Color("submit-fg-green"))
                }
            }header: {
                KMKSwiftUIStyles.i.renderSectionHeader(with: "Decision")
            }

        }
    }
    }
}

//struct ConfirmOrDiscardView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ConfirmOrDiscardView(stats: dummyBreed, onAdoptionClick: { name,stats, data in }).preferredColorScheme(.dark).environmentObject(dummyEnv)
//            ConfirmOrDiscardView(stats: dummyBreed, onAdoptionClick: { name,stats, data in }).preferredColorScheme(.light)
//                .environmentObject(dummyEnv)
//        }
//    }
//}
