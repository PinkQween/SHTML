use crate::server;
use std::io;

pub fn run(port: u16) -> io::Result<()> {
    server::start_server(port)
}
