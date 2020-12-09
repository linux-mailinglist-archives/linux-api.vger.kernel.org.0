Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0942D4A94
	for <lists+linux-api@lfdr.de>; Wed,  9 Dec 2020 20:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbgLITaO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Dec 2020 14:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387606AbgLITaO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Dec 2020 14:30:14 -0500
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD12C061794;
        Wed,  9 Dec 2020 11:28:52 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CrnCl22QYzlhPD9;
        Wed,  9 Dec 2020 20:28:51 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4CrnCk6MT3zlppyv;
        Wed,  9 Dec 2020 20:28:50 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v26 02/12] landlock: Add ruleset and domain management
Date:   Wed,  9 Dec 2020 20:28:29 +0100
Message-Id: <20201209192839.1396820-3-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209192839.1396820-1-mic@digikod.net>
References: <20201209192839.1396820-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

A Landlock ruleset is mainly a red-black tree with Landlock rules as
nodes.  This enables quick update and lookup to match a requested
access, e.g. to a file.  A ruleset is usable through a dedicated file
descriptor (cf. following commit implementing syscalls) which enables a
process to create and populate a ruleset with new rules.

A domain is a ruleset tied to a set of processes.  This group of rules
defines the security policy enforced on these processes and their future
children.  A domain can transition to a new domain which is the
intersection of all its constraints and those of a ruleset provided by
the current process.  This modification only impact the current process.
This means that a process can only gain more constraints (i.e. lose
accesses) over time.

Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
---

Changes since v25:
* Add build-time checks for the num_layers and num_rules variables
  according to LANDLOCK_MAX_NUM_LAYERS and LANDLOCK_MAX_NUM_RULES, and
  move these limits to a dedicated file.
* Cosmetic variable renames.

Changes since v24:
* Update struct landlock_rule with a layer stack.  This reverts "Always
  intersect access rights" from v24 and also adds the ability to tie
  access rights with their policy layer.  As noted by Jann Horn, always
  intersecting access rights made some use cases uselessly more
  difficult to handle in user space.  Thanks to this new stack, we still
  have a deterministic policy behavior whatever their level in the stack
  of policies, while using a "union" of accesses when building a
  ruleset.  The implementation use a FAM to keep the access checks quick
  and memory efficient (4 bytes per layer per inode).  Update
  insert_rule() accordingly.

Changes since v23:
* Always intersect access rights.  Following the filesystem change
  logic, make ruleset updates more consistent by always intersecting
  access rights (boolean AND) instead of combining them (boolean OR) for
  the same layer.  This defensive approach could also help avoid user
  space to inadvertently allow multiple access rights for the same
  object (e.g.  write and execute access on a path hierarchy) instead of
  dealing with such inconsistency.  This can happen when there is no
  deduplication of objects (e.g. paths and underlying inodes) whereas
  they get different access rights with landlock_add_rule(2).
* Add extra checks to make sure that:
  - there is always an (allocated) object in each used rules;
  - when updating a ruleset with a new rule (i.e. not merging two
    rulesets), the ruleset doesn't contain multiple layers.
* Hide merge parameter from the public landlock_insert_rule() API.  This
  helps avoid misuse of this function.
* Replace a remaining hardcoded 1 with SINGLE_DEPTH_NESTING.

Changes since v22:
* Explicitely use RB_ROOT and SINGLE_DEPTH_NESTING (suggested by Jann
  Horn).
* Improve comments and fix spelling (suggested by Jann Horn).

Changes since v21:
* Add and clean up comments.

Changes since v18:
* Account rulesets to kmemcg.
* Remove struct holes.
* Cosmetic changes.

Changes since v17:
* Move include/uapi/linux/landlock.h and _LANDLOCK_ACCESS_FS_* to a
  following patch.

Changes since v16:
* Allow enforcement of empty ruleset, which enables deny-all policies.

Changes since v15:
* Replace layer_levels and layer_depth with a bitfield of layers, cf.
  filesystem commit.
