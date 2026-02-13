use std::{
    env,
    fs,
    io::{self, Write},
    path::{Path, PathBuf},
};

pub fn run(name: Option<String>) -> io::Result<()> {
    // Get project name (arg or prompt)
    let project_name = match name {
        Some(s) => s.trim().to_string(),
        None => {
            print!("Project name: ");
            io::stdout().flush()?; // ensure prompt shows before input

            let mut input = String::new();
            io::stdin().read_line(&mut input)?;
            input.trim().to_string()
        }
    };

    // Validate project name
    if project_name.is_empty() {
        return Err(io::Error::new(
            io::ErrorKind::InvalidInput,
            "Project name cannot be empty",
        ));
    }

    // Allow "." as "current dir", but disallow other weird path-like names
    if project_name != "." {
        if project_name == ".."
            || project_name.contains(std::path::MAIN_SEPARATOR)
            || project_name.contains('/')
            || project_name.contains('\\')
        {
            return Err(io::Error::new(
                io::ErrorKind::InvalidInput,
                "Project name must be a single directory name (no path separators, no '..')",
            ));
        }
    }

    // Decide target directory
    let project_dir: PathBuf = if project_name == "." {
        PathBuf::from(".")
    } else {
        PathBuf::from(&project_name)
    };

    // If creating a new folder, it must not already exist
    if project_name != "." && project_dir.exists() {
        return Err(io::Error::new(
            io::ErrorKind::AlreadyExists,
            format!("Directory '{}' already exists", project_name),
        ));
    }

    // If using current dir, try to avoid overwriting an existing project
    if project_name == "." {
        let pkg = project_dir.join("Package.swift");
        if pkg.exists() {
            return Err(io::Error::new(
                io::ErrorKind::AlreadyExists,
                "Package.swift already exists in the current directory",
            ));
        }
    }

    // Swift module/target folder name: use the directory name when project_name == "."
    let swift_target_name = if project_name == "." {
        // Try to get the current working directory's last path component
        let cwd = env::current_dir();
        let name_from_cwd = cwd
            .as_ref()
            .ok()
            .and_then(|p| p.file_name())
            .and_then(|s| s.to_str())
            .map(|s| s.trim())
            .filter(|s| !s.is_empty())
            .map(|s| s.to_string());

        // If that failed (e.g., weird path), try canonicalizing project_dir and get its last component
        let name = name_from_cwd.or_else(|| {
            project_dir
                .canonicalize()
                .ok()
                .and_then(|p| p.file_name().map(|os| os.to_owned()))
                .and_then(|os| os.to_str().map(|s| s.trim().to_string()))
                .filter(|s| !s.is_empty())
        });

        match name {
            Some(n) => n,
            None => {
                return Err(io::Error::new(
                    io::ErrorKind::InvalidInput,
                    "Could not determine a name from the current directory. Please pass a project name explicitly (e.g., `shtml init MySite`).",
                ));
            }
        }
    } else {
        project_name.clone()
    };

    // Create directories
    let sources_dir = project_dir.join("Sources").join(&swift_target_name);
    fs::create_dir_all(&sources_dir)?;
    fs::create_dir_all(project_dir.join("public"))?;

    // Write Package.swift
    let package_swift = format!(
        r#"// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "{name}",
    platforms: [.macOS(.v13)],
    products: [
        .executable(name: "{target}", targets: ["{target}"])
    ],
    dependencies: [
        .package(url: "https://github.com/pinkqween/SHTML.git", branch: "main")
    ],
    targets: [
        .executableTarget(name: "{target}", dependencies: ["SHTML"])
    ]
)
"#,
        name = swift_target_name,
        target = swift_target_name,
    );
    fs::write(project_dir.join("Package.swift"), package_swift)?;

    // Write main.swift
    let main_swift = r#"import SHTML

struct MyWebsite: Website {
    var body: some HTML {
        html {
            head {
                meta().charset("UTF-8")
                title("SHTML Site")
            }
            SHTML.body {
                h1 { "Hello SHTML!" }
            }
        }
    }
}

let site = MyWebsite()
site.generate()
"#;
    fs::write(sources_dir.join("main.swift"), main_swift)?;

    // Write .gitignore
    let gitignore = ".DS_Store\n/.build\n/Packages\npublic/index.html\n";
    fs::write(project_dir.join(".gitignore"), gitignore)?;

    if project_name == "." {
        println!("\n✅ Created in current directory");
        println!("\nNext:\n  shtml dev");
    } else {
        println!("\n✅ Created {}", project_name);
        println!("\nNext:\n  cd {}\n  shtml dev", project_name);
    }

    Ok(())
}

