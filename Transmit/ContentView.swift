//
//  ContentView.swift
//  Transmit
//
//  Created by Khoa Le on 26/09/2023.
//

import SwiftUI

struct ContentView: View {
    private let data: [Episode] = Episode.mockData
    @State private var isPlaying: Bool = false
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
                }
            }
            .background("F8FAFC".color)
            .padding(.bottom, shouldShowMinimizeView ? 80 : 0)

            if shouldShowMinimizeView {
                VStack {
                    Spacer()
                    ZStack {
                        BlurView(style: .extraLight)
                            .frame(maxWidth: .infinity, maxHeight: 150)
                        VStack {
                            Text("5: Bill Lumbergh")
                                .bold()
                                .font(.system(size: 15))
                            Button(action: { isPlaying.toggle() }) {
                                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 17, height: 17)
                                    .padding(12)
                                    .background("334155".color)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .animation(.bouncy, value: isPlaying)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 120)
                }
                .ignoresSafeArea()
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
                .font(.system(size: 16))
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
                .font(.system(size: 16))
                .foregroundColor("334155".color)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
