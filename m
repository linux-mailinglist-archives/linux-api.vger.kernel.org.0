Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41EA35A266
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2019 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfF1Raq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Jun 2019 13:30:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:51702 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfF1Raq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 28 Jun 2019 13:30:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 10:30:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="163034051"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2019 10:30:44 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH] binfmt_elf: Extract .note.gnu.property from an ELF file
Date:   Fri, 28 Jun 2019 10:22:03 -0700
Message-Id: <20190628172203.797-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patch was part of the Intel Control-flow Enforcement (CET) series at:

    https://lkml.org/lkml/2019/6/6/1014.

In the discussion, we decided to look at only an ELF header's
PT_GNU_PROPERTY, which is a shortcut pointing to the file's
.note.gnu.property.

The Linux gABI extension draft is here:

    https://github.com/hjl-tools/linux-abi/wiki/linux-abi-draft.pdf.

A few existing CET-enabled binary files were built without
PT_GNU_PROPERTY; but those files' .note.gnu.property are checked by
ld-linux, not Linux.  The compatibility impact from this change is
therefore managable.

An ELF file's .note.gnu.property indicates features the executable file
can support.  For example, the property GNU_PROPERTY_X86_FEATURE_1_AND
indicates the file supports GNU_PROPERTY_X86_FEATURE_1_IBT and/or
GNU_PROPERTY_X86_FEATURE_1_SHSTK.

With this patch, if an arch needs to setup features from ELF properties,
it needs CONFIG_ARCH_USE_GNU_PROPERTY to be set, and specific
arch_parse_property() and arch_setup_property().

This work is derived from code provided by H.J. Lu <hjl.tools@gmail.com>.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 fs/Kconfig.binfmt        |   3 +
 fs/Makefile              |   1 +
 fs/binfmt_elf.c          |  20 +++
 fs/gnu_property.c        | 279 +++++++++++++++++++++++++++++++++++++++
 include/linux/elf.h      |  11 ++
 include/uapi/linux/elf.h |  14 ++
 6 files changed, 328 insertions(+)
 create mode 100644 fs/gnu_property.c

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index f87ddd1b6d72..397138ab305b 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -36,6 +36,9 @@ config COMPAT_BINFMT_ELF
 config ARCH_BINFMT_ELF_STATE
 	bool
 
+config ARCH_USE_GNU_PROPERTY
+	bool
+
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y if !BINFMT_ELF
diff --git a/fs/Makefile b/fs/Makefile
index c9aea23aba56..b69f18c14e09 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
 obj-$(CONFIG_COMPAT_BINFMT_ELF)	+= compat_binfmt_elf.o
 obj-$(CONFIG_BINFMT_ELF_FDPIC)	+= binfmt_elf_fdpic.o
 obj-$(CONFIG_BINFMT_FLAT)	+= binfmt_flat.o
+obj-$(CONFIG_ARCH_USE_GNU_PROPERTY) += gnu_property.o
 
 obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
 obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 8264b468f283..cbc6d68f4a18 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -852,6 +852,21 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			}
 	}
 
