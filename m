Return-Path: <linux-api+bounces-385-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 652E781D5B7
	for <lists+linux-api@lfdr.de>; Sat, 23 Dec 2023 19:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8984A1C21869
	for <lists+linux-api@lfdr.de>; Sat, 23 Dec 2023 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0111D171C9;
	Sat, 23 Dec 2023 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiT4g2Qj"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265A52511A;
	Sat, 23 Dec 2023 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-28bd09e35e8so1416693a91.0;
        Sat, 23 Dec 2023 10:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703355126; x=1703959926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktKBvOizNMtREUaFHrOesptiJBwbxl5fyFxNMUuf/cI=;
        b=IiT4g2QjWrw6yQ2fUmybuPgrGxk7Szq55IZ2rtYwVEghxyJgCCzGtQ6It+rYrFvz1Y
         FvQhm4y2exIDnaTEtEINCIiAChVEAGgOKoDTd+qDIeMB7+d4iLCwHesXDqJo99208o0C
         fLKbyd9l9tD/vtpodMqMlyYfdnzCoSE76ZtJ4l+tMHa0JivSL6E5VxIe1vS5h9lDPQ58
         Qnzq1WZ/kCVTvVzKoCwSI/N6A9qiMkIY3Of69dZyTKbN3mu/u6UntgT+H51Vc1TPhf2f
         mDz9h1ffm0UZxLTZ7S9KplrJLFvf6jgOxat0cCDEQrihdHomTTcv0SZ2K4pKCYU5wrLx
         OHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703355126; x=1703959926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktKBvOizNMtREUaFHrOesptiJBwbxl5fyFxNMUuf/cI=;
        b=muYFUQrtRsquTwnGbnVttxDhGFD31pXCmEsCepEuZR9AQZ+jr3aJ52tue7A9fXluVK
         DIfLskVarRNkBg/9DAo++5vUuK20377mQmq4nO91epqTU3D3sAUaQ01ZlHR41Ff5iwOa
         tyUrkizBqHwuqWSi4Qn4a5tyXe+pbk8XsoBOEmEKG5m1n0LHIRf7ZDrNduUTqvtvPr12
         vrdi6n3KhrWsWMtq6VJZ4d5vBvsuWg8m8mDZYAB17j7/Lo+KCPdx9StcXdyBUvCYl1pU
         dQgdRM7Drdz8hYp+gbzamLbW9d32rQv3UUTArvpPk0tbBjXicUAEB41f7tgSe8Edp2bu
         TD7Q==
X-Gm-Message-State: AOJu0YxznKLHTJ7LV/nwHNHzorhwYVa7CgQKqSjtoVBJG5x97raWmpbX
	NEIJwCt9HuglTZKlvdYavw==
X-Google-Smtp-Source: AGHT+IEQEAyj53TNXOFLfTA8VfsUgMr1mgc3b7wM67YewA2cpaI7zBE5vpRRyH+qhXrMuXL7MsCifQ==
X-Received: by 2002:a05:6a20:745:b0:190:d1d2:570d with SMTP id l5-20020a056a20074500b00190d1d2570dmr1437969pzl.29.1703355126387;
        Sat, 23 Dec 2023 10:12:06 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902a5c600b001d3bfd30886sm4316396plq.37.2023.12.23.10.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 10:12:06 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	gregory.price@memverge.com,
	corbet@lwn.net,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	honggyu.kim@sk.com,
	vtavarespetr@micron.com,
	peterz@infradead.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com
Subject: [PATCH v5 11/11] mm/mempolicy: extend set_mempolicy2 and mbind2 to support weighted interleave
Date: Sat, 23 Dec 2023 13:11:01 -0500
Message-Id: <20231223181101.1954-12-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231223181101.1954-1-gregory.price@memverge.com>
References: <20231223181101.1954-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend set_mempolicy2 and mbind2 to support weighted interleave, and
demonstrate the extensibility of the mpol_args structure.

To support weighted interleave we add interleave weight fields to the
following structures:

Kernel Internal:  (include/linux/mempolicy.h)
struct mempolicy {
	/* task-local weights to apply to weighted interleave */
	unsigned char weights[MAX_NUMNODES];
}
struct mempolicy_args {
	/* Optional: interleave weights for MPOL_WEIGHTED_INTERLEAVE */
	unsigned char *il_weights;	/* of size MAX_NUMNODES */
}

