//
//  ContentView.swift
//  Travel App
//
//  Created by Mohsen Abdollahi on 7/15/20.
//  Copyright © 2020 Mohsen Abdollahi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home : View {
    
    @State var index = 0
    @State var show : Bool = false
    @State var data = [
        TravelData(id: 0, image: "yosemite", country: "USA", place: "Yosemite", details: "Yosemite National Park is in California’s Sierra Nevada mountains. It’s famed for its giant, ancient sequoia trees, and for Tunnel View, the iconic vista of towering Bridalveil Fall and the granite cliffs of El Capitan and Half Dome. In Yosemite Village are shops, restaurants, lodging, "),
        
        TravelData(id: 1, image: "antelope", country: "Arizona", place: "Antelope Canyon", details: "Antelope Canyon is a slot canyon in the American Southwest, on Navajo land east of Page, Arizona. It includes two separate, scenic slot canyon sections, referred to as Upper Antelope Canyon, and Lower Antelope Canyon."),
        
        TravelData(id: 2, image: "azores", country: "Portugal", place: "Azores", details: "The Azores, an autonomous region of Portugal, are an archipelago in the mid-Atlantic. The islands are characterized by dramatic landscapes, fishing villages, green pastures and hedgerows of blue hydrangeas. São Miguel, the largest, has lake-filled calderas and the Gorreana "),
        
        TravelData(id: 3, image: "venice", country: "Italy", place: "Venice", details: "Venice, the capital of northern Italy’s Veneto region, is built on more than 100 small islands in a lagoon in the Adriatic Sea. It has no roads, just canals – including the Grand Canal thoroughfare – lined with Renaissance and Gothic palaces."),
        
        TravelData(id: 4, image: "angelfalls", country: "Venezuela", place: "Angel Falls", details: "Angel Falls is a waterfall in Venezuela. It is the world's highest uninterrupted waterfall, with a height of 979 metres and a plunge of 807 m. The waterfall drops over the edge of the Auyán-tepui mountain in the Canaima National Park")
    ]
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Travel")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(index + 1 )/ \(self.data.count)")
                        .foregroundColor(.gray)
                }
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding()
                Spacer()
                
                GeometryReader { geo in
//                    HScrolView(data: self.$data, show: self.$show, size: geo.frame(in : .global))
                    Carousel(data: self.$data, show: self.$show, index: self.$index, size: geo.frame(in : .global))
                }
                .padding(.bottom, (UIApplication.shared.windows.first?.safeAreaInsets.bottom)! + 10)
            }
        }
        .background(Color.black.opacity(0.07).edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}


//Carousel List....

struct HScrolView : View {
    
    @Binding var data : [TravelData]
    // For Expanding View
    @Binding var show : Bool
    var size : CGRect

    var body: some View {
        HStack(spacing : 0){
            ForEach(self.data) { i in
                ZStack{
                    Image(i.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: self.size.width - 30, height: self.size.height)
                        .cornerRadius(25)
                        .contentShape(Rectangle())
                }
                    //Fixed frame for carousel List...
                    .frame(width: self.size.width, height: self.size.height)
            }
        }
    }
}

struct TravelData : Identifiable {
    
    var id : Int
    var image : String
    var country : String
    var place : String
    var details : String
}


struct Carousel : UIViewRepresentable {
    
    @Binding var data : [TravelData]
    @Binding var show : Bool
    @Binding var index : Int
    var size : CGRect
    
    func makeUIView(context: Context) -> UIScrollView {
        let view = UIScrollView()
        view.contentSize = CGSize(width: size.width * CGFloat(data.count), height: size.height)
        
        let child = UIHostingController(rootView: HScrolView(data: self.$data, show: self.$show, size: self.size))
        child.view.backgroundColor = .clear
        child.view.frame = CGRect(x: 0, y: 0, width: size.width * CGFloat(data.count), height: size.height)
        
        view.addSubview(child.view)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = true
        view.isPagingEnabled = true
        
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView , context: Context) {

        }
}
