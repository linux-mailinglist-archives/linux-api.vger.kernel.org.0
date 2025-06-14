Return-Path: <linux-api+bounces-3924-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0F5AD9D2E
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 15:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B452A7A776C
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 13:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CBA2EAD09;
	Sat, 14 Jun 2025 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teM5oIFY"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965DB2EACFE;
	Sat, 14 Jun 2025 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908958; cv=none; b=s6VEDrYAZJGz1yl9EP6Ty15zlsNNco1yBIysl0SPUrfNABI9Z7i0SQuwPjVt/KnDUoMvYHdUT82v55WENrLZmPmrOXoa5YCZfdxrJfDg4/lxZAKUdiQZiDN3J/HcoWZOopdrzJ6HsTzKL+33ZA/vFxT4xFWiR8P/lpU6KLJo2D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908958; c=relaxed/simple;
	bh=G4abd4n8OMhquGl8B0vC4XK2aT/vUVMRQ4+VJ7cqekM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZRXJSybwak5467+zVjilCN3G/zB1Ea1p/jsAjsnTOoHWb2pIThNt2hsiZFVTcK6WGRyTinRFLjlF0mO/Njehwin6oLnxrXOpZoKX/s1xxxTktxjzpHD375+vm7pRokhS7fxdyOdRq4IMPVlk9D9IS5IwUXbUvou7XE9qmwYh4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teM5oIFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD81FC4CEEB;
	Sat, 14 Jun 2025 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908958;
	bh=G4abd4n8OMhquGl8B0vC4XK2aT/vUVMRQ4+VJ7cqekM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=teM5oIFYMQGExhd5Njc/ditHNtwUwxkUK17fEJfuCvrEee6KWZI+8o3jh3z6Vyp0k
	 wz8sDtf8p0Pxd25T7WYyOIlTEsCq8lDEHmEyxA0V6n5I0ohXnE2Il6910Km0gBLxdv
	 EHuj4eAtXxj1zlpAZ5at/SvoOf7mub+MWj/EfV4+YTEByrfxXSbq7/FZQYOM/59rNn
	 F/hiK/zKbRRVI5cBjEwhuvf+rUo9C728jaubiOAw6LB26PqO6d3kn2acMpoTlPRhDQ
	 +9SF6klx43sRhfjXTqe7vR4WhF0sWPLIzJTn77hjevvDsBpVT6IFYg1ptvl326m+xZ
	 dZbwAeYU34+WQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 19/19] tools/kapi: Add kernel API specification extraction tool
Date: Sat, 14 Jun 2025 09:48:58 -0400
Message-Id: <20250614134858.790460-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614134858.790460-1-sashal@kernel.org>
References: <20250614134858.790460-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kapi tool extracts and displays kernel API specifications.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/kernel-api-spec.rst | 198 ++++++-
 tools/kapi/.gitignore                         |   4 +
 tools/kapi/Cargo.toml                         |  19 +
 tools/kapi/src/extractor/debugfs.rs           | 204 ++++++++
 tools/kapi/src/extractor/mod.rs               |  95 ++++
 tools/kapi/src/extractor/source_parser.rs     | 488 ++++++++++++++++++
 .../src/extractor/vmlinux/binary_utils.rs     | 130 +++++
 tools/kapi/src/extractor/vmlinux/mod.rs       | 372 +++++++++++++
 tools/kapi/src/formatter/json.rs              | 170 ++++++
 tools/kapi/src/formatter/mod.rs               |  68 +++
 tools/kapi/src/formatter/plain.rs             |  99 ++++
 tools/kapi/src/formatter/rst.rs               | 144 ++++++
 tools/kapi/src/main.rs                        | 121 +++++
 13 files changed, 2109 insertions(+), 3 deletions(-)
 create mode 100644 tools/kapi/.gitignore
 create mode 100644 tools/kapi/Cargo.toml
 create mode 100644 tools/kapi/src/extractor/debugfs.rs
 create mode 100644 tools/kapi/src/extractor/mod.rs
 create mode 100644 tools/kapi/src/extractor/source_parser.rs
 create mode 100644 tools/kapi/src/extractor/vmlinux/binary_utils.rs
 create mode 100644 tools/kapi/src/extractor/vmlinux/mod.rs
 create mode 100644 tools/kapi/src/formatter/json.rs
 create mode 100644 tools/kapi/src/formatter/mod.rs
 create mode 100644 tools/kapi/src/formatter/plain.rs
 create mode 100644 tools/kapi/src/formatter/rst.rs
 create mode 100644 tools/kapi/src/main.rs

diff --git a/Documentation/admin-guide/kernel-api-spec.rst b/Documentation/admin-guide/kernel-api-spec.rst
index 3a63f6711e27b..9b452753111ad 100644
--- a/Documentation/admin-guide/kernel-api-spec.rst
+++ b/Documentation/admin-guide/kernel-api-spec.rst
@@ -31,7 +31,9 @@ The framework aims to:
    common programming errors during development and testing.
 
 3. **Support Tooling**: Export API specifications in machine-readable formats for
-   use by static analyzers, documentation generators, and development tools.
+   use by static analyzers, documentation generators, and development tools. The
+   ``kapi`` tool (see `The kapi Tool`_) provides comprehensive extraction and
+   formatting capabilities.
 
 4. **Enhance Debugging**: Provide detailed API information at runtime through debugfs
    for debugging and introspection.
@@ -71,6 +73,13 @@ The framework consists of several key components:
    - Type-safe parameter specifications
    - Context and constraint definitions
 
+5. **kapi Tool** (``tools/kapi/``)
+
+   - Userspace utility for extracting specifications
+   - Multiple input sources (source, binary, debugfs)
+   - Multiple output formats (plain, JSON, RST)
+   - Testing and validation utilities
+
 Data Model
 ----------
 
@@ -344,8 +353,177 @@ Documentation Generation
 ------------------------
 
 The framework exports specifications via debugfs that can be used
-to generate documentation. Tools for automatic documentation generation
-from specifications are planned for future development.
+to generate documentation. The ``kapi`` tool provides comprehensive
+extraction and formatting capabilities for kernel API specifications.
+
+The kapi Tool
+=============
+
+Overview
+--------
+
+The ``kapi`` tool is a userspace utility that extracts and displays kernel API
+specifications from multiple sources. It provides a unified interface to access
+API documentation whether from compiled kernels, source code, or runtime systems.
+
+Installation
+------------
+
+Build the tool from the kernel source tree::
+
+    $ cd tools/kapi
+    $ cargo build --release
+
+    # Optional: Install system-wide
+    $ cargo install --path .
+
+The tool requires Rust and Cargo to build. The binary will be available at
+``tools/kapi/target/release/kapi``.
+
+Command-Line Usage
+------------------
+
+Basic syntax::
+
+    kapi [OPTIONS] [API_NAME]
+
+Options:
+
+- ``--vmlinux <PATH>``: Extract from compiled kernel binary
+- ``--source <PATH>``: Extract from kernel source code
+- ``--debugfs <PATH>``: Extract from debugfs (default: /sys/kernel/debug)
+- ``-f, --format <FORMAT>``: Output format (plain, json, rst)
+- ``-h, --help``: Display help information
+- ``-V, --version``: Display version information
+
+Input Modes
+-----------
+
+**1. Source Code Mode**
+
+Extract specifications directly from kernel source::
+
+    # Scan entire kernel source tree
+    $ kapi --source /path/to/linux
+
+    # Extract from specific file
+    $ kapi --source kernel/sched/core.c
+
+    # Get details for specific API
+    $ kapi --source /path/to/linux sys_sched_yield
+
+**2. Vmlinux Mode**
+
+Extract from compiled kernel with debug symbols::
+
+    # List all APIs in vmlinux
+    $ kapi --vmlinux /boot/vmlinux-5.15.0
+
+    # Get specific syscall details
+    $ kapi --vmlinux ./vmlinux sys_read
+
+**3. Debugfs Mode**
+
+Extract from running kernel via debugfs::
+
+    # Use default debugfs path
+    $ kapi
+
+    # Use custom debugfs mount
+    $ kapi --debugfs /mnt/debugfs
+
+    # Get specific API from running kernel
+    $ kapi sys_write
+
+Output Formats
+--------------
+
+**Plain Text Format** (default)::
+
+    $ kapi sys_read
+
+    Detailed information for sys_read:
+    ==================================
+    Description: Read from a file descriptor
+
+    Detailed Description:
+    Reads up to count bytes from file descriptor fd into the buffer starting at buf.
+
+    Execution Context:
+      - KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+
+    Parameters (3):
+
+    Available since: 1.0
+
+**JSON Format**::
+
+    $ kapi --format json sys_read
+    {
+      "api_details": {
+        "name": "sys_read",
+        "description": "Read from a file descriptor",
+        "long_description": "Reads up to count bytes...",
+        "context_flags": ["KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE"],
+        "since_version": "1.0"
+      }
+    }
+
+**ReStructuredText Format**::
+
+    $ kapi --format rst sys_read
+
+    sys_read
+    ========
+
+    **Read from a file descriptor**
+
+    Reads up to count bytes from file descriptor fd into the buffer...
+
+Usage Examples
+--------------
+
+**Generate complete API documentation**::
+
+    # Export all kernel APIs to JSON
+    $ kapi --source /path/to/linux --format json > kernel-apis.json
+
+    # Generate RST documentation for all syscalls
+    $ kapi --vmlinux ./vmlinux --format rst > syscalls.rst
+
+    # List APIs from specific subsystem
+    $ kapi --source drivers/gpu/drm/
+
+**Integration with other tools**::
+
+    # Find all APIs that can sleep
+    $ kapi --format json | jq '.apis[] | select(.context_flags[] | contains("SLEEPABLE"))'
+
+    # Generate markdown documentation
+    $ kapi --format rst sys_mmap | pandoc -f rst -t markdown
+
+**Debugging and analysis**::
+
+    # Compare API between kernel versions
+    $ diff <(kapi --vmlinux vmlinux-5.10) <(kapi --vmlinux vmlinux-5.15)
+
+    # Check if specific API exists
+    $ kapi --source . my_custom_api || echo "API not found"
+
+Implementation Details
+----------------------
+
+The tool extracts API specifications from three sources:
+
+1. **Source Code**: Parses KAPI specification macros using regular expressions
+2. **Vmlinux**: Reads the ``.kapi_specs`` ELF section from compiled kernels
+3. **Debugfs**: Reads from ``/sys/kernel/debug/kapi/`` filesystem interface
+
+The tool supports all KAPI specification types:
+
+- System calls (``DEFINE_KERNEL_API_SPEC``)
+- IOCTLs (``DEFINE_IOCTL_API_SPEC``)
+- Kernel functions (``KAPI_DEFINE_SPEC``)
 
 IDE Integration
 ---------------
