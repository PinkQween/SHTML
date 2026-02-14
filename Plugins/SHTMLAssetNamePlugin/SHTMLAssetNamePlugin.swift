import Foundation
import PackagePlugin

@main
struct SHTMLAssetNamePlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        guard target is SourceModuleTarget else { return [] }

        let tool = try context.tool(named: "shtml-asset-name-gen")
        let imagesDir = context.package.directory.appending("Assets/Images")
        let fontsDir = context.package.directory.appending("Assets/Fonts")
        let outputDir = context.pluginWorkDirectory
        let imageOutput = outputDir.appending("ImageName+Generated.swift")
        let fontOutput = outputDir.appending("FontName+Generated.swift")

        let inputFiles = assetFiles(in: imagesDir) + assetFiles(in: fontsDir)

        return [
            .buildCommand(
                displayName: "SHTML: Generating typed ImageName/FontName symbols",
                executable: tool.path,
                arguments: [imagesDir.string, fontsDir.string, outputDir.string],
                inputFiles: inputFiles,
                outputFiles: [imageOutput, fontOutput]
            )
        ]
    }

    private func assetFiles(in directory: Path) -> [Path] {
        guard FileManager.default.fileExists(atPath: directory.string) else { return [] }
        guard let entries = try? FileManager.default.contentsOfDirectory(atPath: directory.string) else { return [] }
        return entries.map { directory.appending($0) }
    }
}