UAPI: (/include/uapi/linux/mempolicy.h)
struct mpol_args {
	/* Optional: interleave weights for MPOL_WEIGHTED_INTERLEAVE */
	unsigned char *il_weights;	/* of size pol_max_nodes */
}

The task-local weights are a single, one-dimensional array of weights
that apply to all possible nodes on the system.  If a node is set in
the mempolicy nodemask, the weight in `il_weights` must be >= 1,
otherwise set_mempolicy2() will return -EINVAL.  If a node is not
set in pol_nodemask, the weight will default to `1` in the task policy.

The default value of `1` is required to handle the situation where a
task migrates to a set of nodes for which weights were not set (up to
and including the local numa node).  For example, a migrated task whose
nodemask changes entirely will have all its weights defaulted back
to `1`, or if the nodemask changes to include a mix of nodes that
were not previously accounted for - the weighted interleave may be
suboptimal.

If migrations are expected, a task should prefer not to use task-local
interleave weights, and instead utilize the global settings for natural
re-weighting on migration.

To support global vs local weighting,  we add the kernel-internal flag:
MPOL_F_GWEIGHT (1 << 5) /* Utilize global weights */

This flag is set when il_weights is omitted by set_mempolicy2(), or
when MPOL_WEIGHTED_INTERLEAVE is set by set_mempolicy(). This internal
mode_flag dictates whether global weights or task-local weights are
utilized by the the various weighted interleave functions:

* weighted_interleave_nodes
* weighted_interleave_nid
* alloc_pages_bulk_array_weighted_interleave

if (pol->flags & MPOL_F_GWEIGHT)
	pol_weights = iw_table;
else
	pol_weights = pol->wil.weights;

To simplify creations and duplication of mempolicies, the weights are
added as a structure directly within mempolicy. This allows the
existing logic in __mpol_dup to copy the weights without additional
allocations:

if (old == current->mempolicy) {
	task_lock(current);
	*new = *old;
	task_unlock(current);
} else
	*new = *old

Suggested-by: Rakie Kim <rakie.kim@sk.com>
Suggested-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Co-developed-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Co-developed-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Signed-off-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     |  10 ++
 include/linux/mempolicy.h                     |   2 +
 include/uapi/linux/mempolicy.h                |   2 +
 mm/mempolicy.c                                | 129 +++++++++++++++++-
 4 files changed, 139 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index 7edee775cd2f..4f52a9108576 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -254,6 +254,8 @@ MPOL_WEIGHTED_INTERLEAVE
 	This mode operates the same as MPOL_INTERLEAVE, except that
 	interleaving behavior is executed based on weights set in
 	/sys/kernel/mm/mempolicy/weighted_interleave/
+	when configured to utilize global weights, or based on task-local
+	weights configured with set_mempolicy2(2) or mbind2(2).
 
 	Weighted interleave allocations pages on nodes according to
 	their weight.  For example if nodes [0,1] are weighted [5,2]
@@ -261,6 +263,13 @@ MPOL_WEIGHTED_INTERLEAVE
 	2 pages allocated on node1.  This can better distribute data
 	according to bandwidth on heterogeneous memory systems.
 
+	When utilizing task-local weights, weights are not rebalanced
+	in the event of a task migration.  If a weight has not been
+	explicitly set for a node set in the new nodemask, the
+	value of that weight defaults to "1".  For this reason, if
+	migrations are expected or possible, users should consider
+	utilizing global interleave weights.
+
 NUMA memory policy supports the following optional mode flags:
 
 MPOL_F_STATIC_NODES
@@ -516,6 +525,7 @@ Extended Mempolicy Arguments::
 		__s32 home_node;	 /* mbind2: set home node */
 		__u64 pol_maxnodes;
 		__aligned_u64 pol_nodes; /* nodemask pointer */
+		__aligned_u64 il_weights;  /* u8 buf of size pol_maxnodes */
 	};
 
 The extended mempolicy argument structure is defined to allow the mempolicy
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 0f1c85527626..06ec3a3b0f22 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -58,6 +58,7 @@ struct mempolicy {
 	/* Weighted interleave settings */
 	struct {
 		unsigned char cur_weight;
+		unsigned char weights[MAX_NUMNODES];
 	} wil;
 };
 