+	if (interpreter) {
+		retval = arch_parse_property(&loc->interp_elf_ex,
+					     interp_elf_phdata,
+					     interpreter, true,
+					     &arch_state);
+	} else {
+		retval = arch_parse_property(&loc->elf_ex,
+					     elf_phdata,
+					     bprm->file, false,
+					     &arch_state);
+	}
+
+	if (retval)
+		goto out_free_dentry;
+
 	/*
 	 * Allow arch code to reject the ELF at this point, whilst it's
 	 * still possible to return an error to the code that invoked
@@ -1080,6 +1095,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out_free_dentry;
 	}
 
+	retval = arch_setup_property(&arch_state);
+
+	if (retval < 0)
+		goto out_free_dentry;
+
 	if (interpreter) {
 		unsigned long interp_map_addr = 0;
 
diff --git a/fs/gnu_property.c b/fs/gnu_property.c
new file mode 100644
index 000000000000..37cd503a0c48
--- /dev/null
+++ b/fs/gnu_property.c
@@ -0,0 +1,279 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Extract an ELF file's .note.gnu.property.
+ *
+ * The path from the ELF header to the note section is the following:
+ * elfhdr->elf_phdr->elf_note->property[].
+ */
+
+#include <uapi/linux/elf-em.h>
+#include <linux/processor.h>
+#include <linux/binfmts.h>
+#include <linux/elf.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/string.h>
+#include <linux/compat.h>
+
+/*
+ * The .note.gnu.property layout:
+ *
+ *	struct elf_note {
+ *		u32 n_namesz; --> sizeof(n_name[]); always (4)
+ *		u32 n_ndescsz;--> sizeof(property[])
+ *		u32 n_type;   --> always NT_GNU_PROPERTY_TYPE_0 (5)
+ *	};
+ *	char n_name[4]; --> always 'GNU\0'
+ *
+ *	struct {
+ *		struct gnu_property {
+ *			u32 pr_type;
+ *			u32 pr_datasz;
+ *		};
+ *		u8 pr_data[pr_datasz];
+ *	}[];
+ */
+
+typedef bool (test_item_fn)(void *buf, u32 *arg, u32 type);
+typedef void *(next_item_fn)(void *buf, u32 *arg, u32 type);
+
+static bool test_property(void *buf, u32 *max_type, u32 pr_type)
+{
+	struct gnu_property *pr = buf;
+
+	/*
+	 * Property types must be in ascending order.
+	 * Keep track of the max when testing each.
+	 */
+	if (pr->pr_type > *max_type)
+		*max_type = pr->pr_type;
+
+	return (pr->pr_type == pr_type);
+}
+
+static void *next_property(void *buf, u32 *max_type, u32 pr_type)
+{
+	struct gnu_property *pr = buf;
+
+	if ((buf + sizeof(*pr) + pr->pr_datasz < buf) ||
+	    (pr->pr_type > pr_type) ||
+	    (pr->pr_type > *max_type))
+		return NULL;
+	else
+		return (buf + sizeof(*pr) + pr->pr_datasz);
+}
+
+/*
+ * Scan 'buf' for a pattern; return true if found.
+ * *pos is the distance from the beginning of buf to where
+ * the searched item or the next item is located.
+ */
+static int scan(u8 *buf, u32 buf_size, int item_size, test_item_fn test_item,
+		next_item_fn next_item, u32 *arg, u32 type, u32 *pos)
+{
+	int found = 0;
+	u8 *p, *max;
+
+	max = buf + buf_size;
+	if (max < buf)
+		return 0;
+
+	p = buf;
+
+	while ((p + item_size < max) && (p + item_size > buf)) {
+		if (test_item(p, arg, type)) {
+			found = 1;
+			break;
+		}
+
+		p = next_item(p, arg, type);
+	}
+
+	*pos = (p + item_size <= buf) ? 0 : (u32)(p - buf);
+	return found;
+}
+
+/*
+ * Search an NT_GNU_PROPERTY_TYPE_0 for the property of 'pr_type'.
+ */
+static int find_property(u32 pr_type, u32 *property, struct file *file,
+			 loff_t file_offset, unsigned long desc_size)
+{
+	u8 *buf;
+	int buf_size;
+
+	u32 buf_pos;
+	unsigned long read_size;
+	unsigned long done;
+	int found = 0;
+	int ret = 0;
+	u32 last_pr = 0;
+
+	*property = 0;
+	buf_pos = 0;
+
+	buf_size = (desc_size > PAGE_SIZE) ? PAGE_SIZE : desc_size;
+	buf = kmalloc(buf_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	for (done = 0; done < desc_size; done += buf_pos) {
+		read_size = desc_size - done;
+		if (read_size > buf_size)
+			read_size = buf_size;
+
+		ret = kernel_read(file, buf, read_size, &file_offset);
+
+		if (ret != read_size)
+			return (ret < 0) ? ret : -EIO;
+
+		ret = 0;
+		found = scan(buf, read_size, sizeof(struct gnu_property),
+			     test_property, next_property,
+			     &last_pr, pr_type, &buf_pos);
+
+		if ((!buf_pos) || found)
+			break;
+
+		file_offset += buf_pos - read_size;
+	}
+
+	if (found) {
+		struct gnu_property *pr =
+			(struct gnu_property *)(buf + buf_pos);
+
+		if (pr->pr_datasz == 4) {
+			u32 *max =  (u32 *)(buf + read_size);
+			u32 *data = (u32 *)((u8 *)pr + sizeof(*pr));
+
+			if (data + 1 <= max) {
+				*property = *data;
+			} else {
+				file_offset += buf_pos - read_size;
+				file_offset += sizeof(*pr);
+				ret = kernel_read(file, property, 4,
+						  &file_offset);
+			}
+		}
+	}
+
+	kfree(buf);
+	return ret;
+}
+
+/*
+ * Look at an ELF file's PT_GNU_PROPERTY for the property of pr_type.
+ *
+ * Input:
+ *	file: the file to search;
+ *	phdr: the file's elf header;
+ *	phnum: number of entries in phdr;
+ *	pr_type: the property type.
+ *
+ * Output:
+ *	The property found.
+ *
+ * Return:
+ *	Zero or error.
+ */
+
+static int scan_segments_64(struct file *file, struct elf64_phdr *phdr,
+			    int phnum, u32 pr_type, u32 *property)
+{
+	int i, err;
+
+	err = 0;
+
+	for (i = 0; i < phnum; i++, phdr++) {
+		if (phdr->p_align != 8)
+			continue;
+
+		if (phdr->p_type == PT_GNU_PROPERTY) {
+			struct elf64_note n;
+			loff_t pos;
+
+			/* read note header */
+			pos = phdr->p_offset;
+			err = kernel_read(file, &n, sizeof(n), &pos);
+			if (err < sizeof(n))
+				return -EIO;
+
+			/* find note payload offset */
+			pos = phdr->p_offset + round_up(sizeof(n) + n.n_namesz,
+							phdr->p_align);
+
+			err = find_property(pr_type, property, file,
+					    pos, n.n_descsz);
+			break;
+		}
+	}
+
+	return err;
+}
+
+static int scan_segments_32(struct file *file, struct elf32_phdr *phdr,
+			    int phnum, u32 pr_type, u32 *property)
+{
+	int i, err;
+
+	err = 0;
+
+	for (i = 0; i < phnum; i++, phdr++) {
+		if (phdr->p_align != 4)
+			continue;
+
+		if (phdr->p_type == PT_GNU_PROPERTY) {
+			struct elf32_note n;
+			loff_t pos;
+
+			/* read note header */
+			pos = phdr->p_offset;
+			err = kernel_read(file, &n, sizeof(n), &pos);
+			if (err < sizeof(n))
+				return -EIO;
+
+			/* find note payload offset */
+			pos = phdr->p_offset + round_up(sizeof(n) + n.n_namesz,
+							phdr->p_align);
+
+			err = find_property(pr_type, property, file,
+					    pos, n.n_descsz);
+			break;
+		}
+	}
+
+	return err;
+}
+
+int get_gnu_property(void *ehdr_p, void *phdr_p, struct file *f,
+		     u32 pr_type, u32 *property)
+{
+	struct elf64_hdr *ehdr64 = ehdr_p;
+	int err = 0;
+
+	*property = 0;
+
+	if (ehdr64->e_ident[EI_CLASS] == ELFCLASS64) {
+		struct elf64_phdr *phdr64 = phdr_p;
+
+		err = scan_segments_64(f, phdr64, ehdr64->e_phnum,
+				       pr_type, property);
+		if (err < 0)
+			goto out;
+	} else {
+		struct elf32_hdr *ehdr32 = ehdr_p;
+
+		if (ehdr32->e_ident[EI_CLASS] == ELFCLASS32) {
+			struct elf32_phdr *phdr32 = phdr_p;
+
+			err = scan_segments_32(f, phdr32, ehdr32->e_phnum,
+					       pr_type, property);
+			if (err < 0)
+				goto out;
+		}
+	}
+
+out:
+	return err;
+}
diff --git a/include/linux/elf.h b/include/linux/elf.h
index e3649b3e970e..c86cbfd17382 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -56,4 +56,15 @@ static inline int elf_coredump_extra_notes_write(struct coredump_params *cprm) {
 extern int elf_coredump_extra_notes_size(void);
 extern int elf_coredump_extra_notes_write(struct coredump_params *cprm);
 #endif
+
+#ifdef CONFIG_ARCH_USE_GNU_PROPERTY
+extern int arch_parse_property(void *ehdr, void *phdr, struct file *f,
+			       bool inter, struct arch_elf_state *state);
+extern int arch_setup_property(struct arch_elf_state *state);
+extern int get_gnu_property(void *ehdr_p, void *phdr_p, struct file *f,
+			    u32 pr_type, u32 *feature);
+#else
+#define arch_parse_property(ehdr, phdr, file, inter, state) (0)
+#define arch_setup_property(state) (0)
+#endif
 #endif /* _LINUX_ELF_H */
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 34c02e4290fe..530ce08467c2 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -36,6 +36,7 @@ typedef __s64	Elf64_Sxword;
 #define PT_LOPROC  0x70000000
 #define PT_HIPROC  0x7fffffff
 #define PT_GNU_EH_FRAME		0x6474e550
+#define PT_GNU_PROPERTY		0x6474e553
 
 #define PT_GNU_STACK	(PT_LOOS + 0x474e551)
 
@@ -443,4 +444,17 @@ typedef struct elf64_note {
   Elf64_Word n_type;	/* Content type */
 } Elf64_Nhdr;
 
+/* NT_GNU_PROPERTY_TYPE_0 header */
+struct gnu_property {
+  __u32 pr_type;
+  __u32 pr_datasz;
+};
+
+/* .note.gnu.property types */
+#define GNU_PROPERTY_X86_FEATURE_1_AND		0xc0000002
+
+/* Bits of GNU_PROPERTY_X86_FEATURE_1_AND */
+#define GNU_PROPERTY_X86_FEATURE_1_IBT		0x00000001
+#define GNU_PROPERTY_X86_FEATURE_1_SHSTK	0x00000002
+
 #endif /* _UAPI_LINUX_ELF_H */
-- 
2.17.1

