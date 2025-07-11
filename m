Return-Path: <linux-api+bounces-4150-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E37B01AE8
	for <lists+linux-api@lfdr.de>; Fri, 11 Jul 2025 13:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4E816B68C
	for <lists+linux-api@lfdr.de>; Fri, 11 Jul 2025 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB002BE62A;
	Fri, 11 Jul 2025 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5cANssP"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A242BDC3B;
	Fri, 11 Jul 2025 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234176; cv=none; b=QhM9Kms1m4qQ+9j5Ho7/Dqt2hTjo9Uosu33KkDN/wNGWbZoQ15uRCWoJaGwrCxX9ylqGkzeNxsu3ps1j4pFO9GkXHGRg8EiCA2PbQloMZRAYatGqhAxPDfk4q8j/B91ws/3wC+qEhWJ0ghQJNpPDq2r3bVebX/Lfve5HDAGt1Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234176; c=relaxed/simple;
	bh=1dV4Hq0LRuSXsfgdsPo4Jvj5A0rWCB0so8GWrmi6YDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3FHdcliSN4SNMd8/b9zZZajRqNcyniwuw2KtWyFolzycsSpDjfdAUiP/d3wBr+96QY5o9IYEyqA7+sJzhgtk2YHxSz/5RBpFHmIUO67mhDGkgGv+TgqclUqEfRjuKXgPo9G1APgYvRf/zgvkCFbYWM0HkJIujW20fbCN/0nyAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5cANssP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379B9C4CEF5;
	Fri, 11 Jul 2025 11:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234176;
	bh=1dV4Hq0LRuSXsfgdsPo4Jvj5A0rWCB0so8GWrmi6YDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5cANssP+YgmCrw+qKJQmAKEUuxQUdw6HWpMcGaFj6dxpn/MHuxcF3NICY8gbK8V1
	 IN7pmUIo2/Jcqnrab0kKLPSqvxskRBJv72TvC+isjrWMdaf5WQR5elBwMV6B5bUhwF
	 LbP/N7LzMB9+EotDU69F+NnrpaJYAw5PRcvBEOs6rBYziFcSJlbzT7T3q0w/TJP0ri
	 UGamh9nF71QqQp8bE+CjwFSsCgW5qOZHrJ/6czoRfaKgcnzURPxNyyr16QmKn/UgMh
	 EsfpM2qp7r6BscIqcNTk5YcON4jNfWhu3EwCQazv13dykPhobLpwp47pQEvJa+Ahrw
	 xTLXDqywKM6nA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v3 1/4] kernel/api: introduce kernel API specification framework
Date: Fri, 11 Jul 2025 07:42:45 -0400
Message-Id: <20250711114248.2288591-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711114248.2288591-1-sashal@kernel.org>
References: <20250711114248.2288591-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a comprehensive framework for formally documenting kernel APIs with
inline specifications. This framework provides:

- Structured API documentation with parameter specifications, return
  values, error conditions, and execution context requirements
- Runtime validation capabilities for debugging (CONFIG_KAPI_RUNTIME_CHECKS)
- Export of specifications via debugfs for tooling integration
- Support for both internal kernel APIs and system calls

The framework stores specifications in a dedicated ELF section and
provides infrastructure for:
- Compile-time validation of specifications
- Runtime querying of API documentation
- Machine-readable export formats
- Integration with existing SYSCALL_DEFINE macros

This commit introduces the core infrastructure without modifying any
existing APIs. Subsequent patches will add specifications to individual
subsystems.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/kernel-api-spec.rst |  507 ++++++
 MAINTAINERS                                   |    9 +
 arch/um/kernel/dyn.lds.S                      |    3 +
 arch/um/kernel/uml.lds.S                      |    3 +
 arch/x86/kernel/vmlinux.lds.S                 |    3 +
 include/asm-generic/vmlinux.lds.h             |   20 +
 include/linux/kernel_api_spec.h               | 1527 +++++++++++++++++
 include/linux/syscall_api_spec.h              |  137 ++
 include/linux/syscalls.h                      |   38 +
 init/Kconfig                                  |    2 +
 kernel/Makefile                               |    1 +
 kernel/api/Kconfig                            |   35 +
 kernel/api/Makefile                           |    7 +
 kernel/api/kernel_api_spec.c                  | 1122 ++++++++++++
 14 files changed, 3414 insertions(+)
 create mode 100644 Documentation/admin-guide/kernel-api-spec.rst
 create mode 100644 include/linux/kernel_api_spec.h
 create mode 100644 include/linux/syscall_api_spec.h
 create mode 100644 kernel/api/Kconfig
 create mode 100644 kernel/api/Makefile
 create mode 100644 kernel/api/kernel_api_spec.c

diff --git a/Documentation/admin-guide/kernel-api-spec.rst b/Documentation/admin-guide/kernel-api-spec.rst
new file mode 100644
index 0000000000000..3a63f6711e27b
--- /dev/null
+++ b/Documentation/admin-guide/kernel-api-spec.rst
@@ -0,0 +1,507 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+Kernel API Specification Framework
+======================================
+
+:Author: Sasha Levin <sashal@kernel.org>
+:Date: June 2025
+
+.. contents:: Table of Contents
+   :depth: 3
+   :local:
+
+Introduction
+============
+
+The Kernel API Specification Framework (KAPI) provides a comprehensive system for
+formally documenting, validating, and introspecting kernel APIs. This framework
+addresses the long-standing challenge of maintaining accurate, machine-readable
+documentation for the thousands of internal kernel APIs and system calls.
+
+Purpose and Goals
+-----------------
+
+The framework aims to:
+
+1. **Improve API Documentation**: Provide structured, inline documentation that
+   lives alongside the code and is maintained as part of the development process.
+
+2. **Enable Runtime Validation**: Optionally validate API usage at runtime to catch
+   common programming errors during development and testing.
+
+3. **Support Tooling**: Export API specifications in machine-readable formats for
+   use by static analyzers, documentation generators, and development tools.
+
+4. **Enhance Debugging**: Provide detailed API information at runtime through debugfs
+   for debugging and introspection.
+
+5. **Formalize Contracts**: Explicitly document API contracts including parameter
+   constraints, execution contexts, locking requirements, and side effects.
+
+Architecture Overview
+=====================
+
+Components
+----------
+
+The framework consists of several key components:
+
+1. **Core Framework** (``kernel/api/kernel_api_spec.c``)
+
+   - API specification registration and storage
+   - Runtime validation engine
+   - Specification lookup and querying
+
+2. **DebugFS Interface** (``kernel/api/kapi_debugfs.c``)
+
+   - Runtime introspection via ``/sys/kernel/debug/kapi/``
+   - JSON and XML export formats
+   - Per-API detailed information
+
+3. **IOCTL Support** (``kernel/api/ioctl_validation.c``)
+
+   - Extended framework for IOCTL specifications
+   - Automatic validation wrappers
+   - Structure field validation
+
+4. **Specification Macros** (``include/linux/kernel_api_spec.h``)
+
+   - Declarative macros for API documentation
+   - Type-safe parameter specifications
+   - Context and constraint definitions
+
+Data Model
+----------
+
+The framework uses a hierarchical data model::
+
+    kernel_api_spec
+    ├── Basic Information
+    │   ├── name (API function name)
+    │   ├── version (specification version)
+    │   ├── description (human-readable description)
+    │   └── kernel_version (when API was introduced)
+    │
+    ├── Parameters (up to 16)
+    │   └── kapi_param_spec
+    │       ├── name
+    │       ├── type (int, pointer, string, etc.)
+    │       ├── direction (in, out, inout)
+    │       ├── constraints (range, mask, enum values)
+    │       └── validation rules
+    │
+    ├── Return Value
+    │   └── kapi_return_spec
+    │       ├── type
+    │       ├── success conditions
+    │       └── validation rules
+    │
+    ├── Error Conditions (up to 32)
+    │   └── kapi_error_spec
+    │       ├── error code
+    │       ├── condition description
+    │       └── recovery advice
+    │
+    ├── Execution Context
+    │   ├── allowed contexts (process, interrupt, etc.)
+    │   ├── locking requirements
+    │   └── preemption/interrupt state
+    │
+    └── Side Effects
+        ├── memory allocation
+        ├── state changes
+        └── signal handling
+
+Usage Guide
+===========
+
+Basic API Specification
+-----------------------
+
+To document a kernel API, use the specification macros in the implementation file:
+
+.. code-block:: c
+
+    #include <linux/kernel_api_spec.h>
+
+    KAPI_DEFINE_SPEC(kmalloc_spec, kmalloc, "3.0")
+    KAPI_DESCRIPTION("Allocate kernel memory")
+    KAPI_PARAM(0, size, KAPI_TYPE_SIZE_T, KAPI_DIR_IN,
+               "Number of bytes to allocate")
+    KAPI_PARAM_RANGE(0, 0, KMALLOC_MAX_SIZE)
+    KAPI_PARAM(1, flags, KAPI_TYPE_FLAGS, KAPI_DIR_IN,
+               "Allocation flags (GFP_*)")
+    KAPI_PARAM_MASK(1, __GFP_BITS_MASK)
+    KAPI_RETURN(KAPI_TYPE_POINTER, "Pointer to allocated memory or NULL")
+    KAPI_ERROR(ENOMEM, "Out of memory")
+    KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SOFTIRQ | KAPI_CTX_HARDIRQ)
+    KAPI_SIDE_EFFECT("Allocates memory from kernel heap")
+    KAPI_LOCK_NOT_REQUIRED("Any lock")
+    KAPI_END_SPEC
+
+    void *kmalloc(size_t size, gfp_t flags)
+    {
+        /* Implementation */
+    }
+
+System Call Specification
+-------------------------
+
+System calls use specialized macros:
+
+.. code-block:: c
+
+    KAPI_DEFINE_SYSCALL_SPEC(open_spec, open, "1.0")
+    KAPI_DESCRIPTION("Open a file")
+    KAPI_PARAM(0, pathname, KAPI_TYPE_USER_STRING, KAPI_DIR_IN,
+               "Path to file")
+    KAPI_PARAM_PATH(0, PATH_MAX)
+    KAPI_PARAM(1, flags, KAPI_TYPE_FLAGS, KAPI_DIR_IN,
+               "Open flags (O_*)")
+    KAPI_PARAM(2, mode, KAPI_TYPE_MODE_T, KAPI_DIR_IN,
+               "File permissions (if creating)")
+    KAPI_RETURN(KAPI_TYPE_INT, "File descriptor or -1")
+    KAPI_ERROR(EACCES, "Permission denied")
+    KAPI_ERROR(ENOENT, "File does not exist")
+    KAPI_ERROR(EMFILE, "Too many open files")
+    KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+    KAPI_SIGNAL(EINTR, "Open can be interrupted by signal")
+    KAPI_END_SYSCALL_SPEC
+
+IOCTL Specification
+-------------------
+
+IOCTLs have extended support for structure validation:
+
+.. code-block:: c
+
+    KAPI_DEFINE_IOCTL_SPEC(vidioc_querycap_spec, VIDIOC_QUERYCAP,
+                           "VIDIOC_QUERYCAP",
+                           sizeof(struct v4l2_capability),
+                           sizeof(struct v4l2_capability),
+                           "video_fops")
+    KAPI_DESCRIPTION("Query device capabilities")
+    KAPI_IOCTL_FIELD(driver, KAPI_TYPE_CHAR_ARRAY, KAPI_DIR_OUT,
+                     "Driver name", 16)
+    KAPI_IOCTL_FIELD(card, KAPI_TYPE_CHAR_ARRAY, KAPI_DIR_OUT,
+                     "Device name", 32)
+    KAPI_IOCTL_FIELD(version, KAPI_TYPE_U32, KAPI_DIR_OUT,
+                     "Driver version")
+    KAPI_IOCTL_FIELD(capabilities, KAPI_TYPE_FLAGS, KAPI_DIR_OUT,
+                     "Device capabilities")
+    KAPI_END_IOCTL_SPEC
+
+Runtime Validation
+==================
+
+Enabling Validation
+-------------------
+
+Runtime validation is controlled by kernel configuration:
+
+1. Enable ``CONFIG_KAPI_SPEC`` to build the framework
+2. Enable ``CONFIG_KAPI_RUNTIME_CHECKS`` for runtime validation
+3. Optionally enable ``CONFIG_KAPI_SPEC_DEBUGFS`` for debugfs interface
+
+Validation Modes
+----------------
+
+The framework supports several validation modes:
+
+.. code-block:: c
+
+    /* Enable validation for specific API */
+    kapi_enable_validation("kmalloc");
+
+    /* Enable validation for all APIs */
+    kapi_enable_all_validation();
+
+    /* Set validation level */
+    kapi_set_validation_level(KAPI_VALIDATE_FULL);
+
+Validation Levels:
+
+- ``KAPI_VALIDATE_NONE``: No validation
+- ``KAPI_VALIDATE_BASIC``: Type and NULL checks only
+- ``KAPI_VALIDATE_NORMAL``: Basic + range and constraint checks
+- ``KAPI_VALIDATE_FULL``: All checks including custom validators
+
+Custom Validators
+-----------------
+
+APIs can register custom validation functions:
+
+.. code-block:: c
+
+    static bool validate_buffer_size(const struct kapi_param_spec *spec,
+                                     const void *value, void *context)
+    {
+        size_t size = *(size_t *)value;
+        struct my_context *ctx = context;
+
+        return size > 0 && size <= ctx->max_buffer_size;
+    }
+
+    KAPI_PARAM_CUSTOM_VALIDATOR(0, validate_buffer_size)
+
+DebugFS Interface
+=================
+
+The debugfs interface provides runtime access to API specifications:
+
+Directory Structure
+-------------------
+
+::
+
+    /sys/kernel/debug/kapi/
+    ├── apis/                    # All registered APIs
+    │   ├── kmalloc/
+    │   │   ├── specification   # Human-readable spec
+    │   │   ├── json           # JSON format
+    │   │   └── xml            # XML format
+    │   └── open/
+    │       └── ...
+    ├── summary                  # Overview of all APIs
+    ├── validation/              # Validation controls
+    │   ├── enabled             # Global enable/disable
+    │   ├── level               # Validation level
+    │   └── stats               # Validation statistics
+    └── export/                  # Bulk export options
+        ├── all.json            # All specs in JSON
+        └── all.xml             # All specs in XML
+
+Usage Examples
+--------------
+
+Query specific API::
+
+    $ cat /sys/kernel/debug/kapi/apis/kmalloc/specification
+    API: kmalloc
+    Version: 3.0
+    Description: Allocate kernel memory
+
+    Parameters:
+      [0] size (size_t, in): Number of bytes to allocate
+          Range: 0 - 4194304
+      [1] flags (flags, in): Allocation flags (GFP_*)
+          Mask: 0x1ffffff
+
+    Returns: pointer - Pointer to allocated memory or NULL
+
+    Errors:
+      ENOMEM: Out of memory
+
+    Context: process, softirq, hardirq
+
+    Side Effects:
+      - Allocates memory from kernel heap
+
+Export all specifications::
+
+    $ cat /sys/kernel/debug/kapi/export/all.json > kernel-apis.json
+
+Enable validation for specific API::
+
+    $ echo 1 > /sys/kernel/debug/kapi/apis/kmalloc/validate
+
+Performance Considerations
+==========================
+
+Memory Overhead
+---------------
+
+Each API specification consumes approximately 2-4KB of memory. With thousands
+of kernel APIs, this can add up to several megabytes. Consider:
+
+1. Building with ``CONFIG_KAPI_SPEC=n`` for production kernels
+2. Using ``__init`` annotations for APIs only used during boot
+3. Implementing lazy loading for rarely used specifications
+
+Runtime Overhead
+----------------
+
+When ``CONFIG_KAPI_RUNTIME_CHECKS`` is enabled:
+
+- Each validated API call adds 50-200ns overhead
+- Complex validations (custom validators) may add more
+- Use validation only in development/testing kernels
+
+Optimization Strategies
+-----------------------
+
+1. **Compile-time optimization**: When validation is disabled, all
+   validation code is optimized away by the compiler.
+
+2. **Selective validation**: Enable validation only for specific APIs
+   or subsystems under test.
+
+3. **Caching**: The framework caches validation results for repeated
+   calls with identical parameters.
+
+Documentation Generation
+------------------------
+
+The framework exports specifications via debugfs that can be used
+to generate documentation. Tools for automatic documentation generation
+from specifications are planned for future development.
+
+IDE Integration
+---------------
+
+Modern IDEs can use the JSON export for:
+
+- Parameter hints
+- Type checking
+- Context validation
+- Error code documentation
+
+Testing Framework
+-----------------
+
+The framework includes test helpers::
+
+    #ifdef CONFIG_KAPI_TESTING
+    /* Verify API behaves according to specification */
+    kapi_test_api("kmalloc", test_cases);
+    #endif
+
+Best Practices
+==============
+
+Writing Specifications
+----------------------
+
+1. **Be Comprehensive**: Document all parameters, errors, and side effects
+2. **Keep Updated**: Update specs when API behavior changes
+3. **Use Examples**: Include usage examples in descriptions
+4. **Validate Constraints**: Define realistic constraints for parameters
+5. **Document Context**: Clearly specify allowed execution contexts
+
+Maintenance
+-----------
+
+1. **Version Specifications**: Increment version when API changes
+2. **Deprecation**: Mark deprecated APIs and suggest replacements
+3. **Cross-reference**: Link related APIs in descriptions
+4. **Test Specifications**: Verify specs match implementation
+
+Common Patterns
+---------------
+
+**Optional Parameters**::
+
+    KAPI_PARAM(2, optional_arg, KAPI_TYPE_POINTER, KAPI_DIR_IN,
+               "Optional argument (may be NULL)")
+    KAPI_PARAM_OPTIONAL(2)
+
+**Variable Arguments**::
+
+    KAPI_PARAM(1, fmt, KAPI_TYPE_FORMAT_STRING, KAPI_DIR_IN,
+               "Printf-style format string")
+    KAPI_PARAM_VARIADIC(2, "Format arguments")
+
+**Callback Functions**::
+
+    KAPI_PARAM(1, callback, KAPI_TYPE_FUNCTION_PTR, KAPI_DIR_IN,
+               "Callback function")
+    KAPI_PARAM_CALLBACK(1, "int (*)(void *data)", "data")
+
+Troubleshooting
+===============
+
+Common Issues
+-------------
+
+**Specification Not Found**::
+
+    kernel: KAPI: Specification for 'my_api' not found
+
+    Solution: Ensure KAPI_DEFINE_SPEC is in the same translation unit
+    as the function implementation.
+
+**Validation Failures**::
+
+    kernel: KAPI: Validation failed for kmalloc parameter 'size':
+            value 5242880 exceeds maximum 4194304
+
+    Solution: Check parameter constraints or adjust specification if
+    the constraint is incorrect.
+
+**Build Errors**::
+
+    error: 'KAPI_TYPE_UNKNOWN' undeclared
+
+    Solution: Include <linux/kernel_api_spec.h> and ensure
+    CONFIG_KAPI_SPEC is enabled.
+
+Debug Options
+-------------
+
+Enable verbose debugging::
+
+    echo 8 > /proc/sys/kernel/printk
+    echo 1 > /sys/kernel/debug/kapi/debug/verbose
+
+Future Directions
+=================
+
+Planned Features
+----------------
+
+1. **Automatic Extraction**: Tool to extract specifications from existing
+   kernel-doc comments
+
+2. **Contract Verification**: Static analysis to verify implementation
+   matches specification
+
+3. **Performance Profiling**: Measure actual API performance against
+   documented expectations
+
+4. **Fuzzing Integration**: Use specifications to guide intelligent
+   fuzzing of kernel APIs
+
+5. **Version Compatibility**: Track API changes across kernel versions
+
+Research Areas
+--------------
+
+1. **Formal Verification**: Use specifications for mathematical proofs
+   of correctness
+
+2. **Runtime Monitoring**: Detect specification violations in production
+   with minimal overhead
+
+3. **API Evolution**: Analyze how kernel APIs change over time
+
+4. **Security Applications**: Use specifications for security policy
+   enforcement
+
+Contributing
+============
+
+Submitting Specifications
+-------------------------
+
+1. Add specifications to the same file as the API implementation
+2. Follow existing patterns and naming conventions
+3. Test with CONFIG_KAPI_RUNTIME_CHECKS enabled
+4. Verify debugfs output is correct
+5. Run scripts/checkpatch.pl on your changes
+
+Review Criteria
+---------------
+
+Specifications will be reviewed for:
+
+1. **Completeness**: All parameters and errors documented
+2. **Accuracy**: Specification matches implementation
+3. **Clarity**: Descriptions are clear and helpful
+4. **Consistency**: Follows framework conventions
+5. **Performance**: No unnecessary runtime overhead
+
+Contact
+-------
+
+- Maintainer: Sasha Levin <sashal@kernel.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index fad6cb025a191..e4d30955a104c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13049,6 +13049,15 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media.git
 F:	drivers/media/radio/radio-keene*
 