@@ -70,6 +71,7 @@ struct mempolicy_args {
 	unsigned short mode_flags;	/* policy mode flags */
 	int home_node;			/* mbind: use MPOL_MF_HOME_NODE */
 	nodemask_t *policy_nodes;	/* get/set/mbind */
+	unsigned char *il_weights;	/* for mode MPOL_WEIGHTED_INTERLEAVE */
 };
 
 /*
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 8880b753a446..16ee2359ef55 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -33,6 +33,7 @@ struct mpol_args {
 	__s32 home_node;	/* mbind2: policy home node */
 	__u64 pol_maxnodes;
 	__aligned_u64 pol_nodes;
+	__aligned_u64 il_weights; /* size: pol_maxnodes * sizeof(char) */
 };
 
 /* Flags for set_mempolicy */
@@ -73,6 +74,7 @@ struct mpol_args {
 #define MPOL_F_SHARED  (1 << 0)	/* identify shared policies */
 #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
 #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
+#define MPOL_F_GWEIGHT	(1 << 5) /* Utilize global weights */
 
 /*
  * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b5aca779249a..6bed4151e0c2 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -271,6 +271,7 @@ static struct mempolicy *mpol_new(struct mempolicy_args *args)
 	unsigned short mode = args->mode;
 	unsigned short flags = args->mode_flags;
 	nodemask_t *nodes = args->policy_nodes;
+	int node;
 
 	if (mode == MPOL_DEFAULT) {
 		if (nodes && !nodes_empty(*nodes))
@@ -297,6 +298,19 @@ static struct mempolicy *mpol_new(struct mempolicy_args *args)
 		    (flags & MPOL_F_STATIC_NODES) ||
 		    (flags & MPOL_F_RELATIVE_NODES))
 			return ERR_PTR(-EINVAL);
+	} else if (mode == MPOL_WEIGHTED_INTERLEAVE) {
+		/* weighted interleave requires a nodemask and weights > 0 */
+		if (nodes_empty(*nodes))
+			return ERR_PTR(-EINVAL);
+		if (args->il_weights) {
+			node = first_node(*nodes);
+			while (node != MAX_NUMNODES) {
+				if (!args->il_weights[node])
+					return ERR_PTR(-EINVAL);
+				node = next_node(node, *nodes);
+			}
+		} else if (!(args->mode_flags & MPOL_F_GWEIGHT))
+			return ERR_PTR(-EINVAL);
 	} else if (nodes_empty(*nodes))
 		return ERR_PTR(-EINVAL);
 
@@ -309,6 +323,17 @@ static struct mempolicy *mpol_new(struct mempolicy_args *args)
 	policy->home_node = args->home_node;
 	policy->wil.cur_weight = 0;
 
+	if (policy->mode == MPOL_WEIGHTED_INTERLEAVE && args->il_weights) {
+		policy->wil.cur_weight = 0;
+		/* Minimum weight value is always 1 */
+		memset(policy->wil.weights, 1, MAX_NUMNODES);
+		node = first_node(*nodes);
+		while (node != MAX_NUMNODES) {
+			policy->wil.weights[node] = args->il_weights[node];
+			node = next_node(node, *nodes);
+		}
+	}
+
 	return policy;
 }
 
@@ -937,6 +962,17 @@ static void do_get_mempolicy_nodemask(struct mempolicy *pol, nodemask_t *nmask)
 	}
 }
 
+static void do_get_mempolicy_il_weights(struct mempolicy *pol,
+					unsigned char weights[MAX_NUMNODES])
+{
+	if (pol->mode != MPOL_WEIGHTED_INTERLEAVE)
+		memset(weights, 0, MAX_NUMNODES);
+	else if (pol->flags & MPOL_F_GWEIGHT)
+		memcpy(weights, iw_table, MAX_NUMNODES);
+	else
+		memcpy(weights, pol->wil.weights, MAX_NUMNODES);
+}
+
 /* Retrieve NUMA policy for a VMA assocated with a given address  */
 static long do_get_vma_mempolicy(unsigned long addr, int *addr_node,
 				 struct mempolicy_args *args)
