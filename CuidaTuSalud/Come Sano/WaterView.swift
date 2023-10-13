//
//  WaterView.swift
//  CuidaTuSalud
//
//  Created by Saras Singh on 13/10/23.
//

import SwiftUI

struct WaterView: View {
    @State var checkmark = false
    @State var checkmark2 = false
    @State var checkmark3 = false
    @State var checkmark4 = false
    @State var checkmark5 = false
    @State var checkmark6 = false
    var body: some View {
        VStack{
            HStack{
                if checkmark == true {
                    Text("1 de 6 vasos")
                        .bold()
                        .font(.title3)
                        .offset(y: -10)
                    Spacer()
                } else if checkmark2 == true {
                    Text("2 de 6 vasos")
                        .bold()
                        .font(.title3)
                        .offset(y: -10)
                    Spacer()
                }else if checkmark3 == true {
                    Text("3 de 6 vasos")
                        .bold()
                        .font(.title3)
                        .offset(y: -10)
                    Spacer()
                }else if checkmark4 == true {
                    Text("4 de 6 vasos")
                        .bold()
                        .font(.title3)
                        .offset(y: -10)
                    Spacer()
                }else if checkmark5 == true {
                    Text("5 de 6 vasos")
                        .bold()
                        .font(.title3)
                        .offset(y: -10)
                    Spacer()
                }else if checkmark6 == true {
                    Text("2 de 6 vasos")
                        .bold()
                        .font(.title3)
                        .offset(y: -10)
                    Spacer()
                }else {
                    Text("0 de 6 vasos")
                        .bold()
                        .font(.title3)
                        .offset(y: -10)
                    Spacer()
                }
            }
            .padding(.horizontal, 50)
            HStack{
 
                    ZStack{
                        HStack{
                            Image("Cup")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .onTapGesture {
                                    checkmark.toggle()
                                }

                        }
                    }
                    .overlay(alignment: .topTrailing, content: {
                        ZStack{

                            Image(systemName: checkmark ? "checkmark" : "")
                                .bold()
                                .font(.system(size:12))
                                .foregroundColor(CustomColor.BgColor)
                        }
                    })
                
                ZStack{
                    HStack{
                        Image("Cup")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                checkmark2.toggle()
                            }

                    }
                }
                .overlay(alignment: .topTrailing, content: {
                    ZStack{
    
                        Image(systemName: checkmark2 ? "checkmark" : "")
                            .bold()
                            .font(.system(size:12))
                            .foregroundColor(CustomColor.BgColor)
                    }
                })
                ZStack{

                    HStack{
                        Image("Cup")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                checkmark3.toggle()
                            }

                    }
                }
                .overlay(alignment: .topTrailing, content: {
                    ZStack{

                        Image(systemName: checkmark3 ? "checkmark" : "")
                            .bold()
                            .font(.system(size:12))
                            .foregroundColor(CustomColor.BgColor)
                    }
                })
                ZStack{

                    HStack{
                        Image("Cup")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                checkmark4.toggle()
                            }

                    }
                }
                .overlay(alignment: .topTrailing, content: {
                    ZStack{
                        Circle()
                            .foregroundColor(CustomColor.FullColor)
                            .frame(width: 15, height: 15)
                        Image(systemName: checkmark4 ? "checkmark" : "")
                            .bold()
                            .font(.system(size:12))
                            .foregroundColor(CustomColor.BgColor)
                    }
                })
                ZStack{
                    HStack{
                        Image("Cup")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                checkmark5.toggle()
                            }

                    }
                }
                .overlay(alignment: .topTrailing, content: {
                    ZStack{
                        Image(systemName: checkmark5 ? "checkmark" : "")
                            .bold()
                            .font(.system(size:12))
                            .foregroundColor(CustomColor.BgColor)
                    }
                })
                ZStack{
                    HStack{
                        Image("Cup")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                checkmark6.toggle()
                            }

                    }
                }
                .overlay(alignment: .topTrailing, content: {
                    ZStack{

                        Image(systemName: checkmark6 ? "checkmark" : "")
                            .bold()
                            .font(.system(size:12))
                            .foregroundColor(CustomColor.BgColor)
                    }
                })
            }
        }    .frame(height: 150)
            .frame(width: UIScreen.main.bounds.width - 20)
            .background(CustomColor.FullColor)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.2), radius: 20, x:0, y:0)
    }
}

#Preview {
    WaterView()
}
