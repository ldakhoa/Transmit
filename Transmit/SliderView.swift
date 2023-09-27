import SwiftUI

struct SliderView: View {
    @Binding var value: Double

    @State var lastCoordinateValue: CGFloat = 0.0
    var sliderRange: ClosedRange<Double> = 1...100
    let thumbColor: Color = Styles.paragraph
    let minTrackColor: Color = Styles.paragraph
    let maxTrackColor: Color = "F1F5F9".color
    let thumbSpacing: CGFloat = 2

    var body: some View {
        GeometryReader { gr in
            let thumbHeight = gr.size.height * 2.0
            let thumbWidth = gr.size.width * 0.01
            let radius = gr.size.height * 0.5
            let minValue = gr.size.width * 0.015
            let maxValue = (gr.size.width * 0.98) - thumbWidth

            let scaleFactor = (maxValue - minValue) / (sliderRange.upperBound - sliderRange.lowerBound)
            let lower = sliderRange.lowerBound
            let sliderVal = (self.value - lower) * scaleFactor + minValue

            ZStack {
                Rectangle()
                    .foregroundColor(maxTrackColor)
                    .frame(width: gr.size.width, height: gr.size.height * 0.95)
                    .clipShape(RoundedRectangle(cornerRadius: 0))
                HStack {
                    Rectangle()
                        .foregroundColor(minTrackColor)
                        .frame(width: sliderVal, height: gr.size.height * 0.95)
                    Spacer()
                }
                .clipShape(RoundedRectangle(cornerRadius: 0))

                HStack {
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(thumbColor)
                        .frame(width: thumbWidth, height: thumbHeight)
                        .offset(x: sliderVal + thumbSpacing)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { v in
                                    if (abs(v.translation.width) < 0.1) {
                                        self.lastCoordinateValue = sliderVal
                                    }
                                    if v.translation.width > 0 {
                                        let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + v.translation.width)
                                        self.value = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                                    } else {
                                        let nextCoordinateValue = max(minValue, self.lastCoordinateValue + v.translation.width)
                                        self.value = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                                    }
                                }
                        )
                    Spacer()
                }
            }
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    @State static private var currentValue1 = 6.0
    static var previews: some View {
        SliderView(
            value: $currentValue1,
            sliderRange: 0...10
        )
        .frame(width:300, height:10)
    }
}
