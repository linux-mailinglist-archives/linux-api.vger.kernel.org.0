Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED7125FBD2
	for <lists+linux-api@lfdr.de>; Mon,  7 Sep 2020 16:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgIGOIj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Sep 2020 10:08:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729727AbgIGOIA (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 7 Sep 2020 10:08:00 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 20EE5185D0A4C595AE8E;
        Mon,  7 Sep 2020 22:07:58 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 22:07:51 +0800
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
Subject: [PATCH v10 6/6] docs: mm: numaperf.rst Add brief description for access class 1.
Date:   Mon, 7 Sep 2020 22:03:07 +0800
Message-ID: <20200907140307.571932-7-Jonathan.Cameron@huawei.com>
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

Try to make minimal changes to the document which already describes
access class 0 in a generic fashion (including IO initiatiors that
are not CPUs).

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/admin-guide/mm/numaperf.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/mm/numaperf.rst b/Documentation/admin-guide/mm/numaperf.rst
index 4d69ef1de830..b89bb85eac75 100644
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
 
+Access class 1, takes the same form, but only includes values for CPU to
+memory activity.
+
 ==========
 NUMA Cache
 ==========
-- 
2.19.1

