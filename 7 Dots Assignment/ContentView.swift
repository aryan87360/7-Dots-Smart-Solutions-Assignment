import SwiftUI

struct ContentView: View {
    @State private var timeRemaining = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var maxTime = 60

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(.gray)

                Circle()
                    .trim(from: 0.0, to: CGFloat(timeRemaining) / CGFloat(maxTime))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.blue)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear)

                Text("\(timeRemaining)s")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding()

            HStack {
                Button(action: {
                    withAnimation {
                        self.timeRemaining += 10
                        self.maxTime = self.timeRemaining
                    }
                }) {
                    Text("+10 sec")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }

                Button(action: {
                    withAnimation {
                        self.timeRemaining = 0
                    }
                }) {
                    Text("Skip")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
        }
        .onReceive(timer) { _ in
            if self.timeRemaining > 0 {
                withAnimation {
                    self.timeRemaining -= 1
                }
            }
        }
    }
}
