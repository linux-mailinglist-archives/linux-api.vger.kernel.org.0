Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFA127AE6A
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 14:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgI1M4k (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 08:56:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14313 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726406AbgI1M4k (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 28 Sep 2020 08:56:40 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4ED31574762CBD14DE72;
        Mon, 28 Sep 2020 20:56:37 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 28 Sep 2020 20:56:30 +0800
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
        <linux-api@vger.kernel.org>, "Borislav Petkov" <bp@alien8.de>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 5/6] node: Add access1 class to represent CPU to memory characteristics
Date:   Mon, 28 Sep 2020 20:52:34 +0800
Message-ID: <20200928125235.446188-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200928125235.446188-1-Jonathan.Cameron@huawei.com>
References: <20200928125235.446188-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

New access1 class is nearly the same as access0, but always provides
characteristics for CPUs to memory.   The existing access0 class
provides characteristics to nearest or direct connnect initiator
which may be a Generic Initiator such as a GPU or network adapter.

This new class allows thread placement on CPUs to be performed
so as to give optimal access characteristics to memory, even if that
memory is for example attached to a GPU or similar and only accessible
to the CPU via an appropriate bus.

Suggested-by: Dan Willaims <dan.j.williams@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 v11: Formatting fixes only.
 
 drivers/acpi/numa/hmat.c | 88 +++++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 6a91a55229ae..3dc251264423 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -56,7 +56,7 @@ struct memory_target {
 	unsigned int memory_pxm;
 	unsigned int processor_pxm;
 	struct resource memregions;
-	struct node_hmem_attrs hmem_attrs;
+	struct node_hmem_attrs hmem_attrs[2];
 	struct list_head caches;
 	struct node_cache_attrs cache_attrs;
 	bool registered;
@@ -65,6 +65,7 @@ struct memory_target {
 struct memory_initiator {
 	struct list_head node;
 	unsigned int processor_pxm;
+	bool has_cpu;
 };
 
 struct memory_locality {
@@ -108,6 +109,7 @@ static __init void alloc_memory_initiator(unsigned int cpu_pxm)
 		return;
 
 	initiator->processor_pxm = cpu_pxm;
+	initiator->has_cpu = node_state(pxm_to_node(cpu_pxm), N_CPU);
 	list_add_tail(&initiator->node, &initiators);
 }
 
@@ -215,28 +217,28 @@ static u32 hmat_normalize(u16 entry, u64 base, u8 type)
 }
 
 static void hmat_update_target_access(struct memory_target *target,
-					     u8 type, u32 value)
+				      u8 type, u32 value, int access)
 {
 	switch (type) {
 	case ACPI_HMAT_ACCESS_LATENCY:
-		target->hmem_attrs.read_latency = value;
-		target->hmem_attrs.write_latency = value;
+		target->hmem_attrs[access].read_latency = value;
+		target->hmem_attrs[access].write_latency = value;
 		break;
 	case ACPI_HMAT_READ_LATENCY:
-		target->hmem_attrs.read_latency = value;
+		target->hmem_attrs[access].read_latency = value;
 		break;
 	case ACPI_HMAT_WRITE_LATENCY:
-		target->hmem_attrs.write_latency = value;
+		target->hmem_attrs[access].write_latency = value;
 		break;
 	case ACPI_HMAT_ACCESS_BANDWIDTH:
-		target->hmem_attrs.read_bandwidth = value;
-		target->hmem_attrs.write_bandwidth = value;
+		target->hmem_attrs[access].read_bandwidth = value;
+		target->hmem_attrs[access].write_bandwidth = value;
 		break;
 	case ACPI_HMAT_READ_BANDWIDTH:
-		target->hmem_attrs.read_bandwidth = value;
+		target->hmem_attrs[access].read_bandwidth = value;
 		break;
 	case ACPI_HMAT_WRITE_BANDWIDTH:
-		target->hmem_attrs.write_bandwidth = value;
+		target->hmem_attrs[access].write_bandwidth = value;
 		break;
 	default:
 		break;
@@ -329,8 +331,12 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 
 			if (mem_hier == ACPI_HMAT_MEMORY) {
 				target = find_mem_target(targs[targ]);
-				if (target && target->processor_pxm == inits[init])
-					hmat_update_target_access(target, type, value);
+				if (target && target->processor_pxm == inits[init]) {
+					hmat_update_target_access(target, type, value, 0);
+					/* If the node has a CPU, update access 1 */
+					if (node_state(pxm_to_node(inits[init]), N_CPU))
+						hmat_update_target_access(target, type, value, 1);
+				}
 			}
 		}
 	}
@@ -567,6 +573,7 @@ static void hmat_register_target_initiators(struct memory_target *target)
 	unsigned int mem_nid, cpu_nid;
 	struct memory_locality *loc = NULL;
 	u32 best = 0;
+	bool access0done = false;
 	int i;
 
 	mem_nid = pxm_to_node(target->memory_pxm);
@@ -578,7 +585,11 @@ static void hmat_register_target_initiators(struct memory_target *target)
 	if (target->processor_pxm != PXM_INVAL) {
 		cpu_nid = pxm_to_node(target->processor_pxm);
 		register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
-		return;
+		access0done = true;
+		if (node_state(cpu_nid, N_CPU)) {
+			register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
+			return;
+		}
 	}
 
 	if (list_empty(&localities))
@@ -592,6 +603,41 @@ static void hmat_register_target_initiators(struct memory_target *target)
 	 */
 	bitmap_zero(p_nodes, MAX_NUMNODES);
 	list_sort(p_nodes, &initiators, initiator_cmp);
+	if (!access0done) {
+		for (i = WRITE_LATENCY; i <= READ_BANDWIDTH; i++) {
+			loc = localities_types[i];
+			if (!loc)
+				continue;
+
+			best = 0;
+			list_for_each_entry(initiator, &initiators, node) {
+				u32 value;
+
+				if (!test_bit(initiator->processor_pxm, p_nodes))
+					continue;
+
+				value = hmat_initiator_perf(target, initiator,
+							    loc->hmat_loc);
+				if (hmat_update_best(loc->hmat_loc->data_type, value, &best))
+					bitmap_clear(p_nodes, 0, initiator->processor_pxm);
+				if (value != best)
+					clear_bit(initiator->processor_pxm, p_nodes);
+			}
+			if (best)
+				hmat_update_target_access(target, loc->hmat_loc->data_type,
+							  best, 0);
+		}
+
+		for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
+			cpu_nid = pxm_to_node(i);
+			register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
+		}
+	}
+
+	/* Access 1 ignores Generic Initiators */
+	bitmap_zero(p_nodes, MAX_NUMNODES);
+	list_sort(p_nodes, &initiators, initiator_cmp);
+	best = 0;
 	for (i = WRITE_LATENCY; i <= READ_BANDWIDTH; i++) {
 		loc = localities_types[i];
 		if (!loc)
@@ -601,6 +647,10 @@ static void hmat_register_target_initiators(struct memory_target *target)
 		list_for_each_entry(initiator, &initiators, node) {
 			u32 value;
 
+			if (!initiator->has_cpu) {
+				clear_bit(initiator->processor_pxm, p_nodes);
+				continue;
+			}
 			if (!test_bit(initiator->processor_pxm, p_nodes))
 				continue;
 
@@ -611,12 +661,11 @@ static void hmat_register_target_initiators(struct memory_target *target)
 				clear_bit(initiator->processor_pxm, p_nodes);
 		}
 		if (best)
-			hmat_update_target_access(target, loc->hmat_loc->data_type, best);
+			hmat_update_target_access(target, loc->hmat_loc->data_type, best, 1);
 	}
-
 	for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
 		cpu_nid = pxm_to_node(i);
-		register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
+		register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
 	}
 }
 
@@ -629,10 +678,10 @@ static void hmat_register_target_cache(struct memory_target *target)
 		node_add_cache(mem_nid, &tcache->cache_attrs);
 }
 
-static void hmat_register_target_perf(struct memory_target *target)
+static void hmat_register_target_perf(struct memory_target *target, int access)
 {
 	unsigned mem_nid = pxm_to_node(target->memory_pxm);
-	node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
+	node_set_perf_attrs(mem_nid, &target->hmem_attrs[access], access);
 }
 
 static void hmat_register_target_device(struct memory_target *target,
@@ -734,7 +783,8 @@ static void hmat_register_target(struct memory_target *target)
 	if (!target->registered) {
 		hmat_register_target_initiators(target);
 		hmat_register_target_cache(target);
-		hmat_register_target_perf(target);
+		hmat_register_target_perf(target, 0);
+		hmat_register_target_perf(target, 1);
 		target->registered = true;
 	}
 	mutex_unlock(&target_lock);
-- 
2.19.1

