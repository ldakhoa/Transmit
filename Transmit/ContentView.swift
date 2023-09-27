import SwiftUI

struct ContentView: View {
    private let data: [Episode] = Episode.mockData
    @State private var shouldShowMinimizeView: Bool = true

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    header
                        .padding(.bottom, 24)
                    TransmitDivider()
                    episodes
                        .padding(.top, 24)
                        .padding(.horizontal, 16)
                        .background(Color.white)

                    info
                        .padding(.vertical, 24)
                        .padding(.horizontal, 16)
                }
            }
            .background("F8FAFC".color)
            .padding(.bottom, shouldShowMinimizeView ? 90 : 0)

            if shouldShowMinimizeView {
                VStack {
                    Spacer()
                    MinimizePlayerView()
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }

    @ViewBuilder
    private var header: some View {
        VStack(spacing: 24) {
            Image(uiImage: UIImage(named: "poster")!)
                .resizable()
                .frame(width: 200, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: "e2e8f0".color, radius: 10, x: 0, y: 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black.opacity(0.1), lineWidth: 1)
                )
            Text("Their Side")
                .font(.system(size: 18))
                .bold()
            Text("Conversations with the most tragically misunderstood people of our time.")
                .fontWithLineHeight(font: .systemFont(ofSize: 16))
                .padding(.horizontal, 24)
                .multilineTextAlignment(.center)

            VStack(spacing: 12) {
                TransmitDivider()
                    .frame(width: 32 * 8) // 4 image size width 32 * 4, with spacing 32 for each

                HStack(spacing: 32) {
                    iconImage(named: "spotify")
                    iconImage(named: "podcast")
                    iconImage(named: "overcast")
                    iconImage(named: "rss")
                }
            }
        }
    }

    @ViewBuilder
    private var episodes: some View {
        VStack(alignment: .leading) {
            Text("Episodes")
                .font(.system(size: 18))
                .bold()
            Spacer(minLength: 32)
            VStack(alignment: .leading, spacing: 20) {
                ForEach(data) { episode in
                    episodeCell(episode: episode)
                    TransmitDivider()
                        .padding(.horizontal, -16)
                }
            }
        }
    }

    @ViewBuilder
    private func episodeCell(episode: Episode) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(episode.uploadDate)
                .foregroundColor("64748B".color)
                .font(.system(size: 15))
            Text("\(episode.id): \(episode.name)")
                .bold()
                .font(.system(size: 17))
            Text(episode.description)
                .fontWithLineHeight(font: .systemFont(ofSize: 16))
                .foregroundColor(Styles.paragraph)
            HStack(spacing: 16) {
                Button(action: {
                    shouldShowMinimizeView = true
                }, label: {
                    HStack(alignment: .center) {
                        Image(systemName: "play.fill")
                            .frame(width: 10, height: 10)
                            .fontWeight(.light)
                        Text("Listen")
                    }
                })
                .foregroundColor("EC4899".color)
                .bold()

                Text("/")

                Button("Show notes") {
                }
                .foregroundColor("EC4899".color)
                .bold()
            }
            .font(.system(size: 14))

        }
    }

    @ViewBuilder
    private var info: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .center) {
                    Image(uiImage: UIImage(named: "about")!)

                    Text("About")
                        .fontWeight(.medium)
                        .font(.system(size: 15))
                        .foregroundColor("0F172A".color)
                }
                Text("In this show, Eric and Wes dig deep to get to the facts with guests who have been labeled villains by a society quick to judge, without actually getting the full story. Tune in every Thursday to get to the truth with another misunderstood outcast as they share the missing context in their tragic tale.")
                    .fontWithLineHeight(font: .systemFont(ofSize: 16), lineHeight: 28)
                    .foregroundColor(Styles.paragraph)
            }

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(uiImage: UIImage(named: "hosted")!)
                    Text("Hosted By")
                        .fontWeight(.medium)
                        .font(.system(size: 15))
                }
                HStack {
                    Text("Eric Gordon")
                        .bold()
                        .font(.system(size: 15))
                        .foregroundColor("0F172A".color)
                    Text("/")
                    Text("Wes Mantooth")
                        .bold()
                        .font(.system(size: 15))
                }
            }
        }
    }

    @ViewBuilder
    private func iconImage(named: String) -> some View {
        Image(uiImage: UIImage(named: named)!)
            .renderingMode(.template)
            .foregroundColor("94a3b8".color)
            .frame(width: 32, height: 32)
    }
}

struct TransmitDivider: View {
    var body: some View {
        Divider()
            .overlay("94a3b8".color)
            .opacity(0.3)
    }
}

struct MinimizePlayerView: View {
    @State private var isPlaying: Bool = false
    @State private var sliderValue: Double = 6.0

    var body: some View {
        ZStack {
            Color.white
                .opacity(0.8)
                .frame(maxWidth: .infinity, maxHeight: 150)
            VStack {
                SliderView(
                    value: $sliderValue,
                    sliderRange: 0...10
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
                        Button(action: { isPlaying.toggle() }) {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
