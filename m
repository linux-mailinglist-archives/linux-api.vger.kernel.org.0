Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E2927EAAE
	for <lists+linux-api@lfdr.de>; Wed, 30 Sep 2020 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgI3OLP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Sep 2020 10:11:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55288 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730188AbgI3OLO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 30 Sep 2020 10:11:14 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2D5F0D5720AF5433024F;
        Wed, 30 Sep 2020 22:11:10 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 22:10:59 +0800
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
Subject: [PATCH v12 6/6] docs: mm: numaperf.rst Add brief description for access class 1.
Date:   Wed, 30 Sep 2020 22:05:47 +0800
Message-ID: <20200930140547.840251-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200930140547.840251-1-Jonathan.Cameron@huawei.com>
References: <20200930140547.840251-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Try to make minimal changes to the document which already describes
access class 0 in a generic fashion (including IO initiatiors that
are not CPUs).

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/admin-guide/mm/numaperf.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/mm/numaperf.rst b/Documentation/admin-guide/mm/numaperf.rst
index 4d69ef1de830..86f2a3c4b638 100644
--- a/Documentation/admin-guide/mm/numaperf.rst
+++ b/Documentation/admin-guide/mm/numaperf.rst
@@ -56,6 +56,11 @@ nodes' access characteristics share the same performance relative to other
 linked initiator nodes. Each target within an initiator's access class,
 though, do not necessarily perform the same as each other.
 
+The access class "1" is used to allow differentiation between initiators
+that are CPUs and hence suitable for generic task scheduling, and
+IO initiators such as GPUs and NICs.  Unlike access class 0, only
+nodes containing CPUs are considered.
+
 ================
 NUMA Performance
 ================
@@ -88,6 +93,9 @@ The latency attributes are provided in nanoseconds.
 The values reported here correspond to the rated latency and bandwidth
 for the platform.
 
+Access class 1 takes the same form but only includes values for CPU to
+memory activity.
+
 ==========
 NUMA Cache
 ==========
-- 
2.19.1

