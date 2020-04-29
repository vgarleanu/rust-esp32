#[derive(Clone, Copy, Eq, PartialEq)]
pub struct ExitStatus(());

impl ExitStatus {
    pub fn success(&self) -> bool {
        true
    }

    pub fn code(&self) -> Option<i32> {
        None
    }
}

#[derive(PartialEq, Eq, Clone, Copy, Debug)]
pub struct ExitCode(bool);

impl ExitCode {
    pub const SUCCESS: ExitCode = ExitCode(false);
    pub const FAILURE: ExitCode = ExitCode(true);

    pub fn as_i32(&self) -> i32 {
        self.0 as i32
    }
}
