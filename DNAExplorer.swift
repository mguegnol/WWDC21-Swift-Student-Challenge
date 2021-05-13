//
//  DNAExplorer.swift
//  WWDC21
//
//  Created by mguegnol on 07/04/2021.
//

import SwiftUI
import PlaygroundSupport

class CollapsibleData: ObservableObject {
    @Published var uncollapsedId: Int = -1
    @Published var scrollTarget: Int = -1
    @Published var highlightStartId: Int = -1
    @Published var highlightEndId: Int = -1
}

struct Collapsible2: View {
    
    var label: String
    var content: String
    
    var id: Int
    var highlightStart: Int
    var highlightEnd: Int
    
    @ObservedObject var data: CollapsibleData
    
    var body: some View {
        VStack(spacing: 0) {
            Button(
                action: {
                    if self.data.uncollapsedId != self.id {
                        self.data.uncollapsedId = self.id
                        self.data.scrollTarget = self.highlightStart
                        self.data.highlightStartId = self.highlightStart
                        self.data.highlightEndId = self.highlightEnd
                    } else {
                        self.data.uncollapsedId = -1
                        self.data.highlightStartId = -1
                        self.data.highlightStartId = -1
                        self.data.highlightEndId = -1
                    }
                },
                label: {
                    HStack {
                        Text(self.label)
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.leading)
                        
                        Spacer()
                        Image(systemName: self.data.uncollapsedId != self.id ? "chevron.down" : "chevron.up")
                            .padding(.trailing)
                    }
                    .contentShape(Rectangle())
                    .padding([.bottom, .top], 10)
                    .background(Color(hexStringToUIColor(hex: "b3dad0")))
                    .foregroundColor(Color(hexStringToUIColor(hex: "#34665a")))
                }
            )
            .buttonStyle(PlainButtonStyle())
            .zIndex(1)
            
            VStack {
                HStack {
                    Text(self.content)
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .background(Color.gray)
                .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
            }
            .frame(height: self.data.uncollapsedId != self.id ? 0 : .none)
            .clipped()
            .animation(.easeOut)
        }
    }
}

struct HelixCodon: View {
    var fullView: GeometryProxy
    @ObservedObject var data: CollapsibleData
    
    private var V: [String] {
        do {
            let path = Bundle.main.path(forResource: "V_codon", ofType: "txt")!
            let file = try String(contentsOfFile: path)
            let text: [String] = file.components(separatedBy: "\n")
            return text
        } catch let error {
            Swift.print("Fatal Error: \(error.localizedDescription)")
        }
        return [""]
    }
    
    private var S: [String] {
        do {
            let path = Bundle.main.path(forResource: "spike_codon", ofType: "txt")!
            let file = try String(contentsOfFile: path)
            let text: [String] = file.components(separatedBy: "\n")
            return text
        } catch let error {
            Swift.print("Fatal Error: \(error.localizedDescription)")
        }
        return [""]
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 0) {
                Spacer()
                Text("Vaccine")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 125, alignment: .center)
                Spacer()
                Text("Spike")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 125, alignment: .center)
                Spacer()
            }
            ScrollViewReader { scrollProxy in
                GeometryReader { scrollGeo in
                    ScrollView(.vertical) {
                        LazyVStack(spacing: 8) {
                            Spacer()
                                .frame(height: scrollGeo.size.height / 2 - 10 - 8) //minus half one cell height minus LazyVStack spacing
                            ForEach(0..<V.count-1) { index in
                                GeometryReader { cellGeo in
                                    HStack(spacing: 0) {
                                        Spacer()
                                        
                                        ZStack {
                                            Rectangle()
                                                .fill(LinearGradient(gradient: Gradient(colors: [Color(hexStringToUIColor(hex: "#ee9ca7")), Color(hexStringToUIColor(hex: "#f0aab4"))]), startPoint: .leading, endPoint: .trailing))
                                                .clipShape(Capsule())
                                                .frame(width: 125, height: 25, alignment: .center)
                                            
                                            Text("\(self.V[index])")
                                                .fontWeight(.heavy)
                                                .foregroundColor(index >= self.data.highlightStartId ? (index <= self.data.highlightEndId ? Color(hexStringToUIColor(hex: "#ffffff")) : Color(hexStringToUIColor(hex: "#782933"))) : Color(hexStringToUIColor(hex: "#782933")))
                                                .opacity((Double(cellGeo.frame(in: .global).minY - scrollGeo.frame(in: .global).minY)-10) >= 90 ? ((Double(cellGeo.frame(in: .global).minY - scrollGeo.frame(in: .global).minY)-10) <= 270 ? 1.0 : 0.0) : 0.0)
                                        }
                                        .scaleEffect(self.data.highlightStartId == index ? 1.2 : 1)
                                        .animation(.easeInOut, value: self.data.highlightStartId)
                                        .rotation3DEffect(.degrees(180-10+Double(cellGeo.frame(in: .global).minY - scrollGeo.frame(in: .global).minY)), axis: (x: 0, y: 1, z: 0), perspective: 0.1)
                                        
                                        Spacer()
                                        
                                        ZStack {
                                            Rectangle()
                                                .fill(LinearGradient(gradient: Gradient(colors: [Color(hexStringToUIColor(hex: "#ee9ca7")), Color(hexStringToUIColor(hex: "#f0aab4"))]), startPoint: .leading, endPoint: .trailing))
                                                .clipShape(Capsule())
                                                .frame(width: 125, height: 25, alignment: .center)
                                            
                                            Text("\(self.S[index])")
                                                .fontWeight(.heavy)
                                                .foregroundColor(.black)
                                                .opacity((Double(cellGeo.frame(in: .global).minY - scrollGeo.frame(in: .global).minY)-10) >= 90 ? ((Double(cellGeo.frame(in: .global).minY - scrollGeo.frame(in: .global).minY)-10) <= 270 ? 1.0 : 0.0) : 0.0)
                                        }
                                        .rotation3DEffect(.degrees(180-10+Double(cellGeo.frame(in: .global).minY - scrollGeo.frame(in: .global).minY)), axis: (x: 0, y: 1, z: 0), perspective: 0.1)
                                        
                                        Spacer()
                                    }
                                }
                                .id(index)
                                .frame(height: 25, alignment: .center)
                                
                            }
                            Spacer()
                                .frame(height: scrollGeo.size.height / 2 - 10 - 8) //minus half one cell height minus LazyVStack spacing
                        }// Scroll to the desired row when the @State variable changes
                        .onChange(of: data.scrollTarget) { target in
                            withAnimation {
                                scrollProxy.scrollTo(data.scrollTarget, anchor: .center)
                            }
                            data.scrollTarget = -1
                        }
                    }
                }
            }
            .frame(height: 400)
            Spacer()
        }
    }
}

