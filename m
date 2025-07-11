Return-Path: <linux-api+bounces-4151-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BD4B01AEC
	for <lists+linux-api@lfdr.de>; Fri, 11 Jul 2025 13:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D981188BDBE
	for <lists+linux-api@lfdr.de>; Fri, 11 Jul 2025 11:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CDD2BE650;
	Fri, 11 Jul 2025 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5t5HWNl"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EB52BE641;
	Fri, 11 Jul 2025 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234177; cv=none; b=TqHchqaKtRTV1Q17GqEYXAtZyf5MQMK9tm8RDZOfIyFbtCWEbwj38fSiTBd2lXWcqtWM9venK7vJhtmIJpNeqpWHwZZ/nkbyREm8707BIYFthTTejrR+KWeZG0e+7U8Fe8Y34Xj+jr/XIW3GfJyqlF86Nj+HJUq+hpOS+NDLHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234177; c=relaxed/simple;
	bh=uWtTkGexBgSTA1K24PDjaLHTbOK6LKMAEiAR2+A5hbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nqecch5h60s4sbAZM1wIXCrNJShBVguiffUjdkhyRBjBBKj8jw+8FZbMbZ2Ub10oBWjX0wD+0tYDbfnLhASFO6UHOEYN6K03QQg2TUu+UJ3A/zBzr5slT0CsRKMwjLWMZxLB7G19uqoFxlrShdDB/ux8hdkWXIb5tzVwJJiDzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5t5HWNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B01AC4CEF4;
	Fri, 11 Jul 2025 11:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234176;
	bh=uWtTkGexBgSTA1K24PDjaLHTbOK6LKMAEiAR2+A5hbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5t5HWNlhTJzVZFFr6g+S4vtc/FkkLi6RwraeOXiQsQyF3TrrGJme7b4LYH4iBMXm
	 kPPxb2pbAF4Xg3r/7nJgUPd6qlyGisSfQwRFQBWXX1K93e/1psmM0zeybhDkt1Go1K
	 K4Dpfz4umaY0968DuRqrpQUR9x6wDEOWuLFKw8EdNiTy2YfTozb638B093fk5Djsli
	 3uCO87KTa9yBgqFC8SQRDqdC9HO4rNjm//Vcix9g1Q/uf8clRIGLlUo/+FQRS3IVdu
	 wicVMq3szTNS86WO69AgldKr9Oj0qKyYp+byYiwLi3FzvEYpBTLuKNd4+SUvFIe/5+
	 y2HZvqiUgtnNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v3 2/4] kernel/api: enable kerneldoc-based API specifications
Date: Fri, 11 Jul 2025 07:42:46 -0400
Message-Id: <20250711114248.2288591-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711114248.2288591-1-sashal@kernel.org>
References: <20250711114248.2288591-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow kernel developers to write API specifications directly in
kerneldoc comments, which are automatically converted to machine-readable
C macros during build.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/api/Makefile              |  21 +-
 scripts/Makefile.build           |  28 ++
 scripts/generate_api_specs.sh    |  59 +++
 scripts/kernel-doc.py            |   5 +
 scripts/lib/kdoc/kdoc_apispec.py | 623 +++++++++++++++++++++++++++++++
 scripts/lib/kdoc/kdoc_output.py  |   5 +-
 scripts/lib/kdoc/kdoc_parser.py  |  54 ++-
 7 files changed, 791 insertions(+), 4 deletions(-)
 create mode 100755 scripts/generate_api_specs.sh
 create mode 100644 scripts/lib/kdoc/kdoc_apispec.py

diff --git a/kernel/api/Makefile b/kernel/api/Makefile
index 4120ded7e5cf1..312d35179c78a 100644
--- a/kernel/api/Makefile
+++ b/kernel/api/Makefile
@@ -4,4 +4,23 @@
 #
 
 # Core API specification framework
-obj-$(CONFIG_KAPI_SPEC)		+= kernel_api_spec.o
\ No newline at end of file
+obj-$(CONFIG_KAPI_SPEC)		+= kernel_api_spec.o
+
+# Auto-generated API specifications collector
+ifeq ($(CONFIG_KAPI_SPEC),y)
+obj-$(CONFIG_KAPI_SPEC)		+= generated_api_specs.o
+
+# Find all potential apispec files (this is evaluated at make time)
+apispec-files := $(shell find $(objtree) -name "*.apispec.h" -type f 2>/dev/null)
+
+# Generate the collector file
+# Note: FORCE ensures this is always regenerated to pick up new apispec files
+$(obj)/generated_api_specs.c: $(srctree)/scripts/generate_api_specs.sh FORCE
+	$(Q)$(CONFIG_SHELL) $< $(srctree) $(objtree) > $@
+
+targets += generated_api_specs.c
+clean-files += generated_api_specs.c
+
+# Add explicit dependency on the generator script
+$(obj)/generated_api_specs.o: $(obj)/generated_api_specs.c
+endif
\ No newline at end of file
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a6461ea411f7a..5c0e44d1b6dbc 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -172,6 +172,34 @@ ifneq ($(KBUILD_EXTRA_WARN),)
         $<
 endif
 
