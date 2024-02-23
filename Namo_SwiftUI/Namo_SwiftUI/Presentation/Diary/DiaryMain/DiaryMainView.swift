//
//  DiaryMainView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI

// TODO: - 기록 화면 메인 UI 만들기

struct DiaryMainView: View {
    
    @State var showDatePicker: Bool = false
    @State var pickerCurrentYear: Int = Date().toYMD().year
    @State var pickerCurrentMonth: Int = Date().toYMD().month
    @State var test: String = String(format: "%d.%02d", Date().toYMD().year, Date().toYMD().month)
    
    var body: some View {
        ZStack {
            if showDatePicker {
                NamoAlertView(
                    showAlert: $showDatePicker,
                    content: AnyView(
                        HStack(spacing: 0) {
                            Picker("", selection: $pickerCurrentYear) {
                                ForEach(2000...2099, id: \.self) {
                                    Text("\(String($0))년")
                                        .font(.pretendard(.regular, size: 23))
                                }
                            }
                            .pickerStyle(.inline)
                            
                            Picker("", selection: $pickerCurrentMonth) {
                                ForEach(1...12, id: \.self) {
                                    Text("\(String($0))월")
                                        .font(.pretendard(.regular, size: 23))
                                }
                            }
                            .pickerStyle(.inline)
                        }
                            .frame(height: 154)
                    ),
                    leftButtonTitle: "취소",
                    leftButtonAction: {
                        pickerCurrentYear = Date().toYMD().year
                        pickerCurrentMonth = Date().toYMD().month
                    },
                    rightButtonTitle: "확인",
                    rightButtonAction: {
                        test = String(format: "%d.%02d", pickerCurrentYear, pickerCurrentMonth)
                    }
                )
            }
            
            VStack {
                HStack {
                    Button {
                        showDatePicker = true
                    } label: {
                        HStack {
                            Text(test)
                                .font(.pretendard(.bold, size: 22))
                        
                            Image(.icChevronBottomBlack)
                        }
                    }
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    Capsule()
                        .foregroundColor(.mainGray)
                        .frame(width: 152, height: 30)
                        .overlay(alignment: .leading, content: {
                            Capsule()
                                .fill(.mainOrange)
                                .frame(width: 80, height: 26)
                                .overlay(
                                    Text("개인")
                                        .font(.pretendard(.bold, size: 15))
                                        .foregroundStyle(.white)
                                )
                                .padding(.leading, 2)
                                .padding(.trailing, 2)
                        })
                        .overlay(alignment: .trailing, content: {
                            Text("모임")
                                .font(.pretendard(.bold, size: 15))
                                .foregroundStyle(Color(.mainText))
                                .padding(.trailing, 24)
                        })
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
                Text("기록이 없습니다. 기록을 추가해 보세요!")
                    .font(.pretendard(.light, size: 15)) // Weight 400 -> .light
                    .padding(.top, 24)
                
                Spacer()
            }
        }
    }
}

#Preview {
    DiaryMainView()
}
