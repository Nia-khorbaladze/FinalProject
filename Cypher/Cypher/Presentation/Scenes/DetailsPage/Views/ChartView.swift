//
//  ChartView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 17.01.25.
//

import SwiftUI
import Charts

struct ChartView: View {
    @State private var selectedInterval: String = "1D"
    private let intervals = ["1D", "1W", "1M", "1Y", "ALL"]
    
    private let chartData: [String: [Double]] = [
        "1D": [1, 1.5, 1.2, 1.8, 2, 2.3, 2.1],
        "1W": [1, 1.2, 1.5, 2, 1.8, 2.5, 2.3, 3],
        "1M": [1, 1.3, 1.5, 2.2, 2.8, 3.5, 3.1, 4],
        "1Y": [1, 2, 3, 4, 3.5, 4.5, 5, 6],
        "ALL": [1, 1.5, 2, 3, 3.5, 4, 5, 6, 7]
    ]
    
    var body: some View {
        VStack {
            Chart {
                if let data = chartData[selectedInterval] {
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