* Rename the LANDLOCK_ACCESS_FS_{UNLINK,RMDIR} with
  LANDLOCK_ACCESS_FS_REMOVE_{FILE,DIR} because it makes sense to use
  them for the action of renaming a file or a directory, which may lead
  to the removal of the source file or directory.  Removes the
  LANDLOCK_ACCESS_FS_{LINK_TO,RENAME_FROM,RENAME_TO} which are now
  replaced with LANDLOCK_ACCESS_FS_REMOVE_{FILE,DIR} and
  LANDLOCK_ACCESS_FS_MAKE_* .
* Update the documentation accordingly and highlight how the access
  rights are taken into account.
* Change nb_rules from atomic_t to u32 because it is not use anymore by
  show_fdinfo().
* Add safeguard for level variables types.
* Check max number of rules.
* Replace struct landlock_access (self and beneath bitfields) with one
  bitfield.
* Remove useless variable.
* Add comments.

Changes since v14:
* Simplify the object, rule and ruleset management at the expense of a
  less aggressive memory freeing (contributed by Jann Horn, with
  additional modifications):
  - Make a domain immutable (remove the opportunistic cleaning).
  - Remove RCU pointers.
  - Merge struct landlock_ref and struct landlock_ruleset_elem into
    landlock_rule: get ride of rule's RCU.
  - Adjust union.
  - Remove the landlock_insert_rule() check about a new object with the
    same address as a previously disabled one, because it is not
    possible to disable a rule anymore.
  Cf. https://lore.kernel.org/lkml/CAG48ez21bEn0wL1bbmTiiu8j9jP5iEWtHOwz4tURUJ+ki0ydYw@mail.gmail.com/
* Fix nested domains by implementing a notion of layer level and depth:
  - Update landlock_insert_rule() to manage such layers.
  - Add an inherit_ruleset() helper to properly create a new domain.
  - Rename landlock_find_access() to landlock_find_rule() and return a
    full rule reference.
  - Add a layer_level and a layer_depth fields to struct landlock_rule.
  - Add a top_layer_level field to struct landlock_ruleset.
* Remove access rights that may be required for FD-only requests:
  truncate, getattr, lock, chmod, chown, chgrp, ioctl.  This will be
  handle in a future evolution of Landlock, but right now the goal is to
  lighten the code to ease review.
* Remove LANDLOCK_ACCESS_FS_OPEN and rename
  LANDLOCK_ACCESS_FS_{READ,WRITE} with a FILE suffix.
* Rename LANDLOCK_ACCESS_FS_READDIR to match the *_FILE pattern.
* Remove LANDLOCK_ACCESS_FS_MAP which was useless.
* Fix memory leak in put_hierarchy() (reported by Jann Horn).
* Fix user-after-free and rename free_ruleset() (reported by Jann Horn).
* Replace the for loops with rbtree_postorder_for_each_entry_safe().
* Constify variables.
* Only use refcount_inc() through getter helpers.
* Change Landlock_insert_ruleset_access() to
  Landlock_insert_ruleset_rule().
* Rename landlock_put_ruleset_enqueue() to landlock_put_ruleset_deferred().
* Improve kernel documentation and add a warning about the unhandled
  access/syscall families.
* Move ABI check to syscall.c .

Changes since v13:
* New implementation, inspired by the previous inode eBPF map, but
  agnostic to the underlying kernel object.

Previous changes:
https://lore.kernel.org/lkml/20190721213116.23476-7-mic@digikod.net/
---
 security/landlock/Makefile  |   2 +-
 security/landlock/limits.h  |  17 ++
 security/landlock/ruleset.c | 462 ++++++++++++++++++++++++++++++++++++
 security/landlock/ruleset.h | 161 +++++++++++++
 4 files changed, 641 insertions(+), 1 deletion(-)
 create mode 100644 security/landlock/limits.h
 create mode 100644 security/landlock/ruleset.c
 create mode 100644 security/landlock/ruleset.h

diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index cb6deefbf4c0..d846eba445bb 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
 