@@ -970,6 +1006,9 @@ static long do_get_vma_mempolicy(unsigned long addr, int *addr_node,
 	if (args->policy_nodes)
 		do_get_mempolicy_nodemask(pol, args->policy_nodes);
 
+	if (args->il_weights)
+		do_get_mempolicy_il_weights(pol, args->il_weights);
+
 	if (pol != &default_policy) {
 		mpol_put(pol);
 		mpol_cond_put(pol);
@@ -997,6 +1036,9 @@ static long do_get_task_mempolicy(struct mempolicy_args *args, int *pol_node)
 	if (args->policy_nodes)
 		do_get_mempolicy_nodemask(pol, args->policy_nodes);
 
+	if (args->il_weights)
+		do_get_mempolicy_il_weights(pol, args->il_weights);
+
 	return 0;
 }
 
@@ -1519,6 +1561,9 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 	if (err)
 		return err;
 
+	if (mode & MPOL_WEIGHTED_INTERLEAVE)
+		mode_flags |= MPOL_F_GWEIGHT;
+
 	memset(&margs, 0, sizeof(margs));
 	margs.mode = lmode;
 	margs.mode_flags = mode_flags;
@@ -1609,6 +1654,8 @@ SYSCALL_DEFINE5(mbind2, unsigned long, start, unsigned long, len,
 	struct mempolicy_args margs;
 	nodemask_t policy_nodes;
 	unsigned long __user *nodes_ptr;
+	unsigned char weights[MAX_NUMNODES];
+	unsigned char __user *weights_ptr;
 	int err;
 
 	if (!start || !len)
@@ -1641,6 +1688,23 @@ SYSCALL_DEFINE5(mbind2, unsigned long, start, unsigned long, len,
 		return err;
 	margs.policy_nodes = &policy_nodes;
 
+	if (kargs.mode == MPOL_WEIGHTED_INTERLEAVE) {
+		weights_ptr = u64_to_user_ptr(kargs.il_weights);
+		if (weights_ptr) {
+			err = copy_struct_from_user(weights,
+						    sizeof(weights),
+						    weights_ptr,
+						    kargs.pol_maxnodes);
+			if (err)
+				return err;
+			margs.il_weights = weights;
+		} else {
+			margs.il_weights = NULL;
+			margs.mode_flags |= MPOL_F_GWEIGHT;
+		}
+	} else
+		margs.il_weights = NULL;
+
 	return do_mbind(untagged_addr(start), len, &margs, flags);
 }
 
@@ -1662,6 +1726,9 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 	if (err)
 		return err;
 
+	if (mode & MPOL_WEIGHTED_INTERLEAVE)
+		mode_flags |= MPOL_F_GWEIGHT;
+
 	memset(&args, 0, sizeof(args));
 	args.mode = lmode;
 	args.mode_flags = mode_flags;
@@ -1685,6 +1752,8 @@ SYSCALL_DEFINE3(set_mempolicy2, struct mpol_args __user *, uargs, size_t, usize,
 	int err;
 	nodemask_t policy_nodemask;
 	unsigned long __user *nodes_ptr;
+	unsigned char weights[MAX_NUMNODES];
+	unsigned char __user *weights_ptr;
 
 	if (flags)
 		return -EINVAL;
@@ -1710,6 +1779,20 @@ SYSCALL_DEFINE3(set_mempolicy2, struct mpol_args __user *, uargs, size_t, usize,
 	} else
 		margs.policy_nodes = NULL;
 
+	if (kargs.mode == MPOL_WEIGHTED_INTERLEAVE && kargs.il_weights) {
+		weights_ptr = u64_to_user_ptr(kargs.il_weights);
+		err = copy_struct_from_user(weights,
+					    sizeof(weights),
+					    weights_ptr,
+					    kargs.pol_maxnodes);
+		if (err)
+			return err;
+		margs.il_weights = weights;
+	} else {
+		margs.il_weights = NULL;
+		margs.mode_flags |= MPOL_F_GWEIGHT;
+	}
+
 	return do_set_mempolicy(&margs);
 }
 
@@ -1913,17 +1996,25 @@ SYSCALL_DEFINE4(get_mempolicy2, struct mpol_args __user *, uargs, size_t, usize,
 	int err;
 	nodemask_t policy_nodemask;
 	unsigned long __user *nodes_ptr;
+	unsigned char __user *weights_ptr;
+	unsigned char weights[MAX_NUMNODES];
 
 	if (flags & ~(MPOL_F_ADDR))
 		return -EINVAL;
 
 	/* initialize any memory liable to be copied to userland */
 	memset(&margs, 0, sizeof(margs));
+	memset(weights, 0, sizeof(weights));
 
 	err = copy_struct_from_user(&kargs, sizeof(kargs), uargs, usize);
 	if (err)
 		return -EINVAL;
 
+	if (kargs.il_weights)
+		margs.il_weights = weights;
+	else
+		margs.il_weights = NULL;
+
 	margs.policy_nodes = kargs.pol_nodes ? &policy_nodemask : NULL;
 	if (flags & MPOL_F_ADDR)
 		err = do_get_vma_mempolicy(untagged_addr(addr), NULL, &margs);
@@ -1944,6 +2035,13 @@ SYSCALL_DEFINE4(get_mempolicy2, struct mpol_args __user *, uargs, size_t, usize,
 			return err;
 	}
 
+	if (kargs.mode == MPOL_WEIGHTED_INTERLEAVE && kargs.il_weights) {
+		weights_ptr = u64_to_user_ptr(kargs.il_weights);
+		err = copy_to_user(weights_ptr, weights, kargs.pol_maxnodes);
+		if (err)
+			return err;
+	}
+
 	return copy_to_user(uargs, &kargs, usize) ? -EFAULT : 0;
 }
 
@@ -2060,13 +2158,18 @@ static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
 {
 	unsigned int next;
 	struct task_struct *me = current;
+	unsigned char next_weight;
 
 	next = next_node_in(me->il_prev, policy->nodes);
 	if (next == MAX_NUMNODES)
 		return next;
 
-	if (!policy->wil.cur_weight)
-		policy->wil.cur_weight = iw_table[next];
+	if (!policy->wil.cur_weight) {
+		next_weight = (policy->flags & MPOL_F_GWEIGHT) ?
+				iw_table[next] :
+				policy->wil.weights[next];
+		policy->wil.cur_weight = next_weight ? next_weight : 1;
+	}
 
 	policy->wil.cur_weight--;
 	if (!policy->wil.cur_weight)
@@ -2140,6 +2243,7 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 	nodemask_t nodemask = pol->nodes;
 	unsigned int target, weight_total = 0;
 	int nid;
+	unsigned char *pol_weights;
 	unsigned char weights[MAX_NUMNODES];
 	unsigned char weight;
 
@@ -2151,8 +2255,13 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 		return nid;
 
 	/* Then collect weights on stack and calculate totals */
+	if (pol->flags & MPOL_F_GWEIGHT)
+		pol_weights = iw_table;
+	else
+		pol_weights = pol->wil.weights;
+
 	for_each_node_mask(nid, nodemask) {
-		weight = iw_table[nid];
+		weight = pol_weights[nid];
 		weight_total += weight;
 		weights[nid] = weight;
 	}
@@ -2550,6 +2659,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 	unsigned long nr_allocated;
 	unsigned long rounds;
 	unsigned long node_pages, delta;
+	unsigned char *pol_weights;
 	unsigned char weight;
 	unsigned char weights[MAX_NUMNODES];
 	unsigned int weight_total = 0;
@@ -2563,9 +2673,14 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 
 	nnodes = nodes_weight(nodes);
 
+	if (pol->flags & MPOL_F_GWEIGHT)
+		pol_weights = iw_table;
+	else
+		pol_weights = pol->wil.weights;
+
 	/* Collect weights and save them on stack so they don't change */
 	for_each_node_mask(node, nodes) {
-		weight = iw_table[node];
+		weight = pol_weights[node];
 		weight_total += weight;
 		weights[node] = weight;
 	}
@@ -3090,6 +3205,7 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 {
 	int ret;
 	struct mempolicy_args margs;
+	unsigned char weights[MAX_NUMNODES];
 
 	sp->root = RB_ROOT;		/* empty tree == default mempolicy */
 	rwlock_init(&sp->lock);
@@ -3107,6 +3223,11 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		margs.mode_flags = mpol->flags;
 		margs.policy_nodes = &mpol->w.user_nodemask;
 		margs.home_node = NUMA_NO_NODE;
+		if (margs.mode == MPOL_WEIGHTED_INTERLEAVE &&
+		    !(margs.mode_flags & MPOL_F_GWEIGHT)) {
+			memcpy(weights, mpol->wil.weights, sizeof(weights));
+			margs.il_weights = weights;
+		}
 
 		/* contextualize the tmpfs mount point mempolicy to this file */
 		npol = mpol_new(&margs);
-- 
2.39.1


