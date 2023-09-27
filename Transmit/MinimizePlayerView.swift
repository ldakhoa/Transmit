import SwiftUI

final class MinimizePlayerViewModel: ObservableObject {
    @Published var sliderValue: Double = 0.0
    var timer: Timer!

    func startPlayer() {
        timer = Timer(timeInterval: 1, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .default)
    }

    func pausePlayer() {
        timer.invalidate()
    }

    @objc
    private func handleTimer() {
        sliderValue += 1
        if sliderValue == 300 {
            timer.invalidate()
        }
    }
}

struct MinimizePlayerView: View {
    @State private var isPlaying: Bool = false
    @StateObject private var viewModel = MinimizePlayerViewModel()

    var body: some View {
        ZStack {
            Color.white
                .frame(maxWidth: .infinity, maxHeight: 150)
            VStack {
                SliderView(
                    value: $viewModel.sliderValue,
                    sliderRange: 0...300 // 5m
                )
                .frame(height: 8)

                Spacer()

                Text("5: Bill Lumbergh")
                    .bold()
                    .font(.system(size: 15))
                HStack {
                    Image(uiImage: UIImage(named: "speaker")!)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                        .foregroundColor("334155".color)

                    Spacer()

                    HStack(spacing: 16) {
                        Image(systemName: "gobackward.10")
                            .renderingMode(.template)
                            .foregroundColor("334155".color)
                        Button(action: {
                            if isPlaying {
                                viewModel.pausePlayer()
                            } else {
                                viewModel.startPlayer()
                            }
                            isPlaying.toggle()
                        }) {
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 17, height: 17)
                                .padding(12)
                                .background("334155".color)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }

                        Button {

                        } label: {
                            Image(systemName: "goforward.10")
                                .foregroundColor("334155".color)
                        }
                    }

                    Spacer()

                    Button {
                    } label: {
                        Image(uiImage: UIImage(named: "speech1x")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                    }
                }
                .padding(.horizontal, 32)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 140)
    }
}