-landlock-y := object.o
+landlock-y := object.o ruleset.o
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
new file mode 100644
index 000000000000..b734f597bb0e
--- /dev/null
+++ b/security/landlock/limits.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Limits for different components
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#ifndef _SECURITY_LANDLOCK_LIMITS_H
+#define _SECURITY_LANDLOCK_LIMITS_H
+
+#include <linux/limits.h>
+
+#define LANDLOCK_MAX_NUM_LAYERS		64
+#define LANDLOCK_MAX_NUM_RULES		U32_MAX
+
+#endif /* _SECURITY_LANDLOCK_LIMITS_H */
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
new file mode 100644
index 000000000000..bf7ff66c1b12
--- /dev/null
+++ b/security/landlock/ruleset.c
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Ruleset management
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#include <linux/bits.h>
+#include <linux/bug.h>
+#include <linux/compiler_types.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/lockdep.h>
+#include <linux/overflow.h>
+#include <linux/rbtree.h>
+#include <linux/refcount.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#include "limits.h"
+#include "object.h"
+#include "ruleset.h"
+
+static struct landlock_ruleset *create_ruleset(void)
+{
+	struct landlock_ruleset *new_ruleset;
+
+	new_ruleset = kzalloc(sizeof(*new_ruleset), GFP_KERNEL_ACCOUNT);
+	if (!new_ruleset)
+		return ERR_PTR(-ENOMEM);
+	refcount_set(&new_ruleset->usage, 1);
+	mutex_init(&new_ruleset->lock);
+	new_ruleset->root = RB_ROOT;
+	/*
+	 * hierarchy = NULL
+	 * num_rules = 0
+	 * num_layers = 0
+	 * fs_access_mask = 0
+	 */
+	return new_ruleset;
+}
+
+struct landlock_ruleset *landlock_create_ruleset(const u32 fs_access_mask)
+{
+	struct landlock_ruleset *new_ruleset;
+
+	/* Informs about useless ruleset. */
+	if (!fs_access_mask)
+		return ERR_PTR(-ENOMSG);
+	new_ruleset = create_ruleset();
+	if (!IS_ERR(new_ruleset))
+		new_ruleset->fs_access_mask = fs_access_mask;
+	return new_ruleset;
+}
+
+static void build_check_rule(void)
+{
+	const struct landlock_rule rule = {
+		.num_layers = ~0,
+	};
+
+	BUILD_BUG_ON(rule.num_layers < LANDLOCK_MAX_NUM_LAYERS);
+}
+
+static struct landlock_rule *create_rule(
+		struct landlock_object *const object,
+		const struct landlock_layer (*const layers)[],
+		const u32 num_layers,
+		const struct landlock_layer *const new_layer)
+{
+	struct landlock_rule *new_rule;
+	u32 new_num_layers = num_layers;
+
+	build_check_rule();
+	if (new_layer) {
+		/* Should already be checked by merge_ruleset(). */
+		if (WARN_ON_ONCE(num_layers == LANDLOCK_MAX_NUM_LAYERS))
+			return ERR_PTR(-E2BIG);
+		new_num_layers++;
+	}
+	new_rule = kzalloc(struct_size(new_rule, layers, new_num_layers),
+			GFP_KERNEL_ACCOUNT);
+	if (!new_rule)
+		return ERR_PTR(-ENOMEM);
+	RB_CLEAR_NODE(&new_rule->node);
+	landlock_get_object(object);
+	new_rule->object = object;
+	new_rule->num_layers = new_num_layers;
+	if (new_layer)
+		/* Push a copy of @new_layer on the layer stack. */
+		new_rule->layers[0] = *new_layer;
+	/* Copies the original layer stack. */
+	memcpy(&new_rule->layers[new_layer ? 1 : 0], layers,
+			flex_array_size(new_rule, layers, num_layers));
+	return new_rule;
+}
+
+static void put_rule(struct landlock_rule *const rule)
+{
+	might_sleep();
+	if (!rule)
+		return;
+	landlock_put_object(rule->object);
+	kfree(rule);
+}
+
+static void build_check_ruleset(void)
+{
+	const struct landlock_ruleset ruleset = {
+		.num_rules = ~0,
+		.num_layers = ~0,
+	};
+
+	BUILD_BUG_ON(ruleset.num_rules < LANDLOCK_MAX_NUM_RULES);
+	BUILD_BUG_ON(ruleset.num_layers < LANDLOCK_MAX_NUM_LAYERS);
+}
+
+/**
+ * insert_rule - Create and insert a rule in a ruleset
+ *
+ * @ruleset: The ruleset to be updated.
+ * @object: The object to build the new rule with.  The underlying kernel
+ *          object must be held by the caller.
+ * @layers: One or multiple layers to be copied into the new rule.
+ * @num_layers: The number of @layers entries.
+
+ * When user space requests to add a new rule to a ruleset, @layers only
+ * contains one entry and this entry is not assigned to any level.  In this
+ * case, the new rule will extend @ruleset, similarly to a boolean OR between
+ * access rights.
+ *
+ * When merging a ruleset in a domain, or copying a domain, @layers will be
+ * added to @ruleset as new constraints, similarly to a boolean AND between
+ * access rights.
+ */
+static int insert_rule(struct landlock_ruleset *const ruleset,
+		struct landlock_object *const object,
+		const struct landlock_layer (*const layers)[],
+		size_t num_layers)
+{
+	struct rb_node **walker_node;
+	struct rb_node *parent_node = NULL;
+	struct landlock_rule *new_rule;
+
+	might_sleep();
+	lockdep_assert_held(&ruleset->lock);
+	if (WARN_ON_ONCE(!object || !layers))
+		return -ENOENT;
+	walker_node = &(ruleset->root.rb_node);
+	while (*walker_node) {
+		struct landlock_rule *const this = rb_entry(*walker_node,
+				struct landlock_rule, node);
+
+		if (this->object != object) {
+			parent_node = *walker_node;
+			if (this->object < object)
+				walker_node = &((*walker_node)->rb_right);
+			else
+				walker_node = &((*walker_node)->rb_left);
+			continue;
+		}
+
+		/* Only a single-level layer should match an existing rule. */
+		if (WARN_ON_ONCE(num_layers != 1))
+			return -EINVAL;
+
+		/* If there is a matching rule, updates it. */
+		if ((*layers)[0].level == 0) {
+			/*
+			 * Extends access rights when the request comes from
+			 * landlock_add_rule(2), i.e. @ruleset is not a domain.
+			 */
+			if (WARN_ON_ONCE(this->num_layers != 1))
+				return -EINVAL;
+			if (WARN_ON_ONCE(this->layers[0].level != 0))
+				return -EINVAL;
+			this->layers[0].access |= (*layers)[0].access;
+			return 0;
+		}
+
+		if (WARN_ON_ONCE(this->layers[0].level == 0))
+			return -EINVAL;
+
+		/*
+		 * Intersects access rights when it is a merge between a
+		 * ruleset and a domain.
+		 */
+		new_rule = create_rule(object, &this->layers, this->num_layers,
+				&(*layers)[0]);
+		if (IS_ERR(new_rule))
+			return PTR_ERR(new_rule);
+		rb_replace_node(&this->node, &new_rule->node, &ruleset->root);
+		put_rule(this);
+		return 0;
+	}
+
+	/* There is no match for @object. */
+	build_check_ruleset();
+	if (ruleset->num_rules == LANDLOCK_MAX_NUM_RULES)
+		return -E2BIG;
+	new_rule = create_rule(object, layers, num_layers, NULL);
+	if (IS_ERR(new_rule))
+		return PTR_ERR(new_rule);
+	rb_link_node(&new_rule->node, parent_node, walker_node);
+	rb_insert_color(&new_rule->node, &ruleset->root);
+	ruleset->num_rules++;
+	return 0;
+}
+
+static void build_check_layer(void)
+{
+	const struct landlock_layer layer = {
+		.level = ~0,
+	};
+
+	BUILD_BUG_ON(layer.level < LANDLOCK_MAX_NUM_LAYERS);
+}
+
+int landlock_insert_rule(struct landlock_ruleset *const ruleset,
+		struct landlock_object *const object, const u32 access)
+{
+	struct landlock_layer layers[] = {{
+		.access = access,
+		/* When @level is zero, insert_rule() extends @ruleset. */
+		.level = 0,
+	}};
+
+	build_check_layer();
+	return insert_rule(ruleset, object, &layers, ARRAY_SIZE(layers));
+}
+
+static inline void get_hierarchy(struct landlock_hierarchy *const hierarchy)
+{
+	if (hierarchy)
+		refcount_inc(&hierarchy->usage);
+}
+
+static void put_hierarchy(struct landlock_hierarchy *hierarchy)
+{
+	while (hierarchy && refcount_dec_and_test(&hierarchy->usage)) {
+		const struct landlock_hierarchy *const freeme = hierarchy;
+
+		hierarchy = hierarchy->parent;
+		kfree(freeme);
+	}
+}
+
+static int merge_ruleset(struct landlock_ruleset *const dst,
+		struct landlock_ruleset *const src)
+{
+	struct landlock_rule *walker_rule, *next_rule;
+	int err = 0;
+
+	might_sleep();
+	if (!src)
+		return 0;
+	/* Only merge into a domain. */
+	if (WARN_ON_ONCE(!dst || !dst->hierarchy))
+		return -EINVAL;
+
+	/*
+	 * The ruleset being modified (@dst) is locked first, then the ruleset
+	 * being copied (@src).
+	 */
+	mutex_lock(&dst->lock);
+	mutex_lock_nested(&src->lock, SINGLE_DEPTH_NESTING);
+	/*
+	 * Makes a new layer, but only increments the number of layers after
+	 * the rules are inserted.  The layer 0 is invalid, and the last layer
+	 * is then LANDLOCK_MAX_NUM_LAYERS.
+	 */
+	if (dst->num_layers == LANDLOCK_MAX_NUM_LAYERS) {
+		err = -E2BIG;
+		goto out_unlock;
+	}
+	dst->fs_access_mask |= src->fs_access_mask;
+
+	/* Merges the @src tree. */
+	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule,
+			&src->root, node) {
+		struct landlock_layer layers[] = {{
+			.level = dst->num_layers + 1,
+		}};
+
+		if (WARN_ON_ONCE(walker_rule->num_layers != 1)) {
+			err = -EINVAL;
+			goto out_unlock;
+		}
+		if (WARN_ON_ONCE(walker_rule->layers[0].level != 0)) {
+			err = -EINVAL;
+			goto out_unlock;
+		}
+		layers[0].access = walker_rule->layers[0].access;
+		err = insert_rule(dst, walker_rule->object, &layers,
+				ARRAY_SIZE(layers));
+		if (err)
+			goto out_unlock;
+	}
+	dst->num_layers++;
+
+out_unlock:
+	mutex_unlock(&src->lock);
+	mutex_unlock(&dst->lock);
+	return err;
+}
+
+static struct landlock_ruleset *inherit_ruleset(
+		struct landlock_ruleset *const parent)
+{
+	struct landlock_rule *walker_rule, *next_rule;
+	struct landlock_ruleset *new_ruleset;
+	int err = 0;
+
+	might_sleep();
+	new_ruleset = create_ruleset();
+	if (IS_ERR(new_ruleset))
+		return new_ruleset;
+
+	new_ruleset->hierarchy = kzalloc(sizeof(*new_ruleset->hierarchy),
+			GFP_KERNEL_ACCOUNT);
+	if (!new_ruleset->hierarchy) {
+		err = -ENOMEM;
+		goto out_put_ruleset;
+	}
+	refcount_set(&new_ruleset->hierarchy->usage, 1);
+	if (!parent)
+		return new_ruleset;
+
+	mutex_lock(&new_ruleset->lock);
+	mutex_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
+
+	/* Copies the @parent tree. */
+	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule,
+			&parent->root, node) {
+		err = insert_rule(new_ruleset, walker_rule->object,
+				&walker_rule->layers, walker_rule->num_layers);
+		if (err)
+			goto out_unlock;
+	}
+	new_ruleset->num_layers = parent->num_layers;
+	new_ruleset->fs_access_mask = parent->fs_access_mask;
+	if (WARN_ON_ONCE(!parent->hierarchy)) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
+	get_hierarchy(parent->hierarchy);
+	new_ruleset->hierarchy->parent = parent->hierarchy;
+
+	mutex_unlock(&parent->lock);
+	mutex_unlock(&new_ruleset->lock);
+	return new_ruleset;
+
+out_unlock:
+	mutex_unlock(&parent->lock);
+	mutex_unlock(&new_ruleset->lock);
+
+out_put_ruleset:
+	landlock_put_ruleset(new_ruleset);
+	return ERR_PTR(err);
+}
+
+static void free_ruleset(struct landlock_ruleset *const ruleset)
+{
+	struct landlock_rule *freeme, *next;
+
+	might_sleep();
+	rbtree_postorder_for_each_entry_safe(freeme, next, &ruleset->root,
+			node)
+		put_rule(freeme);
+	put_hierarchy(ruleset->hierarchy);
+	kfree(ruleset);
+}
+
+void landlock_put_ruleset(struct landlock_ruleset *const ruleset)
+{
+	might_sleep();
+	if (ruleset && refcount_dec_and_test(&ruleset->usage))
+		free_ruleset(ruleset);
+}
+
+static void free_ruleset_work(struct work_struct *const work)
+{
+	struct landlock_ruleset *ruleset;
+
+	ruleset = container_of(work, struct landlock_ruleset, work_free);
+	free_ruleset(ruleset);
+}
+
+void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
+{
+	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
+		INIT_WORK(&ruleset->work_free, free_ruleset_work);
+		schedule_work(&ruleset->work_free);
+	}
+}
+
+/**
+ * landlock_merge_ruleset - Merge a ruleset with a domain
+ *
+ * @parent: Parent domain.
+ * @ruleset: New ruleset to be merged.
+ *
+ * Returns the intersection of @parent and @ruleset, or returns @parent if
+ * @ruleset is empty, or returns a duplicate of @ruleset if @parent is empty.
+ */
+struct landlock_ruleset *landlock_merge_ruleset(
+		struct landlock_ruleset *const parent,
+		struct landlock_ruleset *const ruleset)
+{
+	struct landlock_ruleset *new_dom;
+	int err;
+
+	might_sleep();
+	/*
+	 * Merging duplicates a ruleset, so a new ruleset cannot be
+	 * the same as the parent, but they can have similar content.
+	 */
+	if (WARN_ON_ONCE(!ruleset || parent == ruleset)) {
+		landlock_get_ruleset(parent);
+		return parent;
+	}
+
+	new_dom = inherit_ruleset(parent);
+	if (IS_ERR(new_dom))
+		return new_dom;
+
+	err = merge_ruleset(new_dom, ruleset);
+	if (err) {
+		landlock_put_ruleset(new_dom);
+		return ERR_PTR(err);
+	}
+	return new_dom;
+}
+
+/*
+ * The returned access has the same lifetime as @ruleset.
+ */
+const struct landlock_rule *landlock_find_rule(
+		const struct landlock_ruleset *const ruleset,
+		const struct landlock_object *const object)
+{
+	const struct rb_node *node;
+
+	if (!object)
+		return NULL;
+	node = ruleset->root.rb_node;
+	while (node) {
+		struct landlock_rule *this = rb_entry(node,
+				struct landlock_rule, node);
+
+		if (this->object == object)
+			return this;
+		if (this->object < object)
+			node = node->rb_right;
+		else
+			node = node->rb_left;
+	}
+	return NULL;
+}
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
new file mode 100644
index 000000000000..f99686cda94b
--- /dev/null
+++ b/security/landlock/ruleset.h
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Ruleset management
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#ifndef _SECURITY_LANDLOCK_RULESET_H
+#define _SECURITY_LANDLOCK_RULESET_H
+
+#include <linux/mutex.h>
+#include <linux/rbtree.h>
+#include <linux/refcount.h>
+#include <linux/workqueue.h>
+
+#include "object.h"
+
+/**
+ * struct landlock_layer - Access rights for a given layer
+ */
+struct landlock_layer {
+	/**
+	 * @level: Position of this layer in the layer stack.
+	 */
+	u16 level;
+	/**
+	 * @access: Bitfield of allowed actions on the kernel object.  They are
+	 * relative to the object type (e.g. %LANDLOCK_ACTION_FS_READ).
+	 */
+	u16 access;
+};
+
+/**
+ * struct landlock_rule - Access rights tied to an object
+ */
+struct landlock_rule {
+	/**
+	 * @node: Node in the ruleset's red-black tree.
+	 */
+	struct rb_node node;
+	/**
+	 * @object: Pointer to identify a kernel object (e.g. an inode).  This
+	 * is used as a key for this ruleset element.  This pointer is set once
+	 * and never modified.  It always points to an allocated object because
+	 * each rule increments the refcount of its object.
+	 */
+	struct landlock_object *object;
+	/**
+	 * @num_layers: Number of entries in @layers.
+	 */
+	u32 num_layers;
+	/**
+	 * @layers: Stack of layers, from the newest to the latest, implemented
+	 * as a flexible array member.
+	 */
+	struct landlock_layer layers[];
+};
+
+/**
+ * struct landlock_hierarchy - Node in a ruleset hierarchy
+ */
+struct landlock_hierarchy {
+	/**
+	 * @parent: Pointer to the parent node, or NULL if it is a root
+	 * Landlock domain.
+	 */
+	struct landlock_hierarchy *parent;
+	/**
+	 * @usage: Number of potential children domains plus their parent
+	 * domain.
+	 */
+	refcount_t usage;
+};
+
+/**
+ * struct landlock_ruleset - Landlock ruleset
+ *
+ * This data structure must contain unique entries, be updatable, and quick to
+ * match an object.
+ */
+struct landlock_ruleset {
+	/**
+	 * @root: Root of a red-black tree containing &struct landlock_rule
+	 * nodes.  Once a ruleset is tied to a process (i.e. as a domain), this
+	 * tree is immutable until @usage reaches zero.
+	 */
+	struct rb_root root;
+	/**
+	 * @hierarchy: Enables hierarchy identification even when a parent
+	 * domain vanishes.  This is needed for the ptrace protection.
+	 */
+	struct landlock_hierarchy *hierarchy;
+	union {
+		/**
+		 * @work_free: Enables to free a ruleset within a lockless
+		 * section.  This is only used by
+		 * landlock_put_ruleset_deferred() when @usage reaches zero.
+		 * The fields @lock, @usage, @num_layers, @num_rules and
+		 * @fs_access_mask are then unused.
+		 */
+		struct work_struct work_free;
+		struct {
+			/**
+			 * @lock: Guards against concurrent modifications of
+			 * @root, if @usage is greater than zero.
+			 */
+			struct mutex lock;
+			/**
+			 * @usage: Number of processes (i.e. domains) or file
+			 * descriptors referencing this ruleset.
+			 */
+			refcount_t usage;
+			/**
+			 * @num_rules: Number of non-overlapping (i.e. not for
+			 * the same object) rules in this ruleset.
+			 */
+			u32 num_rules;
+			/**
+			 * @num_layers: Number of layers which are used in this
+			 * ruleset.  This enables to check that all the layers
+			 * allow an access request.  A value of 0 identifies a
+			 * non-merged ruleset (i.e. not a domain).
+			 */
+			u32 num_layers;
+			/**
+			 * @fs_access_mask: Contains the subset of filesystem
+			 * actions which are restricted by a ruleset.  This is
+			 * used when merging rulesets and for user space
+			 * backward compatibility (i.e. future-proof).  Set
+			 * once and never changed for the lifetime of the
+			 * ruleset.
+			 */
+			u32 fs_access_mask;
+		};
+	};
+};
+
+struct landlock_ruleset *landlock_create_ruleset(const u32 fs_access_mask);
+
+void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
+void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
+
+int landlock_insert_rule(struct landlock_ruleset *const ruleset,
+		struct landlock_object *const object, const u32 access);
+
+struct landlock_ruleset *landlock_merge_ruleset(
+		struct landlock_ruleset *const parent,
+		struct landlock_ruleset *const ruleset);
+
+const struct landlock_rule *landlock_find_rule(
+		const struct landlock_ruleset *const ruleset,
+		const struct landlock_object *const object);
+
+static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
+{
+	if (ruleset)
+		refcount_inc(&ruleset->usage);
+}
+
+#endif /* _SECURITY_LANDLOCK_RULESET_H */
-- 
2.29.2

