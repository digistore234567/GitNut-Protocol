use clap::{Parser, Subcommand};
use sha2::{Digest, Sha256};
use std::fs::File;
use std::io::{Read};
use std::path::PathBuf;

#[derive(Parser, Debug)]
#[command(name = "gitnut-rust-cli")]
#[command(about = "A minimal Rust CLI example for GitNut", long_about = None)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand, Debug)]
enum Commands {
    /// Compute SHA-256 of a file
    Hash {
        /// Path to file
        #[arg(long)]
        path: PathBuf,
    },
}

fn sha256_file(path: &PathBuf) -> anyhow::Result<String> {
    let mut f = File::open(path)?;
    let mut hasher = Sha256::new();
    let mut buf = [0u8; 1024 * 32];
    loop {
        let n = f.read(&mut buf)?;
        if n == 0 {
            break;
        }
        hasher.update(&buf[..n]);
    }
    Ok(hex::encode(hasher.finalize()))
}

fn main() -> anyhow::Result<()> {
    let cli = Cli::parse();

    match cli.command {
        Commands::Hash { path } => {
            let h = sha256_file(&path)?;
            println!("{}", h);
        }
    }

    Ok(())
}
