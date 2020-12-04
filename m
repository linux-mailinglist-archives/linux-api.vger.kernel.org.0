Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91C22CEAA7
	for <lists+linux-api@lfdr.de>; Fri,  4 Dec 2020 10:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgLDJQr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Dec 2020 04:16:47 -0500
Received: from mga04.intel.com ([192.55.52.120]:30511 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgLDJQr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 4 Dec 2020 04:16:47 -0500
IronPort-SDR: CrLf1iLTLW3ZCcsOcdgbkyCEpgtJJ7bzlG+g29Iq5W8MXoZU6Aj6AvTiv57rEJRLEsQH/kIPvT
 /Pf9e9C3Qk/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="170782866"
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="170782866"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 01:16:00 -0800
IronPort-SDR: 5twwErGhDlEER8+2Jvm+9v3O3UlxcxbYxk0mqDdzgCCYXmOERWKJJ3rFZKsoHbvtJVNKgdwRaM
 6ev3PcWV/1OA==
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="550879520"
Received: from unknown (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.212.254])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 01:15:55 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>, linux-api@vger.kernel.org
Subject: [PATCH -V7 3/3] NOT kernel/numactl: Support to enable Linux kernel NUMA balancing
Date:   Fri,  4 Dec 2020 17:15:34 +0800
Message-Id: <20201204091534.72239-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204091534.72239-1-ying.huang@intel.com>
References: <20201204091534.72239-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

A new API: numa_set_membind_balancing() is added to libnuma.  It is
same as numa_set_membind() except that the Linux kernel NUMA balancing
will be enabled for the task if the feature is supported by the
kernel.

At the same time, a new option: --balancing (-b) is added to numactl.
Which can be used before the --membind/-m memory policy in the command
line.  With it, the Linux kernel NUMA balancing will be enabled for
the process if --membind/-m is used and the feature is supported by
the kernel.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
---
 libnuma.c         | 14 ++++++++++++++
 numa.3            | 15 +++++++++++++++
 numa.h            |  4 ++++
 numactl.8         | 12 ++++++++++++
 numactl.c         | 17 ++++++++++++++---
 numaif.h          |  3 +++
 versions.ldscript |  8 ++++++++
 7 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/libnuma.c b/libnuma.c
index 88f479b..f073c50 100644
--- a/libnuma.c
+++ b/libnuma.c
@@ -1064,6 +1064,20 @@ numa_set_membind_v2(struct bitmask *bmp)
 
 make_internal_alias(numa_set_membind_v2);
 
+void
+numa_set_membind_balancing(struct bitmask *bmp)
+{
+	/* MPOL_F_NUMA_BALANCING: ignore if unsupported */
+	if (set_mempolicy(MPOL_BIND | MPOL_F_NUMA_BALANCING,
+			  bmp->maskp, bmp->size + 1) < 0) {
+		if (errno == EINVAL) {
+			errno = 0;
+			numa_set_membind_v2(bmp);
+		} else
+			numa_error("set_mempolicy");
+	}
+}
+
 /*
  * copy a bitmask map body to a numa.h nodemask_t structure
  */
diff --git a/numa.3 b/numa.3
index 3e18098..af01c8f 100644
--- a/numa.3
+++ b/numa.3
@@ -80,6 +80,8 @@ numa \- NUMA policy library
 .br
 .BI "void numa_set_membind(struct bitmask *" nodemask );
 .br
+.BI "void numa_set_membind_balancing(struct bitmask *" nodemask );
+.br
 .B struct bitmask *numa_get_membind(void);
 .sp
 .BI "void *numa_alloc_onnode(size_t " size ", int " node );
@@ -538,6 +540,19 @@ that contains nodes other than those in the mask returned by
 .IR numa_get_mems_allowed ()
 will result in an error.
 
+.BR numa_set_membind_balancing ()
+sets the memory allocation mask and enable the Linux kernel NUMA
+balancing for the task if the feature is supported by the kernel.
+The task will only allocate memory from the nodes set in
+.IR nodemask .
+Passing an empty
+.I nodemask
+or a
+.I nodemask
+that contains nodes other than those in the mask returned by
+.IR numa_get_mems_allowed ()
+will result in an error.
+
 .BR numa_get_membind ()
 returns the mask of nodes from which memory can currently be allocated.
 If the returned mask is equal to
diff --git a/numa.h b/numa.h
index bd1d676..5d8543a 100644
--- a/numa.h
+++ b/numa.h
@@ -192,6 +192,10 @@ void numa_set_localalloc(void);
 /* Only allocate memory from the nodes set in mask. 0 to turn off */
 void numa_set_membind(struct bitmask *nodemask);
 
+/* Only allocate memory from the nodes set in mask. Optimize page
+   placement with Linux kernel NUMA balancing if possible. 0 to turn off */
+void numa_set_membind_balancing(struct bitmask *bmp);
+
 /* Return current membind */
 struct bitmask *numa_get_membind(void);
 