+# Generate API spec headers from kernel-doc comments
+ifeq ($(CONFIG_KAPI_SPEC),y)
+# Function to check if a file has API specifications
+has-apispec = $(shell grep -qE '^\s*\*\s*(api-type|long-desc|context-flags|param-type|error-code|capability|signal|lock|side-effect|state-trans):' $(src)/$(1) 2>/dev/null && echo $(1))
+
+# Get base names without directory prefix
+c-objs-base := $(notdir $(real-obj-y) $(real-obj-m))
+# Filter to only .o files with corresponding .c source files
+c-files := $(foreach o,$(c-objs-base),$(if $(wildcard $(src)/$(o:.o=.c)),$(o:.o=.c)))
+# Also check for any additional .c files that contain API specs but are included
+extra-c-files := $(shell find $(src) -maxdepth 1 -name "*.c" -exec grep -l '^\s*\*\s*\(api-type\|long-desc\|context-flags\|param-type\|error-code\|capability\|signal\|lock\|side-effect\|state-trans\):' {} \; 2>/dev/null | xargs -r basename -a)
+# Combine both lists and remove duplicates
+all-c-files := $(sort $(c-files) $(extra-c-files))
+# Only include files that actually have API specifications
+apispec-files := $(foreach f,$(all-c-files),$(call has-apispec,$(f)))
+# Generate apispec targets with proper directory prefix
+apispec-y := $(addprefix $(obj)/,$(apispec-files:.c=.apispec.h))
+always-y += $(apispec-y)
+targets += $(apispec-y)
+
+quiet_cmd_apispec = APISPEC $@
+      cmd_apispec = PYTHONDONTWRITEBYTECODE=1 $(KERNELDOC) -apispec \
+                    $(KDOCFLAGS) $< > $@ 2>/dev/null || rm -f $@
+
+$(obj)/%.apispec.h: $(src)/%.c FORCE
+	$(call if_changed,apispec)
+endif
+
 # Compile C sources (.c)
 # ---------------------------------------------------------------------------
 
diff --git a/scripts/generate_api_specs.sh b/scripts/generate_api_specs.sh
new file mode 100755
index 0000000000000..1ef817c0d1955
--- /dev/null
+++ b/scripts/generate_api_specs.sh
@@ -0,0 +1,59 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# generate_api_specs.sh - Generate C file that includes all API specification headers
+#
+# Usage: generate_api_specs.sh <srctree> <objtree>
+
+SRCTREE="$1"
+OBJTREE="$2"
+
+if [ -z "$SRCTREE" ] || [ -z "$OBJTREE" ]; then
+    echo "Usage: $0 <srctree> <objtree>" >&2
+    exit 1
+fi
+
+# Generate header
+cat <<EOF
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Auto-generated file - DO NOT EDIT
+ * Generated by: scripts/generate_api_specs.sh
+ *
+ * This file includes all kernel API specification headers
+ */
+
+#include <linux/kernel.h>
+#include <linux/kernel_api_spec.h>
+#include <linux/errno.h>
+#include <linux/capability.h>
+#include <uapi/linux/sched/types.h>
+
+#ifdef CONFIG_KAPI_SPEC
+
+EOF
+
+# Find all .apispec.h files and generate includes
+# We look in the object tree since that's where they're generated
+find "$OBJTREE" -name "*.apispec.h" -type f 2>/dev/null | \
+    grep -v "/generated_api_specs.c" | \
+    sort | \
+    while read -r apispec_file; do
+        # Get relative path from objtree
+        rel_path="${apispec_file#$OBJTREE/}"
+
+        # Skip if file is empty
+        if [ ! -s "$apispec_file" ]; then
+            continue
+        fi
+
+        # Generate include statement
+        # For includes from kernel/api/, we need to go up two levels
+        echo "#include \"../../${rel_path}\""
+    done
+
+# Close the ifdef
+cat <<EOF
+
+#endif /* CONFIG_KAPI_SPEC */
+EOF
\ No newline at end of file
diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index 12ae66f40bd7d..8e0be6b3eacef 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -109,6 +109,7 @@ sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
 
 from kdoc_files import KernelFiles                      # pylint: disable=C0413
 from kdoc_output import RestFormat, ManFormat           # pylint: disable=C0413
