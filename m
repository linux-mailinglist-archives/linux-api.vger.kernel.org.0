Return-Path: <linux-api+bounces-4581-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4BDB349E8
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 20:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B932F2A3A3D
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 18:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EF230EF94;
	Mon, 25 Aug 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuzlJ1HG"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F89030EF8E;
	Mon, 25 Aug 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145679; cv=none; b=YtMtH2QOZfsvshG2rVeiUFUmnxUNMFMd3wC3cWYA3CpVua+GEkKVxEk7/I8zrmjx6VUgD+FsXjHY7LeTOwNwY7M0nMAt95x80q6G69E2HJ+5RAdL0MR/2JxUSjcxW58eTgwtqTtUFlgJzuZpx08PZdJrLw77NUp8cpi3hPQKbNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145679; c=relaxed/simple;
	bh=857Jmd1Smi2NEavah3ADBjUJXxyyVLthI3PMgjYU/iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khhzKO7SskPbbmRVN8AdDyksfPFNtudqtSQn4gP51vd0+T5HBdPxj3lTGdjtxCt8e3IixA4l/W0+maNP4llKkAdjskbF//9kjora5EERkZZResEoyR9EsLVeaTJCZOhGLzv9Tkp9z6LSGeaW1FHHFl+mhbDFQ66UbO7+7gqI4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuzlJ1HG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795EBC116C6;
	Mon, 25 Aug 2025 18:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145679;
	bh=857Jmd1Smi2NEavah3ADBjUJXxyyVLthI3PMgjYU/iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NuzlJ1HGiWSmtxG/33+hi9FLSjG5aKprf9od+hHRaCTvXSKlRsTbbqIldVtjNyYLP
	 AmbI8CRxyrqnENyfe7FRlUMK76E6yaQqkAXGa8DuWoHpT9IMjgmIjdOw3ymqJCNHzM
	 4BkOVaEt4WR8mWnPAyz6n5pxPJI+0CHLKBF5Fj6sPlsLobvyeF+jyDm9N3dtRrUEXe
	 oB40O89nVWDvvdfwy4y9z7gWC/20l1JRz098ysoZXlJnA+BktVUzJMcPCWl4CKZcsl
	 TZVa9iUjOLwBYqXRHTkkvTbKM/00szReoIAIECNp3uwr4eVfZUUzUuhH/aCy8P3IEf
	 Z9uzaTFWRiE1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v4 2/7] kernel/api: enable kerneldoc-based API specifications
Date: Mon, 25 Aug 2025 14:14:29 -0400
Message-ID: <20250825181434.3340805-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825181434.3340805-1-sashal@kernel.org>
References: <20250825181434.3340805-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for extracting API specifications from
kernel-doc comments and generating C macro invocations for the
kernel API specification framework.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/api/Makefile              |  21 +-
 scripts/Makefile.build           |  28 ++
 scripts/generate_api_specs.sh    |  69 +++
 scripts/kernel-doc.py            |   5 +
 scripts/lib/kdoc/kdoc_apispec.py | 714 +++++++++++++++++++++++++++++++
 scripts/lib/kdoc/kdoc_output.py  |   9 +-
 scripts/lib/kdoc/kdoc_parser.py  |  50 ++-
 7 files changed, 891 insertions(+), 5 deletions(-)
 create mode 100755 scripts/generate_api_specs.sh
 create mode 100644 scripts/lib/kdoc/kdoc_apispec.py

diff --git a/kernel/api/Makefile b/kernel/api/Makefile
index 4120ded7e5cf..312d35179c78 100644
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
index d0ee33a487be..8d54b685debe 100644
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
index 000000000000..fe7797bfd135
--- /dev/null
+++ b/scripts/generate_api_specs.sh
@@ -0,0 +1,69 @@
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
+#include <linux/fcntl.h>
+#include <uapi/linux/sched/types.h>
+
+#ifdef CONFIG_KAPI_SPEC
+
+EOF
+
+# Find all .apispec.h files and generate includes
+# Look in both source tree and object tree
+(find "$SRCTREE" -name "*.apispec.h" -type f 2>/dev/null; \
+ find "$OBJTREE" -name "*.apispec.h" -type f 2>/dev/null) | \
+    grep -v "/generated_api_specs.c" | \
+    sort -u | \
+    while read -r apispec_file; do
+        # Get relative path from srctree or objtree
+        case "$apispec_file" in
+            "$SRCTREE"*)
+                rel_path="${apispec_file#$SRCTREE/}"
+                ;;
+            *)
+                rel_path="${apispec_file#$OBJTREE/}"
+                ;;
+        esac
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
+
diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index fc3d46ef519f..286471622c6c 100755
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
 