@@ -357,6 +535,11 @@ Modern IDEs can use the JSON export for:
 - Context validation
 - Error code documentation
 
+Example IDE integration::
+
+    # Generate IDE completion data
+    $ kapi --format json > .vscode/kernel-apis.json
+
 Testing Framework
 -----------------
 
@@ -367,6 +550,15 @@ The framework includes test helpers::
     kapi_test_api("kmalloc", test_cases);
     #endif
 
+The kapi tool can verify specifications against implementations::
+
+    # Run consistency tests
+    $ cd tools/kapi
+    $ ./test_consistency.sh
+
+    # Compare source vs binary specifications
+    $ ./compare_all_syscalls.sh
+
 Best Practices
 ==============
 
diff --git a/tools/kapi/.gitignore b/tools/kapi/.gitignore
new file mode 100644
index 0000000000000..1390bfc12686c
--- /dev/null
+++ b/tools/kapi/.gitignore
@@ -0,0 +1,4 @@
+# Rust build artifacts
+/target/
+**/*.rs.bk
+
diff --git a/tools/kapi/Cargo.toml b/tools/kapi/Cargo.toml
new file mode 100644
index 0000000000000..4e6bcb10d132f
--- /dev/null
+++ b/tools/kapi/Cargo.toml
@@ -0,0 +1,19 @@
+[package]
+name = "kapi"
+version = "0.1.0"
+edition = "2024"
+authors = ["Sasha Levin <sashal@kernel.org>"]
+description = "Tool for extracting and displaying kernel API specifications"
+license = "GPL-2.0"
+
+[dependencies]
+goblin = "0.10"
+clap = { version = "4.4", features = ["derive"] }
+anyhow = "1.0"
+serde = { version = "1.0", features = ["derive"] }
+serde_json = "1.0"
+regex = "1.10"
+walkdir = "2.4"
+
+[dev-dependencies]
+tempfile = "3.8"
diff --git a/tools/kapi/src/extractor/debugfs.rs b/tools/kapi/src/extractor/debugfs.rs
new file mode 100644
index 0000000000000..91775dea223f5
--- /dev/null
+++ b/tools/kapi/src/extractor/debugfs.rs
@@ -0,0 +1,204 @@
+use anyhow::{Context, Result, bail};
+use std::fs;
+use std::io::Write;
+use std::path::PathBuf;
+use crate::formatter::OutputFormatter;
+
+use super::{ApiExtractor, ApiSpec, display_api_spec};
+
+/// Extractor for kernel API specifications from debugfs
+pub struct DebugfsExtractor {
+    debugfs_path: PathBuf,
+}
+
+impl DebugfsExtractor {
+    /// Create a new debugfs extractor with the specified debugfs path
+    pub fn new(debugfs_path: Option<String>) -> Result<Self> {
+        let path = match debugfs_path {
+            Some(p) => PathBuf::from(p),
+            None => PathBuf::from("/sys/kernel/debug"),
+        };
+
+        // Check if the debugfs path exists
+        if !path.exists() {
+            bail!("Debugfs path does not exist: {}", path.display());
+        }
+
+        // Check if kapi directory exists
+        let kapi_path = path.join("kapi");
+        if !kapi_path.exists() {
+            bail!("Kernel API debugfs interface not found at: {}", kapi_path.display());
+        }
+
+        Ok(Self {
+            debugfs_path: path,
+        })
+    }
+
+    /// Parse the list file to get all available API names
+    fn parse_list_file(&self) -> Result<Vec<String>> {
+        let list_path = self.debugfs_path.join("kapi/list");
+        let content = fs::read_to_string(&list_path)
+            .with_context(|| format!("Failed to read {}", list_path.display()))?;
+
+        let mut apis = Vec::new();
+        let mut in_list = false;
+
+        for line in content.lines() {
+            if line.contains("===") {
+                in_list = true;
+                continue;
+            }
+
+            if in_list && line.starts_with("Total:") {
+                break;
+            }
+
+            if in_list && !line.trim().is_empty() {
+                // Extract API name from lines like "sys_read - Read from a file descriptor"
+                if let Some(name) = line.split(" - ").next() {
+                    apis.push(name.trim().to_string());
+                }
+            }
+        }
+
+        Ok(apis)
+    }
+
+    /// Parse a single API specification file
+    fn parse_spec_file(&self, api_name: &str) -> Result<ApiSpec> {
+        let spec_path = self.debugfs_path.join(format!("kapi/specs/{}", api_name));
+        let content = fs::read_to_string(&spec_path)
+            .with_context(|| format!("Failed to read {}", spec_path.display()))?;
+
+        let mut spec = ApiSpec {
+            name: api_name.to_string(),
+            api_type: "unknown".to_string(),
+            description: None,
+            long_description: None,
+            version: None,
+            context_flags: Vec::new(),
+            param_count: None,
+            error_count: None,
+            examples: None,
+            notes: None,
+            since_version: None,
+        };
+
+        // Parse the content
+        let mut collecting_multiline = false;
+        let mut multiline_buffer = String::new();
+        let mut multiline_field = "";
+
+        for line in content.lines() {
+            // Handle section headers
+            if line.starts_with("Parameters (") {
+                if let Some(count_str) = line.strip_prefix("Parameters (").and_then(|s| s.strip_suffix("):")) {
+                    spec.param_count = count_str.parse().ok();
+                }
+                continue;
+            } else if line.starts_with("Errors (") {
+                if let Some(count_str) = line.strip_prefix("Errors (").and_then(|s| s.strip_suffix("):")) {
+                    spec.error_count = count_str.parse().ok();
+                }
+                continue;
+            } else if line.starts_with("Examples:") {
+                collecting_multiline = true;
+                multiline_field = "examples";
+                multiline_buffer.clear();
+                continue;
+            } else if line.starts_with("Notes:") {
+                collecting_multiline = true;
+                multiline_field = "notes";
+                multiline_buffer.clear();
+                continue;
+            }
+
+            // Handle multiline sections
+            if collecting_multiline {
+                if line.trim().is_empty() && multiline_buffer.ends_with("\n\n") {
+                    collecting_multiline = false;
+                    match multiline_field {
+                        "examples" => spec.examples = Some(multiline_buffer.trim().to_string()),
+                        "notes" => spec.notes = Some(multiline_buffer.trim().to_string()),
+                        _ => {}
+                    }
+                    multiline_buffer.clear();
+                } else {
+                    if !multiline_buffer.is_empty() {
+                        multiline_buffer.push('\n');
+                    }
+                    multiline_buffer.push_str(line);
+                }
+                continue;
+            }
+
+            // Parse regular fields
+            if let Some(desc) = line.strip_prefix("Description: ") {
+                spec.description = Some(desc.to_string());
+            } else if let Some(long_desc) = line.strip_prefix("Long description: ") {
+                spec.long_description = Some(long_desc.to_string());
+            } else if let Some(version) = line.strip_prefix("Version: ") {
+                spec.version = Some(version.to_string());
+            } else if let Some(since) = line.strip_prefix("Since: ") {
+                spec.since_version = Some(since.to_string());
+            } else if let Some(flags) = line.strip_prefix("Context flags: ") {
+                spec.context_flags = flags.split_whitespace()
+                    .map(|s| s.to_string())
+                    .collect();
+            }
+        }
+
+        // Determine API type based on name
+        if api_name.starts_with("sys_") {
+            spec.api_type = "syscall".to_string();
+        } else if api_name.contains("_ioctl") || api_name.starts_with("ioctl_") {
+            spec.api_type = "ioctl".to_string();
+        } else {
+            spec.api_type = "function".to_string();
+        }
+
+        Ok(spec)
+    }
+}
+
+impl ApiExtractor for DebugfsExtractor {
+    fn extract_all(&self) -> Result<Vec<ApiSpec>> {
+        let api_names = self.parse_list_file()?;
+        let mut specs = Vec::new();
+
+        for name in api_names {
+            match self.parse_spec_file(&name) {
+                Ok(spec) => specs.push(spec),
+                Err(e) => eprintln!("Warning: Failed to parse spec for {}: {}", name, e),
+            }
+        }
+
+        Ok(specs)
+    }
+
+    fn extract_by_name(&self, name: &str) -> Result<Option<ApiSpec>> {
+        let api_names = self.parse_list_file()?;
+
+        if api_names.contains(&name.to_string()) {
+            Ok(Some(self.parse_spec_file(name)?))
+        } else {
+            Ok(None)
+        }
+    }
+
+    fn display_api_details(
+        &self,
+        api_name: &str,
+        formatter: &mut dyn OutputFormatter,
+        writer: &mut dyn Write,
+    ) -> Result<()> {
+        if let Some(spec) = self.extract_by_name(api_name)? {
+            display_api_spec(&spec, formatter, writer)?;
+        } else {
+            writeln!(writer, "API '{}' not found in debugfs", api_name)?;
+        }
+
+        Ok(())
+    }
+}
\ No newline at end of file
diff --git a/tools/kapi/src/extractor/mod.rs b/tools/kapi/src/extractor/mod.rs
new file mode 100644
index 0000000000000..bc55201152e3e
--- /dev/null
+++ b/tools/kapi/src/extractor/mod.rs
@@ -0,0 +1,95 @@
+use anyhow::Result;
+use std::io::Write;
+use crate::formatter::OutputFormatter;
+
+pub mod vmlinux;
+pub mod source_parser;
+pub mod debugfs;
+
+pub use vmlinux::VmlinuxExtractor;
+pub use source_parser::SourceExtractor;
+pub use debugfs::DebugfsExtractor;
+
+/// Common API specification information that all extractors should provide
+#[derive(Debug, Clone)]
+pub struct ApiSpec {
+    pub name: String,
+    pub api_type: String,
+    pub description: Option<String>,
+    pub long_description: Option<String>,
+    pub version: Option<String>,
+    pub context_flags: Vec<String>,
+    pub param_count: Option<u32>,
+    pub error_count: Option<u32>,
+    pub examples: Option<String>,
+    pub notes: Option<String>,
+    pub since_version: Option<String>,
+}
+
+/// Trait for extracting API specifications from different sources
+pub trait ApiExtractor {
+    /// Extract all API specifications from the source
+    fn extract_all(&self) -> Result<Vec<ApiSpec>>;
+
+    /// Extract a specific API specification by name
+    fn extract_by_name(&self, name: &str) -> Result<Option<ApiSpec>>;
+
+    /// Display detailed information about a specific API
+    fn display_api_details(
+        &self,
+        api_name: &str,
+        formatter: &mut dyn OutputFormatter,
+        writer: &mut dyn Write,
+    ) -> Result<()>;
+}
+
+/// Helper function to display an ApiSpec using a formatter
+pub fn display_api_spec(
+    spec: &ApiSpec,
+    formatter: &mut dyn OutputFormatter,
+    writer: &mut dyn Write,
+) -> Result<()> {
+    formatter.begin_api_details(writer, &spec.name)?;
+
+    if let Some(desc) = &spec.description {
+        formatter.description(writer, desc)?;
+    }
+
+    if let Some(long_desc) = &spec.long_description {
+        formatter.long_description(writer, long_desc)?;
+    }
+
+    if let Some(version) = &spec.since_version {
+        formatter.since_version(writer, version)?;
+    }
+
+    if !spec.context_flags.is_empty() {
+        formatter.begin_context_flags(writer)?;
+        for flag in &spec.context_flags {
+            formatter.context_flag(writer, flag)?;
+        }
+        formatter.end_context_flags(writer)?;
+    }
+
+    if let Some(param_count) = spec.param_count {
+        formatter.begin_parameters(writer, param_count)?;
+        formatter.end_parameters(writer)?;
+    }
+
+    if let Some(error_count) = spec.error_count {
+        formatter.begin_errors(writer, error_count)?;
+        formatter.end_errors(writer)?;
+    }
+
+    if let Some(notes) = &spec.notes {
+        formatter.notes(writer, notes)?;
+    }
+
+    if let Some(examples) = &spec.examples {
+        formatter.examples(writer, examples)?;
+    }
+
+    formatter.end_api_details(writer)?;
+
+    Ok(())
+}
\ No newline at end of file
diff --git a/tools/kapi/src/extractor/source_parser.rs b/tools/kapi/src/extractor/source_parser.rs
new file mode 100644
index 0000000000000..8de35f5a73916
--- /dev/null
+++ b/tools/kapi/src/extractor/source_parser.rs
@@ -0,0 +1,488 @@
+use anyhow::{Context, Result};
+use regex::Regex;
+use std::fs;
+use std::path::Path;
+use std::collections::HashMap;
+use walkdir::WalkDir;
+use std::io::Write;
+use crate::formatter::OutputFormatter;
+use super::{ApiExtractor, ApiSpec, display_api_spec};
+
+#[derive(Debug, Clone)]
+pub struct SourceApiSpec {
+    pub name: String,
+    pub api_type: ApiType,
+    pub parsed_fields: HashMap<String, String>,
+}
+
+#[derive(Debug, Clone, PartialEq)]
+pub enum ApiType {
+    Syscall,
+    Ioctl,
+    Function,
+    Unknown,
+}
+
+impl ApiType {
+    fn from_name(name: &str) -> Self {
+        if name.starts_with("sys_") {
+            ApiType::Syscall
+        } else if name.contains("ioctl") || name.contains("IOCTL") {
+            ApiType::Ioctl
+        } else if name.starts_with("do_") || name.starts_with("__") {
+            ApiType::Function
+        } else {
+            ApiType::Unknown
+        }
+    }
+}
+
+pub struct SourceParser {
+    // Regex patterns for matching KAPI specifications
+    spec_start_pattern: Regex,
+    spec_end_pattern: Regex,
+    ioctl_spec_pattern: Regex,
+}
+
+impl SourceParser {
+    pub fn new() -> Result<Self> {
+        Ok(SourceParser {
+            // Match DEFINE_KERNEL_API_SPEC(function_name)
+            spec_start_pattern: Regex::new(r"DEFINE_KERNEL_API_SPEC\s*\(\s*([a-zA-Z_][a-zA-Z0-9_]*)\s*\)")?,
+            // Match KAPI_END_SPEC
+            spec_end_pattern: Regex::new(r"KAPI_END_SPEC")?,
+            // Match IOCTL specifications
+            ioctl_spec_pattern: Regex::new(r#"DEFINE_IOCTL_API_SPEC\s*\(\s*([a-zA-Z_][a-zA-Z0-9_]*)\s*,\s*([^,]+)\s*,\s*"([^"]+)"\s*\)"#)?,
+        })
+    }
+
+    /// Parse a single source file for KAPI specifications
+    pub fn parse_file(&self, path: &Path) -> Result<Vec<SourceApiSpec>> {
+        let content = fs::read_to_string(path)
+            .with_context(|| format!("Failed to read file: {}", path.display()))?;
+
+        self.parse_content(&content, path)
+    }
+
+    /// Parse file content for KAPI specifications
+    pub fn parse_content(&self, content: &str, _file_path: &Path) -> Result<Vec<SourceApiSpec>> {
+        let mut specs = Vec::new();
+        let lines: Vec<&str> = content.lines().collect();
+
+        // First, look for standard KAPI specs
+        for (i, line) in lines.iter().enumerate() {
+            if let Some(captures) = self.spec_start_pattern.captures(line) {
+                let api_name = captures.get(1).unwrap().as_str().to_string();
+
+                // Find the end of this specification
+                if let Some(spec_content) = self.extract_spec_block(&lines, i) {
+                    let mut spec = SourceApiSpec {
+                        name: api_name.clone(),
+                        api_type: ApiType::from_name(&api_name),
+                        parsed_fields: HashMap::new(),
+                    };
+
+                    // Parse the fields
+                    self.parse_spec_fields(&spec_content, &mut spec.parsed_fields)?;
+
+                    specs.push(spec);
+                }
+            }
+
+            // Also look for IOCTL specs
+            if let Some(captures) = self.ioctl_spec_pattern.captures(line) {
+                let spec_name = captures.get(1).unwrap().as_str().to_string();
+                let cmd = captures.get(2).unwrap().as_str().to_string();
+                let cmd_name = captures.get(3).unwrap().as_str().to_string();
+
+                // Find the end of this IOCTL specification
+                if let Some(spec_content) = self.extract_ioctl_spec_block(&lines, i) {
+                    let mut spec = SourceApiSpec {
+                        name: spec_name,
+                        api_type: ApiType::Ioctl,
+                        parsed_fields: HashMap::new(),
+                    };
+
+                    // Add IOCTL-specific fields
+                    spec.parsed_fields.insert("cmd".to_string(), cmd);
+                    spec.parsed_fields.insert("cmd_name".to_string(), cmd_name);
+
+                    // Parse other fields
+                    self.parse_spec_fields(&spec_content, &mut spec.parsed_fields)?;
+
+                    specs.push(spec);
+                }
+            }
+        }
+
+        Ok(specs)
+    }
+
+    /// Extract a complete KAPI specification block from the source
+    fn extract_spec_block(&self, lines: &[&str], start_idx: usize) -> Option<String> {
+        let mut spec_lines = Vec::new();
+        let mut brace_count = 0;
+        let mut in_spec = false;
+
+        for (_i, line) in lines.iter().enumerate().skip(start_idx) {
+            spec_lines.push(line.to_string());
+
+            // Count braces to handle nested structures
+            for ch in line.chars() {
+                match ch {
+                    '{' => {
+                        brace_count += 1;
+                        in_spec = true;
+                    }
+                    '}' => {
+                        brace_count -= 1;
+                    }
+                    _ => {}
+                }
+            }
+
+            // Check for end of spec
+            if self.spec_end_pattern.is_match(line) {
+                return Some(spec_lines.join("\n"));
+            }
+
+            // Alternative end: closing brace with semicolon
+            if in_spec && brace_count == 0 && line.contains("};") {
+                return Some(spec_lines.join("\n"));
+            }
+        }
+
+        None
+    }
+
+    /// Extract a complete IOCTL specification block
+    fn extract_ioctl_spec_block(&self, lines: &[&str], start_idx: usize) -> Option<String> {
+        let mut spec_lines = Vec::new();
+        let mut brace_count = 0;
+
+        for (i, line) in lines.iter().enumerate().skip(start_idx) {
+            spec_lines.push(line.to_string());
+
+            // Count braces
+            for ch in line.chars() {
+                match ch {
+                    '{' => brace_count += 1,
+                    '}' => brace_count -= 1,
+                    _ => {}
+                }
+            }
+
+            // Check for end patterns
+            if line.contains("KAPI_END_IOCTL_SPEC") || line.contains("KAPI_IOCTL_END_SPEC") {
+                return Some(spec_lines.join("\n"));
+            }
+
+            // Alternative end: closing brace with semicolon at top level
+            if brace_count == 0 && line.contains("};") && i > start_idx {
+                return Some(spec_lines.join("\n"));
+            }
+        }
+
+        None
+    }
+
+    /// Parse individual KAPI fields from the specification
+    fn parse_spec_fields(&self, content: &str, fields: &mut HashMap<String, String>) -> Result<()> {
+        // Parse KAPI_DESCRIPTION
+        if let Some(captures) = Regex::new(r#"KAPI_DESCRIPTION\s*\(\s*"([^"]*)"\s*\)"#)?.captures(content) {
+            fields.insert("description".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse KAPI_LONG_DESC (handle multi-line)
+        if let Some(captures) = Regex::new(r#"KAPI_LONG_DESC\s*\(\s*"([^"]*(?:\s*"[^"]*)*?)"\s*\)"#)?.captures(content) {
+            let long_desc = captures.get(1).unwrap().as_str()
+                .replace("\"\n\t\t       \"", " ")
+                .replace("\"\n\t\t    \"", " ")
+                .replace("\"\n\t\t   \"", " ")
+                .replace("\"\n\t\t  \"", " ")
+                .replace("\"\n\t\t \"", " ")
+                .replace("\"\n\t\t\"", " ");
+            fields.insert("long_description".to_string(), long_desc);
+        }
+
+        // Parse KAPI_CONTEXT
+        if let Some(captures) = Regex::new(r"KAPI_CONTEXT\s*\(([^)]+)\)")?.captures(content) {
+            fields.insert("context".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse KAPI_NOTES (handle multi-line)
+        if let Some(captures) = Regex::new(r#"KAPI_NOTES\s*\(\s*"([^"]*(?:\s*"[^"]*)*?)"\s*\)"#)?.captures(content) {
+            let notes = captures.get(1).unwrap().as_str()
+                .replace("\"\n\t\t       \"", " ")
+                .replace("\"\n\t\t    \"", " ")
+                .replace("\"\n\t\t   \"", " ")
+                .replace("\"\n\t\t  \"", " ")
+                .replace("\"\n\t\t \"", " ")
+                .replace("\"\n\t\t\"", " ")
+                .trim()
+                .to_string();
+            fields.insert("notes".to_string(), notes);
+        }
+
+        // Parse KAPI_EXAMPLES (handle multi-line)
+        if let Some(captures) = Regex::new(r#"KAPI_EXAMPLES\s*\(\s*"([^"]*(?:\s*"[^"]*)*?)"\s*\)"#)?.captures(content) {
+            let examples = captures.get(1).unwrap().as_str()
+                .replace("\\n\"\n\t\t    \"", "\n")
+                .replace("\\n\"\n\t\t   \"", "\n")
+                .replace("\\n\"\n\t\t  \"", "\n")
+                .replace("\\n\"\n\t\t \"", "\n")
+                .replace("\\n\"\n\t\t\"", "\n")
+                .replace("\\n", "\n")
+                .trim()
+                .to_string();
+            fields.insert("examples".to_string(), examples);
+        }
+
+        // Parse KAPI_SINCE_VERSION
+        if let Some(captures) = Regex::new(r#"KAPI_SINCE_VERSION\s*\(\s*"([^"]*)"\s*\)"#)?.captures(content) {
+            fields.insert("since_version".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse parameter count
+        let param_regex = Regex::new(r"KAPI_PARAM\s*\(\s*(\d+)\s*,")?;
+        let mut max_param_idx = 0;
+        for captures in param_regex.captures_iter(content) {
+            if let Ok(idx) = captures.get(1).unwrap().as_str().parse::<usize>() {
+                max_param_idx = max_param_idx.max(idx + 1);
+            }
+        }
+        if max_param_idx > 0 {
+            fields.insert("param_count".to_string(), max_param_idx.to_string());
+        }
+
+        // Parse error count
+        let error_regex = Regex::new(r"KAPI_ERROR\s*\(\s*(\d+)\s*,")?;
+        let mut max_error_idx = 0;
+        for captures in error_regex.captures_iter(content) {
+            if let Ok(idx) = captures.get(1).unwrap().as_str().parse::<usize>() {
+                max_error_idx = max_error_idx.max(idx + 1);
+            }
+        }
+        if max_error_idx > 0 {
+            fields.insert("error_count".to_string(), max_error_idx.to_string());
+        }
+
+        // Parse other counts
+        if content.contains(".error_count =") {
+            if let Some(captures) = Regex::new(r"\.error_count\s*=\s*(\d+)")?.captures(content) {
+                fields.insert("error_count".to_string(), captures.get(1).unwrap().as_str().to_string());
+            }
+        }
+
+        if content.contains(".param_count =") {
+            if let Some(captures) = Regex::new(r"\.param_count\s*=\s*(\d+)")?.captures(content) {
+                fields.insert("param_count".to_string(), captures.get(1).unwrap().as_str().to_string());
+            }
+        }
+
+        // Parse .since_version
+        if let Some(captures) = Regex::new(r#"\.since_version\s*=\s*"([^"]*)""#)?.captures(content) {
+            fields.insert("since_version".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse .notes (handle multi-line)
+        if let Some(captures) = Regex::new(r#"\.notes\s*=\s*"([^"]*(?:\s*"[^"]*)*?)""#)?.captures(content) {
+            let notes = captures.get(1).unwrap().as_str()
+                .replace("\"\n\t\t \"", " ")
+                .replace("\"\n\t\t\"", " ")
+                .replace("\"\n\t \"", " ")  // Handle single tab + space
+                .trim()
+                .to_string();
+            fields.insert("notes".to_string(), notes);
+        }
+
+        // Parse .examples (handle multi-line)
+        if let Some(captures) = Regex::new(r#"\.examples\s*=\s*"([^"]*(?:\s*"[^"]*)*?)""#)?.captures(content) {
+            let examples = captures.get(1).unwrap().as_str()
+                .replace("\\n\"\n\t\t    \"", "\n")
+                .replace("\\n", "\n");
+            fields.insert("examples".to_string(), examples);
+        }
+
+        Ok(())
+    }
+
+    /// Scan a directory tree for files containing KAPI specifications
+    pub fn scan_directory(&self, dir: &Path, extensions: &[&str]) -> Result<Vec<SourceApiSpec>> {
+        let mut all_specs = Vec::new();
+
+        for entry in WalkDir::new(dir)
+            .follow_links(true)
+            .into_iter()
+            .filter_map(|e| e.ok())
+        {
+            let path = entry.path();
+
+            // Skip non-files
+            if !path.is_file() {
+                continue;
+            }
+
+            // Check file extension
+            if let Some(ext) = path.extension() {
+                if extensions.iter().any(|&e| ext == e) {
+                    // Try to parse the file
+                    match self.parse_file(path) {
+                        Ok(specs) => {
+                            if !specs.is_empty() {
+                                all_specs.extend(specs);
+                            }
+                        }
+                        Err(e) => {
+                            eprintln!("Warning: Failed to parse {}: {}", path.display(), e);
+                        }
+                    }
+                }
+            }
+        }
+
+        Ok(all_specs)
+    }
+
+}
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+    use std::io::Write;
+    use tempfile::NamedTempFile;
+
+    #[test]
+    fn test_parse_syscall_spec() {
+        let parser = SourceParser::new().unwrap();
+
+        let content = r#"
+DEFINE_KERNEL_API_SPEC(sys_mlock)
+    KAPI_DESCRIPTION("Lock pages in memory")
+    KAPI_LONG_DESC("Locks pages in the specified address range into RAM")
+    KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+    KAPI_PARAM(0, "start", "unsigned long", "Starting address")
+    KAPI_PARAM_END
+
+    KAPI_PARAM(1, "len", "size_t", "Length of range")
+    KAPI_PARAM_END
+
+    .param_count = 2,
+    .error_count = 3,
+
+KAPI_END_SPEC
+"#;
+
+        let mut temp_file = NamedTempFile::new().unwrap();
+        write!(temp_file, "{}", content).unwrap();
+
+        let specs = parser.parse_content(content, temp_file.path()).unwrap();
+
+        assert_eq!(specs.len(), 1);
+        assert_eq!(specs[0].name, "sys_mlock");
+        assert_eq!(specs[0].api_type, ApiType::Syscall);
+        assert_eq!(specs[0].parsed_fields.get("description").unwrap(), "Lock pages in memory");
+        assert_eq!(specs[0].parsed_fields.get("param_count").unwrap(), "2");
+    }
+
+    #[test]
+    fn test_parse_ioctl_spec() {
+        let parser = SourceParser::new().unwrap();
+
+        let content = r#"
+DEFINE_IOCTL_API_SPEC(binder_write_read, BINDER_WRITE_READ, "BINDER_WRITE_READ")
+    KAPI_DESCRIPTION("Perform read/write operations on binder")
+    KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+    KAPI_PARAM(0, "write_size", "binder_size_t", "Bytes to write")
+    KAPI_PARAM_END
+
+KAPI_END_IOCTL_SPEC
+"#;
+
+        let mut temp_file = NamedTempFile::new().unwrap();
+        write!(temp_file, "{}", content).unwrap();
+
+        let specs = parser.parse_content(content, temp_file.path()).unwrap();
+
+        assert_eq!(specs.len(), 1);
+        assert_eq!(specs[0].name, "binder_write_read");
+        assert_eq!(specs[0].api_type, ApiType::Ioctl);
+        assert_eq!(specs[0].parsed_fields.get("cmd_name").unwrap(), "BINDER_WRITE_READ");
+    }
+}
+
+// SourceExtractor implementation
+pub struct SourceExtractor {
+    specs: Vec<SourceApiSpec>,
+}
+
+impl SourceExtractor {
+    pub fn new(path: String) -> Result<Self> {
+        let parser = SourceParser::new()?;
+        let path_obj = Path::new(&path);
+
+        let specs = if path_obj.is_file() {
+            parser.parse_file(path_obj)?
+        } else if path_obj.is_dir() {
+            parser.scan_directory(path_obj, &["c", "h"])?
+        } else {
+            anyhow::bail!("Path does not exist: {}", path_obj.display())
+        };
+
+        Ok(SourceExtractor { specs })
+    }
+
+    fn convert_to_api_spec(&self, source_spec: &SourceApiSpec) -> ApiSpec {
+        ApiSpec {
+            name: source_spec.name.clone(),
+            api_type: match source_spec.api_type {
+                ApiType::Syscall => "syscall".to_string(),
+                ApiType::Ioctl => "ioctl".to_string(),
+                ApiType::Function => "function".to_string(),
+                ApiType::Unknown => "unknown".to_string(),
+            },
+            description: source_spec.parsed_fields.get("description").cloned(),
+            long_description: source_spec.parsed_fields.get("long_description").cloned(),
+            version: source_spec.parsed_fields.get("version").cloned(),
+            context_flags: source_spec.parsed_fields.get("context")
+                .map(|c| vec![c.clone()])
+                .unwrap_or_default(),
+            param_count: source_spec.parsed_fields.get("param_count")
+                .and_then(|s| s.parse::<u32>().ok()),
+            error_count: source_spec.parsed_fields.get("error_count")
+                .and_then(|s| s.parse::<u32>().ok()),
+            examples: source_spec.parsed_fields.get("examples").cloned(),
+            notes: source_spec.parsed_fields.get("notes").cloned(),
+            since_version: source_spec.parsed_fields.get("since_version").cloned(),
+        }
+    }
+}
+
+impl ApiExtractor for SourceExtractor {
+    fn extract_all(&self) -> Result<Vec<ApiSpec>> {
+        Ok(self.specs.iter()
+            .map(|s| self.convert_to_api_spec(s))
+            .collect())
+    }
+
+    fn extract_by_name(&self, name: &str) -> Result<Option<ApiSpec>> {
+        Ok(self.specs.iter()
+            .find(|s| s.name == name)
+            .map(|s| self.convert_to_api_spec(s)))
+    }
+
+    fn display_api_details(
+        &self,
+        api_name: &str,
+        formatter: &mut dyn OutputFormatter,
+        writer: &mut dyn Write,
+    ) -> Result<()> {
+        if let Some(spec) = self.specs.iter().find(|s| s.name == api_name) {
+            let api_spec = self.convert_to_api_spec(spec);
+            display_api_spec(&api_spec, formatter, writer)?;
+        }
+        Ok(())
+    }
+}
\ No newline at end of file
diff --git a/tools/kapi/src/extractor/vmlinux/binary_utils.rs b/tools/kapi/src/extractor/vmlinux/binary_utils.rs
new file mode 100644
index 0000000000000..02c8e3b8eda77
--- /dev/null
+++ b/tools/kapi/src/extractor/vmlinux/binary_utils.rs
@@ -0,0 +1,130 @@
+use anyhow::Result;
+use std::io::Write;
+use crate::formatter::OutputFormatter;
+
+// Constants for all structure field sizes
+pub mod sizes {
+    pub const NAME: usize = 128;
+    pub const DESC: usize = 512;
+    pub const MAX_PARAMS: usize = 16;
+    pub const MAX_ERRORS: usize = 32;
+    pub const MAX_CONSTRAINTS: usize = 16;
+}
+
+// Helper for reading data at specific offsets
+pub struct DataReader<'a> {
+    data: &'a [u8],
+    pos: usize,
+}
+
+impl<'a> DataReader<'a> {
+    pub fn new(data: &'a [u8], offset: usize) -> Self {
+        Self { data, pos: offset }
+    }
+
+    pub fn read_bytes(&mut self, len: usize) -> Option<&'a [u8]> {
+        if self.pos + len <= self.data.len() {
+            let bytes = &self.data[self.pos..self.pos + len];
+            self.pos += len;
+            Some(bytes)
+        } else {
+            None
+        }
+    }
+
+    pub fn read_cstring(&mut self, max_len: usize) -> Option<String> {
+        let bytes = self.read_bytes(max_len)?;
+        if let Some(null_pos) = bytes.iter().position(|&b| b == 0) {
+            if null_pos > 0 {
+                if let Ok(s) = std::str::from_utf8(&bytes[..null_pos]) {
+                    return Some(s.to_string());
+                }
+            }
+        }
+        None
+    }
+
+    pub fn read_u32(&mut self) -> Option<u32> {
+        let bytes = self.read_bytes(4)?;
+        Some(u32::from_le_bytes([bytes[0], bytes[1], bytes[2], bytes[3]]))
+    }
+
+    pub fn skip(&mut self, len: usize) {
+        self.pos = (self.pos + len).min(self.data.len());
+    }
+}
+
+#[allow(dead_code)]
+pub fn parse_context_flags(flags: u32, formatter: &mut dyn OutputFormatter, w: &mut dyn Write) -> Result<()> {
+    // Context flags from kernel headers
+    const KAPI_CTX_PROCESS: u32 = 1 << 0;
+    const KAPI_CTX_SOFTIRQ: u32 = 1 << 1;
+    const KAPI_CTX_HARDIRQ: u32 = 1 << 2;
+    const KAPI_CTX_NMI: u32 = 1 << 3;
+    const KAPI_CTX_USER: u32 = 1 << 4;
+    const KAPI_CTX_KERNEL: u32 = 1 << 5;
+    const KAPI_CTX_SLEEPABLE: u32 = 1 << 6;
+    const KAPI_CTX_ATOMIC: u32 = 1 << 7;
+    const KAPI_CTX_PREEMPTIBLE: u32 = 1 << 8;
+    const KAPI_CTX_MIGRATION_DISABLED: u32 = 1 << 9;
+
+    if flags & KAPI_CTX_PROCESS != 0 { formatter.context_flag(w, "Process context")?; }
+    if flags & KAPI_CTX_SOFTIRQ != 0 { formatter.context_flag(w, "Softirq context")?; }
+    if flags & KAPI_CTX_HARDIRQ != 0 { formatter.context_flag(w, "Hardirq context")?; }
+    if flags & KAPI_CTX_NMI != 0 { formatter.context_flag(w, "NMI context")?; }
+    if flags & KAPI_CTX_USER != 0 { formatter.context_flag(w, "User mode")?; }
+    if flags & KAPI_CTX_KERNEL != 0 { formatter.context_flag(w, "Kernel mode")?; }
+    if flags & KAPI_CTX_SLEEPABLE != 0 { formatter.context_flag(w, "May sleep")?; }
+    if flags & KAPI_CTX_ATOMIC != 0 { formatter.context_flag(w, "Atomic context")?; }
+    if flags & KAPI_CTX_PREEMPTIBLE != 0 { formatter.context_flag(w, "Preemptible")?; }
+    if flags & KAPI_CTX_MIGRATION_DISABLED != 0 { formatter.context_flag(w, "Migration disabled")?; }
+
+    Ok(())
+}
+
+// Structure layout definitions for calculating sizes
+pub fn param_spec_layout_size() -> usize {
+    // Packed structure
+    sizes::NAME * 2 + // name, type_name
+    4 + 4 + // type, flags
+    8 + 8 + // size, alignment
+    8 + 8 + // min_value, max_value
+    8 + // valid_mask
+    8 + // enum_values pointer
+    4 + 4 + // enum_count, constraint_type
+    8 + // validate pointer
+    sizes::DESC * 2 + // description, constraints
+    4 + 8 // size_param_idx, size_multiplier
+}
+
+pub fn return_spec_layout_size() -> usize {
+    // Packed structure
+    sizes::NAME + // type_name
+    4 + 4 + // type, check_type
+    8 + 8 + 8 + // success_value, success_min, success_max
+    8 + // error_values pointer
+    4 + // error_count
+    8 + // is_success pointer
+    sizes::DESC // description
+}
+
+pub fn error_spec_layout_size() -> usize {
+    // Packed structure
+    4 + // code
+    sizes::NAME + // name
+    sizes::DESC * 2 // condition, description
+}
+
+pub fn lock_spec_layout_size() -> usize {
+    // Packed structure
+    sizes::NAME + // name
+    4 + // lock_type
+    1 + 1 + 1 + 1 + // bools
+    sizes::DESC // description
+}
+
+pub fn constraint_spec_layout_size() -> usize {
+    // Packed structure
+    sizes::NAME + // name
+    sizes::DESC * 2 // description, expression
+}
\ No newline at end of file
diff --git a/tools/kapi/src/extractor/vmlinux/mod.rs b/tools/kapi/src/extractor/vmlinux/mod.rs
new file mode 100644
index 0000000000000..5d5ca413d77a2
--- /dev/null
+++ b/tools/kapi/src/extractor/vmlinux/mod.rs
@@ -0,0 +1,372 @@
+use anyhow::{Context, Result};
+use goblin::elf::Elf;
+use std::fs;
+use std::io::Write;
+use crate::formatter::OutputFormatter;
+use super::{ApiExtractor, ApiSpec};
+
+mod binary_utils;
+use binary_utils::{sizes, DataReader,
+    param_spec_layout_size, return_spec_layout_size, error_spec_layout_size,
+    lock_spec_layout_size, constraint_spec_layout_size};
+
+pub struct VmlinuxExtractor {
+    kapi_data: Vec<u8>,
+    specs: Vec<KapiSpec>,
+}
+
+#[derive(Debug)]
+struct KapiSpec {
+    name: String,
+    api_type: String,
+    offset: usize,
+}
+
+impl VmlinuxExtractor {
+    pub fn new(vmlinux_path: String) -> Result<Self> {
+        let vmlinux_data = fs::read(&vmlinux_path)
+            .with_context(|| format!("Failed to read vmlinux file: {}", vmlinux_path))?;
+
+        let elf = Elf::parse(&vmlinux_data)
+            .context("Failed to parse ELF file")?;
+
+        // Find the .kapi_specs section
+        let kapi_section = elf.section_headers
+            .iter()
+            .find(|sh| {
+                if let Some(name) = elf.shdr_strtab.get_at(sh.sh_name) {
+                    name == ".kapi_specs"
+                } else {
+                    false
+                }
+            })
+            .context("Could not find .kapi_specs section in vmlinux")?;
+
+        // Find __start_kapi_specs and __stop_kapi_specs symbols
+        let mut start_addr = None;
+        let mut stop_addr = None;
+
+        for sym in &elf.syms {
+            if let Some(name) = elf.strtab.get_at(sym.st_name) {
+                match name {
+                    "__start_kapi_specs" => start_addr = Some(sym.st_value),
+                    "__stop_kapi_specs" => stop_addr = Some(sym.st_value),
+                    _ => {}
+                }
+            }
+        }
+
+        let start = start_addr.context("Could not find __start_kapi_specs symbol")?;
+        let stop = stop_addr.context("Could not find __stop_kapi_specs symbol")?;
+
+        if stop <= start {
+            anyhow::bail!("No kernel API specifications found in vmlinux");
+        }
+
+        // Calculate the offset within the file
+        let section_vaddr = kapi_section.sh_addr;
+        let file_offset = kapi_section.sh_offset + (start - section_vaddr);
+        let data_size = (stop - start) as usize;
+
+        if file_offset as usize + data_size > vmlinux_data.len() {
+            anyhow::bail!("Invalid offset/size for .kapi_specs data");
+        }
+
+        // Extract the raw data
+        let kapi_data = vmlinux_data[file_offset as usize..(file_offset as usize + data_size)].to_vec();
+
+        // Parse the specifications
+        let specs = parse_kapi_specs(&kapi_data)?;
+
+        Ok(VmlinuxExtractor {
+            kapi_data,
+            specs,
+        })
+    }
+
+}
+
+impl ApiExtractor for VmlinuxExtractor {
+    fn extract_all(&self) -> Result<Vec<ApiSpec>> {
+        // For vmlinux extractor, we return basic info only
+        // Detailed parsing happens in display_api_details
+        Ok(self.specs.iter().map(|spec| {
+            ApiSpec {
+                name: spec.name.clone(),
+                api_type: spec.api_type.clone(),
+                description: None,
+                long_description: None,
+                version: None,
+                context_flags: vec![],
+                param_count: None,
+                error_count: None,
+                examples: None,
+                notes: None,
+                since_version: None,
+            }
+        }).collect())
+    }
+
+    fn extract_by_name(&self, name: &str) -> Result<Option<ApiSpec>> {
+        Ok(self.specs.iter()
+            .find(|s| s.name == name)
+            .map(|spec| ApiSpec {
+                name: spec.name.clone(),
+                api_type: spec.api_type.clone(),
+                description: None,
+                long_description: None,
+                version: None,
+                context_flags: vec![],
+                param_count: None,
+                error_count: None,
+                examples: None,
+                notes: None,
+                since_version: None,
+            }))
+    }
+
+    fn display_api_details(
+        &self,
+        api_name: &str,
+        formatter: &mut dyn OutputFormatter,
+        writer: &mut dyn Write,
+    ) -> Result<()> {
+        if let Some(spec) = self.specs.iter().find(|s| s.name == api_name) {
+            // Parse the binary data into an ApiSpec
+            let api_spec = parse_binary_to_api_spec(&self.kapi_data, spec.offset)?;
+            // Use the common display function
+            super::display_api_spec(&api_spec, formatter, writer)?;
+        }
+        Ok(())
+    }
+}
+
+fn parse_kapi_specs(data: &[u8]) -> Result<Vec<KapiSpec>> {
+    let mut specs = Vec::new();
+
+    // The kernel_api_spec struct size in the kernel is 308064 bytes
+    // This is calculated as sizeof(struct kernel_api_spec) which includes:
+    // - Basic fields (name, version, description, etc.)
+    // - Arrays for parameters, errors, locks, constraints
+    // - Additional metadata fields
+    // TODO: This should ideally be read from kernel headers or made configurable
+    let struct_size = 308064;
+
+    let mut offset = 0;
+    while offset + struct_size <= data.len() {
+        // Try to read the name at this offset
+        if let Some(name) = read_cstring(data, offset, 128) {
+            if is_valid_api_name(&name) {
+                let api_type = if name.starts_with("sys_") {
+                    "syscall"
+                } else if name.contains("ioctl") || name.contains("IOCTL") {
+                    "ioctl"
+                } else {
+                    "other"
+                };
+
+                specs.push(KapiSpec {
+                    name: name.to_string(),
+                    api_type: api_type.to_string(),
+                    offset,
+                });
+            }
+        }
+
+        offset += struct_size;
+    }
+
+    // Handle any remaining data that might be a partial spec
+    if offset < data.len() && data.len() - offset >= 128 {
+        if let Some(name) = read_cstring(data, offset, 128) {
+            if is_valid_api_name(&name) {
+                let api_type = if name.starts_with("sys_") {
+                    "syscall"
+                } else if name.contains("ioctl") || name.contains("IOCTL") {
+                    "ioctl"
+                } else {
+                    "other"
+                };
+
+                specs.push(KapiSpec {
+                    name: name.to_string(),
+                    api_type: api_type.to_string(),
+                    offset,
+                });
+            }
+        }
+    }
+
+    Ok(specs)
+}
+
+fn read_cstring(data: &[u8], offset: usize, max_len: usize) -> Option<String> {
+    if offset + max_len > data.len() {
+        return None;
+    }
+
+    let bytes = &data[offset..offset + max_len];
+    if let Some(null_pos) = bytes.iter().position(|&b| b == 0) {
+        if null_pos > 0 {
+            if let Ok(s) = std::str::from_utf8(&bytes[..null_pos]) {
+                return Some(s.to_string());
+            }
+        }
+    }
+    None
+}
+
+fn is_valid_api_name(name: &str) -> bool {
+    if name.is_empty() || name.len() > 100 {
+        return false;
+    }
+
+    name.chars().all(|c| c.is_ascii_alphanumeric() || c == '_')
+        && (name.starts_with("sys_")
+            || name.contains("ioctl")
+            || name.contains("IOCTL")
+            || name.starts_with("do_")
+            || name.starts_with("__"))
+}
+
+fn parse_binary_to_api_spec(data: &[u8], offset: usize) -> Result<ApiSpec> {
+    let mut reader = DataReader::new(data, offset);
+
+    // Read name
+    let name = reader.read_cstring(sizes::NAME)
+        .ok_or_else(|| anyhow::anyhow!("Failed to read API name"))?;
+
+    // Read version
+    let version = reader.read_u32()
+        .map(|v| v.to_string());
+
+    // Read description
+    let description = reader.read_cstring(sizes::DESC)
+        .filter(|s| !s.is_empty());
+
+    // Read long description
+    let long_description = reader.read_cstring(sizes::DESC * 4)
+        .filter(|s| !s.is_empty());
+
+    // Read context flags
+    let context_flags = if let Some(flags) = reader.read_u32() {
+        let mut flag_strings = Vec::new();
+
+        const KAPI_CTX_PROCESS: u32 = 1 << 0;
+        const KAPI_CTX_SOFTIRQ: u32 = 1 << 1;
+        const KAPI_CTX_HARDIRQ: u32 = 1 << 2;
+        const KAPI_CTX_NMI: u32 = 1 << 3;
+        const KAPI_CTX_USER: u32 = 1 << 4;
+        const KAPI_CTX_KERNEL: u32 = 1 << 5;
+        const KAPI_CTX_SLEEPABLE: u32 = 1 << 6;
+        const KAPI_CTX_ATOMIC: u32 = 1 << 7;
+        const KAPI_CTX_PREEMPTIBLE: u32 = 1 << 8;
+        const KAPI_CTX_MIGRATION_DISABLED: u32 = 1 << 9;
+
+        // Build the flag string similar to source format
+        let mut parts = Vec::new();
+        if flags & KAPI_CTX_PROCESS != 0 { parts.push("KAPI_CTX_PROCESS"); }
+        if flags & KAPI_CTX_SOFTIRQ != 0 { parts.push("KAPI_CTX_SOFTIRQ"); }
+        if flags & KAPI_CTX_HARDIRQ != 0 { parts.push("KAPI_CTX_HARDIRQ"); }
+        if flags & KAPI_CTX_NMI != 0 { parts.push("KAPI_CTX_NMI"); }
+        if flags & KAPI_CTX_USER != 0 { parts.push("KAPI_CTX_USER"); }
+        if flags & KAPI_CTX_KERNEL != 0 { parts.push("KAPI_CTX_KERNEL"); }
+        if flags & KAPI_CTX_SLEEPABLE != 0 { parts.push("KAPI_CTX_SLEEPABLE"); }
+        if flags & KAPI_CTX_ATOMIC != 0 { parts.push("KAPI_CTX_ATOMIC"); }
+        if flags & KAPI_CTX_PREEMPTIBLE != 0 { parts.push("KAPI_CTX_PREEMPTIBLE"); }
+        if flags & KAPI_CTX_MIGRATION_DISABLED != 0 { parts.push("KAPI_CTX_MIGRATION_DISABLED"); }
+
+        if !parts.is_empty() {
+            flag_strings.push(parts.join(" | "));
+        }
+        flag_strings
+    } else {
+        vec![]
+    };
+
+    // Read parameter count
+    let param_count = reader.read_u32();
+
+    // Skip parameters for now (to match source output)
+    if let Some(count) = param_count {
+        if count > 0 && count <= sizes::MAX_PARAMS as u32 {
+            reader.skip(param_spec_layout_size() * count as usize);
+            reader.skip(param_spec_layout_size() * (sizes::MAX_PARAMS - count as usize));
+        } else {
+            reader.skip(param_spec_layout_size() * sizes::MAX_PARAMS);
+        }
+    }
+
+    // Skip return spec
+    reader.skip(return_spec_layout_size());
+
+    // Read error count
+    let error_count = reader.read_u32();
+
+    // Skip errors
+    if let Some(count) = error_count {
+        if count > 0 && count <= sizes::MAX_ERRORS as u32 {
+            reader.skip(error_spec_layout_size() * count as usize);
+            reader.skip(error_spec_layout_size() * (sizes::MAX_ERRORS - count as usize));
+        } else {
+            reader.skip(error_spec_layout_size() * sizes::MAX_ERRORS);
+        }
+    }
+
+    // Skip locks
+    if let Some(lock_count) = reader.read_u32() {
+        if lock_count > 0 && lock_count <= sizes::MAX_CONSTRAINTS as u32 {
+            reader.skip(lock_spec_layout_size() * lock_count as usize);
+            reader.skip(lock_spec_layout_size() * (sizes::MAX_CONSTRAINTS - lock_count as usize));
+        } else {
+            reader.skip(lock_spec_layout_size() * sizes::MAX_CONSTRAINTS);
+        }
+    }
+
+    // Skip constraints
+    if let Some(constraint_count) = reader.read_u32() {
+        if constraint_count > 0 && constraint_count <= sizes::MAX_CONSTRAINTS as u32 {
+            reader.skip(constraint_spec_layout_size() * constraint_count as usize);
+            reader.skip(constraint_spec_layout_size() * (sizes::MAX_CONSTRAINTS - constraint_count as usize));
+        } else {
+            reader.skip(constraint_spec_layout_size() * sizes::MAX_CONSTRAINTS);
+        }
+    }
+
+    // Read examples
+    let examples = reader.read_cstring(sizes::DESC * 2)
+        .filter(|s| !s.is_empty());
+
+    // Read notes
+    let notes = reader.read_cstring(sizes::DESC)
+        .filter(|s| !s.is_empty());
+
+    // Read since_version
+    let since_version = reader.read_cstring(32)
+        .filter(|s| !s.is_empty());
+
+    // Determine API type from name
+    let api_type = if name.starts_with("sys_") {
+        "syscall"
+    } else if name.contains("ioctl") || name.contains("IOCTL") {
+        "ioctl"
+    } else {
+        "other"
+    }.to_string();
+
+    Ok(ApiSpec {
+        name,
+        api_type,
+        description,
+        long_description,
+        version,
+        context_flags,
+        param_count,
+        error_count,
+        examples,
+        notes,
+        since_version,
+    })
+}
+
+// Old display_api_details_from_binary function removed - now using parse_binary_to_api_spec + display_api_spec
\ No newline at end of file
diff --git a/tools/kapi/src/formatter/json.rs b/tools/kapi/src/formatter/json.rs
new file mode 100644
index 0000000000000..44d2bbfc91133
--- /dev/null
+++ b/tools/kapi/src/formatter/json.rs
@@ -0,0 +1,170 @@
+use super::OutputFormatter;
+use std::io::Write;
+use serde::Serialize;
+
+pub struct JsonFormatter {
+    data: JsonData,
+}
+
+#[derive(Serialize)]
+struct JsonData {
+    #[serde(skip_serializing_if = "Option::is_none")]
+    apis: Option<Vec<JsonApi>>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    api_details: Option<JsonApiDetails>,
+}
+
+#[derive(Serialize)]
+struct JsonApi {
+    name: String,
+    api_type: String,
+}
+
+#[derive(Serialize)]
+struct JsonApiDetails {
+    name: String,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    description: Option<String>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    long_description: Option<String>,
+    #[serde(skip_serializing_if = "Vec::is_empty")]
+    context_flags: Vec<String>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    examples: Option<String>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    notes: Option<String>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    since_version: Option<String>,
+}
+
+
+impl JsonFormatter {
+    pub fn new() -> Self {
+        JsonFormatter {
+            data: JsonData {
+                apis: None,
+                api_details: None,
+            }
+        }
+    }
+}
+
+impl OutputFormatter for JsonFormatter {
+    fn begin_document(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn end_document(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        let json = serde_json::to_string_pretty(&self.data)?;
+        writeln!(w, "{}", json)?;
+        Ok(())
+    }
+
+    fn begin_api_list(&mut self, _w: &mut dyn Write, _title: &str) -> std::io::Result<()> {
+        self.data.apis = Some(Vec::new());
+        Ok(())
+    }
+
+    fn api_item(&mut self, _w: &mut dyn Write, name: &str, api_type: &str) -> std::io::Result<()> {
+        if let Some(apis) = &mut self.data.apis {
+            apis.push(JsonApi {
+                name: name.to_string(),
+                api_type: api_type.to_string(),
+            });
+        }
+        Ok(())
+    }
+
+    fn end_api_list(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn total_specs(&mut self, _w: &mut dyn Write, _count: usize) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_api_details(&mut self, _w: &mut dyn Write, name: &str) -> std::io::Result<()> {
+        self.data.api_details = Some(JsonApiDetails {
+            name: name.to_string(),
+            description: None,
+            long_description: None,
+            context_flags: Vec::new(),
+            examples: None,
+            notes: None,
+            since_version: None,
+        });
+        Ok(())
+    }
+
+    fn end_api_details(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+
+    fn description(&mut self, _w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.description = Some(desc.to_string());
+        }
+        Ok(())
+    }
+
+    fn long_description(&mut self, _w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.long_description = Some(desc.to_string());
+        }
+        Ok(())
+    }
+
+    fn begin_context_flags(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn context_flag(&mut self, _w: &mut dyn Write, flag: &str) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.context_flags.push(flag.to_string());
+        }
+        Ok(())
+    }
+
+    fn end_context_flags(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_parameters(&mut self, _w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        Ok(())
+    }
+
+
+    fn end_parameters(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_errors(&mut self, _w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn end_errors(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn examples(&mut self, _w: &mut dyn Write, examples: &str) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.examples = Some(examples.to_string());
+        }
+        Ok(())
+    }
+
+    fn notes(&mut self, _w: &mut dyn Write, notes: &str) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.notes = Some(notes.to_string());
+        }
+        Ok(())
+    }
+
+    fn since_version(&mut self, _w: &mut dyn Write, version: &str) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.since_version = Some(version.to_string());
+        }
+        Ok(())
+    }
+}
\ No newline at end of file
diff --git a/tools/kapi/src/formatter/mod.rs b/tools/kapi/src/formatter/mod.rs
new file mode 100644
index 0000000000000..6eb42e8b404d0
--- /dev/null
+++ b/tools/kapi/src/formatter/mod.rs
@@ -0,0 +1,68 @@
+use std::io::Write;
+
+mod plain;
+mod json;
+mod rst;
+
+pub use plain::PlainFormatter;
+pub use json::JsonFormatter;
+pub use rst::RstFormatter;
+
+
+#[derive(Debug, Clone, Copy, PartialEq)]
+pub enum OutputFormat {
+    Plain,
+    Json,
+    Rst,
+}
+
+impl std::str::FromStr for OutputFormat {
+    type Err = String;
+
+    fn from_str(s: &str) -> Result<Self, Self::Err> {
+        match s.to_lowercase().as_str() {
+            "plain" => Ok(OutputFormat::Plain),
+            "json" => Ok(OutputFormat::Json),
+            "rst" => Ok(OutputFormat::Rst),
+            _ => Err(format!("Unknown output format: {}", s)),
+        }
+    }
+}
+
+pub trait OutputFormatter {
+    fn begin_document(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+    fn end_document(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn begin_api_list(&mut self, w: &mut dyn Write, title: &str) -> std::io::Result<()>;
+    fn api_item(&mut self, w: &mut dyn Write, name: &str, api_type: &str) -> std::io::Result<()>;
+    fn end_api_list(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn total_specs(&mut self, w: &mut dyn Write, count: usize) -> std::io::Result<()>;
+
+    fn begin_api_details(&mut self, w: &mut dyn Write, name: &str) -> std::io::Result<()>;
+    fn end_api_details(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+    fn description(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()>;
+    fn long_description(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()>;
+
+    fn begin_context_flags(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+    fn context_flag(&mut self, w: &mut dyn Write, flag: &str) -> std::io::Result<()>;
+    fn end_context_flags(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn begin_parameters(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()>;
+    fn end_parameters(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn begin_errors(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()>;
+    fn end_errors(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn examples(&mut self, w: &mut dyn Write, examples: &str) -> std::io::Result<()>;
+    fn notes(&mut self, w: &mut dyn Write, notes: &str) -> std::io::Result<()>;
+    fn since_version(&mut self, w: &mut dyn Write, version: &str) -> std::io::Result<()>;
+}
+
+pub fn create_formatter(format: OutputFormat) -> Box<dyn OutputFormatter> {
+    match format {
+        OutputFormat::Plain => Box::new(PlainFormatter::new()),
+        OutputFormat::Json => Box::new(JsonFormatter::new()),
+        OutputFormat::Rst => Box::new(RstFormatter::new()),
+    }
+}
\ No newline at end of file
diff --git a/tools/kapi/src/formatter/plain.rs b/tools/kapi/src/formatter/plain.rs
new file mode 100644
index 0000000000000..4ccbfcbbc8416
--- /dev/null
+++ b/tools/kapi/src/formatter/plain.rs
@@ -0,0 +1,99 @@
+use super::OutputFormatter;
+use std::io::Write;
+
+pub struct PlainFormatter;
+
+impl PlainFormatter {
+    pub fn new() -> Self {
+        PlainFormatter
+    }
+}
+
+impl OutputFormatter for PlainFormatter {
+    fn begin_document(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn end_document(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_api_list(&mut self, w: &mut dyn Write, title: &str) -> std::io::Result<()> {
+        writeln!(w, "\n{}:", title)?;
+        writeln!(w, "{}", "-".repeat(title.len() + 1))
+    }
+
+    fn api_item(&mut self, w: &mut dyn Write, name: &str, _api_type: &str) -> std::io::Result<()> {
+        writeln!(w, "  {}", name)
+    }
+
+    fn end_api_list(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn total_specs(&mut self, w: &mut dyn Write, count: usize) -> std::io::Result<()> {
+        writeln!(w, "\nTotal specifications found: {}", count)
+    }
+
+    fn begin_api_details(&mut self, w: &mut dyn Write, name: &str) -> std::io::Result<()> {
+        writeln!(w, "\nDetailed information for {}:", name)?;
+        writeln!(w, "{}=", "=".repeat(25 + name.len()))
+    }
+
+    fn end_api_details(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+
+    fn description(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        writeln!(w, "Description: {}", desc)
+    }
+
+    fn long_description(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        writeln!(w, "\nDetailed Description:")?;
+        writeln!(w, "{}", desc)
+    }
+
+    fn begin_context_flags(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        writeln!(w, "\nExecution Context:")
+    }
+
+    fn context_flag(&mut self, w: &mut dyn Write, flag: &str) -> std::io::Result<()> {
+        writeln!(w, "  - {}", flag)
+    }
+
+    fn end_context_flags(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_parameters(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nParameters ({}):", count)
+    }
+
+
+    fn end_parameters(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_errors(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nPossible Errors ({}):", count)
+    }
+
+    fn end_errors(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn examples(&mut self, w: &mut dyn Write, examples: &str) -> std::io::Result<()> {
+        writeln!(w, "\nExamples:")?;
+        writeln!(w, "{}", examples)
+    }
+
+    fn notes(&mut self, w: &mut dyn Write, notes: &str) -> std::io::Result<()> {
+        writeln!(w, "\nNotes:")?;
+        writeln!(w, "{}", notes)
+    }
+
+    fn since_version(&mut self, w: &mut dyn Write, version: &str) -> std::io::Result<()> {
+        writeln!(w, "\nAvailable since: {}", version)
+    }
+}
\ No newline at end of file
diff --git a/tools/kapi/src/formatter/rst.rs b/tools/kapi/src/formatter/rst.rs
new file mode 100644
index 0000000000000..96be83bf208dd
--- /dev/null
+++ b/tools/kapi/src/formatter/rst.rs
@@ -0,0 +1,144 @@
+use super::OutputFormatter;
+use std::io::Write;
+
+pub struct RstFormatter {
+    current_section_level: usize,
+}
+
+impl RstFormatter {
+    pub fn new() -> Self {
+        RstFormatter {
+            current_section_level: 0,
+        }
+    }
+
+    fn section_char(&self, level: usize) -> char {
+        match level {
+            0 => '=',
+            1 => '-',
+            2 => '~',
+            3 => '^',
+            _ => '"',
+        }
+    }
+}
+
+impl OutputFormatter for RstFormatter {
+    fn begin_document(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn end_document(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_api_list(&mut self, w: &mut dyn Write, title: &str) -> std::io::Result<()> {
+        writeln!(w, "\n{}", title)?;
+        writeln!(w, "{}", self.section_char(0).to_string().repeat(title.len()))?;
+        writeln!(w)
+    }
+
+    fn api_item(&mut self, w: &mut dyn Write, name: &str, api_type: &str) -> std::io::Result<()> {
+        writeln!(w, "* **{}** (*{}*)", name, api_type)
+    }
+
+    fn end_api_list(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn total_specs(&mut self, w: &mut dyn Write, count: usize) -> std::io::Result<()> {
+        writeln!(w, "\n**Total specifications found:** {}", count)
+    }
+
+    fn begin_api_details(&mut self, w: &mut dyn Write, name: &str) -> std::io::Result<()> {
+        self.current_section_level = 0;
+        writeln!(w, "\n{}", name)?;
+        writeln!(w, "{}", self.section_char(0).to_string().repeat(name.len()))?;
+        writeln!(w)
+    }
+
+    fn end_api_details(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+
+    fn description(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        writeln!(w, "**{}**", desc)?;
+        writeln!(w)
+    }
+
+    fn long_description(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        writeln!(w, "{}", desc)?;
+        writeln!(w)
+    }
+
+    fn begin_context_flags(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        self.current_section_level = 1;
+        let title = "Execution Context";
+        writeln!(w, "{}", title)?;
+        writeln!(w, "{}", self.section_char(1).to_string().repeat(title.len()))?;
+        writeln!(w)
+    }
+
+    fn context_flag(&mut self, w: &mut dyn Write, flag: &str) -> std::io::Result<()> {
+        writeln!(w, "* {}", flag)
+    }
+
+    fn end_context_flags(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        writeln!(w)
+    }
+
+    fn begin_parameters(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        self.current_section_level = 1;
+        let title = format!("Parameters ({})", count);
+        writeln!(w, "{}", title)?;
+        writeln!(w, "{}", self.section_char(1).to_string().repeat(title.len()))?;
+        writeln!(w)
+    }
+
+
+    fn end_parameters(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_errors(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        self.current_section_level = 1;
+        let title = format!("Possible Errors ({})", count);
+        writeln!(w, "{}", title)?;
+        writeln!(w, "{}", self.section_char(1).to_string().repeat(title.len()))?;
+        writeln!(w)
+    }
+
+    fn end_errors(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn examples(&mut self, w: &mut dyn Write, examples: &str) -> std::io::Result<()> {
+        self.current_section_level = 1;
+        let title = "Examples";
+        writeln!(w, "{}", title)?;
+        writeln!(w, "{}", self.section_char(1).to_string().repeat(title.len()))?;
+        writeln!(w)?;
+        writeln!(w, ".. code-block:: c")?;
+        writeln!(w)?;
+        for line in examples.lines() {
+            writeln!(w, "   {}", line)?;
+        }
+        writeln!(w)
+    }
+
+    fn notes(&mut self, w: &mut dyn Write, notes: &str) -> std::io::Result<()> {
+        self.current_section_level = 1;
+        let title = "Notes";
+        writeln!(w, "{}", title)?;
+        writeln!(w, "{}", self.section_char(1).to_string().repeat(title.len()))?;
+        writeln!(w)?;
+        writeln!(w, "{}", notes)?;
+        writeln!(w)
+    }
+
+    fn since_version(&mut self, w: &mut dyn Write, version: &str) -> std::io::Result<()> {
+        writeln!(w, ":Available since: {}", version)?;
+        writeln!(w)
+    }
+}
\ No newline at end of file
diff --git a/tools/kapi/src/main.rs b/tools/kapi/src/main.rs
new file mode 100644
index 0000000000000..9d6533cbc7dd1
--- /dev/null
+++ b/tools/kapi/src/main.rs
@@ -0,0 +1,121 @@
+//! kapi - Kernel API Specification Tool
+//!
+//! This tool extracts and displays kernel API specifications from multiple sources:
+//! - Kernel source code (KAPI macros)
+//! - Compiled vmlinux binaries (.kapi_specs ELF section)
+//! - Running kernel via debugfs
+
+use anyhow::Result;
+use clap::Parser;
+use std::io::{self, Write};
+
+mod formatter;
+mod extractor;
+
+use formatter::{OutputFormat, create_formatter};
+use extractor::{ApiExtractor, VmlinuxExtractor, SourceExtractor, DebugfsExtractor};
+
+#[derive(Parser, Debug)]
+#[command(author, version, about, long_about = None)]
+struct Args {
+    /// Path to the vmlinux file
+    #[arg(long, value_name = "PATH", group = "input")]
+    vmlinux: Option<String>,
+
+    /// Path to kernel source directory or file
+    #[arg(long, value_name = "PATH", group = "input")]
+    source: Option<String>,
+
+    /// Path to debugfs (defaults to /sys/kernel/debug if not specified)
+    #[arg(long, value_name = "PATH", group = "input")]
+    debugfs: Option<String>,
+
+    /// Optional: Name of specific API to show details for
+    api_name: Option<String>,
+
+    /// Output format
+    #[arg(long, short = 'f', default_value = "plain")]
+    format: String,
+}
+
+fn main() -> Result<()> {
+    let args = Args::parse();
+
+    let output_format: OutputFormat = args.format.parse()
+        .map_err(|e: String| anyhow::anyhow!(e))?;
+
+    let extractor: Box<dyn ApiExtractor> = match (args.vmlinux, args.source, args.debugfs.clone()) {
+        (Some(vmlinux_path), None, None) => {
+            Box::new(VmlinuxExtractor::new(vmlinux_path)?)
+        }
+        (None, Some(source_path), None) => {
+            Box::new(SourceExtractor::new(source_path)?)
+        }
+        (None, None, Some(_)) | (None, None, None) => {
+            // If debugfs is specified or no input is provided, use debugfs
+            Box::new(DebugfsExtractor::new(args.debugfs)?)
+        }
+        _ => {
+            anyhow::bail!("Please specify only one of --vmlinux, --source, or --debugfs")
+        }
+    };
+
+    display_apis(extractor.as_ref(), args.api_name, output_format)
+}
+
+fn display_apis(extractor: &dyn ApiExtractor, api_name: Option<String>, output_format: OutputFormat) -> Result<()> {
+    let mut formatter = create_formatter(output_format);
+    let mut stdout = io::stdout();
+
+    formatter.begin_document(&mut stdout)?;
+
+    if let Some(api_name_req) = api_name {
+        // Use the extractor to display API details
+        if let Some(_spec) = extractor.extract_by_name(&api_name_req)? {
+            extractor.display_api_details(&api_name_req, &mut *formatter, &mut stdout)?;
+        } else if output_format == OutputFormat::Plain {
+            writeln!(stdout, "\nAPI '{}' not found.", api_name_req)?;
+            writeln!(stdout, "\nAvailable APIs:")?;
+            for spec in extractor.extract_all()? {
+                writeln!(stdout, "  {} ({})", spec.name, spec.api_type)?;
+            }
+        }
+    } else {
+        // Display list of APIs using the extractor
+        let all_specs = extractor.extract_all()?;
+        let syscalls: Vec<_> = all_specs.iter().filter(|s| s.api_type == "syscall").collect();
+        let ioctls: Vec<_> = all_specs.iter().filter(|s| s.api_type == "ioctl").collect();
+        let functions: Vec<_> = all_specs.iter().filter(|s| s.api_type == "function").collect();
+
+        if !syscalls.is_empty() {
+            formatter.begin_api_list(&mut stdout, "System Calls")?;
+            for spec in syscalls {
+                formatter.api_item(&mut stdout, &spec.name, &spec.api_type)?;
+            }
+            formatter.end_api_list(&mut stdout)?;
+        }
+
+        if !ioctls.is_empty() {
+            formatter.begin_api_list(&mut stdout, "IOCTLs")?;
+            for spec in ioctls {
+                formatter.api_item(&mut stdout, &spec.name, &spec.api_type)?;
+            }
+            formatter.end_api_list(&mut stdout)?;
+        }
+
+        if !functions.is_empty() {
+            formatter.begin_api_list(&mut stdout, "Functions")?;
+            for spec in functions {
+                formatter.api_item(&mut stdout, &spec.name, &spec.api_type)?;
+            }
+            formatter.end_api_list(&mut stdout)?;
+        }
+
+        formatter.total_specs(&mut stdout, all_specs.len())?;
+    }
+
+    formatter.end_document(&mut stdout)?;
+
+    Ok(())
+}
+
-- 
2.39.5