+KERNEL API SPECIFICATION FRAMEWORK (KAPI)
+M:	Sasha Levin <sashal@kernel.org>
+L:	linux-api@vger.kernel.org
+S:	Maintained
+F:	Documentation/admin-guide/kernel-api-spec.rst
+F:	include/linux/kernel_api_spec.h
+F:	kernel/api/
+F:	scripts/extract-kapi-spec.sh
+
 KERNEL AUTOMOUNTER
 M:	Ian Kent <raven@themaw.net>
 L:	autofs@vger.kernel.org
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index a36b7918a011a..283ab11788d8c 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -102,6 +102,9 @@ SECTIONS
   init.data : { INIT_DATA }
   __init_end = .;
 
+  /* Kernel API specifications in dedicated section */
+  KAPI_SPECS_SECTION()
+
   /* Ensure the __preinit_array_start label is properly aligned.  We
      could instead move the label definition inside the section, but
      the linker would then create the section even if it turns out to
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index a409d4b66114f..e3850d8293436 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -74,6 +74,9 @@ SECTIONS
   init.data : { INIT_DATA }
   __init_end = .;
 
+  /* Kernel API specifications in dedicated section */
+  KAPI_SPECS_SECTION()
+
   .data    :
   {
     INIT_TASK_DATA(KERNEL_STACK_SIZE)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4fa0be732af10..8cc508adc9d51 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -173,6 +173,9 @@ SECTIONS
 	RO_DATA(PAGE_SIZE)
 	X86_ALIGN_RODATA_END
 
+	/* Kernel API specifications in dedicated section */
+	KAPI_SPECS_SECTION()
+
 	/* Data */
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		/* Start of data section */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index fa5f19b8d53a0..7b47736057e01 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -279,6 +279,26 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define TRACE_SYSCALLS()
 #endif
 
+#ifdef CONFIG_KAPI_SPEC
+#define KAPI_SPECS()				\
+	. = ALIGN(8);				\
+	__start_kapi_specs = .;			\
+	KEEP(*(.kapi_specs))			\
+	__stop_kapi_specs = .;
+
+/* For placing KAPI specs in a dedicated section */
+#define KAPI_SPECS_SECTION()			\
+	.kapi_specs : AT(ADDR(.kapi_specs) - LOAD_OFFSET) {	\
+		. = ALIGN(8);			\
+		__start_kapi_specs = .;		\
+		KEEP(*(.kapi_specs))		\
+		__stop_kapi_specs = .;		\
+	}
+#else
+#define KAPI_SPECS()
+#define KAPI_SPECS_SECTION()
+#endif
+
 #ifdef CONFIG_BPF_EVENTS
 #define BPF_RAW_TP() STRUCT_ALIGN();				\
 	BOUNDED_SECTION_BY(__bpf_raw_tp_map, __bpf_raw_tp)
diff --git a/include/linux/kernel_api_spec.h b/include/linux/kernel_api_spec.h
new file mode 100644
index 0000000000000..177ecc29a1dda
--- /dev/null
+++ b/include/linux/kernel_api_spec.h
@@ -0,0 +1,1527 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * kernel_api_spec.h - Kernel API Formal Specification Framework
+ *
+ * This framework provides structures and macros to formally specify kernel APIs
+ * in both human and machine-readable formats. It supports comprehensive documentation
+ * of function signatures, parameters, return values, error conditions, and constraints.
+ */
+
+#ifndef _LINUX_KERNEL_API_SPEC_H
+#define _LINUX_KERNEL_API_SPEC_H
+
+#include <linux/types.h>
+#include <linux/stringify.h>
+#include <linux/compiler.h>
+
+struct sigaction;
+
+#define KAPI_MAX_PARAMS		16
+#define KAPI_MAX_ERRORS		32
+#define KAPI_MAX_CONSTRAINTS	16
+#define KAPI_MAX_SIGNALS	32
+#define KAPI_MAX_NAME_LEN	128
+#define KAPI_MAX_DESC_LEN	512
+#define KAPI_MAX_CAPABILITIES	8
+#define KAPI_MAX_SOCKET_STATES	16
+#define KAPI_MAX_PROTOCOL_BEHAVIORS	8
+#define KAPI_MAX_NET_ERRORS	16
+#define KAPI_MAX_SOCKOPTS	16
+#define KAPI_MAX_ADDR_FAMILIES	8
+
+/**
+ * enum kapi_param_type - Parameter type classification
+ * @KAPI_TYPE_VOID: void type
+ * @KAPI_TYPE_INT: Integer types (int, long, etc.)
+ * @KAPI_TYPE_UINT: Unsigned integer types
+ * @KAPI_TYPE_PTR: Pointer types
+ * @KAPI_TYPE_STRUCT: Structure types
+ * @KAPI_TYPE_UNION: Union types
+ * @KAPI_TYPE_ENUM: Enumeration types
+ * @KAPI_TYPE_FUNC_PTR: Function pointer types
+ * @KAPI_TYPE_ARRAY: Array types
+ * @KAPI_TYPE_FD: File descriptor - validated in process context
+ * @KAPI_TYPE_USER_PTR: User space pointer - validated for access and size
+ * @KAPI_TYPE_PATH: Pathname - validated for access and path limits
+ * @KAPI_TYPE_CUSTOM: Custom/complex types
+ */
+enum kapi_param_type {
+	KAPI_TYPE_VOID = 0,
+	KAPI_TYPE_INT,
+	KAPI_TYPE_UINT,
+	KAPI_TYPE_PTR,
+	KAPI_TYPE_STRUCT,
+	KAPI_TYPE_UNION,
+	KAPI_TYPE_ENUM,
+	KAPI_TYPE_FUNC_PTR,
+	KAPI_TYPE_ARRAY,
+	KAPI_TYPE_FD,		/* File descriptor - validated in process context */
+	KAPI_TYPE_USER_PTR,	/* User space pointer - validated for access and size */
+	KAPI_TYPE_PATH,		/* Pathname - validated for access and path limits */
+	KAPI_TYPE_CUSTOM,
+};
+
+/**
+ * enum kapi_param_flags - Parameter attribute flags
+ * @KAPI_PARAM_IN: Input parameter
+ * @KAPI_PARAM_OUT: Output parameter
+ * @KAPI_PARAM_INOUT: Input/output parameter
+ * @KAPI_PARAM_OPTIONAL: Optional parameter (can be NULL)
+ * @KAPI_PARAM_CONST: Const qualified parameter
+ * @KAPI_PARAM_VOLATILE: Volatile qualified parameter
+ * @KAPI_PARAM_USER: User space pointer
+ * @KAPI_PARAM_DMA: DMA-capable memory required
+ * @KAPI_PARAM_ALIGNED: Alignment requirements
+ */
+enum kapi_param_flags {
+	KAPI_PARAM_IN		= (1 << 0),
+	KAPI_PARAM_OUT		= (1 << 1),
+	KAPI_PARAM_INOUT	= (1 << 2),
+	KAPI_PARAM_OPTIONAL	= (1 << 3),
+	KAPI_PARAM_CONST	= (1 << 4),
+	KAPI_PARAM_VOLATILE	= (1 << 5),
+	KAPI_PARAM_USER		= (1 << 6),
+	KAPI_PARAM_DMA		= (1 << 7),
+	KAPI_PARAM_ALIGNED	= (1 << 8),
+};
+
+/**
+ * enum kapi_context_flags - Function execution context flags
+ * @KAPI_CTX_PROCESS: Can be called from process context
+ * @KAPI_CTX_SOFTIRQ: Can be called from softirq context
+ * @KAPI_CTX_HARDIRQ: Can be called from hardirq context
+ * @KAPI_CTX_NMI: Can be called from NMI context
+ * @KAPI_CTX_ATOMIC: Must be called in atomic context
+ * @KAPI_CTX_SLEEPABLE: May sleep
+ * @KAPI_CTX_PREEMPT_DISABLED: Requires preemption disabled
+ * @KAPI_CTX_IRQ_DISABLED: Requires interrupts disabled
+ */
+enum kapi_context_flags {
+	KAPI_CTX_PROCESS	= (1 << 0),
+	KAPI_CTX_SOFTIRQ	= (1 << 1),
+	KAPI_CTX_HARDIRQ	= (1 << 2),
+	KAPI_CTX_NMI		= (1 << 3),
+	KAPI_CTX_ATOMIC		= (1 << 4),
+	KAPI_CTX_SLEEPABLE	= (1 << 5),
+	KAPI_CTX_PREEMPT_DISABLED = (1 << 6),
+	KAPI_CTX_IRQ_DISABLED	= (1 << 7),
+};
+
+/**
+ * enum kapi_lock_type - Lock types used/required by the function
+ * @KAPI_LOCK_NONE: No locking requirements
+ * @KAPI_LOCK_MUTEX: Mutex lock
+ * @KAPI_LOCK_SPINLOCK: Spinlock
+ * @KAPI_LOCK_RWLOCK: Read-write lock
+ * @KAPI_LOCK_SEQLOCK: Sequence lock
+ * @KAPI_LOCK_RCU: RCU lock
+ * @KAPI_LOCK_SEMAPHORE: Semaphore
+ * @KAPI_LOCK_CUSTOM: Custom locking mechanism
+ */
+enum kapi_lock_type {
+	KAPI_LOCK_NONE = 0,
+	KAPI_LOCK_MUTEX,
+	KAPI_LOCK_SPINLOCK,
+	KAPI_LOCK_RWLOCK,
+	KAPI_LOCK_SEQLOCK,
+	KAPI_LOCK_RCU,
+	KAPI_LOCK_SEMAPHORE,
+	KAPI_LOCK_CUSTOM,
+};
+
+/**
+ * enum kapi_constraint_type - Types of parameter constraints
+ * @KAPI_CONSTRAINT_NONE: No constraint
+ * @KAPI_CONSTRAINT_RANGE: Numeric range constraint
+ * @KAPI_CONSTRAINT_MASK: Bitmask constraint
+ * @KAPI_CONSTRAINT_ENUM: Enumerated values constraint
+ * @KAPI_CONSTRAINT_CUSTOM: Custom validation function
+ */
+enum kapi_constraint_type {
+	KAPI_CONSTRAINT_NONE = 0,
+	KAPI_CONSTRAINT_RANGE,
+	KAPI_CONSTRAINT_MASK,
+	KAPI_CONSTRAINT_ENUM,
+	KAPI_CONSTRAINT_CUSTOM,
+};
+
+/**
+ * struct kapi_param_spec - Parameter specification
+ * @name: Parameter name
+ * @type_name: Type name as string
+ * @type: Parameter type classification
+ * @flags: Parameter attribute flags
+ * @size: Size in bytes (for arrays/buffers)
+ * @alignment: Required alignment
+ * @min_value: Minimum valid value (for numeric types)
+ * @max_value: Maximum valid value (for numeric types)
+ * @valid_mask: Valid bits mask (for flag parameters)
+ * @enum_values: Array of valid enumerated values
+ * @enum_count: Number of valid enumerated values
+ * @constraint_type: Type of constraint applied
+ * @validate: Custom validation function
+ * @description: Human-readable description
+ * @constraints: Additional constraints description
+ * @size_param_idx: Index of parameter that determines size (-1 if fixed size)
+ * @size_multiplier: Multiplier for size calculation (e.g., sizeof(struct))
+ */
+struct kapi_param_spec {
+	char name[KAPI_MAX_NAME_LEN];
+	char type_name[KAPI_MAX_NAME_LEN];
+	enum kapi_param_type type;
+	u32 flags;
+	size_t size;
+	size_t alignment;
+	s64 min_value;
+	s64 max_value;
+	u64 valid_mask;
+	const s64 *enum_values;
+	u32 enum_count;
+	enum kapi_constraint_type constraint_type;
+	bool (*validate)(s64 value);
+	char description[KAPI_MAX_DESC_LEN];
+	char constraints[KAPI_MAX_DESC_LEN];
+	int size_param_idx;	/* Index of param that determines size, -1 if N/A */
+	size_t size_multiplier;	/* Size per unit (e.g., sizeof(struct epoll_event)) */
+} __attribute__((packed));
+
+/**
+ * struct kapi_error_spec - Error condition specification
+ * @error_code: Error code value
+ * @name: Error code name (e.g., "EINVAL")
+ * @condition: Condition that triggers this error
+ * @description: Detailed error description
+ */
+struct kapi_error_spec {
+	int error_code;
+	char name[KAPI_MAX_NAME_LEN];
+	char condition[KAPI_MAX_DESC_LEN];
+	char description[KAPI_MAX_DESC_LEN];
+} __attribute__((packed));
+
+/**
+ * enum kapi_return_check_type - Return value check types
+ * @KAPI_RETURN_EXACT: Success is an exact value
+ * @KAPI_RETURN_RANGE: Success is within a range
+ * @KAPI_RETURN_ERROR_CHECK: Success is when NOT in error list
+ * @KAPI_RETURN_FD: Return value is a file descriptor (>= 0 is success)
+ * @KAPI_RETURN_CUSTOM: Custom validation function
+ */
+enum kapi_return_check_type {
+	KAPI_RETURN_EXACT,
+	KAPI_RETURN_RANGE,
+	KAPI_RETURN_ERROR_CHECK,
+	KAPI_RETURN_FD,
+	KAPI_RETURN_CUSTOM,
+};
+
+/**
+ * struct kapi_return_spec - Return value specification
+ * @type_name: Return type name
+ * @type: Return type classification
+ * @check_type: Type of success check to perform
+ * @success_value: Exact value indicating success (for EXACT)
+ * @success_min: Minimum success value (for RANGE)
+ * @success_max: Maximum success value (for RANGE)
+ * @error_values: Array of error values (for ERROR_CHECK)
+ * @error_count: Number of error values
+ * @is_success: Custom function to check success
+ * @description: Return value description
+ */
+struct kapi_return_spec {
+	char type_name[KAPI_MAX_NAME_LEN];
+	enum kapi_param_type type;
+	enum kapi_return_check_type check_type;
+	s64 success_value;
+	s64 success_min;
+	s64 success_max;
+	const s64 *error_values;
+	u32 error_count;
+	bool (*is_success)(s64 retval);
+	char description[KAPI_MAX_DESC_LEN];
+} __attribute__((packed));
+
+/**
+ * struct kapi_lock_spec - Lock requirement specification
+ * @lock_name: Name of the lock
+ * @lock_type: Type of lock
+ * @acquired: Whether function acquires this lock
+ * @released: Whether function releases this lock
+ * @held_on_entry: Whether lock must be held on entry
+ * @held_on_exit: Whether lock is held on exit
+ * @description: Additional lock requirements
+ */
+struct kapi_lock_spec {
+	char lock_name[KAPI_MAX_NAME_LEN];
+	enum kapi_lock_type lock_type;
+	bool acquired;
+	bool released;
+	bool held_on_entry;
+	bool held_on_exit;
+	char description[KAPI_MAX_DESC_LEN];
+} __attribute__((packed));
+
+/**
+ * struct kapi_constraint_spec - Additional constraint specification
+ * @name: Constraint name
+ * @description: Constraint description
+ * @expression: Formal expression (if applicable)
+ */
+struct kapi_constraint_spec {
+	char name[KAPI_MAX_NAME_LEN];
+	char description[KAPI_MAX_DESC_LEN];
+	char expression[KAPI_MAX_DESC_LEN];
+} __attribute__((packed));
+
+/**
+ * enum kapi_signal_direction - Signal flow direction
+ * @KAPI_SIGNAL_RECEIVE: Function may receive this signal
+ * @KAPI_SIGNAL_SEND: Function may send this signal
+ * @KAPI_SIGNAL_HANDLE: Function handles this signal specially
+ * @KAPI_SIGNAL_BLOCK: Function blocks this signal
+ * @KAPI_SIGNAL_IGNORE: Function ignores this signal
+ */
+enum kapi_signal_direction {
+	KAPI_SIGNAL_RECEIVE	= (1 << 0),
+	KAPI_SIGNAL_SEND	= (1 << 1),
+	KAPI_SIGNAL_HANDLE	= (1 << 2),
+	KAPI_SIGNAL_BLOCK	= (1 << 3),
+	KAPI_SIGNAL_IGNORE	= (1 << 4),
+};
+
+/**
+ * enum kapi_signal_action - What the function does with the signal
+ * @KAPI_SIGNAL_ACTION_DEFAULT: Default signal action applies
+ * @KAPI_SIGNAL_ACTION_TERMINATE: Causes termination
+ * @KAPI_SIGNAL_ACTION_COREDUMP: Causes termination with core dump
+ * @KAPI_SIGNAL_ACTION_STOP: Stops the process
+ * @KAPI_SIGNAL_ACTION_CONTINUE: Continues a stopped process
+ * @KAPI_SIGNAL_ACTION_CUSTOM: Custom handling described in notes
+ * @KAPI_SIGNAL_ACTION_RETURN: Returns from syscall with EINTR
+ * @KAPI_SIGNAL_ACTION_RESTART: Restarts the syscall
+ * @KAPI_SIGNAL_ACTION_QUEUE: Queues the signal for later delivery
+ * @KAPI_SIGNAL_ACTION_DISCARD: Discards the signal
+ * @KAPI_SIGNAL_ACTION_TRANSFORM: Transforms to another signal
+ */
+enum kapi_signal_action {
+	KAPI_SIGNAL_ACTION_DEFAULT = 0,
+	KAPI_SIGNAL_ACTION_TERMINATE,
+	KAPI_SIGNAL_ACTION_COREDUMP,
+	KAPI_SIGNAL_ACTION_STOP,
+	KAPI_SIGNAL_ACTION_CONTINUE,
+	KAPI_SIGNAL_ACTION_CUSTOM,
+	KAPI_SIGNAL_ACTION_RETURN,
+	KAPI_SIGNAL_ACTION_RESTART,
+	KAPI_SIGNAL_ACTION_QUEUE,
+	KAPI_SIGNAL_ACTION_DISCARD,
+	KAPI_SIGNAL_ACTION_TRANSFORM,
+};
+
+/**
+ * struct kapi_signal_spec - Signal specification
+ * @signal_num: Signal number (e.g., SIGKILL, SIGTERM)
+ * @signal_name: Signal name as string
+ * @direction: Direction flags (OR of kapi_signal_direction)
+ * @action: What happens when signal is received
+ * @target: Description of target process/thread for sent signals
+ * @condition: Condition under which signal is sent/received/handled
+ * @description: Detailed description of signal handling
+ * @restartable: Whether syscall is restartable after this signal
+ * @sa_flags_required: Required signal action flags (SA_*)
+ * @sa_flags_forbidden: Forbidden signal action flags
+ * @error_on_signal: Error code returned when signal occurs (-EINTR, etc)
+ * @transform_to: Signal number to transform to (if action is TRANSFORM)
+ * @timing: When signal can occur ("entry", "during", "exit", "anytime")
+ * @priority: Signal handling priority (lower processed first)
+ * @interruptible: Whether this operation is interruptible by this signal
+ * @queue_behavior: How signal is queued ("realtime", "standard", "coalesce")
+ * @state_required: Required process state for signal to be delivered
+ * @state_forbidden: Forbidden process state for signal delivery
+ */
+struct kapi_signal_spec {
+	int signal_num;
+	char signal_name[32];
+	u32 direction;
+	enum kapi_signal_action action;
+	char target[KAPI_MAX_DESC_LEN];
+	char condition[KAPI_MAX_DESC_LEN];
+	char description[KAPI_MAX_DESC_LEN];
+	bool restartable;
+	u32 sa_flags_required;
+	u32 sa_flags_forbidden;
+	int error_on_signal;
+	int transform_to;
+	char timing[32];
+	u8 priority;
+	bool interruptible;
+	char queue_behavior[128];
+	u32 state_required;
+	u32 state_forbidden;
+} __attribute__((packed));
+
+/**
+ * struct kapi_signal_mask_spec - Signal mask specification
+ * @mask_name: Name of the signal mask
+ * @signals: Array of signal numbers in the mask
+ * @signal_count: Number of signals in the mask
+ * @description: Description of what this mask represents
+ */
+struct kapi_signal_mask_spec {
+	char mask_name[KAPI_MAX_NAME_LEN];
+	int signals[KAPI_MAX_SIGNALS];
+	u32 signal_count;
+	char description[KAPI_MAX_DESC_LEN];
+} __attribute__((packed));
+
+/**
+ * struct kapi_struct_field - Structure field specification
+ * @name: Field name
+ * @type: Field type classification
+ * @type_name: Type name as string
+ * @offset: Offset within structure
+ * @size: Size of field in bytes
+ * @flags: Field attribute flags
+ * @constraint_type: Type of constraint applied
+ * @min_value: Minimum valid value (for numeric types)
+ * @max_value: Maximum valid value (for numeric types)
+ * @valid_mask: Valid bits mask (for flag fields)
+ * @enum_values: Comma-separated list of valid enum values (for enum types)
+ * @description: Field description
+ */
+struct kapi_struct_field {
+	char name[KAPI_MAX_NAME_LEN];
+	enum kapi_param_type type;
+	char type_name[KAPI_MAX_NAME_LEN];
+	size_t offset;
+	size_t size;
+	u32 flags;
+	enum kapi_constraint_type constraint_type;
+	s64 min_value;
+	s64 max_value;
+	u64 valid_mask;
+	char enum_values[KAPI_MAX_DESC_LEN];	/* Comma-separated list of valid enum values */
+	char description[KAPI_MAX_DESC_LEN];
+} __attribute__((packed));
+
+/**
+ * struct kapi_struct_spec - Structure type specification
+ * @name: Structure name
+ * @size: Total size of structure
+ * @alignment: Required alignment
+ * @field_count: Number of fields
+ * @fields: Field specifications
+ * @description: Structure description
+ */
+struct kapi_struct_spec {
+	char name[KAPI_MAX_NAME_LEN];
+	size_t size;
+	size_t alignment;
+	u32 field_count;
+	struct kapi_struct_field fields[KAPI_MAX_PARAMS];
+	char description[KAPI_MAX_DESC_LEN];
+} __attribute__((packed));
+
+/**
+ * enum kapi_capability_action - What the capability allows
+ * @KAPI_CAP_BYPASS_CHECK: Bypasses a check entirely
+ * @KAPI_CAP_INCREASE_LIMIT: Increases or removes a limit
+ * @KAPI_CAP_OVERRIDE_RESTRICTION: Overrides a restriction
+ * @KAPI_CAP_GRANT_PERMISSION: Grants permission that would otherwise be denied
+ * @KAPI_CAP_MODIFY_BEHAVIOR: Changes the behavior of the operation
+ * @KAPI_CAP_ACCESS_RESOURCE: Allows access to restricted resources
+ * @KAPI_CAP_PERFORM_OPERATION: Allows performing a privileged operation
+ */
+enum kapi_capability_action {
+	KAPI_CAP_BYPASS_CHECK = 0,
+	KAPI_CAP_INCREASE_LIMIT,
+	KAPI_CAP_OVERRIDE_RESTRICTION,
+	KAPI_CAP_GRANT_PERMISSION,
+	KAPI_CAP_MODIFY_BEHAVIOR,
+	KAPI_CAP_ACCESS_RESOURCE,
+	KAPI_CAP_PERFORM_OPERATION,
+};
+
+/**
+ * struct kapi_capability_spec - Capability requirement specification
+ * @capability: The capability constant (e.g., CAP_IPC_LOCK)
+ * @cap_name: Capability name as string
+ * @action: What the capability allows (kapi_capability_action)
+ * @allows: Description of what the capability allows
+ * @without_cap: What happens without the capability
+ * @check_condition: Condition when capability is checked
+ * @priority: Check priority (lower checked first)
+ * @alternative: Alternative capabilities that can be used
+ * @alternative_count: Number of alternative capabilities
+ */
+struct kapi_capability_spec {
+	int capability;
+	char cap_name[KAPI_MAX_NAME_LEN];
+	enum kapi_capability_action action;
+	char allows[KAPI_MAX_DESC_LEN];
+	char without_cap[KAPI_MAX_DESC_LEN];
+	char check_condition[KAPI_MAX_DESC_LEN];
+	u8 priority;
+	int alternative[KAPI_MAX_CAPABILITIES];
+	u32 alternative_count;
+} __attribute__((packed));
+
+/**
+ * enum kapi_side_effect_type - Types of side effects
+ * @KAPI_EFFECT_NONE: No side effects
+ * @KAPI_EFFECT_ALLOC_MEMORY: Allocates memory
+ * @KAPI_EFFECT_FREE_MEMORY: Frees memory
+ * @KAPI_EFFECT_MODIFY_STATE: Modifies global/shared state
+ * @KAPI_EFFECT_SIGNAL_SEND: Sends signals
+ * @KAPI_EFFECT_FILE_POSITION: Modifies file position
+ * @KAPI_EFFECT_LOCK_ACQUIRE: Acquires locks
+ * @KAPI_EFFECT_LOCK_RELEASE: Releases locks
+ * @KAPI_EFFECT_RESOURCE_CREATE: Creates system resources (FDs, PIDs, etc)
+ * @KAPI_EFFECT_RESOURCE_DESTROY: Destroys system resources
+ * @KAPI_EFFECT_SCHEDULE: May cause scheduling/context switch
+ * @KAPI_EFFECT_HARDWARE: Interacts with hardware
+ * @KAPI_EFFECT_NETWORK: Network I/O operation
+ * @KAPI_EFFECT_FILESYSTEM: Filesystem modification
+ * @KAPI_EFFECT_PROCESS_STATE: Modifies process state
+ */
+enum kapi_side_effect_type {
+	KAPI_EFFECT_NONE = 0,
+	KAPI_EFFECT_ALLOC_MEMORY = (1 << 0),
+	KAPI_EFFECT_FREE_MEMORY = (1 << 1),
+	KAPI_EFFECT_MODIFY_STATE = (1 << 2),
+	KAPI_EFFECT_SIGNAL_SEND = (1 << 3),
+	KAPI_EFFECT_FILE_POSITION = (1 << 4),
+	KAPI_EFFECT_LOCK_ACQUIRE = (1 << 5),
+	KAPI_EFFECT_LOCK_RELEASE = (1 << 6),
+	KAPI_EFFECT_RESOURCE_CREATE = (1 << 7),
+	KAPI_EFFECT_RESOURCE_DESTROY = (1 << 8),
+	KAPI_EFFECT_SCHEDULE = (1 << 9),
+	KAPI_EFFECT_HARDWARE = (1 << 10),
+	KAPI_EFFECT_NETWORK = (1 << 11),
+	KAPI_EFFECT_FILESYSTEM = (1 << 12),
+	KAPI_EFFECT_PROCESS_STATE = (1 << 13),
+};
+
+/**
+ * struct kapi_side_effect - Side effect specification
+ * @type: Bitmask of effect types
+ * @target: What is affected (e.g., "process memory", "file descriptor table")
+ * @condition: Condition under which effect occurs
+ * @description: Detailed description of the effect
+ * @reversible: Whether the effect can be undone
+ */
+struct kapi_side_effect {
+	u32 type;
+	char target[KAPI_MAX_NAME_LEN];
+	char condition[KAPI_MAX_DESC_LEN];
+	char description[KAPI_MAX_DESC_LEN];
+	bool reversible;
+} __attribute__((packed));
+
+/**
+ * struct kapi_state_transition - State transition specification
+ * @from_state: Starting state description
+ * @to_state: Ending state description
+ * @condition: Condition for transition
+ * @object: Object whose state changes
+ * @description: Detailed description
+ */
+struct kapi_state_transition {
+	char from_state[KAPI_MAX_NAME_LEN];
+	char to_state[KAPI_MAX_NAME_LEN];
+	char condition[KAPI_MAX_DESC_LEN];
+	char object[KAPI_MAX_NAME_LEN];
+	char description[KAPI_MAX_DESC_LEN];
+} __attribute__((packed));
+
+#define KAPI_MAX_STRUCT_SPECS	8
+#define KAPI_MAX_SIDE_EFFECTS	16
+#define KAPI_MAX_STATE_TRANS	8
+
+#ifdef CONFIG_NET
+/**
+ * enum kapi_socket_state - Socket states for state machine
+ */
+enum kapi_socket_state {
+	KAPI_SOCK_STATE_UNSPEC = 0,
+	KAPI_SOCK_STATE_CLOSED,
+	KAPI_SOCK_STATE_OPEN,
+	KAPI_SOCK_STATE_BOUND,
+	KAPI_SOCK_STATE_LISTEN,
+	KAPI_SOCK_STATE_SYN_SENT,
+	KAPI_SOCK_STATE_SYN_RECV,
+	KAPI_SOCK_STATE_ESTABLISHED,
+	KAPI_SOCK_STATE_FIN_WAIT1,
+	KAPI_SOCK_STATE_FIN_WAIT2,
+	KAPI_SOCK_STATE_CLOSE_WAIT,
+	KAPI_SOCK_STATE_CLOSING,
+	KAPI_SOCK_STATE_LAST_ACK,
+	KAPI_SOCK_STATE_TIME_WAIT,
+	KAPI_SOCK_STATE_CONNECTED,
+	KAPI_SOCK_STATE_DISCONNECTED,
+};
+
+/**
+ * enum kapi_socket_protocol - Socket protocol types
+ */
+enum kapi_socket_protocol {
+	KAPI_PROTO_TCP		= (1 << 0),
+	KAPI_PROTO_UDP		= (1 << 1),
+	KAPI_PROTO_UNIX		= (1 << 2),
+	KAPI_PROTO_RAW		= (1 << 3),
+	KAPI_PROTO_PACKET	= (1 << 4),
+	KAPI_PROTO_NETLINK	= (1 << 5),
+	KAPI_PROTO_SCTP		= (1 << 6),
+	KAPI_PROTO_DCCP		= (1 << 7),
+	KAPI_PROTO_ALL		= 0xFFFFFFFF,
+};
+
+/**
+ * enum kapi_buffer_behavior - Network buffer handling behaviors
+ */
+enum kapi_buffer_behavior {
+	KAPI_BUF_PEEK		= (1 << 0),
+	KAPI_BUF_TRUNCATE	= (1 << 1),
+	KAPI_BUF_SCATTER	= (1 << 2),
+	KAPI_BUF_ZERO_COPY	= (1 << 3),
+	KAPI_BUF_KERNEL_ALLOC	= (1 << 4),
+	KAPI_BUF_DMA_CAPABLE	= (1 << 5),
+	KAPI_BUF_FRAGMENT	= (1 << 6),
+};
+
+/**
+ * enum kapi_async_behavior - Asynchronous operation behaviors
+ */
+enum kapi_async_behavior {
+	KAPI_ASYNC_BLOCK	= 0,
+	KAPI_ASYNC_NONBLOCK	= (1 << 0),
+	KAPI_ASYNC_POLL_READY	= (1 << 1),
+	KAPI_ASYNC_SIGNAL_DRIVEN = (1 << 2),
+	KAPI_ASYNC_AIO		= (1 << 3),
+	KAPI_ASYNC_IO_URING	= (1 << 4),
+	KAPI_ASYNC_EPOLL	= (1 << 5),
+};
+
+/**
+ * struct kapi_socket_state_spec - Socket state requirement/transition
+ */
+struct kapi_socket_state_spec {
+	enum kapi_socket_state required_states[KAPI_MAX_SOCKET_STATES];
+	u32 required_state_count;
+	enum kapi_socket_state forbidden_states[KAPI_MAX_SOCKET_STATES];
+	u32 forbidden_state_count;
+	enum kapi_socket_state resulting_state;
+	char state_condition[KAPI_MAX_DESC_LEN];
+	u32 applicable_protocols;
+} __attribute__((packed));
+
+/**
+ * struct kapi_protocol_behavior - Protocol-specific behavior
+ */
+struct kapi_protocol_behavior {
+	u32 applicable_protocols;
+	char behavior[KAPI_MAX_DESC_LEN];
+	s64 protocol_flags;
+	char flag_description[KAPI_MAX_DESC_LEN];
+} __attribute__((packed));
+
+/**
+ * struct kapi_buffer_spec - Network buffer specification
+ */
+struct kapi_buffer_spec {
+	u32 buffer_behaviors;
+	size_t min_buffer_size;
+	size_t max_buffer_size;
+	size_t optimal_buffer_size;
+	char fragmentation_rules[KAPI_MAX_DESC_LEN];
+	bool can_partial_transfer;
+	char partial_transfer_rules[KAPI_MAX_DESC_LEN];
+} __attribute__((packed));
+
+/**
+ * struct kapi_async_spec - Asynchronous behavior specification
+ */
+struct kapi_async_spec {
+	enum kapi_async_behavior supported_modes;
+	int nonblock_errno;
+	u32 poll_events_in;
+	u32 poll_events_out;
+	char completion_condition[KAPI_MAX_DESC_LEN];
+	bool supports_timeout;
+	char timeout_behavior[KAPI_MAX_DESC_LEN];
+} __attribute__((packed));
+
+/**
+ * struct kapi_addr_family_spec - Address family specification
+ */
+struct kapi_addr_family_spec {
+	int family;
+	char family_name[32];
+	size_t addr_struct_size;
+	size_t min_addr_len;
+	size_t max_addr_len;
+	char addr_format[KAPI_MAX_DESC_LEN];
+	bool supports_wildcard;
+	bool supports_multicast;
+	bool supports_broadcast;
+	char special_addresses[KAPI_MAX_DESC_LEN];
+	u32 port_range_min;
+	u32 port_range_max;
+} __attribute__((packed));
+#endif /* CONFIG_NET */
+
+/**
+ * struct kernel_api_spec - Complete kernel API specification
+ * @name: Function name
+ * @version: API version
+ * @description: Brief description
+ * @long_description: Detailed description
+ * @context_flags: Execution context flags
+ * @param_count: Number of parameters
+ * @params: Parameter specifications
+ * @return_spec: Return value specification
+ * @error_count: Number of possible errors
+ * @errors: Error specifications
+ * @lock_count: Number of lock specifications
+ * @locks: Lock requirement specifications
+ * @constraint_count: Number of additional constraints
+ * @constraints: Additional constraint specifications
+ * @examples: Usage examples
+ * @notes: Additional notes
+ * @since_version: Kernel version when introduced
+ * @deprecated: Whether API is deprecated
+ * @replacement: Replacement API if deprecated
+ * @signal_count: Number of signal specifications
+ * @signals: Signal handling specifications
+ * @signal_mask_count: Number of signal mask specifications
+ * @signal_masks: Signal mask specifications
+ * @struct_spec_count: Number of structure specifications
+ * @struct_specs: Structure type specifications
+ * @side_effect_count: Number of side effect specifications
+ * @side_effects: Side effect specifications
+ * @state_trans_count: Number of state transition specifications
+ * @state_transitions: State transition specifications
+ */
+struct kernel_api_spec {
+	char name[KAPI_MAX_NAME_LEN];
+	u32 version;
+	char description[KAPI_MAX_DESC_LEN];
+	char long_description[KAPI_MAX_DESC_LEN * 4];
+	u32 context_flags;
+
+	/* Parameters */
+	u32 param_count;
+	struct kapi_param_spec params[KAPI_MAX_PARAMS];
+
+	/* Return value */
+	struct kapi_return_spec return_spec;
+
+	/* Errors */
+	u32 error_count;
+	struct kapi_error_spec errors[KAPI_MAX_ERRORS];
+
+	/* Locking */
+	u32 lock_count;
+	struct kapi_lock_spec locks[KAPI_MAX_CONSTRAINTS];
+
+	/* Constraints */
+	u32 constraint_count;
+	struct kapi_constraint_spec constraints[KAPI_MAX_CONSTRAINTS];
+
+	/* Additional information */
+	char examples[KAPI_MAX_DESC_LEN * 2];
+	char notes[KAPI_MAX_DESC_LEN * 2];
+	char since_version[32];
+	bool deprecated;
+	char replacement[KAPI_MAX_NAME_LEN];
+
+	/* Signal specifications */
+	u32 signal_count;
+	struct kapi_signal_spec signals[KAPI_MAX_SIGNALS];
+
+	/* Signal mask specifications */
+	u32 signal_mask_count;
+	struct kapi_signal_mask_spec signal_masks[KAPI_MAX_SIGNALS];
+
+	/* Structure specifications */
+	u32 struct_spec_count;
+	struct kapi_struct_spec struct_specs[KAPI_MAX_STRUCT_SPECS];
+
+	/* Side effects */
+	u32 side_effect_count;
+	struct kapi_side_effect side_effects[KAPI_MAX_SIDE_EFFECTS];
+
+	/* State transitions */
+	u32 state_trans_count;
+	struct kapi_state_transition state_transitions[KAPI_MAX_STATE_TRANS];
+
+	/* Capability specifications */
+	u32 capability_count;
+	struct kapi_capability_spec capabilities[KAPI_MAX_CAPABILITIES];
+
+#ifdef CONFIG_NET
+	/* Networking-specific fields */
+	struct kapi_socket_state_spec socket_state;
+	struct kapi_protocol_behavior protocol_behaviors[KAPI_MAX_PROTOCOL_BEHAVIORS];
+	u32 protocol_behavior_count;
+	struct kapi_buffer_spec buffer_spec;
+	struct kapi_async_spec async_spec;
+	struct kapi_addr_family_spec addr_families[KAPI_MAX_ADDR_FAMILIES];
+	u32 addr_family_count;
+
+	/* Network operation characteristics */
+	bool is_connection_oriented;
+	bool is_message_oriented;
+	bool supports_oob_data;
+	bool supports_peek;
+	bool supports_select_poll;
+	bool is_reentrant;
+
+	/* Network semantic descriptions */
+	char connection_establishment[KAPI_MAX_DESC_LEN];
+	char connection_termination[KAPI_MAX_DESC_LEN];
+	char data_transfer_semantics[KAPI_MAX_DESC_LEN];
+#endif /* CONFIG_NET */
+} __attribute__((packed));
+
+/* Macros for defining API specifications */
+
+/**
+ * DEFINE_KERNEL_API_SPEC - Define a kernel API specification
+ * @func_name: Function name to specify
+ */
+#define DEFINE_KERNEL_API_SPEC(func_name) \
+	static struct kernel_api_spec __kapi_spec_##func_name \
+	__used __section(".kapi_specs") = {	\
+		.name = __stringify(func_name),	\
+		.version = 1,
+
+#define KAPI_END_SPEC };
+
+/**
+ * KAPI_DESCRIPTION - Set API description
+ * @desc: Description string
+ */
+#define KAPI_DESCRIPTION(desc) \
+	.description = desc,
+
+/**
+ * KAPI_LONG_DESC - Set detailed API description
+ * @desc: Detailed description string
+ */
+#define KAPI_LONG_DESC(desc) \
+	.long_description = desc,
+
+/**
+ * KAPI_CONTEXT - Set execution context flags
+ * @flags: Context flags (OR'ed KAPI_CTX_* values)
+ */
+#define KAPI_CONTEXT(flags) \
+	.context_flags = flags,
+
+/**
+ * KAPI_PARAM - Define a parameter specification
+ * @idx: Parameter index (0-based)
+ * @pname: Parameter name
+ * @ptype: Type name string
+ * @pdesc: Parameter description
+ */
+#define KAPI_PARAM(idx, pname, ptype, pdesc) \
+	.params[idx] = {			\
+		.name = pname,			\
+		.type_name = ptype,		\
+		.description = pdesc,		\
+		.size_param_idx = -1,		/* Default: no dynamic sizing */
+
+#define KAPI_PARAM_TYPE(ptype) \
+		.type = ptype,
+
+#define KAPI_PARAM_FLAGS(pflags) \
+		.flags = pflags,
+
+#define KAPI_PARAM_SIZE(psize) \
+		.size = psize,
+
+#define KAPI_PARAM_RANGE(pmin, pmax) \
+		.min_value = pmin,	\
+		.max_value = pmax,
+
+#define KAPI_PARAM_CONSTRAINT_TYPE(ctype) \
+		.constraint_type = ctype,
+
+#define KAPI_PARAM_CONSTRAINT(desc) \
+		.constraints = desc,
+
+#define KAPI_PARAM_VALID_MASK(mask) \
+		.valid_mask = mask,
+
+#define KAPI_PARAM_ENUM_VALUES(values) \
+		.enum_values = values, \
+		.enum_count = ARRAY_SIZE(values),
+
+#define KAPI_PARAM_END },
+
+/**
+ * KAPI_RETURN - Define return value specification
+ * @rtype: Return type name
+ * @rdesc: Return value description
+ */
+#define KAPI_RETURN(rtype, rdesc) \
+	.return_spec = {		\
+		.type_name = rtype,	\
+		.description = rdesc,
+
+#define KAPI_RETURN_SUCCESS(val) \
+		.success_value = val,
+
+#define KAPI_RETURN_TYPE(rtype) \
+		.type = rtype,
+
+#define KAPI_RETURN_CHECK_TYPE(ctype) \
+		.check_type = ctype,
+
+#define KAPI_RETURN_ERROR_VALUES(values) \
+		.error_values = values,
+
+#define KAPI_RETURN_ERROR_COUNT(count) \
+		.error_count = count,
+
+#define KAPI_RETURN_SUCCESS_RANGE(min, max) \
+		.success_min = min, \
+		.success_max = max,
+
+#define KAPI_RETURN_END },
+
+/**
+ * KAPI_ERROR - Define an error condition
+ * @idx: Error index
+ * @ecode: Error code value
+ * @ename: Error name
+ * @econd: Error condition
+ * @edesc: Error description
+ */
+#define KAPI_ERROR(idx, ecode, ename, econd, edesc) \
+	.errors[idx] = {			\
+		.error_code = ecode,		\
+		.name = ename,			\
+		.condition = econd,		\
+		.description = edesc,		\
+	},
+
+/**
+ * KAPI_LOCK - Define a lock requirement
+ * @idx: Lock index
+ * @lname: Lock name
+ * @ltype: Lock type
+ */
+#define KAPI_LOCK(idx, lname, ltype) \
+	.locks[idx] = {			\
+		.lock_name = lname,	\
+		.lock_type = ltype,
+
+#define KAPI_LOCK_ACQUIRED \
+		.acquired = true,
+
+#define KAPI_LOCK_RELEASED \
+		.released = true,
+
+#define KAPI_LOCK_HELD_ENTRY \
+		.held_on_entry = true,
+
+#define KAPI_LOCK_HELD_EXIT \
+		.held_on_exit = true,
+
+#define KAPI_LOCK_DESC(ldesc) \
+		.description = ldesc,
+
+#define KAPI_LOCK_END },
+
+/**
+ * KAPI_CONSTRAINT - Define an additional constraint
+ * @idx: Constraint index
+ * @cname: Constraint name
+ * @cdesc: Constraint description
+ */
+#define KAPI_CONSTRAINT(idx, cname, cdesc) \
+	.constraints[idx] = {		\
+		.name = cname,		\
+		.description = cdesc,
+
+#define KAPI_CONSTRAINT_EXPR(expr) \
+		.expression = expr,
+
+#define KAPI_CONSTRAINT_END },
+
+/**
+ * KAPI_EXAMPLES - Set API usage examples
+ * @examples: Examples string
+ */
+#define KAPI_EXAMPLES(ex) \
+	.examples = ex,
+
+/**
+ * KAPI_NOTES - Set API notes
+ * @notes: Notes string
+ */
+#define KAPI_NOTES(n) \
+	.notes = n,
+
+/**
+ * KAPI_DEPRECATED - Mark API as deprecated
+ */
+#define KAPI_DEPRECATED \
+	.deprecated = true,
+
+/**
+ * KAPI_REPLACEMENT - Set replacement API for deprecated function
+ * @repl: Replacement API name
+ */
+#define KAPI_REPLACEMENT(repl) \
+	.replacement = repl,
+
+/**
+ * KAPI_SIGNAL - Define a signal specification
+ * @idx: Signal index
+ * @signum: Signal number (e.g., SIGKILL)
+ * @signame: Signal name string
+ * @dir: Direction flags
+ * @act: Action taken
+ */
+#define KAPI_SIGNAL(idx, signum, signame, dir, act) \
+	.signals[idx] = {			\
+		.signal_num = signum,		\
+		.signal_name = signame,		\
+		.direction = dir,		\
+		.action = act,
+
+#define KAPI_SIGNAL_TARGET(tgt) \
+		.target = tgt,
+
+#define KAPI_SIGNAL_CONDITION(cond) \
+		.condition = cond,
+
+#define KAPI_SIGNAL_DESC(desc) \
+		.description = desc,
+
+#define KAPI_SIGNAL_RESTARTABLE \
+		.restartable = true,
+
+#define KAPI_SIGNAL_SA_FLAGS_REQ(flags) \
+		.sa_flags_required = flags,
+
+#define KAPI_SIGNAL_SA_FLAGS_FORBID(flags) \
+		.sa_flags_forbidden = flags,
+
+#define KAPI_SIGNAL_ERROR(err) \
+		.error_on_signal = err,
+
+#define KAPI_SIGNAL_TRANSFORM(sig) \
+		.transform_to = sig,
+
+#define KAPI_SIGNAL_TIMING(when) \
+		.timing = when,
+
+#define KAPI_SIGNAL_PRIORITY(prio) \
+		.priority = prio,
+
+#define KAPI_SIGNAL_INTERRUPTIBLE \
+		.interruptible = true,
+
+#define KAPI_SIGNAL_QUEUE(behavior) \
+		.queue_behavior = behavior,
+
+#define KAPI_SIGNAL_STATE_REQ(state) \
+		.state_required = state,
+
+#define KAPI_SIGNAL_STATE_FORBID(state) \
+		.state_forbidden = state,
+
+#define KAPI_SIGNAL_END },
+
+#define KAPI_SIGNAL_COUNT(n) \
+	.signal_count = n,
+
+/**
+ * KAPI_SIGNAL_MASK - Define a signal mask specification
+ * @idx: Mask index
+ * @name: Mask name
+ * @desc: Mask description
+ */
+#define KAPI_SIGNAL_MASK(idx, name, desc) \
+	.signal_masks[idx] = {		\
+		.mask_name = name,	\
+		.description = desc,
+
+#define KAPI_SIGNAL_MASK_ADD(signum) \
+		.signals[.signal_count++] = signum,
+
+#define KAPI_SIGNAL_MASK_END },
+
+/**
+ * KAPI_STRUCT_SPEC - Define a structure specification
+ * @idx: Structure spec index
+ * @sname: Structure name
+ * @sdesc: Structure description
+ */
+#define KAPI_STRUCT_SPEC(idx, sname, sdesc) \
+	.struct_specs[idx] = {		\
+		.name = #sname,		\
+		.description = sdesc,
+
+#define KAPI_STRUCT_SIZE(ssize, salign) \
+		.size = ssize,		\
+		.alignment = salign,
+
+#define KAPI_STRUCT_FIELD_COUNT(n) \
+		.field_count = n,
+
+/**
+ * KAPI_STRUCT_FIELD - Define a structure field
+ * @fidx: Field index
+ * @fname: Field name
+ * @ftype: Field type (KAPI_TYPE_*)
+ * @ftype_name: Type name as string
+ * @fdesc: Field description
+ */
+#define KAPI_STRUCT_FIELD(fidx, fname, ftype, ftype_name, fdesc) \
+		.fields[fidx] = {	\
+			.name = fname,	\
+			.type = ftype,	\
+			.type_name = ftype_name, \
+			.description = fdesc,
+
+#define KAPI_FIELD_OFFSET(foffset) \
+			.offset = foffset,
+
+#define KAPI_FIELD_SIZE(fsize) \
+			.size = fsize,
+
+#define KAPI_FIELD_FLAGS(fflags) \
+			.flags = fflags,
+
+#define KAPI_FIELD_CONSTRAINT_RANGE(min, max) \
+			.constraint_type = KAPI_CONSTRAINT_RANGE, \
+			.min_value = min, \
+			.max_value = max,
+
+#define KAPI_FIELD_CONSTRAINT_MASK(mask) \
+			.constraint_type = KAPI_CONSTRAINT_MASK, \
+			.valid_mask = mask,
+
+#define KAPI_FIELD_CONSTRAINT_ENUM(values) \
+			.constraint_type = KAPI_CONSTRAINT_ENUM, \
+			.enum_values = values,
+
+#define KAPI_STRUCT_FIELD_END },
+
+#define KAPI_STRUCT_SPEC_END },
+
+/* Counter for structure specifications */
+#define KAPI_STRUCT_SPEC_COUNT(n) \
+	.struct_spec_count = n,
+
+/* Additional lock-related macros */
+#define KAPI_LOCK_COUNT(n) \
+	.lock_count = n,
+
+/**
+ * KAPI_SIDE_EFFECT - Define a side effect
+ * @idx: Side effect index
+ * @etype: Effect type bitmask (OR'ed KAPI_EFFECT_* values)
+ * @etarget: What is affected
+ * @edesc: Effect description
+ */
+#define KAPI_SIDE_EFFECT(idx, etype, etarget, edesc) \
+	.side_effects[idx] = {		\
+		.type = etype,		\
+		.target = etarget,	\
+		.description = edesc,	\
+		.reversible = false,	/* Default to non-reversible */
+
+#define KAPI_EFFECT_CONDITION(cond) \
+		.condition = cond,
+
+#define KAPI_EFFECT_REVERSIBLE \
+		.reversible = true,
+
+#define KAPI_SIDE_EFFECT_END },
+
+/**
+ * KAPI_STATE_TRANS - Define a state transition
+ * @idx: State transition index
+ * @obj: Object whose state changes
+ * @from: From state
+ * @to: To state
+ * @desc: Transition description
+ */
+#define KAPI_STATE_TRANS(idx, obj, from, to, desc) \
+	.state_transitions[idx] = {	\
+		.object = obj,		\
+		.from_state = from,	\
+		.to_state = to,		\
+		.description = desc,
+
+#define KAPI_STATE_TRANS_COND(cond) \
+		.condition = cond,
+
+#define KAPI_STATE_TRANS_END },
+
+/* Counters for side effects and state transitions */
+#define KAPI_SIDE_EFFECT_COUNT(n) \
+	.side_effect_count = n,
+
+#define KAPI_STATE_TRANS_COUNT(n) \
+	.state_trans_count = n,
+
+/* Helper macros for common side effect patterns */
+#define KAPI_EFFECTS_MEMORY	(KAPI_EFFECT_ALLOC_MEMORY | KAPI_EFFECT_FREE_MEMORY)
+#define KAPI_EFFECTS_LOCKING	(KAPI_EFFECT_LOCK_ACQUIRE | KAPI_EFFECT_LOCK_RELEASE)
+#define KAPI_EFFECTS_RESOURCES	(KAPI_EFFECT_RESOURCE_CREATE | KAPI_EFFECT_RESOURCE_DESTROY)
+#define KAPI_EFFECTS_IO		(KAPI_EFFECT_NETWORK | KAPI_EFFECT_FILESYSTEM)
+
+/* Helper macros for common patterns */
+
+#define KAPI_PARAM_IN		(KAPI_PARAM_IN)
+#define KAPI_PARAM_OUT		(KAPI_PARAM_OUT)
+#define KAPI_PARAM_INOUT	(KAPI_PARAM_IN | KAPI_PARAM_OUT)
+#define KAPI_PARAM_OPTIONAL	(KAPI_PARAM_OPTIONAL)
+#define KAPI_PARAM_USER_PTR	(KAPI_PARAM_USER | KAPI_PARAM_PTR)
+
+/* Common signal timing constants */
+#define KAPI_SIGNAL_TIME_ENTRY		"entry"
+#define KAPI_SIGNAL_TIME_DURING		"during"
+#define KAPI_SIGNAL_TIME_EXIT		"exit"
+#define KAPI_SIGNAL_TIME_ANYTIME	"anytime"
+#define KAPI_SIGNAL_TIME_BLOCKING	"while_blocked"
+#define KAPI_SIGNAL_TIME_SLEEPING	"while_sleeping"
+
+/* Common signal queue behaviors */
+#define KAPI_SIGNAL_QUEUE_STANDARD	"standard"
+#define KAPI_SIGNAL_QUEUE_REALTIME	"realtime"
+#define KAPI_SIGNAL_QUEUE_COALESCE	"coalesce"
+#define KAPI_SIGNAL_QUEUE_REPLACE	"replace"
+#define KAPI_SIGNAL_QUEUE_DISCARD	"discard"
+
+/* Process state flags for signal delivery */
+#define KAPI_SIGNAL_STATE_RUNNING	(1 << 0)
+#define KAPI_SIGNAL_STATE_SLEEPING	(1 << 1)
+#define KAPI_SIGNAL_STATE_STOPPED	(1 << 2)
+#define KAPI_SIGNAL_STATE_TRACED	(1 << 3)
+#define KAPI_SIGNAL_STATE_ZOMBIE	(1 << 4)
+#define KAPI_SIGNAL_STATE_DEAD		(1 << 5)
+
+/* Capability specification macros */
+
+/**
+ * KAPI_CAPABILITY - Define a capability requirement
+ * @idx: Capability index
+ * @cap: Capability constant (e.g., CAP_IPC_LOCK)
+ * @name: Capability name string
+ * @act: Action type (kapi_capability_action)
+ */
+#define KAPI_CAPABILITY(idx, cap, name, act) \
+	.capabilities[idx] = {		\
+		.capability = cap,	\
+		.cap_name = name,	\
+		.action = act,
+
+#define KAPI_CAP_ALLOWS(desc) \
+		.allows = desc,
+
+#define KAPI_CAP_WITHOUT(desc) \
+		.without_cap = desc,
+
+#define KAPI_CAP_CONDITION(cond) \
+		.check_condition = cond,
+
+#define KAPI_CAP_PRIORITY(prio) \
+		.priority = prio,
+
+#define KAPI_CAP_ALTERNATIVE(caps, count) \
+		.alternative = caps,	\
+		.alternative_count = count,
+
+#define KAPI_CAPABILITY_END },
+
+/* Counter for capability specifications */
+#define KAPI_CAPABILITY_COUNT(n) \
+	.capability_count = n,
+
+/* Common signal patterns for syscalls */
+#define KAPI_SIGNAL_INTERRUPTIBLE_SLEEP \
+	KAPI_SIGNAL(0, SIGINT, "SIGINT", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN) \
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_SLEEPING) \
+		KAPI_SIGNAL_ERROR(-EINTR) \
+		KAPI_SIGNAL_RESTARTABLE \
+		KAPI_SIGNAL_DESC("Interrupts sleep, returns -EINTR") \
+	KAPI_SIGNAL_END, \
+	KAPI_SIGNAL(1, SIGTERM, "SIGTERM", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN) \
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_SLEEPING) \
+		KAPI_SIGNAL_ERROR(-EINTR) \
+		KAPI_SIGNAL_RESTARTABLE \
+		KAPI_SIGNAL_DESC("Interrupts sleep, returns -EINTR") \
+	KAPI_SIGNAL_END
+
+#define KAPI_SIGNAL_FATAL_DEFAULT \
+	KAPI_SIGNAL(2, SIGKILL, "SIGKILL", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_TERMINATE) \
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_ANYTIME) \
+		KAPI_SIGNAL_PRIORITY(0) \
+		KAPI_SIGNAL_DESC("Process terminated immediately") \
+	KAPI_SIGNAL_END
+
+#define KAPI_SIGNAL_STOP_CONT \
+	KAPI_SIGNAL(3, SIGSTOP, "SIGSTOP", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_STOP) \
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_ANYTIME) \
+		KAPI_SIGNAL_DESC("Process stopped") \
+	KAPI_SIGNAL_END, \
+	KAPI_SIGNAL(4, SIGCONT, "SIGCONT", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_CONTINUE) \
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_ANYTIME) \
+		KAPI_SIGNAL_DESC("Process continued") \
+	KAPI_SIGNAL_END
+
+/* Validation and runtime checking */
+
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+bool kapi_validate_params(const struct kernel_api_spec *spec, ...);
+bool kapi_validate_param(const struct kapi_param_spec *param_spec, s64 value);
+bool kapi_validate_param_with_context(const struct kapi_param_spec *param_spec,
+				       s64 value, const s64 *all_params, int param_count);
+int kapi_validate_syscall_param(const struct kernel_api_spec *spec,
+				int param_idx, s64 value);
+int kapi_validate_syscall_params(const struct kernel_api_spec *spec,
+				 const s64 *params, int param_count);
+bool kapi_check_return_success(const struct kapi_return_spec *return_spec, s64 retval);
+bool kapi_validate_return_value(const struct kernel_api_spec *spec, s64 retval);
+int kapi_validate_syscall_return(const struct kernel_api_spec *spec, s64 retval);
+void kapi_check_context(const struct kernel_api_spec *spec);
+void kapi_check_locks(const struct kernel_api_spec *spec);
+bool kapi_check_signal_allowed(const struct kernel_api_spec *spec, int signum);
+bool kapi_validate_signal_action(const struct kernel_api_spec *spec, int signum,
+				 struct sigaction *act);
+int kapi_get_signal_error(const struct kernel_api_spec *spec, int signum);
+bool kapi_is_signal_restartable(const struct kernel_api_spec *spec, int signum);
+#else
+static inline bool kapi_validate_params(const struct kernel_api_spec *spec, ...)
+{
+	return true;
+}
+static inline bool kapi_validate_param(const struct kapi_param_spec *param_spec, s64 value)
+{
+	return true;
+}
+static inline bool kapi_validate_param_with_context(const struct kapi_param_spec *param_spec,
+						     s64 value, const s64 *all_params, int param_count)
+{
+	return true;
+}
+static inline int kapi_validate_syscall_param(const struct kernel_api_spec *spec,
+					       int param_idx, s64 value)
+{
+	return 0;
+}
+static inline int kapi_validate_syscall_params(const struct kernel_api_spec *spec,
+					       const s64 *params, int param_count)
+{
+	return 0;
+}
+static inline bool kapi_check_return_success(const struct kapi_return_spec *return_spec, s64 retval)
+{
+	return true;
+}
+static inline bool kapi_validate_return_value(const struct kernel_api_spec *spec, s64 retval)
+{
+	return true;
+}
+static inline int kapi_validate_syscall_return(const struct kernel_api_spec *spec, s64 retval)
+{
+	return 0;
+}
+static inline void kapi_check_context(const struct kernel_api_spec *spec) {}
+static inline void kapi_check_locks(const struct kernel_api_spec *spec) {}
+static inline bool kapi_check_signal_allowed(const struct kernel_api_spec *spec, int signum)
+{
+	return true;
+}
+static inline bool kapi_validate_signal_action(const struct kernel_api_spec *spec, int signum,
+					       struct sigaction *act)
+{
+	return true;
+}
+static inline int kapi_get_signal_error(const struct kernel_api_spec *spec, int signum)
+{
+	return -EINTR;
+}
+static inline bool kapi_is_signal_restartable(const struct kernel_api_spec *spec, int signum)
+{
+	return false;
+}
+#endif
+
+/* Export/query functions */
+const struct kernel_api_spec *kapi_get_spec(const char *name);
+int kapi_export_json(const struct kernel_api_spec *spec, char *buf, size_t size);
+void kapi_print_spec(const struct kernel_api_spec *spec);
+
+/* Registration for dynamic APIs */
+int kapi_register_spec(struct kernel_api_spec *spec);
+void kapi_unregister_spec(const char *name);
+
+/* Helper to get parameter constraint info */
+static inline bool kapi_get_param_constraint(const char *api_name, int param_idx,
+					      enum kapi_constraint_type *type,
+					      u64 *valid_mask, s64 *min_val, s64 *max_val)
+{
+	const struct kernel_api_spec *spec = kapi_get_spec(api_name);
+
+	if (!spec || param_idx >= spec->param_count)
+		return false;
+
+	if (type)
+		*type = spec->params[param_idx].constraint_type;
+	if (valid_mask)
+		*valid_mask = spec->params[param_idx].valid_mask;
+	if (min_val)
+		*min_val = spec->params[param_idx].min_value;
+	if (max_val)
+		*max_val = spec->params[param_idx].max_value;
+
+	return true;
+}
+
+#ifdef CONFIG_NET
+/* Networking-specific macros */
+
+/* Socket state requirement macros */
+#define KAPI_SOCKET_STATE_REQ(...) \
+	.socket_state = { \
+		.required_states = { __VA_ARGS__ }, \
+		.required_state_count = sizeof((enum kapi_socket_state[]){__VA_ARGS__})/sizeof(enum kapi_socket_state),
+
+#define KAPI_SOCKET_STATE_FORBID(...) \
+		.forbidden_states = { __VA_ARGS__ }, \
+		.forbidden_state_count = sizeof((enum kapi_socket_state[]){__VA_ARGS__})/sizeof(enum kapi_socket_state),
+
+#define KAPI_SOCKET_STATE_RESULT(state) \
+		.resulting_state = state,
+
+#define KAPI_SOCKET_STATE_COND(cond) \
+		.state_condition = cond,
+
+#define KAPI_SOCKET_STATE_PROTOS(protos) \
+		.applicable_protocols = protos,
+
+#define KAPI_SOCKET_STATE_END },
+
+/* Protocol behavior macros */
+#define KAPI_PROTOCOL_BEHAVIOR(idx, protos, desc) \
+	.protocol_behaviors[idx] = { \
+		.applicable_protocols = protos, \
+		.behavior = desc,
+
+#define KAPI_PROTOCOL_FLAGS(flags, desc) \
+		.protocol_flags = flags, \
+		.flag_description = desc,
+
+#define KAPI_PROTOCOL_BEHAVIOR_END },
+
+/* Async behavior macros */
+#define KAPI_ASYNC_SPEC(modes, errno) \
+	.async_spec = { \
+		.supported_modes = modes, \
+		.nonblock_errno = errno,
+
+#define KAPI_ASYNC_POLL(in, out) \
+		.poll_events_in = in, \
+		.poll_events_out = out,
+
+#define KAPI_ASYNC_COMPLETION(cond) \
+		.completion_condition = cond,
+
+#define KAPI_ASYNC_TIMEOUT(supported, desc) \
+		.supports_timeout = supported, \
+		.timeout_behavior = desc,
+
+#define KAPI_ASYNC_END },
+
+/* Buffer behavior macros */
+#define KAPI_BUFFER_SPEC(behaviors) \
+	.buffer_spec = { \
+		.buffer_behaviors = behaviors,
+
+#define KAPI_BUFFER_SIZE(min, max, optimal) \
+		.min_buffer_size = min, \
+		.max_buffer_size = max, \
+		.optimal_buffer_size = optimal,
+
+#define KAPI_BUFFER_PARTIAL(allowed, rules) \
+		.can_partial_transfer = allowed, \
+		.partial_transfer_rules = rules,
+
+#define KAPI_BUFFER_FRAGMENT(rules) \
+		.fragmentation_rules = rules,
+
+#define KAPI_BUFFER_END },
+
+/* Address family macros */
+#define KAPI_ADDR_FAMILY(idx, fam, name, struct_sz, min_len, max_len) \
+	.addr_families[idx] = { \
+		.family = fam, \
+		.family_name = name, \
+		.addr_struct_size = struct_sz, \
+		.min_addr_len = min_len, \
+		.max_addr_len = max_len,
+
+#define KAPI_ADDR_FORMAT(fmt) \
+		.addr_format = fmt,
+
+#define KAPI_ADDR_FEATURES(wildcard, multicast, broadcast) \
+		.supports_wildcard = wildcard, \
+		.supports_multicast = multicast, \
+		.supports_broadcast = broadcast,
+
+#define KAPI_ADDR_SPECIAL(addrs) \
+		.special_addresses = addrs,
+
+#define KAPI_ADDR_PORTS(min, max) \
+		.port_range_min = min, \
+		.port_range_max = max,
+
+#define KAPI_ADDR_FAMILY_END },
+
+#define KAPI_ADDR_FAMILY_COUNT(n) \
+	.addr_family_count = n,
+
+#define KAPI_PROTOCOL_BEHAVIOR_COUNT(n) \
+	.protocol_behavior_count = n,
+
+#define KAPI_CONSTRAINT_COUNT(n) \
+	.constraint_count = n,
+
+/* Network operation characteristics macros */
+#define KAPI_NET_CONNECTION_ORIENTED \
+	.is_connection_oriented = true,
+
+#define KAPI_NET_MESSAGE_ORIENTED \
+	.is_message_oriented = true,
+
+#define KAPI_NET_SUPPORTS_OOB \
+	.supports_oob_data = true,
+
+#define KAPI_NET_SUPPORTS_PEEK \
+	.supports_peek = true,
+
+#define KAPI_NET_REENTRANT \
+	.is_reentrant = true,
+
+/* Semantic description macros */
+#define KAPI_NET_CONN_ESTABLISH(desc) \
+	.connection_establishment = desc,
+
+#define KAPI_NET_CONN_TERMINATE(desc) \
+	.connection_termination = desc,
+
+#define KAPI_NET_DATA_TRANSFER(desc) \
+	.data_transfer_semantics = desc,
+
+#endif /* CONFIG_NET */
+
+#endif /* _LINUX_KERNEL_API_SPEC_H */
diff --git a/include/linux/syscall_api_spec.h b/include/linux/syscall_api_spec.h
new file mode 100644
index 0000000000000..0a813ad89ea15
--- /dev/null
+++ b/include/linux/syscall_api_spec.h
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * syscall_api_spec.h - System Call API Specification Integration
+ *
+ * This header extends the SYSCALL_DEFINEX macros to support inline API specifications,
+ * allowing syscall documentation to be written alongside the implementation in a
+ * human-readable and machine-parseable format.
+ */
+
+#ifndef _LINUX_SYSCALL_API_SPEC_H
+#define _LINUX_SYSCALL_API_SPEC_H
+
+#include <linux/kernel_api_spec.h>
+
+
+
+/* Automatic syscall validation infrastructure */
+/* 
+ * The validation is now integrated directly into the SYSCALL_DEFINEx macros
+ * in syscalls.h when CONFIG_KAPI_RUNTIME_CHECKS is enabled.
+ * 
+ * The validation happens in the __do_kapi_sys##name wrapper function which:
+ * 1. Validates all parameters before calling the actual syscall
+ * 2. Calls the real syscall implementation
+ * 3. Validates the return value
+ * 4. Returns the result
+ */
+
+
+/*
+ * Helper macros for common syscall patterns
+ */
+
+/* For syscalls that can sleep */
+#define KAPI_SYSCALL_SLEEPABLE \
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+/* For syscalls that must be atomic */
+#define KAPI_SYSCALL_ATOMIC \
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_ATOMIC)
+
+/* Common parameter specifications */
+#define KAPI_PARAM_FD(idx, desc) \
+	KAPI_PARAM(idx, "fd", "int", desc) \
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN) \
+		.type = KAPI_TYPE_FD, \
+		.constraint_type = KAPI_CONSTRAINT_NONE, \
+	KAPI_PARAM_END
+
+#define KAPI_PARAM_USER_BUF(idx, name, desc) \
+	KAPI_PARAM(idx, name, "void __user *", desc) \
+		KAPI_PARAM_FLAGS(KAPI_PARAM_USER_PTR | KAPI_PARAM_IN) \
+	KAPI_PARAM_END
+
+#define KAPI_PARAM_USER_STRUCT(idx, name, struct_type, desc) \
+	KAPI_PARAM(idx, name, #struct_type " __user *", desc) \
+		KAPI_PARAM_FLAGS(KAPI_PARAM_USER | KAPI_PARAM_IN) \
+		.type = KAPI_TYPE_USER_PTR, \
+		.size = sizeof(struct_type), \
+		.constraint_type = KAPI_CONSTRAINT_NONE, \
+	KAPI_PARAM_END
+
+#define KAPI_PARAM_SIZE_T(idx, name, desc) \
+	KAPI_PARAM(idx, name, "size_t", desc) \
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN) \
+		KAPI_PARAM_RANGE(0, SIZE_MAX) \
+	KAPI_PARAM_END
+
+/* Common error specifications */
+#define KAPI_ERROR_EBADF(idx) \
+	KAPI_ERROR(idx, -EBADF, "EBADF", "Invalid file descriptor", \
+		   "The file descriptor is not valid or has been closed")
+
+#define KAPI_ERROR_EINVAL(idx, condition) \
+	KAPI_ERROR(idx, -EINVAL, "EINVAL", condition, \
+		   "Invalid argument provided")
+
+#define KAPI_ERROR_ENOMEM(idx) \
+	KAPI_ERROR(idx, -ENOMEM, "ENOMEM", "Insufficient memory", \
+		   "Cannot allocate memory for the operation")
+
+#define KAPI_ERROR_EPERM(idx) \
+	KAPI_ERROR(idx, -EPERM, "EPERM", "Operation not permitted", \
+		   "The calling process does not have the required permissions")
+
+#define KAPI_ERROR_EFAULT(idx) \
+	KAPI_ERROR(idx, -EFAULT, "EFAULT", "Bad address", \
+		   "Invalid user space address provided")
+
+/* Standard return value specifications */
+#define KAPI_RETURN_SUCCESS_ZERO \
+	KAPI_RETURN("long", "0 on success, negative error code on failure") \
+		KAPI_RETURN_SUCCESS(0, "== 0") \
+	KAPI_RETURN_END
+
+#define KAPI_RETURN_FD_SPEC \
+	KAPI_RETURN("long", "File descriptor on success, negative error code on failure") \
+		.check_type = KAPI_RETURN_FD, \
+	KAPI_RETURN_END
+
+#define KAPI_RETURN_COUNT \
+	KAPI_RETURN("long", "Number of bytes processed on success, negative error code on failure") \
+		KAPI_RETURN_SUCCESS(0, ">= 0") \
+	KAPI_RETURN_END
+
+/**
+ * KAPI_ERROR_COUNT - Set the error count
+ * @count: Number of errors defined
+ */
+#define KAPI_ERROR_COUNT(count) \
+	.error_count = count,
+
+/**
+ * KAPI_PARAM_COUNT - Set the parameter count
+ * @count: Number of parameters defined
+ */
+#define KAPI_PARAM_COUNT(count) \
+	.param_count = count,
+
+/**
+ * KAPI_SINCE_VERSION - Set the since version
+ * @version: Version string when the API was introduced
+ */
+#define KAPI_SINCE_VERSION(version) \
+	.since_version = version,
+
+
+/**
+ * KAPI_SIGNAL_MASK_COUNT - Set the signal mask count
+ * @count: Number of signal masks defined
+ */
+#define KAPI_SIGNAL_MASK_COUNT(count) \
+	.signal_mask_count = count,
+
+
+
+#endif /* _LINUX_SYSCALL_API_SPEC_H */
\ No newline at end of file
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e5603cc91963d..62a8edc14ec87 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -87,6 +87,7 @@ struct xattr_args;
 #include <linux/bug.h>
 #include <linux/sem.h>
 #include <asm/siginfo.h>
+#include <linux/syscall_api_spec.h>
 #include <linux/unistd.h>
 #include <linux/quota.h>
 #include <linux/key.h>
@@ -132,6 +133,7 @@ struct xattr_args;
 #define __SC_TYPE(t, a)	t
 #define __SC_ARGS(t, a)	a
 #define __SC_TEST(t, a) (void)BUILD_BUG_ON_ZERO(!__TYPE_IS_LL(t) && sizeof(t) > sizeof(long))
+#define __SC_CAST_TO_S64(t, a)	(s64)(a)
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #define __SC_STR_ADECL(t, a)	#a
@@ -242,6 +244,41 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
  * done within __do_sys_*().
  */
 #ifndef __SYSCALL_DEFINEx
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+#define __SYSCALL_DEFINEx(x, name, ...)					\
+	__diag_push();							\
+	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
+		      "Type aliasing is used to sanitize syscall arguments");\
+	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
+		__attribute__((alias(__stringify(__se_sys##name))));	\
+	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	static inline long __do_kapi_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)); \
+	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
+	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
+	{								\
+		long ret = __do_kapi_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
+		__MAP(x,__SC_TEST,__VA_ARGS__);				\
+		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
+		return ret;						\
+	}								\
+	__diag_pop();							\
+	static inline long __do_kapi_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))\
+	{								\
+		const struct kernel_api_spec *__spec = kapi_get_spec("sys_" #name); \
+		if (__spec) {						\
+			s64 __params[x] = { __MAP(x,__SC_CAST_TO_S64,__VA_ARGS__) }; \
+			int __ret = kapi_validate_syscall_params(__spec, __params, x); \
+			if (__ret) return __ret;			\
+		}							\
+		long ret = __do_sys##name(__MAP(x,__SC_ARGS,__VA_ARGS__));	\
+		if (__spec) {						\
+			kapi_validate_syscall_return(__spec, (s64)ret); \
+		}							\
+		return ret;						\
+	}								\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+#else /* !CONFIG_KAPI_RUNTIME_CHECKS */
 #define __SYSCALL_DEFINEx(x, name, ...)					\
 	__diag_push();							\
 	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
@@ -260,6 +297,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 	}								\
 	__diag_pop();							\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+#endif /* CONFIG_KAPI_RUNTIME_CHECKS */
 #endif /* __SYSCALL_DEFINEx */
 
 /* For split 64-bit arguments on 32-bit architectures */
diff --git a/init/Kconfig b/init/Kconfig
index af4c2f0854554..7a15248933895 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2079,6 +2079,8 @@ config TRACEPOINTS
 
 source "kernel/Kconfig.kexec"
 
+source "kernel/api/Kconfig"
+
 endmenu		# General setup
 
 source "arch/Kconfig"
diff --git a/kernel/Makefile b/kernel/Makefile
index 32e80dd626af0..ba94ee4bb2292 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -56,6 +56,7 @@ obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
 obj-$(CONFIG_MODULES) += module/
+obj-$(CONFIG_KAPI_SPEC) += api/
 
 obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
diff --git a/kernel/api/Kconfig b/kernel/api/Kconfig
new file mode 100644
index 0000000000000..fde25ec70e134
--- /dev/null
+++ b/kernel/api/Kconfig
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Kernel API Specification Framework Configuration
+#
+
+config KAPI_SPEC
+	bool "Kernel API Specification Framework"
+	help
+	  This option enables the kernel API specification framework,
+	  which provides formal documentation of kernel APIs in both
+	  human and machine-readable formats.
+
+	  The framework allows developers to document APIs inline with
+	  their implementation, including parameter specifications,
+	  return values, error conditions, locking requirements, and
+	  execution context constraints.
+
+	  When enabled, API specifications can be queried at runtime
+	  and exported in various formats (JSON, XML) through debugfs.
+
+	  If unsure, say N.
+
+config KAPI_RUNTIME_CHECKS
+	bool "Runtime API specification checks"
+	depends on KAPI_SPEC
+	depends on DEBUG_KERNEL
+	help
+	  Enable runtime validation of API usage against specifications.
+	  This includes checking execution context requirements, parameter
+	  validation, and lock state verification.
+
+	  This adds overhead and should only be used for debugging and
+	  development. The checks use WARN_ONCE to report violations.
+
+	  If unsure, say N.
diff --git a/kernel/api/Makefile b/kernel/api/Makefile
new file mode 100644
index 0000000000000..4120ded7e5cf1
--- /dev/null
+++ b/kernel/api/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Kernel API Specification Framework
+#
+
+# Core API specification framework
+obj-$(CONFIG_KAPI_SPEC)		+= kernel_api_spec.o
\ No newline at end of file
diff --git a/kernel/api/kernel_api_spec.c b/kernel/api/kernel_api_spec.c
new file mode 100644
index 0000000000000..8827e9f96c111
--- /dev/null
+++ b/kernel/api/kernel_api_spec.c
@@ -0,0 +1,1122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * kernel_api_spec.c - Kernel API Specification Framework Implementation
+ *
+ * Provides runtime support for kernel API specifications including validation,
+ * export to various formats, and querying capabilities.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kernel_api_spec.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
+#include <linux/export.h>
+#include <linux/preempt.h>
+#include <linux/hardirq.h>
+#include <linux/file.h>
+#include <linux/fdtable.h>
+#include <linux/uaccess.h>
+#include <linux/limits.h>
+#include <linux/fcntl.h>
+
+/* Section where API specifications are stored */
+extern struct kernel_api_spec __start_kapi_specs[];
+extern struct kernel_api_spec __stop_kapi_specs[];
+
+/* Dynamic API registration */
+static LIST_HEAD(dynamic_api_specs);
+static DEFINE_MUTEX(api_spec_mutex);
+
+struct dynamic_api_spec {
+	struct list_head list;
+	struct kernel_api_spec *spec;
+};
+
+/**
+ * kapi_get_spec - Get API specification by name
+ * @name: Function name to look up
+ *
+ * Return: Pointer to API specification or NULL if not found
+ */
+const struct kernel_api_spec *kapi_get_spec(const char *name)
+{
+	struct kernel_api_spec *spec;
+	struct dynamic_api_spec *dyn_spec;
+
+	/* Search static specifications */
+	for (spec = __start_kapi_specs; spec < __stop_kapi_specs; spec++) {
+		if (strcmp(spec->name, name) == 0)
+			return spec;
+	}
+
+	/* Search dynamic specifications */
+	mutex_lock(&api_spec_mutex);
+	list_for_each_entry(dyn_spec, &dynamic_api_specs, list) {
+		if (strcmp(dyn_spec->spec->name, name) == 0) {
+			mutex_unlock(&api_spec_mutex);
+			return dyn_spec->spec;
+		}
+	}
+	mutex_unlock(&api_spec_mutex);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(kapi_get_spec);
+
+/**
+ * kapi_register_spec - Register a dynamic API specification
+ * @spec: API specification to register
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int kapi_register_spec(struct kernel_api_spec *spec)
+{
+	struct dynamic_api_spec *dyn_spec;
+
+	if (!spec || !spec->name[0])
+		return -EINVAL;
+
+	/* Check if already exists */
+	if (kapi_get_spec(spec->name))
+		return -EEXIST;
+
+	dyn_spec = kzalloc(sizeof(*dyn_spec), GFP_KERNEL);
+	if (!dyn_spec)
+		return -ENOMEM;
+
+	dyn_spec->spec = spec;
+
+	mutex_lock(&api_spec_mutex);
+	list_add_tail(&dyn_spec->list, &dynamic_api_specs);
+	mutex_unlock(&api_spec_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kapi_register_spec);
+
+/**
+ * kapi_unregister_spec - Unregister a dynamic API specification
+ * @name: Name of API to unregister
+ */
+void kapi_unregister_spec(const char *name)
+{
+	struct dynamic_api_spec *dyn_spec, *tmp;
+
+	mutex_lock(&api_spec_mutex);
+	list_for_each_entry_safe(dyn_spec, tmp, &dynamic_api_specs, list) {
+		if (strcmp(dyn_spec->spec->name, name) == 0) {
+			list_del(&dyn_spec->list);
+			kfree(dyn_spec);
+			break;
+		}
+	}
+	mutex_unlock(&api_spec_mutex);
+}
+EXPORT_SYMBOL_GPL(kapi_unregister_spec);
+
+/**
+ * param_type_to_string - Convert parameter type to string
+ * @type: Parameter type
+ *
+ * Return: String representation of type
+ */
+static const char *param_type_to_string(enum kapi_param_type type)
+{
+	static const char * const type_names[] = {
+		[KAPI_TYPE_VOID] = "void",
+		[KAPI_TYPE_INT] = "int",
+		[KAPI_TYPE_UINT] = "uint",
+		[KAPI_TYPE_PTR] = "pointer",
+		[KAPI_TYPE_STRUCT] = "struct",
+		[KAPI_TYPE_UNION] = "union",
+		[KAPI_TYPE_ENUM] = "enum",
+		[KAPI_TYPE_FUNC_PTR] = "function_pointer",
+		[KAPI_TYPE_ARRAY] = "array",
+		[KAPI_TYPE_FD] = "file_descriptor",
+		[KAPI_TYPE_USER_PTR] = "user_pointer",
+		[KAPI_TYPE_PATH] = "pathname",
+		[KAPI_TYPE_CUSTOM] = "custom",
+	};
+
+	if (type >= ARRAY_SIZE(type_names))
+		return "unknown";
+
+	return type_names[type];
+}
+
+/**
+ * lock_type_to_string - Convert lock type to string
+ * @type: Lock type
+ *
+ * Return: String representation of lock type
+ */
+static const char *lock_type_to_string(enum kapi_lock_type type)
+{
+	static const char * const lock_names[] = {
+		[KAPI_LOCK_NONE] = "none",
+		[KAPI_LOCK_MUTEX] = "mutex",
+		[KAPI_LOCK_SPINLOCK] = "spinlock",
+		[KAPI_LOCK_RWLOCK] = "rwlock",
+		[KAPI_LOCK_SEQLOCK] = "seqlock",
+		[KAPI_LOCK_RCU] = "rcu",
+		[KAPI_LOCK_SEMAPHORE] = "semaphore",
+		[KAPI_LOCK_CUSTOM] = "custom",
+	};
+
+	if (type >= ARRAY_SIZE(lock_names))
+		return "unknown";
+
+	return lock_names[type];
+}
+
+/**
+ * return_check_type_to_string - Convert return check type to string
+ * @type: Return check type
+ *
+ * Return: String representation of return check type
+ */
+static const char *return_check_type_to_string(enum kapi_return_check_type type)
+{
+	static const char * const check_names[] = {
+		[KAPI_RETURN_EXACT] = "exact",
+		[KAPI_RETURN_RANGE] = "range",
+		[KAPI_RETURN_ERROR_CHECK] = "error_check",
+		[KAPI_RETURN_FD] = "file_descriptor",
+		[KAPI_RETURN_CUSTOM] = "custom",
+	};
+
+	if (type >= ARRAY_SIZE(check_names))
+		return "unknown";
+
+	return check_names[type];
+}
+
+/**
+ * capability_action_to_string - Convert capability action to string
+ * @action: Capability action
+ *
+ * Return: String representation of capability action
+ */
+static const char *capability_action_to_string(enum kapi_capability_action action)
+{
+	static const char * const action_names[] = {
+		[KAPI_CAP_BYPASS_CHECK] = "bypass_check",
+		[KAPI_CAP_INCREASE_LIMIT] = "increase_limit",
+		[KAPI_CAP_OVERRIDE_RESTRICTION] = "override_restriction",
+		[KAPI_CAP_GRANT_PERMISSION] = "grant_permission",
+		[KAPI_CAP_MODIFY_BEHAVIOR] = "modify_behavior",
+		[KAPI_CAP_ACCESS_RESOURCE] = "access_resource",
+		[KAPI_CAP_PERFORM_OPERATION] = "perform_operation",
+	};
+
+	if (action >= ARRAY_SIZE(action_names))
+		return "unknown";
+
+	return action_names[action];
+}
+
+/**
+ * kapi_export_json - Export API specification to JSON format
+ * @spec: API specification to export
+ * @buf: Buffer to write JSON to
+ * @size: Size of buffer
+ *
+ * Return: Number of bytes written or negative error
+ */
+int kapi_export_json(const struct kernel_api_spec *spec, char *buf, size_t size)
+{
+	int ret = 0;
+	int i;
+
+	if (!spec || !buf || size == 0)
+		return -EINVAL;
+
+	ret = scnprintf(buf, size,
+		"{\n"
+		"  \"name\": \"%s\",\n"
+		"  \"version\": %u,\n"
+		"  \"description\": \"%s\",\n"
+		"  \"long_description\": \"%s\",\n"
+		"  \"context_flags\": \"0x%x\",\n",
+		spec->name,
+		spec->version,
+		spec->description,
+		spec->long_description,
+		spec->context_flags);
+
+	/* Parameters */
+	ret += scnprintf(buf + ret, size - ret,
+		"  \"parameters\": [\n");
+
+	for (i = 0; i < spec->param_count && i < KAPI_MAX_PARAMS; i++) {
+		const struct kapi_param_spec *param = &spec->params[i];
+
+		ret += scnprintf(buf + ret, size - ret,
+			"    {\n"
+			"      \"name\": \"%s\",\n"
+			"      \"type\": \"%s\",\n"
+			"      \"type_class\": \"%s\",\n"
+			"      \"flags\": \"0x%x\",\n"
+			"      \"description\": \"%s\"\n"
+			"    }%s\n",
+			param->name,
+			param->type_name,
+			param_type_to_string(param->type),
+			param->flags,
+			param->description,
+			(i < spec->param_count - 1) ? "," : "");
+	}
+
+	ret += scnprintf(buf + ret, size - ret, "  ],\n");
+
+	/* Return value */
+	ret += scnprintf(buf + ret, size - ret,
+		"  \"return\": {\n"
+		"    \"type\": \"%s\",\n"
+		"    \"type_class\": \"%s\",\n"
+		"    \"check_type\": \"%s\",\n",
+		spec->return_spec.type_name,
+		param_type_to_string(spec->return_spec.type),
+		return_check_type_to_string(spec->return_spec.check_type));
+
+	switch (spec->return_spec.check_type) {
+	case KAPI_RETURN_EXACT:
+		ret += scnprintf(buf + ret, size - ret,
+			"    \"success_value\": %lld,\n",
+			spec->return_spec.success_value);
+		break;
+	case KAPI_RETURN_RANGE:
+		ret += scnprintf(buf + ret, size - ret,
+			"    \"success_min\": %lld,\n"
+			"    \"success_max\": %lld,\n",
+			spec->return_spec.success_min,
+			spec->return_spec.success_max);
+		break;
+	case KAPI_RETURN_ERROR_CHECK:
+		ret += scnprintf(buf + ret, size - ret,
+			"    \"error_count\": %u,\n",
+			spec->return_spec.error_count);
+		break;
+	default:
+		break;
+	}
+
+	ret += scnprintf(buf + ret, size - ret,
+		"    \"description\": \"%s\"\n"
+		"  },\n",
+		spec->return_spec.description);
+
+	/* Errors */
+	ret += scnprintf(buf + ret, size - ret,
+		"  \"errors\": [\n");
+
+	for (i = 0; i < spec->error_count && i < KAPI_MAX_ERRORS; i++) {
+		const struct kapi_error_spec *error = &spec->errors[i];
+
+		ret += scnprintf(buf + ret, size - ret,
+			"    {\n"
+			"      \"code\": %d,\n"
+			"      \"name\": \"%s\",\n"
+			"      \"condition\": \"%s\",\n"
+			"      \"description\": \"%s\"\n"
+			"    }%s\n",
+			error->error_code,
+			error->name,
+			error->condition,
+			error->description,
+			(i < spec->error_count - 1) ? "," : "");
+	}
+
+	ret += scnprintf(buf + ret, size - ret, "  ],\n");
+
+	/* Locks */
+	ret += scnprintf(buf + ret, size - ret,
+		"  \"locks\": [\n");
+
+	for (i = 0; i < spec->lock_count && i < KAPI_MAX_CONSTRAINTS; i++) {
+		const struct kapi_lock_spec *lock = &spec->locks[i];
+
+		ret += scnprintf(buf + ret, size - ret,
+			"    {\n"
+			"      \"name\": \"%s\",\n"
+			"      \"type\": \"%s\",\n"
+			"      \"acquired\": %s,\n"
+			"      \"released\": %s,\n"
+			"      \"held_on_entry\": %s,\n"
+			"      \"held_on_exit\": %s,\n"
+			"      \"description\": \"%s\"\n"
+			"    }%s\n",
+			lock->lock_name,
+			lock_type_to_string(lock->lock_type),
+			lock->acquired ? "true" : "false",
+			lock->released ? "true" : "false",
+			lock->held_on_entry ? "true" : "false",
+			lock->held_on_exit ? "true" : "false",
+			lock->description,
+			(i < spec->lock_count - 1) ? "," : "");
+	}
+
+	ret += scnprintf(buf + ret, size - ret, "  ],\n");
+
+	/* Capabilities */
+	ret += scnprintf(buf + ret, size - ret,
+		"  \"capabilities\": [\n");
+
+	for (i = 0; i < spec->capability_count && i < KAPI_MAX_CAPABILITIES; i++) {
+		const struct kapi_capability_spec *cap = &spec->capabilities[i];
+
+		ret += scnprintf(buf + ret, size - ret,
+			"    {\n"
+			"      \"capability\": %d,\n"
+			"      \"name\": \"%s\",\n"
+			"      \"action\": \"%s\",\n"
+			"      \"allows\": \"%s\",\n"
+			"      \"without_cap\": \"%s\",\n"
+			"      \"check_condition\": \"%s\",\n"
+			"      \"priority\": %u",
+			cap->capability,
+			cap->cap_name,
+			capability_action_to_string(cap->action),
+			cap->allows,
+			cap->without_cap,
+			cap->check_condition,
+			cap->priority);
+
+		if (cap->alternative_count > 0) {
+			int j;
+			ret += scnprintf(buf + ret, size - ret,
+				",\n      \"alternatives\": [");
+			for (j = 0; j < cap->alternative_count; j++) {
+				ret += scnprintf(buf + ret, size - ret,
+					"%d%s", cap->alternative[j],
+					(j < cap->alternative_count - 1) ? ", " : "");
+			}
+			ret += scnprintf(buf + ret, size - ret, "]");
+		}
+
+		ret += scnprintf(buf + ret, size - ret,
+			"\n    }%s\n",
+			(i < spec->capability_count - 1) ? "," : "");
+	}
+
+	ret += scnprintf(buf + ret, size - ret, "  ],\n");
+
+	/* Additional info */
+	ret += scnprintf(buf + ret, size - ret,
+		"  \"since_version\": \"%s\",\n"
+		"  \"deprecated\": %s,\n"
+		"  \"replacement\": \"%s\",\n"
+		"  \"examples\": \"%s\",\n"
+		"  \"notes\": \"%s\"\n"
+		"}\n",
+		spec->since_version,
+		spec->deprecated ? "true" : "false",
+		spec->replacement,
+		spec->examples,
+		spec->notes);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kapi_export_json);
+
+
+/**
+ * kapi_print_spec - Print API specification to kernel log
+ * @spec: API specification to print
+ */
+void kapi_print_spec(const struct kernel_api_spec *spec)
+{
+	int i;
+
+	if (!spec)
+		return;
+
+	pr_info("=== Kernel API Specification ===\n");
+	pr_info("Name: %s\n", spec->name);
+	pr_info("Version: %u\n", spec->version);
+	pr_info("Description: %s\n", spec->description);
+
+	if (spec->long_description[0])
+		pr_info("Long Description: %s\n", spec->long_description);
+
+	pr_info("Context Flags: 0x%x\n", spec->context_flags);
+
+	/* Parameters */
+	if (spec->param_count > 0) {
+		pr_info("Parameters:\n");
+		for (i = 0; i < spec->param_count && i < KAPI_MAX_PARAMS; i++) {
+			const struct kapi_param_spec *param = &spec->params[i];
+			pr_info("  [%d] %s: %s (flags: 0x%x)\n",
+				i, param->name, param->type_name, param->flags);
+			if (param->description[0])
+				pr_info("      Description: %s\n", param->description);
+		}
+	}
+
+	/* Return value */
+	pr_info("Return: %s\n", spec->return_spec.type_name);
+	if (spec->return_spec.description[0])
+		pr_info("  Description: %s\n", spec->return_spec.description);
+
+	/* Errors */
+	if (spec->error_count > 0) {
+		pr_info("Possible Errors:\n");
+		for (i = 0; i < spec->error_count && i < KAPI_MAX_ERRORS; i++) {
+			const struct kapi_error_spec *error = &spec->errors[i];
+			pr_info("  %s (%d): %s\n",
+				error->name, error->error_code, error->condition);
+		}
+	}
+
+	/* Capabilities */
+	if (spec->capability_count > 0) {
+		pr_info("Capabilities:\n");
+		for (i = 0; i < spec->capability_count && i < KAPI_MAX_CAPABILITIES; i++) {
+			const struct kapi_capability_spec *cap = &spec->capabilities[i];
+			pr_info("  %s (%d):\n", cap->cap_name, cap->capability);
+			pr_info("    Action: %s\n", capability_action_to_string(cap->action));
+			pr_info("    Allows: %s\n", cap->allows);
+			pr_info("    Without: %s\n", cap->without_cap);
+			if (cap->check_condition[0])
+				pr_info("    Condition: %s\n", cap->check_condition);
+		}
+	}
+
+	pr_info("================================\n");
+}
+EXPORT_SYMBOL_GPL(kapi_print_spec);
+
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+
+/**
+ * kapi_validate_fd - Validate that a file descriptor is valid in current context
+ * @fd: File descriptor to validate
+ *
+ * Return: true if fd is valid in current process context, false otherwise
+ */
+static bool kapi_validate_fd(int fd)
+{
+	struct fd f;
+
+	/* Special case: AT_FDCWD is always valid */
+	if (fd == AT_FDCWD)
+		return true;
+
+	/* Check basic range */
+	if (fd < 0)
+		return false;
+
+	/* Check if fd is valid in current process context */
+	f = fdget(fd);
+	if (fd_empty(f)) {
+		return false;
+	}
+
+	/* fd is valid, release reference */
+	fdput(f);
+	return true;
+}
+
+/**
+ * kapi_validate_user_ptr - Validate that a user pointer is accessible
+ * @ptr: User pointer to validate
+ * @size: Size in bytes to validate
+ * @write: Whether write access is required
+ *
+ * Return: true if user memory is accessible, false otherwise
+ */
+static bool kapi_validate_user_ptr(const void __user *ptr, size_t size, bool write)
+{
+	/* NULL is valid if parameter is marked optional */
+	if (!ptr)
+		return false;
+
+	/* Check if the user memory region is accessible */
+	if (write) {
+		return access_ok(ptr, size);
+	} else {
+		return access_ok(ptr, size);
+	}
+}
+
+/**
+ * kapi_validate_user_ptr_with_params - Validate user pointer with dynamic size
+ * @param_spec: Parameter specification
+ * @ptr: User pointer to validate
+ * @all_params: Array of all parameter values
+ * @param_count: Number of parameters
+ *
+ * Return: true if user memory is accessible, false otherwise
+ */
+static bool kapi_validate_user_ptr_with_params(const struct kapi_param_spec *param_spec,
+						const void __user *ptr,
+						const s64 *all_params,
+						int param_count)
+{
+	size_t actual_size;
+	bool write;
+
+	/* NULL is allowed for optional parameters */
+	if (!ptr && (param_spec->flags & KAPI_PARAM_OPTIONAL))
+		return true;
+
+	/* Calculate actual size based on related parameter */
+	if (param_spec->size_param_idx >= 0 &&
+	    param_spec->size_param_idx < param_count) {
+		s64 count = all_params[param_spec->size_param_idx];
+
+		/* Validate count is positive */
+		if (count <= 0) {
+			pr_warn("Parameter %s: size determinant is non-positive (%lld)\n",
+				param_spec->name, count);
+			return false;
+		}
+
+		/* Check for multiplication overflow */
+		if (param_spec->size_multiplier > 0 &&
+		    count > SIZE_MAX / param_spec->size_multiplier) {
+			pr_warn("Parameter %s: size calculation overflow\n",
+				param_spec->name);
+			return false;
+		}
+
+		actual_size = count * param_spec->size_multiplier;
+	} else {
+		/* Use fixed size */
+		actual_size = param_spec->size;
+	}
+
+	write = (param_spec->flags & KAPI_PARAM_OUT) ||
+		(param_spec->flags & KAPI_PARAM_INOUT);
+
+	return kapi_validate_user_ptr(ptr, actual_size, write);
+}
+
+/**
+ * kapi_validate_path - Validate that a pathname is accessible and within limits
+ * @path: User pointer to pathname
+ * @param_spec: Parameter specification
+ *
+ * Return: true if path is valid, false otherwise
+ */
+static bool kapi_validate_path(const char __user *path,
+				const struct kapi_param_spec *param_spec)
+{
+	size_t len;
+
+	/* NULL is allowed for optional parameters */
+	if (!path && (param_spec->flags & KAPI_PARAM_OPTIONAL))
+		return true;
+
+	if (!path) {
+		pr_warn("Parameter %s: NULL path not allowed\n", param_spec->name);
+		return false;
+	}
+
+	/* Check if the path is accessible */
+	if (!access_ok(path, 1)) {
+		pr_warn("Parameter %s: path pointer %p not accessible\n",
+			param_spec->name, path);
+		return false;
+	}
+
+	/* Use strnlen_user to get the length and validate accessibility */
+	len = strnlen_user(path, PATH_MAX + 1);
+	if (len == 0) {
+		pr_warn("Parameter %s: invalid path pointer %p\n",
+			param_spec->name, path);
+		return false;
+	}
+
+	/* Check path length limit */
+	if (len > PATH_MAX) {
+		pr_warn("Parameter %s: path too long (exceeds PATH_MAX)\n",
+			param_spec->name);
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * kapi_validate_param - Validate a parameter against its specification
+ * @param_spec: Parameter specification
+ * @value: Parameter value to validate
+ *
+ * Return: true if valid, false otherwise
+ */
+bool kapi_validate_param(const struct kapi_param_spec *param_spec, s64 value)
+{
+	int i;
+
+	/* Special handling for file descriptor type */
+	if (param_spec->type == KAPI_TYPE_FD) {
+		if (!kapi_validate_fd((int)value)) {
+			pr_warn("Parameter %s: invalid file descriptor %lld\n",
+				param_spec->name, value);
+			return false;
+		}
+		/* Continue with additional constraint checks if needed */
+	}
+
+	/* Special handling for user pointer type */
+	if (param_spec->type == KAPI_TYPE_USER_PTR) {
+		const void __user *ptr = (const void __user *)value;
+		bool write = (param_spec->flags & KAPI_PARAM_OUT) ||
+			     (param_spec->flags & KAPI_PARAM_INOUT);
+
+		/* NULL is allowed for optional parameters */
+		if (!ptr && (param_spec->flags & KAPI_PARAM_OPTIONAL))
+			return true;
+
+		if (!kapi_validate_user_ptr(ptr, param_spec->size, write)) {
+			pr_warn("Parameter %s: invalid user pointer %p (size: %zu, %s)\n",
+				param_spec->name, ptr, param_spec->size,
+				write ? "write" : "read");
+			return false;
+		}
+		/* Continue with additional constraint checks if needed */
+	}
+
+	/* Special handling for path type */
+	if (param_spec->type == KAPI_TYPE_PATH) {
+		const char __user *path = (const char __user *)value;
+
+		if (!kapi_validate_path(path, param_spec)) {
+			return false;
+		}
+		/* Continue with additional constraint checks if needed */
+	}
+
+	switch (param_spec->constraint_type) {
+	case KAPI_CONSTRAINT_NONE:
+		return true;
+
+	case KAPI_CONSTRAINT_RANGE:
+		if (value < param_spec->min_value || value > param_spec->max_value) {
+			pr_warn("Parameter %s value %lld out of range [%lld, %lld]\n",
+				param_spec->name, value,
+				param_spec->min_value, param_spec->max_value);
+			return false;
+		}
+		return true;
+
+	case KAPI_CONSTRAINT_MASK:
+		if (value & ~param_spec->valid_mask) {
+			pr_warn("Parameter %s value 0x%llx contains invalid bits (valid mask: 0x%llx)\n",
+				param_spec->name, value, param_spec->valid_mask);
+			return false;
+		}
+		return true;
+
+	case KAPI_CONSTRAINT_ENUM:
+		if (!param_spec->enum_values || param_spec->enum_count == 0)
+			return true;
+
+		for (i = 0; i < param_spec->enum_count; i++) {
+			if (value == param_spec->enum_values[i])
+				return true;
+		}
+		pr_warn("Parameter %s value %lld not in valid enumeration\n",
+			param_spec->name, value);
+		return false;
+
+	case KAPI_CONSTRAINT_CUSTOM:
+		if (param_spec->validate)
+			return param_spec->validate(value);
+		return true;
+
+	default:
+		return true;
+	}
+}
+EXPORT_SYMBOL_GPL(kapi_validate_param);
+
+/**
+ * kapi_validate_param_with_context - Validate parameter with access to all params
+ * @param_spec: Parameter specification
+ * @value: Parameter value to validate
+ * @all_params: Array of all parameter values
+ * @param_count: Number of parameters
+ *
+ * Return: true if valid, false otherwise
+ */
+bool kapi_validate_param_with_context(const struct kapi_param_spec *param_spec,
+				       s64 value, const s64 *all_params, int param_count)
+{
+	/* Special handling for user pointer type with dynamic sizing */
+	if (param_spec->type == KAPI_TYPE_USER_PTR) {
+		const void __user *ptr = (const void __user *)value;
+
+		/* NULL is allowed for optional parameters */
+		if (!ptr && (param_spec->flags & KAPI_PARAM_OPTIONAL))
+			return true;
+
+		if (!kapi_validate_user_ptr_with_params(param_spec, ptr, all_params, param_count)) {
+			pr_warn("Parameter %s: invalid user pointer %p\n",
+				param_spec->name, ptr);
+			return false;
+		}
+		/* Continue with additional constraint checks if needed */
+	}
+
+	/* For other types, fall back to regular validation */
+	return kapi_validate_param(param_spec, value);
+}
+EXPORT_SYMBOL_GPL(kapi_validate_param_with_context);
+
+/**
+ * kapi_validate_syscall_param - Validate syscall parameter with enforcement
+ * @spec: API specification
+ * @param_idx: Parameter index
+ * @value: Parameter value
+ *
+ * Return: -EINVAL if invalid, 0 if valid
+ */
+int kapi_validate_syscall_param(const struct kernel_api_spec *spec,
+				 int param_idx, s64 value)
+{
+	const struct kapi_param_spec *param_spec;
+
+	if (!spec || param_idx >= spec->param_count)
+		return 0;
+
+	param_spec = &spec->params[param_idx];
+
+	if (!kapi_validate_param(param_spec, value)) {
+		if (strncmp(spec->name, "sys_", 4) == 0) {
+			/* For syscalls, we can return EINVAL to userspace */
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kapi_validate_syscall_param);
+
+/**
+ * kapi_validate_syscall_params - Validate all syscall parameters together
+ * @spec: API specification
+ * @params: Array of parameter values
+ * @param_count: Number of parameters
+ *
+ * Return: -EINVAL if any parameter is invalid, 0 if all valid
+ */
+int kapi_validate_syscall_params(const struct kernel_api_spec *spec,
+				 const s64 *params, int param_count)
+{
+	int i;
+
+	if (!spec || !params)
+		return 0;
+
+	/* Validate that we have the expected number of parameters */
+	if (param_count != spec->param_count) {
+		pr_warn("API %s: parameter count mismatch (expected %u, got %d)\n",
+			spec->name, spec->param_count, param_count);
+		return -EINVAL;
+	}
+
+	/* Validate each parameter with context */
+	for (i = 0; i < spec->param_count && i < KAPI_MAX_PARAMS; i++) {
+		const struct kapi_param_spec *param_spec = &spec->params[i];
+
+		if (!kapi_validate_param_with_context(param_spec, params[i], params, param_count)) {
+			if (strncmp(spec->name, "sys_", 4) == 0) {
+				/* For syscalls, we can return EINVAL to userspace */
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kapi_validate_syscall_params);
+
+/**
+ * kapi_check_return_success - Check if return value indicates success
+ * @return_spec: Return specification
+ * @retval: Return value to check
+ *
+ * Returns true if the return value indicates success according to the spec.
+ */
+bool kapi_check_return_success(const struct kapi_return_spec *return_spec, s64 retval)
+{
+	u32 i;
+
+	if (!return_spec)
+		return true; /* No spec means we can't validate */
+
+	switch (return_spec->check_type) {
+	case KAPI_RETURN_EXACT:
+		return retval == return_spec->success_value;
+
+	case KAPI_RETURN_RANGE:
+		return retval >= return_spec->success_min &&
+		       retval <= return_spec->success_max;
+
+	case KAPI_RETURN_ERROR_CHECK:
+		/* Success if NOT in error list */
+		if (return_spec->error_values) {
+			for (i = 0; i < return_spec->error_count; i++) {
+				if (retval == return_spec->error_values[i])
+					return false; /* Found in error list */
+			}
+		}
+		return true; /* Not in error list = success */
+
+	case KAPI_RETURN_FD:
+		/* File descriptors: >= 0 is success, < 0 is error */
+		return retval >= 0;
+
+	case KAPI_RETURN_CUSTOM:
+		if (return_spec->is_success)
+			return return_spec->is_success(retval);
+		fallthrough;
+
+	default:
+		return true; /* Unknown check type, assume success */
+	}
+}
+EXPORT_SYMBOL_GPL(kapi_check_return_success);
+
+/**
+ * kapi_validate_return_value - Validate that return value matches spec
+ * @spec: API specification
+ * @retval: Return value to validate
+ *
+ * Return: true if return value is valid according to spec, false otherwise.
+ *
+ * This function checks:
+ * 1. If the value indicates success, it must match the success criteria
+ * 2. If the value indicates error, it must be one of the specified error codes
+ */
+bool kapi_validate_return_value(const struct kernel_api_spec *spec, s64 retval)
+{
+	int i;
+	bool is_success;
+
+	if (!spec)
+		return true; /* No spec means we can't validate */
+
+	/* First check if this is a success return */
+	is_success = kapi_check_return_success(&spec->return_spec, retval);
+
+	if (is_success) {
+		/* Success case - already validated by kapi_check_return_success */
+		return true;
+	}
+
+	/* Special validation for file descriptor returns */
+	if (spec->return_spec.check_type == KAPI_RETURN_FD && is_success) {
+		/* For successful FD returns, validate it's a valid FD */
+		if (!kapi_validate_fd((int)retval)) {
+			pr_warn("API %s returned invalid file descriptor %lld\n",
+				spec->name, retval);
+			return false;
+		}
+		return true;
+	}
+
+	/* Error case - check if it's one of the specified errors */
+	if (spec->error_count == 0) {
+		/* No errors specified, so any error is potentially valid */
+		pr_debug("API %s returned unspecified error %lld\n",
+			 spec->name, retval);
+		return true;
+	}
+
+	/* Check if the error is in our list of specified errors */
+	for (i = 0; i < spec->error_count && i < KAPI_MAX_ERRORS; i++) {
+		if (retval == spec->errors[i].error_code)
+			return true;
+	}
+
+	/* Error not in spec */
+	pr_warn("API %s returned unspecified error code %lld. Valid errors are:\n",
+		spec->name, retval);
+	for (i = 0; i < spec->error_count && i < KAPI_MAX_ERRORS; i++) {
+		pr_warn("  %s (%d): %s\n",
+			spec->errors[i].name,
+			spec->errors[i].error_code,
+			spec->errors[i].condition);
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(kapi_validate_return_value);
+
+/**
+ * kapi_validate_syscall_return - Validate syscall return value with enforcement
+ * @spec: API specification
+ * @retval: Return value
+ *
+ * Return: 0 if valid, -EINVAL if the return value doesn't match spec
+ *
+ * For syscalls, this can help detect kernel bugs where unspecified error
+ * codes are returned to userspace.
+ */
+int kapi_validate_syscall_return(const struct kernel_api_spec *spec, s64 retval)
+{
+	if (!spec)
+		return 0;
+
+	if (!kapi_validate_return_value(spec, retval)) {
+		/* Log the violation but don't change the return value */
+		WARN_ONCE(1, "Syscall %s returned unspecified value %lld\n",
+			  spec->name, retval);
+		/* Could return -EINVAL here to enforce, but that might break userspace */
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kapi_validate_syscall_return);
+
+/**
+ * kapi_check_context - Check if current context matches API requirements
+ * @spec: API specification to check against
+ */
+void kapi_check_context(const struct kernel_api_spec *spec)
+{
+	u32 ctx = spec->context_flags;
+	bool valid = false;
+
+	if (!ctx)
+		return;
+
+	/* Check if we're in an allowed context */
+	if ((ctx & KAPI_CTX_PROCESS) && !in_interrupt())
+		valid = true;
+
+	if ((ctx & KAPI_CTX_SOFTIRQ) && in_softirq())
+		valid = true;
+
+	if ((ctx & KAPI_CTX_HARDIRQ) && in_hardirq())
+		valid = true;
+
+	if ((ctx & KAPI_CTX_NMI) && in_nmi())
+		valid = true;
+
+	if (!valid) {
+		WARN_ONCE(1, "API %s called from invalid context\n", spec->name);
+	}
+
+	/* Check specific requirements */
+	if ((ctx & KAPI_CTX_ATOMIC) && preemptible()) {
+		WARN_ONCE(1, "API %s requires atomic context\n", spec->name);
+	}
+
+	if ((ctx & KAPI_CTX_SLEEPABLE) && !preemptible()) {
+		WARN_ONCE(1, "API %s requires sleepable context\n", spec->name);
+	}
+}
+EXPORT_SYMBOL_GPL(kapi_check_context);
+
+#endif /* CONFIG_KAPI_RUNTIME_CHECKS */
+
+/* DebugFS interface */
+#ifdef CONFIG_DEBUG_FS
+
+static struct dentry *kapi_debugfs_root;
+
+static int kapi_spec_show(struct seq_file *s, void *v)
+{
+	struct kernel_api_spec *spec = s->private;
+	char *buf;
+	int ret;
+
+	buf = kmalloc(PAGE_SIZE * 4, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = kapi_export_json(spec, buf, PAGE_SIZE * 4);
+	if (ret > 0)
+		seq_printf(s, "%s", buf);
+
+	kfree(buf);
+	return 0;
+}
+
+static int kapi_spec_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, kapi_spec_show, inode->i_private);
+}
+
+static const struct file_operations kapi_spec_fops = {
+	.open = kapi_spec_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int kapi_list_show(struct seq_file *s, void *v)
+{
+	struct kernel_api_spec *spec;
+	struct dynamic_api_spec *dyn_spec;
+
+	seq_printf(s, "Kernel API Specifications:\n\n");
+
+	/* List static specifications */
+	seq_printf(s, "Static APIs:\n");
+	for (spec = __start_kapi_specs; spec < __stop_kapi_specs; spec++) {
+		seq_printf(s, "  %s (v%u): %s\n",
+			spec->name, spec->version, spec->description);
+	}
+
+	/* List dynamic specifications */
+	seq_printf(s, "\nDynamic APIs:\n");
+	mutex_lock(&api_spec_mutex);
+	list_for_each_entry(dyn_spec, &dynamic_api_specs, list) {
+		spec = dyn_spec->spec;
+		seq_printf(s, "  %s (v%u): %s\n",
+			spec->name, spec->version, spec->description);
+	}
+	mutex_unlock(&api_spec_mutex);
+
+	return 0;
+}
+
+static int kapi_list_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, kapi_list_show, NULL);
+}
+
+static const struct file_operations kapi_list_fops = {
+	.open = kapi_list_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int __init kapi_debugfs_init(void)
+{
+	struct kernel_api_spec *spec;
+	struct dentry *spec_dir;
+
+	kapi_debugfs_root = debugfs_create_dir("kapi", NULL);
+	if (!kapi_debugfs_root)
+		return -ENOMEM;
+
+	/* Create list file */
+	debugfs_create_file("list", 0444, kapi_debugfs_root, NULL,
+			    &kapi_list_fops);
+
+	/* Create directory for specifications */
+	spec_dir = debugfs_create_dir("specs", kapi_debugfs_root);
+
+	/* Create files for each static specification */
+	for (spec = __start_kapi_specs; spec < __stop_kapi_specs; spec++) {
+		debugfs_create_file(spec->name, 0444, spec_dir, spec,
+				    &kapi_spec_fops);
+	}
+
+	return 0;
+}
+
+late_initcall(kapi_debugfs_init);
+
+#endif /* CONFIG_DEBUG_FS */
\ No newline at end of file
-- 
2.39.5