struct DNAExplorer: View {
    @StateObject var collapsibleData: CollapsibleData = CollapsibleData()
    
    var body: some View {
        GeometryReader { fullView in
            Text("mRNA-Explorer: Browse & Learn")
                .font(.system(size: 50, weight: .semibold))
                .padding(50)
                .foregroundColor(.white)
            HStack {
                HelixCodon(fullView: fullView, data: collapsibleData)
                VStack {
                    ForEach(0..<collapsibleContentArray.count) { i in
                        Collapsible2(
                            label: collapsibleContentArray[i].labelStr,
                            content: collapsibleContentArray[i].contentStr,
                            id: i,
                            highlightStart: collapsibleContentArray[i].highlightStart,
                            highlightEnd: collapsibleContentArray[i].highlightEnd,
                            data: collapsibleData
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.trailing, 16*2)
                        .animation(.easeInOut)
                        
                    }
                }
            }
        }
    }
}

struct SplashView: View {
    @Binding var showSplash: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text("mRNA-Explorer")
                .font(.system(size: 60, weight: .semibold))
            Text("We're hearing all about BioNTech/Pfizer's revolutionary vaccine, but what is it really? Let's take a look at the vaccine's source code, composed of 4284 characters.\n\n\"Vaccine source code\"? Yes! mRNA is made up of molecules (A, C, G, U), and serves as the blueprint human cells use to make proteins. Scientists focused on the genetic sequence of the virus’s 'spike' protein (the one that allows the virus to enter our healthy cells), to synthesize a harmless mRNA copy of it. Once inside your body, cells make many of these proteins, exposing your immune system to the viral proteins, without making you sick.")
                .font(.system(size: 30))
                .padding(50)
            Image(uiImage: UIImage(named: "vaccine-process.png")!)
                .resizable()
                .scaledToFit()
                .padding([.leading, .trailing], 50)
            Button(action: {
                withAnimation(.linear) {
                    self.showSplash.toggle()
                }
            }) {
                Text("EXPLORE mRNA!")
                    .font(.system(size: 18, weight: .heavy))
                    .padding()
                    .padding([.leading, .trailing], 40)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.white, lineWidth: 2)
                    )
            }
            .padding(.top, 50)
        }.foregroundColor(.white)
    }
}

struct ContainerView: View {
    @State var showSplash: Bool = true
    
    var body: some View {
        ZStack {
            SplashView(showSplash: $showSplash)
                .opacity(showSplash ? 1.0 : 0.0)
            DNAExplorer()
                .opacity(showSplash ? 0.0 : 1.0)
        }
        .background(Color(hexStringToUIColor(hex: "#1e1e1e")))
        .cornerRadius(30)
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.white, lineWidth: 2)
        )
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

func hexStringToUIColor(hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

PlaygroundPage.current.setLiveView(ContainerView().frame(maxWidth: 1100))