@@ -285,6 +288,8 @@ def main():
         out_style = ManFormat(modulename=args.modulename)
     elif args.none:
         out_style = None
+    elif args.apispec:
+        out_style = ApiSpecFormat()
     else:
         out_style = RestFormat()
 
diff --git a/scripts/lib/kdoc/kdoc_apispec.py b/scripts/lib/kdoc/kdoc_apispec.py
new file mode 100644
index 000000000000..7ece6848c0af
--- /dev/null
+++ b/scripts/lib/kdoc/kdoc_apispec.py
@@ -0,0 +1,714 @@
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
+import re
+
+
+# Valid KAPI effect types
+VALID_EFFECT_TYPES = {
+    'KAPI_EFFECT_NONE', 'KAPI_EFFECT_MODIFY_STATE', 'KAPI_EFFECT_PROCESS_STATE',
+    'KAPI_EFFECT_IRREVERSIBLE', 'KAPI_EFFECT_SCHEDULE', 'KAPI_EFFECT_FILESYSTEM',
+    'KAPI_EFFECT_HARDWARE', 'KAPI_EFFECT_ALLOC_MEMORY', 'KAPI_EFFECT_FREE_MEMORY',
+    'KAPI_EFFECT_SIGNAL_SEND', 'KAPI_EFFECT_FILE_POSITION', 'KAPI_EFFECT_LOCK_ACQUIRE',
+    'KAPI_EFFECT_LOCK_RELEASE', 'KAPI_EFFECT_RESOURCE_CREATE', 'KAPI_EFFECT_RESOURCE_DESTROY',
+    'KAPI_EFFECT_NETWORK'
+}
+
+# C type to KAPI type mapping
+CTYPE_TO_KAPI = {
+    '__u32': 'KAPI_TYPE_UINT', '__u64': 'KAPI_TYPE_UINT',
+    'u32': 'KAPI_TYPE_UINT', 'u64': 'KAPI_TYPE_UINT',
+    '__s32': 'KAPI_TYPE_INT', '__s64': 'KAPI_TYPE_INT',
+    's32': 'KAPI_TYPE_INT', 's64': 'KAPI_TYPE_INT',
+}
+
+
+class ApiSpecFormat(OutputFormat):
+    """Generate C macro invocations for kernel API specifications"""
+
+    def __init__(self):
+        super().__init__()
+        self.api_specs = {}
+        self.header_written = False
+
+    def msg(self, fname, name, args):
+        """Handles a single entry from kernel-doc parser"""
+        if not self.header_written:
+            self.data = self._generate_header()
+            self.header_written = True
+        else:
+            self.data = ""
+
+        result = super().msg(fname, name, args)
+        return result if result else self.data
+
+    def _generate_header(self):
+        """Generate the file header"""
+        return (
+            "/* SPDX-License-Identifier: GPL-2.0 */\n"
+            "/* Auto-generated from kerneldoc annotations - DO NOT EDIT */\n\n"
+            "#include <linux/kernel_api_spec.h>\n"
+            "#include <linux/errno.h>\n\n"
+        )
+
+    def _format_macro_param(self, value):
+        """Format a value for use in C macro parameter"""
+        if value is None:
+            return '""'
+        value = str(value).replace('\\', '\\\\').replace('"', '\\"')
+        value = value.replace('\n', '\\n"\n\t\t       "')
+        return f'"{value}"'
+
+    def _get_section(self, sections, key):
+        """Get value from sections, checking with and without @ prefix"""
+        for prefix in ['', '@']:
+            full_key = prefix + key
+            if full_key in sections:
+                content = sections[full_key].strip()
+                # Return only first line to avoid mixing sections
+                return content.split('\n')[0].strip() if content else ''
+        return None
+
+    def _get_section_lines(self, sections, key):
+        """Get all lines from a section"""
+        for prefix in ['', '@']:
+            full_key = prefix + key
+            if full_key in sections:
+                return [line.strip() for line in sections[full_key].strip().split('\n') if line.strip()]
+        return []
+
+    def _parse_indented_items(self, section_content, item_parser):
+        """Generic parser for indented items.
+
+        Args:
+            section_content: Raw section content
+            item_parser: Function that takes (lines, start_index) and returns (item, next_index)
+
+        Returns:
+            List of parsed items
+        """
+        if not section_content:
+            return []
+
+        items = []
+        lines = section_content.strip().split('\n')
+        i = 0
+
+        while i < len(lines):
+            if not lines[i].strip():
+                i += 1
+                continue
+
+            # Check if this is a main item (not indented)
+            if not lines[i].startswith((' ', '\t')):
+                item, i = item_parser(lines, i)
+                if item:
+                    items.append(item)
+            else:
+                i += 1
+
+        return items
+
+    def _parse_subfields(self, lines, start_idx):
+        """Parse indented subfields starting from start_idx+1.
+
+        Returns: (dict of subfields, next index)
+        """
+        subfields = {}
+        i = start_idx + 1
+
+        while i < len(lines) and (lines[i].startswith((' ', '\t'))):
+            line = lines[i].strip()
+            if ':' in line:
+                key, value = line.split(':', 1)
+                subfields[key.strip()] = value.strip()
+            i += 1
+
+        return subfields, i
+
+    def _parse_signal_item(self, lines, i):
+        """Parse a single signal specification"""
+        signal = {'name': lines[i].strip()}
+        subfields, next_i = self._parse_subfields(lines, i)
+
+        # Map subfields to signal attributes
+        signal.update({
+            'direction': subfields.get('direction', 'KAPI_SIGNAL_RECEIVE'),
+            'action': subfields.get('action', 'KAPI_SIGNAL_ACTION_RETURN'),
+            'condition': subfields.get('condition'),
+            'desc': subfields.get('desc'),
+            'error': subfields.get('error'),
+            'timing': subfields.get('timing'),
+            'priority': subfields.get('priority'),
+            'interruptible': subfields.get('interruptible', '').lower() == 'yes',
+            'number': subfields.get('number', '0'),
+        })
+
+        return signal, next_i
+
+    def _parse_error_item(self, lines, i):
+        """Parse a single error specification"""
+        line = lines[i].strip()
+
+        # Skip desc: lines
+        if line.startswith('desc:'):
+            return None, i + 1
+
+        # Check for error pattern
+        if not re.match(r'^[A-Z][A-Z0-9_]+,', line):
+            return None, i + 1
+
+        error = {'line': line, 'desc': ''}
+
+        # Look for desc: continuation
+        i += 1
+        desc_lines = []
+        while i < len(lines):
+            next_line = lines[i].strip()
+            if next_line.startswith('desc:'):
+                desc_lines.append(next_line[5:].strip())
+                i += 1
+            elif not next_line or re.match(r'^[A-Z][A-Z0-9_]+,', next_line):
+                break
+            else:
+                desc_lines.append(next_line)
+                i += 1
+
+        if desc_lines:
+            error['desc'] = ' '.join(desc_lines)
+
+        return error, i
+
+    def _parse_lock_item(self, lines, i):
+        """Parse a single lock specification"""
+        line = lines[i].strip()
+        if ':' not in line:
+            return None, i + 1
+
+        parts = line.split(':', 1)[1].strip().split(',', 1)
+        if len(parts) < 2:
+            return None, i + 1
+
+        lock = {
+            'name': parts[0].strip(),
+            'type': parts[1].strip()
+        }
+
+        subfields, next_i = self._parse_subfields(lines, i)
+
+        # Map boolean fields
+        for field in ['acquired', 'released', 'held-on-entry', 'held-on-exit']:
+            if subfields.get(field, '').lower() == 'true':
+                lock[field] = True
+
+        lock['desc'] = subfields.get('desc', '')
+
+        return lock, next_i
+
+    def _parse_constraint_item(self, lines, i):
+        """Parse a single constraint specification"""
+        line = lines[i].strip()
+
+        # Check for old format with comma
+        if ',' in line:
+            parts = line.split(',', 1)
+            constraint = {
+                'name': parts[0].strip(),
+                'desc': parts[1].strip() if len(parts) > 1 else '',
+                'expr': None
+            }
+        else:
+            constraint = {'name': line, 'desc': '', 'expr': None}
+
+        subfields, next_i = self._parse_subfields(lines, i)
+
+        if 'desc' in subfields:
+            constraint['desc'] = (constraint['desc'] + ' ' + subfields['desc']).strip()
+        constraint['expr'] = subfields.get('expr')
+
+        return constraint, next_i
+
+    def _parse_side_effect_item(self, lines, i):
+        """Parse a single side effect specification"""
+        line = lines[i].strip()
+
+        # Default to new format
+        effect = {
+            'type': line,
+            'target': '',
+            'desc': '',
+            'condition': None,
+            'reversible': False
+        }
+
+        # Check for old format with commas
+        if ',' in line:
+            # Handle condition and reversible flags
+            cond_match = re.search(r',\s*condition=([^,]+?)(?:\s*,\s*reversible=(yes|no)\s*)?$', line)
+            if cond_match:
+                effect['condition'] = cond_match.group(1).strip()
+                effect['reversible'] = cond_match.group(2) == 'yes'
+                line = line[:cond_match.start()]
+            elif ', reversible=yes' in line:
+                effect['reversible'] = True
+                line = line.replace(', reversible=yes', '')
+            elif ', reversible=no' in line:
+                line = line.replace(', reversible=no', '')
+
+            parts = line.split(',', 2)
+            if len(parts) >= 1:
+                effect['type'] = parts[0].strip()
+            if len(parts) >= 2:
+                effect['target'] = parts[1].strip()
+            if len(parts) >= 3:
+                effect['desc'] = parts[2].strip()
+        else:
+            # Multi-line format with subfields
+            subfields, next_i = self._parse_subfields(lines, i)
+            effect.update({
+                'target': subfields.get('target', ''),
+                'desc': subfields.get('desc', ''),
+                'condition': subfields.get('condition'),
+                'reversible': subfields.get('reversible', '').lower() == 'yes'
+            })
+            return effect, next_i
+
+        return effect, i + 1
+
+    def _parse_state_trans_item(self, lines, i):
+        """Parse a single state transition specification"""
+        line = lines[i].strip()
+
+        trans = {
+            'target': line,
+            'from': '',
+            'to': '',
+            'condition': '',
+            'desc': ''
+        }
+
+        # Check for old format with commas
+        if ',' in line:
+            parts = line.split(',', 3)
+            if len(parts) >= 1:
+                trans['target'] = parts[0].strip()
+            if len(parts) >= 2:
+                trans['from'] = parts[1].strip()
+            if len(parts) >= 3:
+                trans['to'] = parts[2].strip()
+            if len(parts) >= 4:
+                desc_part = parts[3].strip()
+                desc_parts = desc_part.split(',', 1)
+                if len(desc_parts) > 1:
+                    trans['condition'] = desc_parts[0].strip()
+                    trans['desc'] = desc_parts[1].strip()
+                else:
+                    trans['desc'] = desc_part
+            return trans, i + 1
+        else:
+            # Multi-line format with subfields
+            subfields, next_i = self._parse_subfields(lines, i)
+            trans.update({
+                'from': subfields.get('from', ''),
+                'to': subfields.get('to', ''),
+                'condition': subfields.get('condition', ''),
+                'desc': subfields.get('desc', '')
+            })
+            return trans, next_i
+
+    def _process_parameters(self, sections, parameterlist, parameterdescs, parametertypes):
+        """Process and output parameter specifications"""
+        param_count = len(parameterlist)
+        if param_count > 0:
+            self.data += f"\n\tKAPI_PARAM_COUNT({param_count})\n"
+
+        for param_idx, param in enumerate(parameterlist):
+            param_name = param.strip()
+            param_desc = parameterdescs.get(param_name, '')
+            param_ctype = parametertypes.get(param_name, '')
+
+            # Parse parameter specifications
+            param_section = sections.get('param', sections.get('@param', ''))
+            param_specs = {}
+            if param_section:
+                param_specs = self._parse_param_spec(param_section, param_name)
+
+            self.data += f"\n\tKAPI_PARAM({param_idx}, {self._format_macro_param(param_name)}, "
+            self.data += f"{self._format_macro_param(param_ctype)}, {self._format_macro_param(param_desc)})\n"
+
+            # Add parameter attributes
+            for key, macro in [
+                ('param-type', 'KAPI_PARAM_TYPE'),
+                ('param-flags', 'KAPI_PARAM_FLAGS'),
+                ('param-alignment', 'KAPI_PARAM_ALIGNMENT'),
+            ]:
+                if key in param_specs:
+                    self.data += f"\t\t{macro}({param_specs[key]})\n"
+
+            # Handle constraint type
+            if 'param-constraint-type' in param_specs:
+                ctype = param_specs['param-constraint-type']
+                if ctype == 'KAPI_CONSTRAINT_BITMASK':
+                    ctype = 'KAPI_CONSTRAINT_MASK'
+                self.data += f"\t\tKAPI_PARAM_CONSTRAINT_TYPE({ctype})\n"
+
+            # Handle range
+            if 'param-range' in param_specs and ',' in param_specs['param-range']:
+                min_val, max_val = param_specs['param-range'].split(',', 1)
+                self.data += f"\t\tKAPI_PARAM_RANGE({min_val.strip()}, {max_val.strip()})\n"
+
+            # Handle mask
+            if 'param-mask' in param_specs:
+                self.data += f"\t\tKAPI_PARAM_VALID_MASK({param_specs['param-mask']})\n"
+
+            # Handle constraint description
+            if 'param-constraint' in param_specs:
+                self.data += f"\t\tKAPI_PARAM_CONSTRAINT({self._format_macro_param(param_specs['param-constraint'])})\n"
+
+            self.data += "\tKAPI_PARAM_END\n"
+
+    def _parse_param_spec(self, section_content, param_name):
+        """Parse parameter specifications from indented format"""
+        specs = {}
+        lines = section_content.strip().split('\n')
+        current_item = None
+
+        for i, line in enumerate(lines):
+            if not line.strip():
+                continue
+
+            # Check if this is our parameter
+            if not line.startswith((' ', '\t')):
+                parts = line.strip().split(',', 1)
+                current_item = param_name if parts[0].strip() == param_name else None
+                if current_item and len(parts) > 1:
+                    specs['param-type'] = parts[1].strip()
+            elif current_item == param_name:
+                # Parse subfield
+                line = line.strip()
+                if ':' in line:
+                    key, value = line.split(':', 1)
+                    key = key.strip()
+                    value = value.strip()
+
+                    # Map to expected keys
+                    field_map = {
+                        'flags': 'param-flags',
+                        'constraint-type': 'param-constraint-type',
+                        'constraint': 'param-constraint',
+                        'range': 'param-range',
+                        'mask': 'param-mask',
+                        'valid-mask': 'param-mask',
+                        'alignment': 'param-alignment',
+                        'struct-type': 'param-struct-type',
+                    }
+
+                    if key in field_map:
+                        specs[field_map[key]] = value
+
+        return specs
+
+    def _validate_effect_type(self, effect_type):
+        """Validate and normalize effect type"""
+        if 'KAPI_EFFECT_SCHEDULER' in effect_type:
+            return effect_type.replace('KAPI_EFFECT_SCHEDULER', 'KAPI_EFFECT_SCHEDULE')
+
+        if 'KAPI_EFFECT_' in effect_type and effect_type not in VALID_EFFECT_TYPES:
+            if '|' in effect_type:
+                parts = [p.strip() for p in effect_type.split('|')]
+                valid_parts = [p if p in VALID_EFFECT_TYPES else 'KAPI_EFFECT_MODIFY_STATE' for p in parts]
+                return ' | '.join(valid_parts)
+            return 'KAPI_EFFECT_MODIFY_STATE'
+
+        return effect_type
+
+    def _has_api_spec(self, sections):
+        """Check if this function has an API specification"""
+        indicators = [
+            'api-type', 'context-flags', 'param-type', 'error-code',
+            'capability', 'signal', 'lock', 'state-trans', 'constraint',
+            'return', 'error', 'side-effects', 'struct'
+        ]
+
+        count = sum(1 for ind in indicators
+                   if any(key.lower().startswith(ind.lower()) or
+                         key.lower().startswith('@' + ind.lower())
+                         for key in sections.keys()))
+
+        return count >= 2
+
+    def out_function(self, fname, name, args):
+        """Generate API spec for a function"""
+        function_name = args.get('function', name)
+        sections = args.sections if hasattr(args, 'sections') else args.get('sections', {})
+
+        if not self._has_api_spec(sections):
+            return
+
+        parameterlist = args.parameterlist if hasattr(args, 'parameterlist') else args.get('parameterlist', [])
+        parameterdescs = args.parameterdescs if hasattr(args, 'parameterdescs') else args.get('parameterdescs', {})
+        parametertypes = args.parametertypes if hasattr(args, 'parametertypes') else args.get('parametertypes', {})
+        purpose = args.get('purpose', '')
+
+        # Start macro invocation
+        self.data += f"DEFINE_KERNEL_API_SPEC({function_name})\n"
+
+        # Basic info
+        if purpose:
+            self.data += f"\tKAPI_DESCRIPTION({self._format_macro_param(purpose)})\n"
+
+        long_desc = self._get_section(sections, 'long-desc')
+        if long_desc:
+            self.data += f"\tKAPI_LONG_DESC({self._format_macro_param(long_desc)})\n"
+
+        # Context flags
+        context = self._get_section(sections, 'context-flags') or self._get_section(sections, 'context')
+        if context:
+            self.data += f"\tKAPI_CONTEXT({context})\n"
+
+        # Process parameters
+        self._process_parameters(sections, parameterlist, parameterdescs, parametertypes)
+
+        # Process errors
+        errors = self._parse_indented_items(
+            sections.get('error', sections.get('@error', '')),
+            self._parse_error_item
+        )
+
+        if errors:
+            self.data += f"\n\tKAPI_RETURN_ERROR_COUNT({len(errors)})\n"
+            self.data += f"\n\tKAPI_ERROR_COUNT({len(errors)})\n"
+
+            for idx, error in enumerate(errors):
+                self._output_error(idx, error)
+
+        # Process signals
+        signals = self._parse_indented_items(
+            sections.get('signal', sections.get('@signal', '')),
+            self._parse_signal_item
+        )
+
+        if signals:
+            self.data += f"\n\tKAPI_SIGNAL_COUNT({len(signals)})\n"
+
+            for idx, signal in enumerate(signals):
+                self._output_signal(idx, signal)
+
+        # Process other specifications
+        self._process_locks(sections)
+        self._process_constraints(sections)
+        self._process_side_effects(sections)
+        self._process_state_transitions(sections)
+        self._process_capabilities(sections)
+
+        # Add examples and notes
+        for key, macro in [('examples', 'KAPI_EXAMPLES'), ('notes', 'KAPI_NOTES')]:
+            value = self._get_section(sections, key)
+            if value:
+                self.data += f"\n\t{macro}({self._format_macro_param(value)})\n"
+
+        self.data += "\nKAPI_END_SPEC;\n\n"
+
+    def _output_error(self, idx, error):
+        """Output a single error specification"""
+        line = error['line']
+        if line.startswith('-'):
+            line = line[1:].strip()
+
+        parts = line.split(',', 2)
+        if len(parts) == 2:
+            # Format: NAME, description
+            name = parts[0].strip()
+            short_desc = parts[1].strip()
+            code = f"-{name}"
+        elif len(parts) >= 3:
+            # Format: code, name, description
+            code = parts[0].strip()
+            name = parts[1].strip()
+            short_desc = parts[2].strip()
+            if not code.startswith('-'):
+                code = f"-{code}"
+        else:
+            return
+
+        long_desc = error.get('desc', '') or short_desc
+
+        self.data += f"\n\tKAPI_ERROR({idx}, {code}, {self._format_macro_param(name)}, "
+        self.data += f"{self._format_macro_param(short_desc)},\n\t\t   {self._format_macro_param(long_desc)})\n"
+
+    def _output_signal(self, idx, signal):
+        """Output a single signal specification"""
+        self.data += f"\n\tKAPI_SIGNAL({idx}, {signal['number']}, "
+        self.data += f"{self._format_macro_param(signal['name'])}, "
+        self.data += f"{signal['direction']}, {signal['action']})\n"
+
+        for key, macro in [
+            ('condition', 'KAPI_SIGNAL_CONDITION'),
+            ('desc', 'KAPI_SIGNAL_DESC'),
+            ('error', 'KAPI_SIGNAL_ERROR'),
+            ('timing', 'KAPI_SIGNAL_TIMING'),
+            ('priority', 'KAPI_SIGNAL_PRIORITY'),
+        ]:
+            if signal.get(key):
+                # Priority field is numeric
+                if key == 'priority':
+                    self.data += f"\t\t{macro}({signal[key]})\n"
+                else:
+                    self.data += f"\t\t{macro}({self._format_macro_param(signal[key])})\n"
+
+        if signal.get('interruptible'):
+            self.data += "\t\tKAPI_SIGNAL_INTERRUPTIBLE\n"
+
+        self.data += "\tKAPI_SIGNAL_END\n"
+
+    def _process_locks(self, sections):
+        """Process lock specifications"""
+        locks = self._parse_indented_items(
+            sections.get('lock', sections.get('@lock', '')),
+            self._parse_lock_item
+        )
+
+        if locks:
+            self.data += f"\n\tKAPI_LOCK_COUNT({len(locks)})\n"
+
+            for idx, lock in enumerate(locks):
+                self.data += f"\n\tKAPI_LOCK({idx}, {self._format_macro_param(lock['name'])}, {lock['type']})\n"
+
+                for flag in ['acquired', 'released']:
+                    if lock.get(flag):
+                        self.data += f"\t\tKAPI_LOCK_{flag.upper()}\n"
+
+                if lock.get('desc'):
+                    self.data += f"\t\tKAPI_LOCK_DESC({self._format_macro_param(lock['desc'])})\n"
+
+                self.data += "\tKAPI_LOCK_END\n"
+
+    def _process_constraints(self, sections):
+        """Process constraint specifications"""
+        constraints = self._parse_indented_items(
+            sections.get('constraint', sections.get('@constraint', '')),
+            self._parse_constraint_item
+        )
+
+        if constraints:
+            self.data += f"\n\tKAPI_CONSTRAINT_COUNT({len(constraints)})\n"
+
+            for idx, constraint in enumerate(constraints):
+                self.data += f"\n\tKAPI_CONSTRAINT({idx}, {self._format_macro_param(constraint['name'])},\n"
+                self.data += f"\t\t\t{self._format_macro_param(constraint['desc'])})\n"
+
+                if constraint.get('expr'):
+                    self.data += f"\t\tKAPI_CONSTRAINT_EXPR({self._format_macro_param(constraint['expr'])})\n"
+
+                self.data += "\tKAPI_CONSTRAINT_END\n"
+
+    def _process_side_effects(self, sections):
+        """Process side effect specifications"""
+        effects = self._parse_indented_items(
+            sections.get('side-effect', sections.get('@side-effect', '')),
+            self._parse_side_effect_item
+        )
+
+        if effects:
+            self.data += f"\n\tKAPI_SIDE_EFFECT_COUNT({len(effects)})\n"
+
+            for idx, effect in enumerate(effects):
+                effect_type = self._validate_effect_type(effect['type'])
+
+                self.data += f"\n\tKAPI_SIDE_EFFECT({idx}, {effect_type},\n"
+                self.data += f"\t\t\t {self._format_macro_param(effect['target'])},\n"
+                self.data += f"\t\t\t {self._format_macro_param(effect['desc'])})\n"
+
+                if effect.get('condition'):
+                    self.data += f"\t\tKAPI_EFFECT_CONDITION({self._format_macro_param(effect['condition'])})\n"
+
+                if effect.get('reversible'):
+                    self.data += "\t\tKAPI_EFFECT_REVERSIBLE\n"
+
+                self.data += "\tKAPI_SIDE_EFFECT_END\n"
+
+    def _process_state_transitions(self, sections):
+        """Process state transition specifications"""
+        transitions = self._parse_indented_items(
+            sections.get('state-trans', sections.get('@state-trans', '')),
+            self._parse_state_trans_item
+        )
+
+        if transitions:
+            self.data += f"\n\tKAPI_STATE_TRANS_COUNT({len(transitions)})\n"
+
+            for idx, trans in enumerate(transitions):
+                desc = trans['desc']
+                if trans.get('condition'):
+                    desc = trans['condition'] + (', ' + desc if desc else '')
+
+                self.data += f"\n\tKAPI_STATE_TRANS({idx}, {self._format_macro_param(trans['target'])}, "
+                self.data += f"{self._format_macro_param(trans['from'])}, {self._format_macro_param(trans['to'])},\n"
+                self.data += f"\t\t\t {self._format_macro_param(desc)})\n"
+                self.data += "\tKAPI_STATE_TRANS_END\n"
+
+    def _process_capabilities(self, sections):
+        """Process capability specifications"""
+        cap_section = sections.get('capability', sections.get('@capability', ''))
+        if not cap_section:
+            return
+
+        lines = cap_section.strip().split('\n')
+        capabilities = []
+        i = 0
+
+        while i < len(lines):
+            line = lines[i].strip()
+            if not line or line.startswith(('allows:', 'without:', 'condition:', 'priority:')):
+                i += 1
+                continue
+
+            cap_info = {'line': line}
+
+            # Parse subfields
+            subfields, next_i = self._parse_subfields(lines, i)
+            cap_info.update(subfields)
+            capabilities.append(cap_info)
+            i = next_i
+
+        if capabilities:
+            self.data += f"\n\tKAPI_CAPABILITY_COUNT({len(capabilities)})\n"
+
+            for idx, cap in enumerate(capabilities):
+                parts = cap['line'].split(',', 2)
+                if len(parts) >= 2:
+                    cap_name = parts[0].strip()
+                    cap_type = parts[1].strip()
+                    cap_desc = parts[2].strip() if len(parts) > 2 else cap_name
+
+                    # Fix common type issues
+                    if 'BYPASS' in cap_type and cap_type != 'KAPI_CAP_BYPASS_CHECK':
+                        cap_type = 'KAPI_CAP_BYPASS_CHECK'
+
+                    self.data += f"\n\tKAPI_CAPABILITY({idx}, {cap_name}, {self._format_macro_param(cap_desc)}, {cap_type})\n"
+
+                    for key, macro in [
+                        ('allows', 'KAPI_CAP_ALLOWS'),
+                        ('without', 'KAPI_CAP_WITHOUT'),
+                        ('condition', 'KAPI_CAP_CONDITION'),
+                        ('priority', 'KAPI_CAP_PRIORITY'),
+                    ]:
+                        if cap.get(key):
+                            value = self._format_macro_param(cap[key]) if key != 'priority' else cap[key]
+                            self.data += f"\t\t{macro}({value})\n"
+
+                    self.data += "\tKAPI_CAPABILITY_END\n"
+
+    # Skip output methods for non-function types
+    def out_enum(self, fname, name, args): pass
+    def out_typedef(self, fname, name, args): pass
+    def out_struct(self, fname, name, args): pass
+    def out_doc(self, fname, name, args): pass
\ No newline at end of file
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index ea8914537ba0..9ac8e5beddaf 100644
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -124,8 +124,13 @@ class OutputFormat:
         Output warnings for identifiers that will be displayed.
         """
 
-        for log_msg in args.warnings:
-            self.config.warning(log_msg)
+        warnings = args.get('warnings', [])
+
+        for log_msg in warnings:
+            # Skip numeric warnings (line numbers) which are false positives
+            # from parameter-specific sections like "param-constraint: name, value"
+            if not isinstance(log_msg, int):
+                self.config.warning(log_msg)
 
     def check_doc(self, name, args):
         """Check if DOC should be output"""
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index fe730099eca8..55679224d578 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -46,7 +46,21 @@ doc_decl = doc_com + KernRe(r'(\w+)', cache=False)
 known_section_names = 'description|context|returns?|notes?|examples?'
 known_sections = KernRe(known_section_names, flags = re.I)
 doc_sect = doc_com + \
-    KernRe(r'\s*(\@[.\w]+|\@\.\.\.|' + known_section_names + r')\s*:([^:].*)?$',
+    KernRe(r'\s*(\@[.\w\-]+|\@\.\.\.|' + known_section_names + r'|' +
+           r'@?api-type|@?api-version|@?param(?!-)|' +
+           r'@?struct(?!-)|@?struct-type|@?struct-field|@?struct-field-[a-z\-]+|' +
+           r'@?validation-group|@?validation-policy|@?validation-flag|@?validation-rule|' +
+           r'@?error(?!-)|@?error-code|@?error-condition|@?error-count|' +
+           r'@?capability(?!-)|' +
+           r'@?capability-count|' +
+           r'@?signal(?!-)|@?signal-count|' +
+           r'@?lock(?!-)|@?lock-count|' +
+           r'@?since|@?since-version|' +
+           r'@?context-flags|@?return(?!-)|@?return-type|@?return-check|@?return-check-type|@?return-success|@?return-desc|' +
+           r'@?long-desc|@?constraint(?!-)|@?constraint-count|' +
+           r'@?side-effect(?!-)|@?side-effect-count|' +
+           r'@?state-trans(?!-)|@?state-trans-count|' +
+           r'@?param-count|@?kapi-.*)\s*:([^:].*)?$',
            flags=re.I, cache=False)
 
 doc_content = doc_com_body + KernRe(r'(.*)', cache=False)
@@ -183,7 +197,39 @@ class KernelEntry:
         name = self.section
         contents = self.contents()
 
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
+            'error', 'error-code', 'error-condition', 'error-count',
+            'capability', 'capability-allows', 'capability-without', 'capability-condition',
+            'capability-priority', 'capability-count', 'signal', 'signal-direction',
+            'signal-action', 'signal-condition', 'signal-desc', 'signal-error',
+            'signal-timing', 'signal-priority', 'signal-interruptible', 'signal-state-req',
+            'signal-restartable', 'signal-count', 'lock', 'lock-type', 'lock-acquired', 'lock-released',
+            'lock-desc', 'lock-count', 'since', 'since-version', 'context-flags',
+            'return', 'return-type', 'return-check', 'return-check-type', 'return-success', 'return-desc',
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
2.50.1


