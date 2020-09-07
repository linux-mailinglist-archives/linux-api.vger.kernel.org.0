Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63482601FE
	for <lists+linux-api@lfdr.de>; Mon,  7 Sep 2020 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgIGRPj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Sep 2020 13:15:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729763AbgIGOFq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 7 Sep 2020 10:05:46 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1646D9B65E56938C9A4D;
        Mon,  7 Sep 2020 22:05:38 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 22:05:28 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <rafael@kernel.org>, Ingo Molnar <mingo@redhat.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, <linuxarm@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        "Sean V Kelley" <sean.v.kelley@linux.intel.com>,
        <linux-api@vger.kernel.org>, "Hanjun Guo" <guohanjun@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v10 2/6] x86: Support Generic Initiator only proximity domains
Date:   Mon, 7 Sep 2020 22:03:03 +0800
Message-ID: <20200907140307.571932-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200907140307.571932-1-Jonathan.Cameron@huawei.com>
References: <20200907140307.571932-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In common with memoryless domains we only register GI domains
if the proximity node is not online. If a domain is already
a memory containing domain, or a memoryless domain there is
nothing to do just because it also contains a Generic Initiator.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/x86/include/asm/numa.h |  2 ++
 arch/x86/kernel/setup.c     |  1 +
 arch/x86/mm/numa.c          | 14 ++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index bbfde3d2662f..f631467272a3 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -62,12 +62,14 @@ extern void numa_clear_node(int cpu);
 extern void __init init_cpu_to_node(void);
 extern void numa_add_cpu(int cpu);
 extern void numa_remove_cpu(int cpu);
+extern void init_gi_nodes(void);
 #else	/* CONFIG_NUMA */
 static inline void numa_set_node(int cpu, int node)	{ }
 static inline void numa_clear_node(int cpu)		{ }
 static inline void init_cpu_to_node(void)		{ }
 static inline void numa_add_cpu(int cpu)		{ }
 static inline void numa_remove_cpu(int cpu)		{ }
+static inline void init_gi_nodes(void)			{ }
 #endif	/* CONFIG_NUMA */
 
 #ifdef CONFIG_DEBUG_PER_CPU_MAPS
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3511736fbc74..9062c146f03a 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1218,6 +1218,7 @@ void __init setup_arch(char **cmdline_p)
 	prefill_possible_map();
 
 	init_cpu_to_node();
+	init_gi_nodes();
 
 	io_apic_init_mappings();
 
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index aa76ec2d359b..fc630dc6764e 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -747,6 +747,20 @@ static void __init init_memory_less_node(int nid)
 	 */
 }
 
+/*
+ * Generic Initiator Nodes may have neither CPU nor Memory.
+ * At this stage if either of the others were present we would
+ * already be online.
+ */
+void __init init_gi_nodes(void)
+{
+	int nid;
+
+	for_each_node_state(nid, N_GENERIC_INITIATOR)
+		if (!node_online(nid))
+			init_memory_less_node(nid);
+}
+
 /*
  * Setup early cpu_to_node.
  *
-- 
2.19.1

