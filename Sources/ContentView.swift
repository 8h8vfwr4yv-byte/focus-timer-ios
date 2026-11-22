import SwiftUI

// 专注番茄钟：25 分钟专注 / 5 分钟休息，圆环进度，完成次数会存下来。
struct ContentView: View {
    @State private var totalSeconds = 25 * 60
    @State private var remaining = 25 * 60
    @State private var isRunning = false
    @State private var isBreak = false
    @AppStorage("focusDoneCount") private var doneCount = 0
    @State private var timer: Timer? = nil

    var body: some View {
        ZStack {
            (isBreak ? Color.green.opacity(0.15) : Color.orange.opacity(0.15))
                .ignoresSafeArea()
            VStack(spacing: 28) {
                Text(isBreak ? "休息一下" : "专注时间")
                    .font(.title2).bold()
                    .foregroundStyle(isBreak ? .green : .orange)

                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 14)
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(isBreak ? Color.green : Color.orange,
                                style: StrokeStyle(lineWidth: 14, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .animation(.linear(duration: 0.3), value: remaining)
                    Text(timeText)
                        .font(.system(size: 56, weight: .bold, design: .monospaced))
                }
                .frame(width: 240, height: 240)

                HStack(spacing: 16) {
                    Button(isRunning ? "暂停" : (remaining < totalSeconds ? "继续" : "开始")) {
                        toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(isBreak ? .green : .orange)

                    Button("重置") { reset() }
                        .buttonStyle(.bordered)
                }
                .font(.title3)

                HStack(spacing: 12) {
                    Button("专注 25 分钟") { setMode(minutes: 25, breakMode: false) }
                    Button("休息 5 分钟") { setMode(minutes: 5, breakMode: true) }
                }
                .buttonStyle(.bordered)
                .font(.subheadline)

                Text("已完成 \(doneCount) 个番茄")
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
    }

    private var progress: Double {
        totalSeconds == 0 ? 0 : Double(totalSeconds - remaining) / Double(totalSeconds)
    }

    private var timeText: String {
        String(format: "%02d:%02d", remaining / 60, remaining % 60)
    }

    private func toggle() {
        if isRunning {
            timer?.invalidate()
            timer = nil
            isRunning = false
        } else {
            isRunning = true
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if remaining > 0 {
                    remaining -= 1
                } else {
                    finish()
                }
            }
        }
    }

    private func finish() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        if !isBreak { doneCount += 1 }
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        // 自动切到另一种模式，停在起点等用户开始
        if isBreak {
            setMode(minutes: 25, breakMode: false)
        } else {
            setMode(minutes: 5, breakMode: true)
        }
    }

    private func reset() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        remaining = totalSeconds
    }

    private func setMode(minutes: Int, breakMode: Bool) {
        timer?.invalidate()
        timer = nil
        isRunning = false
        isBreak = breakMode
        totalSeconds = minutes * 60
        remaining = totalSeconds
    }
}
