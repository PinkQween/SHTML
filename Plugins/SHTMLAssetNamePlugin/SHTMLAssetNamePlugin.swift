import Foundation
import PackagePlugin

@main
struct SHTMLAssetNamePlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        guard target is SourceModuleTarget else { return [] }

        let tool = try context.tool(named: "shtml-asset-name-gen")
        let imagesDir = context.package.directoryURL.appendingPathComponent("Assets/Images")
        let videosDir = context.package.directoryURL.appendingPathComponent("Assets/Videos")
        let audioDir = context.package.directoryURL.appendingPathComponent("Assets/Audio")
        let fontsDir = context.package.directoryURL.appendingPathComponent("Assets/Fonts")
        let outputDir = context.pluginWorkDirectoryURL
        let imageOutput = outputDir.appendingPathComponent("ImageName+Generated.swift")
        let videoOutput = outputDir.appendingPathComponent("VideoName+Generated.swift")
        let audioOutput = outputDir.appendingPathComponent("AudioName+Generated.swift")
        let fontOutput = outputDir.appendingPathComponent("FontName+Generated.swift")

        let inputFiles = assetFiles(in: imagesDir) + assetFiles(in: videosDir) + assetFiles(in: audioDir) + assetFiles(in: fontsDir)

        return [
            .buildCommand(
                displayName: "SHTML: Generating typed ImageName/FontName symbols",
                executable: tool.url,
                arguments: [imagesDir.path, videosDir.path, audioDir.path, fontsDir.path, outputDir.path],
                inputFiles: inputFiles,
                outputFiles: [imageOutput, videoOutput, audioOutput, fontOutput]
            )
        ]
    }

    private func assetFiles(in directory: URL) -> [URL] {
        guard FileManager.default.fileExists(atPath: directory.path) else { return [] }
        guard let entries = try? FileManager.default.contentsOfDirectory(atPath: directory.path) else { return [] }
        return entries.map { directory.appendingPathComponent($0) }
    }
}
