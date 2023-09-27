import SwiftUI

struct ContentView: View {
    private let data: [Episode] = Episode.mockData
    @State private var shouldShowMinimizeView: Bool = false
    @EnvironmentObject var orientationInfo: OrientationInfo
    @Environment(\.verticalSizeClass) var verticalSizeClass

    private var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }

    private var isPortrait: Bool {
        orientationInfo.orientation == .portrait
    }

    var body: some View {
        if isPhone {
            contentView
        } else {
            if orientationInfo.orientation == .portrait {
                contentView
            } else {
                iPadContentView
            }
        }
    }

    @ViewBuilder
    private var contentView: some View {
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
    private var iPadContentView: some View {
        HStack(spacing: 0) {
            VStack {
                HStack(alignment: .center, spacing: 24) {
                    Text("Hosted by")
                        .foregroundColor("64748B".color)
                        .font(.system(size: 14))
                    Text("Eric Gordon")
                        .fontWeight(.semibold)
                        .font(.system(size: 14))
                        .foregroundColor("0F172A".color)
                    Text("/")
                        .font(.system(size: 14))
                        .foregroundColor("0F172A".color)
                    Text("Wes Mantooth")
                        .fontWeight(.semibold)
                        .font(.system(size: 14))
                        .foregroundColor("0F172A".color)

                }
                .rotationEffect(Angle(degrees: 90), anchor: .center)
                .fixedSize()
                .padding(.top, 152)

                Spacer()
            }
            .frame(maxWidth: 40, maxHeight: .infinity)
            .background("F8FAFC".color)
            TransmitDivider()

            ScrollView(showsIndicators: true) {
                header
                    .padding(.horizontal, 24)
            }
            .frame(maxWidth: 348)
            .background("F8FAFC".color)

            TransmitDivider()

            ScrollView {
                episodes
                    .padding(.horizontal, 24)
            }

        }
    }
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @ViewBuilder
    private var header: some View {
        VStack(alignment: isPortrait ? .center : .leading, spacing: 24) {
            Image(uiImage: UIImage(named: "poster")!)
                .resizable()
                .frame(width: isPortrait ? 200 : 300, height: isPortrait ? 200 : 300)
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
                .fontWithLineHeight(font: .systemFont(ofSize: 17))
                .padding(.horizontal, isPortrait ? 24 : 0)
                .multilineTextAlignment(isPortrait ? .center : .leading)

            VStack(spacing: 12) {
                if isPortrait {
                    TransmitDivider()
                        .frame(width: 32 * 8) // 4 image size width 32 * 4, with spacing 32 for each
                }

                if isPortrait {
                    HStack(spacing: 32) {
                        iconImage(named: "spotify")
                        iconImage(named: "podcast")
                        iconImage(named: "overcast")
                        iconImage(named: "rss")
                    }
                } else {
                    VStack(alignment: .leading, spacing: 32) {
                        info

                        VStack(alignment: .leading, spacing: 32) {
                            HStack {
                                Image(uiImage: UIImage(named: "listen")!)
                                Text("Listen")
                                    .fontWeight(.medium)
                                    .font(.system(size: 15))
                            }

                            iconImageLandscape(named: "spotify", title: "Spotify")
                            iconImageLandscape(named: "podcast", title: "Apple Podcast")
                            iconImageLandscape(named: "overcast", title: "Overcast")
                            iconImageLandscape(named: "rss", title: "RSS Feed")
                        }
                    }
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
                .lineLimit(0)
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

            if isPortrait {
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
                            .foregroundColor("0F172A".color)
                    }
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

    @ViewBuilder
    private func iconImageLandscape(named: String, title: String) -> some View {
        HStack {
            iconImage(named: named)
            Text(title)
                .fontWeight(.medium)
                .foregroundColor(Styles.textLabel)
                .font(.system(size: 15))
        }
    }

}

struct TransmitDivider: View {
    var body: some View {
        Divider()
            .overlay("94a3b8".color)
            .opacity(0.3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.landscapeLeft)
                .environmentObject(OrientationInfo())

            ContentView()
                .environmentObject(OrientationInfo())
        }
    }
}