+from kdoc_apispec import ApiSpecFormat                  # pylint: disable=C0413
 
 DESC = """
 Read C language source or header FILEs, extract embedded documentation comments,
@@ -225,6 +226,8 @@ def main():
                          help="Output reStructuredText format (default).")
     out_fmt.add_argument("-N", "-none", "--none", action="store_true",
                          help="Do not output documentation, only warnings.")
+    out_fmt.add_argument("-apispec", "--apispec", action="store_true",
+                         help="Output C macro invocations for kernel API specifications.")
 
     # Output selection mutually-exclusive group
 
@@ -275,6 +278,8 @@ def main():
         out_style = ManFormat(modulename=args.modulename)
     elif args.none:
         out_style = None
+    elif args.apispec:
+        out_style = ApiSpecFormat()
     else:
         out_style = RestFormat()
 
diff --git a/scripts/lib/kdoc/kdoc_apispec.py b/scripts/lib/kdoc/kdoc_apispec.py
new file mode 100644
index 0000000000000..129fe5bf236a4
--- /dev/null
+++ b/scripts/lib/kdoc/kdoc_apispec.py
@@ -0,0 +1,623 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Generate C macro invocations for kernel API specifications from kernel-doc comments.
+
+This module creates C header files with API specification macros that match
+the kernel API specification framework introduced in commit 9688de5c25bed.
+"""
+
+from kdoc_output import OutputFormat
+
+
+class ApiSpecFormat(OutputFormat):
+    """Generate C macro invocations for kernel API specifications"""
+
+    def __init__(self):
+        """Initialize ApiSpecFormat"""
+        super().__init__()
+        self.api_specs = {}
+
+    def _format_macro_param(self, value):
+        """Format a value for use in C macro parameter"""
+        if value is None:
+            return '""'
+        # Escape quotes and backslashes for C string literals
+        value = str(value).replace('\\', '\\\\').replace('"', '\\"')
+        # Handle multi-line strings by replacing newlines with escaped newlines
+        value = value.replace('\n', '\\n"\n\t\t       "')
+        return f'"{value}"'
+
+    def _get_api_section_value(self, sections, key):
+        """Get value from API sections"""
+        # sections is a dictionary where keys are section names
+        # Check both with and without @ prefix
+        if key in sections:
+            content = sections[key]
+            # Return full content, stripping trailing newlines
+            return content.rstrip('\n')
+        elif '@' + key in sections:
+            content = sections['@' + key]
+            return content.rstrip('\n')
+        return None
+
+    def _get_all_section_lines(self, sections, key):
+        """Get all lines from a section"""
+        if key in sections:
+            return [line.strip() for line in sections[key].strip().split('\n') if line.strip()]
+        elif '@' + key in sections:
+            return [line.strip() for line in sections['@' + key].strip().split('\n') if line.strip()]
+        return []
+
+    def _process_error_code(self, error_lines, error_idx):
+        """Process a multi-line error code specification"""
+        if not error_lines:
+            return
+
+        # First line has: -ECODE, NAME, Short desc, Long desc
+        first_line = error_lines[0]
+        parts = first_line.split(',', 3)
+        if len(parts) >= 3:
+            code = parts[0].strip()
+            name = parts[1].strip()
+            short_desc = parts[2].strip()
+
+            # Collect long description from remaining parts and lines
+            long_desc_parts = []
+            if len(parts) > 3:
+                long_desc_parts.append(parts[3].strip())
+            # Add continuation lines
+            for line in error_lines[1:]:
+                long_desc_parts.append(line.strip())
+            long_desc = ' '.join(long_desc_parts)
+
+            self.data += f"\n\tKAPI_ERROR({error_idx}, {code}, {self._format_macro_param(name)}, "
+            self.data += f"{self._format_macro_param(short_desc)},\n\t\t   {self._format_macro_param(long_desc)})\n"
+
+    def _parse_param_spec(self, param_name, sections):
+        """Parse all specifications for a parameter"""
+        specs = {}
+
+        # Look for parameter-specific sections
+        for key, content in sections.items():
+            # Check both param- and @param- prefixes
+            if key.startswith('param-') or key.startswith('@param-'):
+                # Remove @ prefix if present for specs key
+                specs_key = key[1:] if key.startswith('@') else key
+
+                # Each section may contain multiple parameter specifications
+                # separated by newlines
+                for line in content.strip().split('\n'):
+                    line = line.strip()
+                    if ',' in line and line.split(',', 1)[0].strip() == param_name:
+                        value = line.split(',', 1)[1].strip()
+                        specs[specs_key] = value
+                        break  # Found this parameter's value for this key
+
+        return specs
+
+    def out_function(self, fname, name, args):
+        """Generate API spec for a function"""
+        function_name = args.get('function', '')
+        sections = args.get('sections', {})
+        parameterlist = args.get('parameterlist', [])
+        parameterdescs = args.get('parameterdescs', {})
+        parametertypes = args.get('parametertypes', {})
+        purpose = args.get('purpose', '')
+
+        # Check if this function has an API specification
+        # Look for key API spec sections that indicate this is a full API specification
+        api_indicators = [
+            'api-type', 'context-flags', 'param-type', 'error-code',
+            'capability', 'signal', 'lock', 'side-effect', 'state-trans'
+        ]
+
+        has_api_spec = False
+        for indicator in api_indicators:
+            # Check both with and without @ prefix
+            if any(key.startswith(indicator) or key.startswith('@' + indicator) for key in sections.keys()):
+                has_api_spec = True
+                break
+
+        if not has_api_spec:
+            return
+
+        # Clear warnings for API spec output since parameter-specific sections
+        # trigger false warnings
+        args['warnings'] = []
+
+
+        # Start building the macro invocation
+        self.data += f"DEFINE_KERNEL_API_SPEC({function_name})\n"
+
+        # Add description
+        if purpose:
+            self.data += f"\tKAPI_DESCRIPTION({self._format_macro_param(purpose)})\n"
+
+        # Add long description if present
+        long_desc = self._get_api_section_value(sections, 'long-desc')
+        if long_desc:
+            self.data += f"\tKAPI_LONG_DESC({self._format_macro_param(long_desc)})\n"
+
+        # Add context flags
+        context_flags = self._get_api_section_value(sections, 'context-flags')
+        if context_flags:
+            self.data += f"\tKAPI_CONTEXT({context_flags})\n"
+        elif self._get_api_section_value(sections, 'context'):
+            # Fallback to simple context
+            self.data += f"\tKAPI_CONTEXT({self._get_api_section_value(sections, 'context')})\n"
+
+        # Add parameter count first
+        param_count = len(parameterlist)
+        param_count_val = self._get_api_section_value(sections, 'param-count')
+        # Note: KAPI_PARAM_COUNT doesn't exist in the current infrastructure
+        # Parameters are handled individually with KAPI_PARAM/KAPI_PARAM_END
+
+        # Process parameters
+        for param_idx, param in enumerate(parameterlist):
+            param_name = param.strip()
+            param_desc = parameterdescs.get(param_name, '')
+            param_ctype = parametertypes.get(param_name, '')
+
+            # Get all parameter specifications
+            param_specs = self._parse_param_spec(param_name, sections)
+
+            self.data += f"\n\tKAPI_PARAM({param_idx}, {self._format_macro_param(param_name)}, "
+            self.data += f"{self._format_macro_param(param_ctype)}, {self._format_macro_param(param_desc)})\n"
+
+            # Add parameter type
+            if 'param-type' in param_specs:
+                self.data += f"\t\tKAPI_PARAM_TYPE({param_specs['param-type']})\n"
+
+            # Add parameter flags
+            if 'param-flags' in param_specs:
+                self.data += f"\t\tKAPI_PARAM_FLAGS({param_specs['param-flags']})\n"
+
+            # Add constraint type
+            if 'param-constraint-type' in param_specs:
+                self.data += f"\t\tKAPI_PARAM_CONSTRAINT_TYPE({param_specs['param-constraint-type']})\n"
+
+            # Add range
+            if 'param-range' in param_specs:
+                if ',' in param_specs['param-range']:
+                    min_val, max_val = param_specs['param-range'].split(',', 1)
+                    self.data += f"\t\tKAPI_PARAM_RANGE({min_val.strip()}, {max_val.strip()})\n"
+
+            # Add mask
+            if 'param-mask' in param_specs:
+                self.data += f"\t\tKAPI_PARAM_MASK({param_specs['param-mask']})\n"
+
+            # Add constraint description
+            if 'param-constraint' in param_specs:
+                self.data += f"\t\tKAPI_PARAM_CONSTRAINT({self._format_macro_param(param_specs['param-constraint'])})\n"
+
+            # struct-type information is stored as comments for documentation purposes
+            # The actual struct validation happens in the kernel based on param type
+
+            self.data += "\tKAPI_PARAM_END\n"
+
+        # Add return specification if we have meaningful return information
+        return_type = self._get_api_section_value(sections, 'return-type')
+        return_check = self._get_api_section_value(sections, 'return-check-type') or \
+                      self._get_api_section_value(sections, 'return-check')
+        return_success = self._get_api_section_value(sections, 'return-success')
+
+        if return_type or return_check or return_success:
+            # Get return description but don't use generic ones
+            return_desc = sections.get('return', sections.get('returns', sections.get('Return', '')))
+            if return_desc and any(phrase in return_desc.lower() for phrase in
+                                 ['error code', 'negative error', 'success or error']):
+                return_desc = ""  # Skip generic descriptions
+
+            self.data += f"\n\tKAPI_RETURN({self._format_macro_param(parametertypes.get('', 'long'))}, "
+            self.data += f"{self._format_macro_param(return_desc)})\n"
+
+            if return_type:
+                self.data += f"\t\tKAPI_RETURN_TYPE({return_type})\n"
+
+            if return_check:
+                self.data += f"\t\tKAPI_RETURN_CHECK_TYPE({return_check})\n"
+
+            if return_success:
+                self.data += f"\t\tKAPI_RETURN_SUCCESS({return_success})\n"
+
+            self.data += "\tKAPI_RETURN_END\n"
+
+        # Add error count before processing errors
+        error_lines = self._get_all_section_lines(sections, 'error-code')
+        error_count = self._get_api_section_value(sections, 'error-count')
+        if error_count:
+            self.data += f"\n\tKAPI_RETURN_ERROR_COUNT({error_count})\n"
+        else:
+            # Count the error lines
+            error_line_count = 0
+            for line in error_lines:
+                if line.startswith('-'):
+                    error_line_count += 1
+            if error_line_count > 0:
+                self.data += f"\n\tKAPI_RETURN_ERROR_COUNT({error_line_count})\n"
+
+        # Process error codes with extended format
+        error_idx = 0
+
+        # Process each error-code entry (which may span multiple lines)
+        current_error = []
+        for line in error_lines:
+            # Check if this starts a new error code (starts with -)
+            if line.startswith('-') and current_error:
+                # Process the previous error
+                self._process_error_code(current_error, error_idx)
+                error_idx += 1
+                current_error = [line]
+            else:
+                # Continuation of current error
+                current_error.append(line)
+
+        # Process the last error
+        if current_error:
+            self._process_error_code(current_error, error_idx)
+            error_idx += 1
+
+        # Add lock count before processing locks
+        lock_lines = self._get_all_section_lines(sections, 'lock')
+        lock_count = self._get_api_section_value(sections, 'lock-count')
+        if lock_count:
+            self.data += f"\n\tKAPI_LOCK_COUNT({lock_count})\n"
+        else:
+            # Count lock lines
+            lock_line_count = len(lock_lines)
+            lock_req = self._get_api_section_value(sections, 'lock-req')
+            if lock_req and lock_line_count == 0:
+                lock_line_count = 1
+            if lock_line_count > 0:
+                self.data += f"\n\tKAPI_LOCK_COUNT({lock_line_count})\n"
+
+        # Process locks
+        lock_idx = 0
+        for line in lock_lines:
+            parts = line.split(',')
+            if len(parts) >= 2:
+                lock_name = parts[0].strip()
+                lock_type = parts[1].strip()
+                self.data += f"\n\tKAPI_LOCK({lock_idx}, {self._format_macro_param(lock_name)}, {lock_type})\n"
+
+                # Check for lock attributes
+                if self._get_api_section_value(sections, 'lock-acquired'):
+                    self.data += "\t\tKAPI_LOCK_ACQUIRED\n"
+                if self._get_api_section_value(sections, 'lock-released'):
+                    self.data += "\t\tKAPI_LOCK_RELEASED\n"
+
+                lock_desc = self._get_api_section_value(sections, 'lock-desc')
+                if lock_desc:
+                    self.data += f"\t\tKAPI_LOCK_DESC({self._format_macro_param(lock_desc)})\n"
+
+                self.data += "\tKAPI_LOCK_END\n"
+                lock_idx += 1
+
+        # Legacy lock-req support
+        lock_req = self._get_api_section_value(sections, 'lock-req')
+        if lock_req and lock_idx == 0:
+            self.data += f"\n\tKAPI_LOCK(0, {self._format_macro_param(lock_req)}, KAPI_LOCK_CUSTOM)\n"
+            self.data += f"\t\tKAPI_LOCK_DESC({self._format_macro_param(lock_req)})\n"
+            self.data += "\tKAPI_LOCK_END\n"
+            lock_idx = 1
+
+        # Add constraint count before processing constraints
+        constraint_lines = self._get_all_section_lines(sections, 'constraint')
+        const_count = self._get_api_section_value(sections, 'constraint-count')
+        if const_count:
+            self.data += f"\n\tKAPI_CONSTRAINT_COUNT({const_count})\n"
+        elif len(constraint_lines) > 0:
+            self.data += f"\n\tKAPI_CONSTRAINT_COUNT({len(constraint_lines)})\n"
+
+        # Process constraints first (before signals/capabilities/etc)
+        constraint_idx = 0
+        for line in constraint_lines:
+            parts = line.split(',', 1)
+            if parts:
+                name = parts[0].strip()
+                desc = parts[1].strip() if len(parts) > 1 else ""
+
+                self.data += f"\n\tKAPI_CONSTRAINT({constraint_idx}, {self._format_macro_param(name)},\n"
+                self.data += f"\t\t\t{self._format_macro_param(desc)})\n"
+
+                # Check for constraint expression
+                expr_lines = self._get_all_section_lines(sections, 'constraint-expr')
+                for expr_line in expr_lines:
+                    if expr_line.startswith(name):
+                        expr = expr_line.split(',', 1)[1].strip() if ',' in expr_line else ""
+                        self.data += f"\t\tKAPI_CONSTRAINT_EXPR({self._format_macro_param(expr)})\n"
+                        break
+
+                self.data += "\tKAPI_CONSTRAINT_END\n"
+                constraint_idx += 1
+
+        # Process signals
+        signal_idx = 0
+        signal_lines = self._get_all_section_lines(sections, 'signal')
+        signal_count = self._get_api_section_value(sections, 'signal-count')
+
+        if signal_count:
+            self.data += f"\n\tKAPI_SIGNAL_COUNT({signal_count})\n"
+        elif len(signal_lines) > 0:
+            self.data += f"\n\tKAPI_SIGNAL_COUNT({len(signal_lines)})\n"
+
+        for line in signal_lines:
+            # Remove this redundant signal count check
+
+            self.data += f"\n\tKAPI_SIGNAL({signal_idx}, 0, {self._format_macro_param(line)}, "
+
+            # Add signal direction
+            signal_dir = self._get_api_section_value(sections, 'signal-direction')
+            if signal_dir:
+                self.data += f"{signal_dir}, "
+            else:
+                self.data += "KAPI_SIGNAL_RECEIVE, "
+
+            # Add signal action
+            signal_action = self._get_api_section_value(sections, 'signal-action')
+            if signal_action:
+                self.data += f"{signal_action})\n"
+            else:
+                self.data += "KAPI_SIGNAL_ACTION_RETURN)\n"
+
+            # Add signal attributes
+            signal_cond = self._get_api_section_value(sections, 'signal-condition')
+            if signal_cond:
+                self.data += f"\t\tKAPI_SIGNAL_CONDITION({self._format_macro_param(signal_cond)})\n"
+
+            signal_desc = self._get_api_section_value(sections, 'signal-desc')
+            if signal_desc:
+                self.data += f"\t\tKAPI_SIGNAL_DESC({self._format_macro_param(signal_desc)})\n"
+
+            signal_error = self._get_api_section_value(sections, 'signal-error')
+            if signal_error:
+                self.data += f"\t\tKAPI_SIGNAL_ERROR({signal_error})\n"
+
+            signal_timing = self._get_api_section_value(sections, 'signal-timing')
+            if signal_timing:
+                self.data += f"\t\tKAPI_SIGNAL_TIMING({signal_timing})\n"
+
+            signal_priority = self._get_api_section_value(sections, 'signal-priority')
+            if signal_priority:
+                self.data += f"\t\tKAPI_SIGNAL_PRIORITY({signal_priority})\n"
+
+            if self._get_api_section_value(sections, 'signal-interruptible'):
+                self.data += "\t\tKAPI_SIGNAL_INTERRUPTIBLE\n"
+
+            signal_state = self._get_api_section_value(sections, 'signal-state-req')
+            if signal_state:
+                self.data += f"\t\tKAPI_SIGNAL_STATE_REQ({signal_state})\n"
+
+            self.data += "\tKAPI_SIGNAL_END\n"
+            signal_idx += 1
+
+        # Process side effects
+        side_effect_lines = self._get_all_section_lines(sections, 'side-effect')
+        effect_count = self._get_api_section_value(sections, 'side-effect-count')
+        if effect_count:
+            self.data += f"\n\tKAPI_SIDE_EFFECT_COUNT({effect_count})\n"
+        elif len(side_effect_lines) > 0:
+            self.data += f"\n\tKAPI_SIDE_EFFECT_COUNT({len(side_effect_lines)})\n"
+
+        # Actually process side effects
+        side_effect_idx = 0
+        for line in side_effect_lines:
+            # Parse: type, target, description[, key=value pairs]
+            # First extract any key=value pairs at the end
+            import re
+
+            # Extract condition=... and reversible=yes
+            condition = None
+            reversible = False
+
+            # Look for condition=... pattern
+            cond_match = re.search(r',\s*condition=([^,]+?)(?:\s*,\s*reversible=yes\s*)?$', line)
+            if cond_match:
+                condition = cond_match.group(1).strip()
+                line = line[:cond_match.start()]  # Remove condition from line
+
+            # Check for reversible=yes
+            if line.endswith(', reversible=yes'):
+                reversible = True
+                line = line[:-len(', reversible=yes')]
+            elif ', reversible=yes,' in line:
+                reversible = True
+                line = line.replace(', reversible=yes,', ',')
+
+            # Now parse the main parts
+            parts = line.split(',', 2)
+            if len(parts) >= 2:
+                effect_type = parts[0].strip()
+                target = parts[1].strip()
+                desc = parts[2].strip() if len(parts) > 2 else ""
+
+                self.data += f"\n\tKAPI_SIDE_EFFECT({side_effect_idx}, {effect_type},\n"
+                self.data += f"\t\t\t {self._format_macro_param(target)},\n"
+                self.data += f"\t\t\t {self._format_macro_param(desc)})\n"
+
+                if condition:
+                    self.data += f"\t\tKAPI_EFFECT_CONDITION({self._format_macro_param(condition)})\n"
+
+                if reversible:
+                    self.data += "\t\tKAPI_EFFECT_REVERSIBLE\n"
+
+                self.data += "\tKAPI_SIDE_EFFECT_END\n"
+                side_effect_idx += 1
+
+        # Process state transitions
+        state_trans_lines = self._get_all_section_lines(sections, 'state-trans')
+        trans_count = self._get_api_section_value(sections, 'state-trans-count')
+        if trans_count:
+            self.data += f"\n\tKAPI_STATE_TRANS_COUNT({trans_count})\n"
+        elif len(state_trans_lines) > 0:
+            self.data += f"\n\tKAPI_STATE_TRANS_COUNT({len(state_trans_lines)})\n"
+
+        state_trans_idx = 0
+        for line in state_trans_lines:
+            parts = line.split(',', 3)
+            if len(parts) >= 3:
+                target = parts[0].strip()
+                from_state = parts[1].strip()
+                to_state = parts[2].strip()
+                desc = parts[3].strip() if len(parts) > 3 else ""
+
+                self.data += f"\n\tKAPI_STATE_TRANS({state_trans_idx}, {self._format_macro_param(target)}, "
+                self.data += f"{self._format_macro_param(from_state)}, {self._format_macro_param(to_state)},\n"
+                self.data += f"\t\t\t {self._format_macro_param(desc)})\n"
+                self.data += "\tKAPI_STATE_TRANS_END\n"
+                state_trans_idx += 1
+
+        # Process capabilities
+        cap_lines = self._get_all_section_lines(sections, 'capability')
+        cap_count = self._get_api_section_value(sections, 'capability-count')
+        if cap_count:
+            self.data += f"\n\tKAPI_CAPABILITY_COUNT({cap_count})\n"
+        elif len(cap_lines) > 0:
+            self.data += f"\n\tKAPI_CAPABILITY_COUNT({len(cap_lines)})\n"
+
+        cap_idx = 0
+        for line in cap_lines:
+            parts = line.split(',', 2)
+            if len(parts) >= 2:
+                cap_name = parts[0].strip()
+                cap_type = parts[1].strip()
+                cap_desc = parts[2].strip() if len(parts) > 2 else cap_name
+
+                self.data += f"\n\tKAPI_CAPABILITY({cap_idx}, {cap_name}, {self._format_macro_param(cap_desc)}, {cap_type})\n"
+
+                # Check for capability attributes
+                cap_allows = self._get_api_section_value(sections, 'capability-allows')
+                if cap_allows:
+                    self.data += f"\t\tKAPI_CAP_ALLOWS({self._format_macro_param(cap_allows)})\n"
+
+                cap_without = self._get_api_section_value(sections, 'capability-without')
+                if cap_without:
+                    self.data += f"\t\tKAPI_CAP_WITHOUT({self._format_macro_param(cap_without)})\n"
+
+                cap_cond = self._get_api_section_value(sections, 'capability-condition')
+                if cap_cond:
+                    self.data += f"\t\tKAPI_CAP_CONDITION({self._format_macro_param(cap_cond)})\n"
+
+                cap_priority = self._get_api_section_value(sections, 'capability-priority')
+                if cap_priority:
+                    self.data += f"\t\tKAPI_CAP_PRIORITY({cap_priority})\n"
+
+                self.data += "\tKAPI_CAPABILITY_END\n"
+                cap_idx += 1
+
+        # Add examples
+        examples = self._get_api_section_value(sections, 'examples')
+        if examples:
+            self.data += f"\n\tKAPI_EXAMPLES({self._format_macro_param(examples)})\n"
+
+        # Add notes
+        notes = self._get_api_section_value(sections, 'notes')
+        if notes:
+            self.data += f"\tKAPI_NOTES({self._format_macro_param(notes)})\n"
+
+        # Process struct specifications
+        struct_types = {}
+        # Find all unique struct types from struct-type and struct-field sections
+        struct_type_lines = self._get_all_section_lines(sections, 'struct-type')
+        for line in struct_type_lines:
+            parts = line.split(',', 1)
+            if len(parts) >= 2:
+                struct_name = parts[1].strip()
+                if struct_name not in struct_types:
+                    struct_types[struct_name] = {'fields': []}
+
+        # Collect struct fields
+        struct_field_lines = self._get_all_section_lines(sections, 'struct-field')
+        current_struct = None
+        if struct_types:
+            # Get the first struct type as the current one
+            current_struct = list(struct_types.keys())[0]
+
+        for line in struct_field_lines:
+            parts = line.split(',', 2)
+            if len(parts) >= 3:
+                field_name = parts[0].strip()
+                field_type = parts[1].strip()
+                field_desc = parts[2].strip()
+                if current_struct and current_struct in struct_types:
+                    struct_types[current_struct]['fields'].append({
+                        'name': field_name,
+                        'type': field_type,
+                        'desc': field_desc
+                    })
+
+        # Generate struct specifications
+        if struct_types:
+            struct_count = len(struct_types)
+            self.data += f"\n\tKAPI_STRUCT_SPEC_COUNT({struct_count})\n"
+
+            struct_idx = 0
+            for struct_name, struct_info in struct_types.items():
+                self.data += f"\n\tKAPI_STRUCT_SPEC({struct_idx}, {self._format_macro_param(struct_name)}, "
+                self.data += f"{self._format_macro_param(f'Structure specification for {struct_name}')})\n"
+
+                # Add field count
+                field_count = len(struct_info['fields'])
+                if field_count > 0:
+                    self.data += f"\t\tKAPI_STRUCT_FIELD_COUNT({field_count})\n"
+
+                # Add fields
+                field_idx = 0
+                for field in struct_info['fields']:
+                    # Map common C types to KAPI types
+                    kapi_type = "KAPI_TYPE_CUSTOM"
+                    if field['type'] in ['__u32', '__u64', '__s32', '__s64', 'u32', 'u64', 's32', 's64']:
+                        if field['type'].startswith('__s') or field['type'].startswith('s'):
+                            kapi_type = "KAPI_TYPE_INT"
+                        else:
+                            kapi_type = "KAPI_TYPE_UINT"
+
+                    self.data += f"\n\t\tKAPI_STRUCT_FIELD({field_idx}, {self._format_macro_param(field['name'])}, "
+                    self.data += f"{kapi_type}, {self._format_macro_param(field['type'])}, "
+                    self.data += f"{self._format_macro_param(field['desc'])})\n"
+
+                    # Add field constraints from other sections
+                    field_range_lines = self._get_all_section_lines(sections, 'struct-field-range')
+                    for range_line in field_range_lines:
+                        if range_line.startswith(field['name'] + ','):
+                            range_parts = range_line.split(',')
+                            if len(range_parts) >= 3:
+                                self.data += f"\t\t\tKAPI_FIELD_CONSTRAINT_RANGE({range_parts[1].strip()}, {range_parts[2].strip()})\n"
+
+                    # Add enum constraints if defined
+                    field_enum_lines = self._get_all_section_lines(sections, 'struct-field-enum')
+                    for enum_line in field_enum_lines:
+                        if enum_line.startswith(field['name'] + ','):
+                            enum_parts = enum_line.split(',', 1)
+                            if len(enum_parts) >= 2:
+                                self.data += f"\t\t\tKAPI_FIELD_CONSTRAINT_ENUM({self._format_macro_param(enum_parts[1].strip())})\n"
+
+                    self.data += "\t\tKAPI_STRUCT_FIELD_END\n"
+                    field_idx += 1
+
+                self.data += "\tKAPI_STRUCT_SPEC_END\n"
+                struct_idx += 1
+
+
+        # Version information is not supported in the current KAPI infrastructure
+        # The 'since' and 'since-version' sections are ignored for now
+
+        self.data += "\nKAPI_END_SPEC;\n\n"
+
+    def out_enum(self, fname, name, args):
+        """Skip enum output for API specs"""
+        pass
+
+    def out_typedef(self, fname, name, args):
+        """Skip typedef output for API specs"""
+        pass
+
+    def out_struct(self, fname, name, args):
+        """Skip struct output for API specs"""
+        pass
+
+    def out_doc(self, fname, name, args):
+        """Skip DOC block output for API specs"""
+        pass
\ No newline at end of file
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 86102e628d917..0c47cffc25e9f 100644
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -127,7 +127,10 @@ class OutputFormat:
         warnings = args.get('warnings', [])
 
         for log_msg in warnings:
-            self.config.warning(log_msg)
+            # Skip numeric warnings (line numbers) which are false positives
+            # from parameter-specific sections like "param-constraint: name, value"
+            if not isinstance(log_msg, int):
+                self.config.warning(log_msg)
 
     def check_doc(self, name, args):
         """Check if DOC should be output"""
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 062453eefc7a3..4b43023f2a297 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -43,7 +43,25 @@ doc_decl = doc_com + KernRe(r'(\w+)', cache=False)
 # while trying to not match literal block starts like "example::"
 #
 doc_sect = doc_com + \
-            KernRe(r'\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:([^:].*)?$',
+            KernRe(r'\s*(\@[.\w\-]+|\@\.\.\.|description|context|returns?|notes?|examples?|' +
+                   r'@?api-type|@?api-version|@?param-type|@?param-flags|@?param-constraint|@?param-range|@?param-mask|' +
+                   r'@?param-constraint-type|@?param-size|@?param-alignment|@?param-enum|@?param-validate|' +
+                   r'@?param-size-param|@?param-size-multiplier|' +
+                   r'@?struct-type|@?struct-field|@?struct-field-[a-z\-]+|' +
+                   r'@?validation-group|@?validation-policy|@?validation-flag|@?validation-rule|' +
+                   r'@?error-code|@?error-condition|@?error-count|' +
+                   r'@?capability|@?capability-allows|@?capability-without|@?capability-condition|@?capability-priority|' +
+                   r'@?capability-count|' +
+                   r'@?signal|@?signal-direction|@?signal-action|@?signal-condition|@?signal-desc|@?signal-error|' +
+                   r'@?signal-timing|@?signal-priority|@?signal-interruptible|@?signal-state-req|@?signal-count|' +
+                   r'@?lock|@?lock-type|@?lock-acquired|@?lock-released|@?lock-desc|@?lock-count|' +
+                   r'@?since|@?since-version|' +
+                   r'@?context-flags|@?return-type|@?return-check|@?return-check-type|@?return-success|' +
+                   r'@?long-desc|@?constraint|@?constraint-expr|@?constraint-count|' +
+                   r'@?side-effect|@?side-effect-type|@?side-effect-desc|@?side-effect-condition|' +
+                   r'@?side-effect-reversible|@?side-effect-count|' +
+                   r'@?state-trans|@?state-trans-desc|@?state-trans-count|' +
+                   r'@?param-count|@?kapi-.*)\s*:([^:].*)?$',
                 flags=re.I, cache=False)
 
 doc_content = doc_com_body + KernRe(r'(.*)', cache=False)
@@ -159,7 +177,39 @@ class KernelEntry:
         name = self.section
         contents = self.contents
 
-        if type_param.match(name):
+        # Check if this is an API specification section
+        # These should always be treated as sections, not parameters
+        api_sections = {
+            'api-type', 'api-version', 'param-type', 'param-flags', 'param-constraint',
+            'param-range', 'param-mask', 'param-constraint-type', 'param-size',
+            'param-alignment', 'param-enum', 'param-validate', 'param-size-param',
+            'param-size-multiplier', 'struct-type', 'struct-field', 'struct-field-range',
+            'struct-field-enum', 'struct-field-mask', 'struct-field-policy',
+            'struct-field-version', 'struct-field-flag', 'struct-field-validate',
+            'validation-group', 'validation-policy', 'validation-flag', 'validation-rule',
+            'error-code', 'error-condition', 'error-count',
+            'capability', 'capability-allows', 'capability-without', 'capability-condition',
+            'capability-priority', 'capability-count', 'signal', 'signal-direction',
+            'signal-action', 'signal-condition', 'signal-desc', 'signal-error',
+            'signal-timing', 'signal-priority', 'signal-interruptible', 'signal-state-req',
+            'signal-count', 'lock', 'lock-type', 'lock-acquired', 'lock-released',
+            'lock-desc', 'lock-count', 'since', 'since-version', 'context-flags',
+            'return-type', 'return-check', 'return-check-type', 'return-success',
+            'long-desc', 'constraint', 'constraint-expr', 'constraint-count',
+            'side-effect', 'side-effect-type', 'side-effect-desc', 'side-effect-condition',
+            'side-effect-reversible', 'side-effect-count', 'state-trans',
+            'state-trans-desc', 'state-trans-count', 'param-count',
+            # Also include notes and examples which can appear with or without @
+            'notes', 'note', 'examples', 'example'
+        }
+
+        # Check if name starts with @ and matches kapi-.* pattern
+        is_api_section = (name.lower() in api_sections or
+                         (name.startswith('@') and name[1:].lower() in api_sections) or
+                         (name.lower().startswith('kapi-')) or
+                         (name.lower().startswith('@kapi-')))
+
+        if not is_api_section and type_param.match(name):
             name = type_param.group(1)
 
             self.parameterdescs[name] = contents
-- 
2.39.5


