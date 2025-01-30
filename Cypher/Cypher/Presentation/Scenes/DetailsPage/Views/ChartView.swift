//
//  ChartView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 17.01.25.
//

import SwiftUI
import Charts

struct ChartView: View {
    @ObservedObject var viewModel: DetailsPageViewModel
    @State private var selectedInterval: String = "1D"
    private let intervals = ["1D", "1W", "1M", "1Y", "ALL"]
    
    var body: some View {
        VStack {
            Chart {
                if let data = viewModel.priceHistory[selectedInterval], !data.isEmpty {
                    ForEach(data.indices, id: \.self) { index in
                        LineMark(
                            x: .value("Time", index),
                            y: .value("Price", data[index])
                        )
                        .foregroundStyle(.green)
                    }
                }
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .frame(height: 200)
            .padding()
            
            HStack {
                ForEach(intervals, id: \.self) { interval in
                    Text(interval)
                        .font(Fonts.semiBold.size(13))
                        .foregroundColor(selectedInterval == interval ? Color(AppColors.accent.rawValue) : Color(AppColors.lightGrey.rawValue))
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(selectedInterval == interval ? Color(AppColors.greyBlue.rawValue) : Color.clear)
                        )
                        .onTapGesture {
                            withAnimation {
                                selectedInterval = interval
                            }
                        }
                }
            }
            .background(Color(AppColors.backgroundColor.rawValue))
            .cornerRadius(12)
            .padding()
        }
        .background(Color(AppColors.backgroundColor.rawValue).ignoresSafeArea(.all))
    }
}