diff --git a/numactl.8 b/numactl.8
index f3bb22b..7d52688 100644
--- a/numactl.8
+++ b/numactl.8
@@ -25,6 +25,8 @@ numactl \- Control NUMA policy for processes or shared memory
 [
 .B \-\-all
 ] [
+.B \-\-balancing
+] [
 .B \-\-interleave nodes
 ] [
 .B \-\-preferred node 
@@ -168,6 +170,12 @@ but if memory cannot be allocated there fall back to other nodes.
 This option takes only a single node number.
 Relative notation may be used.
 .TP
+.B \-\-balancing, \-b
+Enable Linux kernel NUMA balancing for the process if it is supported by kernel.
+This should only be used with
+.I \-\-membind, \-m
+only, otherwise ignored.
+.TP
 .B \-\-show, \-s
 Show NUMA policy settings of the current process. 
 .TP
@@ -278,6 +286,10 @@ numactl \-\-cpunodebind=0 \-\-membind=0,1 -- process -l
 Run process as above, but with an option (-l) that would be confused with
 a numactl option.
 
+numactl \-\-cpunodebind=0 \-\-balancing \-\-membind=0,1 process
+Run process on node 0 with memory allocated on node 0 and 1.  Optimize the
+page placement with Linux kernel NUMA balancing mechanism if possible.
+
 numactl \-\-cpunodebind=netdev:eth0 \-\-membind=netdev:eth0 network-server
 Run network-server on the node of network device eth0 with its memory
 also in the same node.
diff --git a/numactl.c b/numactl.c
index df9dbcb..5a9d2df 100644
--- a/numactl.c
+++ b/numactl.c
@@ -45,6 +45,7 @@ struct option opts[] = {
 	{"membind", 1, 0, 'm'},
 	{"show", 0, 0, 's' },
 	{"localalloc", 0,0, 'l'},
+	{"balancing", 0, 0, 'b'},
 	{"hardware", 0,0,'H' },
 
 	{"shm", 1, 0, 'S'},
@@ -65,9 +66,10 @@ struct option opts[] = {
 void usage(void)
 {
 	fprintf(stderr,
-		"usage: numactl [--all | -a] [--interleave= | -i <nodes>] [--preferred= | -p <node>]\n"
-		"               [--physcpubind= | -C <cpus>] [--cpunodebind= | -N <nodes>]\n"
-		"               [--membind= | -m <nodes>] [--localalloc | -l] command args ...\n"
+		"usage: numactl [--all | -a] [--balancing | -b] [--interleave= | -i <nodes>]\n"
+		"               [--preferred= | -p <node>] [--physcpubind= | -C <cpus>]\n"
+		"               [--cpunodebind= | -N <nodes>] [--membind= | -m <nodes>]\n"
+		"               [--localalloc | -l] command args ...\n"
 		"       numactl [--show | -s]\n"
 		"       numactl [--hardware | -H]\n"
 		"       numactl [--length | -l <length>] [--offset | -o <offset>] [--shmmode | -M <shmmode>]\n"
@@ -90,6 +92,8 @@ void usage(void)
 		"all numbers and ranges can be made cpuset-relative with +\n"
 		"the old --cpubind argument is deprecated.\n"
 		"use --cpunodebind or --physcpubind instead\n"
+		"use --balancing | -b to enable Linux kernel NUMA balancing\n"
+		"for the process if it is supported by kernel\n"
 		"<length> can have g (GB), m (MB) or k (KB) suffixes\n");
 	exit(1);
 }
@@ -338,6 +342,7 @@ int do_dump = 0;
 int shmattached = 0;
 int did_node_cpu_parse = 0;
 int parse_all = 0;
+int numa_balancing = 0;
 char *shmoption;
 
 void check_cpubind(int flag)
@@ -431,6 +436,10 @@ int main(int ac, char **av)
 			nopolicy();
 			hardware();
 			exit(0);
+		case 'b': /* --balancing  */
+			nopolicy();
+			numa_balancing = 1;
+			break;
 		case 'i': /* --interleave */
 			checknuma();
 			if (parse_all)
@@ -507,6 +516,8 @@ int main(int ac, char **av)
 			numa_set_bind_policy(1);
 			if (shmfd >= 0) {
 				numa_tonodemask_memory(shmptr, shmlen, mask);
+			} else if (numa_balancing) {
+				numa_set_membind_balancing(mask);
 			} else {
 				numa_set_membind(mask);
 			}
diff --git a/numaif.h b/numaif.h
index 91aa230..32c12c3 100644
--- a/numaif.h
+++ b/numaif.h
@@ -29,6 +29,9 @@ extern long move_pages(int pid, unsigned long count,
 #define MPOL_LOCAL       4
 #define MPOL_MAX         5
 
+/* Flags for set_mempolicy, specified in mode */
+#define MPOL_F_NUMA_BALANCING	(1 << 13) /* Optimize with NUMA balancing if possible */
+
 /* Flags for get_mem_policy */
 #define MPOL_F_NODE    (1<<0)   /* return next il node or node of address */
 				/* Warning: MPOL_F_NODE is unsupported and
diff --git a/versions.ldscript b/versions.ldscript
index 23074a0..358eeeb 100644
--- a/versions.ldscript
+++ b/versions.ldscript
@@ -146,3 +146,11 @@ libnuma_1.4 {
   local:
     *;
 } libnuma_1.3;
+
+# New interface for membind with NUMA balancing optimization
+libnuma_1.5 {
+  global:
+    numa_set_membind_balancing;
+  local:
+    *;
+} libnuma_1.4;
-- 
2.29.2

