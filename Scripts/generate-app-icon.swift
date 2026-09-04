import AppKit
import Foundation

guard CommandLine.arguments.count == 2 else {
    fputs("usage: generate-app-icon.swift <output.icns>\n", stderr)
    exit(2)
}

let outputURL = URL(fileURLWithPath: CommandLine.arguments[1])
let iconsetURL = outputURL.deletingPathExtension().appendingPathExtension("iconset")
let fileManager = FileManager.default
try? fileManager.removeItem(at: iconsetURL)
try fileManager.createDirectory(at: iconsetURL, withIntermediateDirectories: true)
defer { try? fileManager.removeItem(at: iconsetURL) }

let logicalSizes = [16, 32, 128, 256, 512]

func makeIcon(pixelSize: Int) throws -> Data {
    let size = CGFloat(pixelSize)
    guard let bitmap = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: pixelSize,
        pixelsHigh: pixelSize,
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bitmapFormat: [],
        bytesPerRow: 0,
        bitsPerPixel: 0
    ), let context = NSGraphicsContext(bitmapImageRep: bitmap) else {
        throw NSError(domain: "DisplayHarborIcon", code: 1)
    }
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = context
    defer { NSGraphicsContext.restoreGraphicsState() }

    let bounds = NSRect(x: 0, y: 0, width: size, height: size)
    let radius = size * 0.22
    let card = NSBezierPath(roundedRect: bounds.insetBy(dx: size * 0.04, dy: size * 0.04), xRadius: radius, yRadius: radius)
    NSGradient(colors: [NSColor(calibratedRed: 0.10, green: 0.48, blue: 0.96, alpha: 1), NSColor(calibratedRed: 0.34, green: 0.26, blue: 0.88, alpha: 1)])?.draw(in: card, angle: -35)

    NSColor.white.withAlphaComponent(0.18).setFill()
    NSBezierPath(roundedRect: bounds.insetBy(dx: size * 0.08, dy: size * 0.08), xRadius: radius * 0.82, yRadius: radius * 0.82).fill()

    let gap = size * 0.07
    let inset = size * 0.24
    let tileWidth = (size - inset * 2 - gap) * 0.58
    let tileHeight = (size - inset * 2 - gap) * 0.42
    let tileRadius = size * 0.075
    let tiles = [
        NSRect(x: inset, y: inset + tileHeight + gap, width: tileWidth, height: tileHeight),
        NSRect(x: inset + tileWidth + gap, y: inset + tileHeight + gap, width: tileWidth, height: tileHeight),
        NSRect(x: inset, y: inset, width: tileWidth, height: tileHeight),
        NSRect(x: inset + tileWidth + gap, y: inset, width: tileWidth, height: tileHeight)
    ]

    NSColor.white.setFill()
    for tile in tiles {
        NSBezierPath(roundedRect: tile, xRadius: tileRadius, yRadius: tileRadius).fill()
    }

    guard let png = bitmap.representation(using: .png, properties: [:]) else {
        throw NSError(domain: "DisplayHarborIcon", code: 1)
    }
    return png
}

for logicalSize in logicalSizes {
    let oneX = try makeIcon(pixelSize: logicalSize)
    let twoX = try makeIcon(pixelSize: logicalSize * 2)
    try oneX.write(to: iconsetURL.appendingPathComponent("icon_\(logicalSize)x\(logicalSize).png"))
    try twoX.write(to: iconsetURL.appendingPathComponent("icon_\(logicalSize)x\(logicalSize)@2x.png"))
}

let process = Process()
process.executableURL = URL(fileURLWithPath: "/usr/bin/iconutil")
process.arguments = ["--convert", "icns", "--output", outputURL.path, iconsetURL.path]
try process.run()
process.waitUntilExit()
guard process.terminationStatus == 0 else {
    throw NSError(domain: "DisplayHarborIcon", code: Int(process.terminationStatus))
}
