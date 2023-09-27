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
    @EnvironmentObject private var orientationInfo: OrientationInfo

    var body: some View {
        if orientationInfo.orientation == .portrait {
            contentView
        } else {
            landscapeContentView
        }
    }

    private var contentView: some View {
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
                        playButton()

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
    }

    @ViewBuilder
    private var landscapeContentView: some View {
        ZStack {
            Color.white
                .frame(maxWidth: .infinity, maxHeight: 150)
            HStack {
                playButton(size: 28, padding: 14)

                Spacer(minLength: 24)
                VStack(alignment: .leading) {
                    Text("5: Bill Lumbergh")
                        .bold()
                        .font(.system(size: 15))

                    HStack(alignment: .center, spacing: 16) {
                        HStack(alignment: .center, spacing: 16) {
                            Image(systemName: "gobackward.10")
                                .renderingMode(.template)
                                .foregroundColor("334155".color)
                            Image(systemName: "goforward.10")
                                .renderingMode(.template)
                                .foregroundColor("334155".color)
                        }

                        SliderView(
                            value: $viewModel.sliderValue,
                            sliderRange: 0...300 // 5m
                        )
                        .frame(height: 8)
                        .padding(.bottom, 8)

                        HStack {
                            let minutes = Int(viewModel.sliderValue) / 60
                            let seconds = Int(viewModel.sliderValue) % 60
                            let formattedTime = String(format: "%02d:%02d", minutes, seconds)
                            let currentTime = Text(formattedTime)
                            Text("\(currentTime)")
                                .foregroundColor("64748B".color)
                                .font(.system(size: 14))
                            Text("/")
                                .foregroundColor("CDD6E2".color)
                                .font(.system(size: 14))
                            Text("05:00")
                                .foregroundColor("64748B".color)
                                .font(.system(size: 14))
                        }

                        Button {
                        } label: {
                            Image(uiImage: UIImage(named: "speech1x")!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                        }

                        Image(uiImage: UIImage(named: "speaker")!)
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                            .foregroundColor("334155".color)
                    }
                }
            }
            .padding(.horizontal, 24)
        }
    }

    @ViewBuilder
    private func playButton(size: CGFloat = 17.0, padding: CGFloat = 12) -> some View {
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
                .frame(width: size, height: size)
                .padding(padding)
                .background("334155".color)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }
}

struct MinimizePlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MinimizePlayerView()
            .environmentObject(OrientationInfo())
            .padding(.horizontal, 24)
    }
}
