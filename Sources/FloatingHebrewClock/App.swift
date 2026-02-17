import AppKit
import SwiftUI

@main
struct FloatingHebrewClockApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var panel: NSPanel?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)

        let initialSize = NSSize(width: 420, height: 150)

        let hosting = NSHostingView(
            rootView: ClockView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
        hosting.wantsLayer = true
        hosting.layer?.backgroundColor = NSColor.clear.cgColor

        let panel = NSPanel(
            contentRect: NSRect(origin: .zero, size: initialSize),
            styleMask: [.titled, .nonactivatingPanel, .fullSizeContentView, .resizable],
            backing: .buffered,
            defer: false
        )

        panel.center()
        panel.isFloatingPanel = true
        panel.level = .floating
        panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary, .ignoresCycle]
        panel.titleVisibility = .hidden
        panel.titlebarAppearsTransparent = true
        panel.standardWindowButton(.closeButton)?.isHidden = true
        panel.standardWindowButton(.miniaturizeButton)?.isHidden = true
        panel.standardWindowButton(.zoomButton)?.isHidden = true
        panel.hasShadow = false
        panel.isOpaque = false
        panel.backgroundColor = .clear
        panel.ignoresMouseEvents = false
        panel.hidesOnDeactivate = false
        panel.isMovable = true
        panel.isMovableByWindowBackground = true
        panel.minSize = NSSize(width: 280, height: 120)
        panel.contentView = hosting
        panel.makeKeyAndOrderFront(nil)

        self.panel = panel
    }
}

struct ClockView: View {
    @State private var now = Date()

    private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(.ultraThinMaterial.opacity(0.22))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )

            VStack(spacing: 8) {
                Text(HebrewTimeFormatter.digital(from: now))
                    .font(.system(size: 16, weight: .medium, design: .monospaced))
                    .foregroundStyle(.white.opacity(0.72))

                Text(HebrewTimeFormatter.words(from: now))
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.94))
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.55)
                    .shadow(color: .black.opacity(0.35), radius: 3, x: 0, y: 1)
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
        }
        .padding(10)
        .background(Color.clear)
        .drawingGroup()
        .onReceive(timer) { date in
            now = date
        }
    }
}
