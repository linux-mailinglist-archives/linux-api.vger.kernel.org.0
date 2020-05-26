Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4689D1B94ED
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 03:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgD0B2l (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 26 Apr 2020 21:28:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:7235 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgD0B2l (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 26 Apr 2020 21:28:41 -0400
IronPort-SDR: nSyTS8TgP9U9UJb6VgEWwy0/D4QkKDkPcgwZxwd1eARsWLFhbmUjNqxlxfQqPhAogfUuf41UR2
 nb+XnZR/Yjhg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2020 18:28:40 -0700
IronPort-SDR: b51KUHewyZjdZ/fePBgDQv3zlVNuShzLv/2JB/dy/YE4NzLmjS9MRiby4IQcsXOsqEU9dLXIRW
 RitizkW6VBDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,321,1583222400"; 
   d="scan'208";a="257060231"
Received: from hao-dev.bj.intel.com ([10.238.157.66])
  by orsmga003.jf.intel.com with ESMTP; 26 Apr 2020 18:28:24 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     will@kernel.org, mdf@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, atull@kernel.org, yilun.xu@intel.com,
        trix@redhat.com, bhu@redhat.com, rdunlap@infradead.org,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v10 1/2] Documentation: fpga: dfl: add description for performance reporting support
Date:   Mon, 27 Apr 2020 09:06:22 +0800
Message-Id: <1587949583-12058-2-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587949583-12058-1-git-send-email-hao.wu@intel.com>
References: <1587949583-12058-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Xu Yilun <yilun.xu@intel.com>

This patch adds description for performance reporting support for
Device Feature List (DFL) based FPGA.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v5:  rebase due to format change (txt->rst).
v8:  rename pmu "fmeX" to "dfl-fmeX".
     update cpumask sysfs description.
v10: fix comments from Randy.
---
 Documentation/fpga/dfl.rst | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 094fc8a..0de7f89 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -118,6 +118,11 @@ More functions are exposed through sysfs
      management information (current temperature, thresholds, threshold status,
      etc.).
 
+ Performance reporting
+     performance counters are exposed through perf PMU APIs. Standard perf tool
+     can be used to monitor all available perf events. Please see performance
+     counter section below for more detailed information.
+
 
 FIU - PORT
 ==========
@@ -378,6 +383,85 @@ The device nodes used for ioctl() or mmap() can be referenced through::
 	/sys/class/fpga_region/<regionX>/<dfl-port.n>/dev
 
 
+Performance Counters
+====================
+Performance reporting is one private feature implemented in FME. It could
+supports several independent, system-wide, device counter sets in hardware to
+monitor and count for performance events, including "basic", "cache", "fabric",
+"vtd" and "vtd_sip" counters. Users could use standard perf tool to monitor
+FPGA cache hit/miss rate, transaction number, interface clock counter of AFU
+and other FPGA performance events.
+
+Different FPGA devices may have different counter sets, depending on hardware
+implementation. E.g., some discrete FPGA cards don't have any cache. User could
+use "perf list" to check which perf events are supported by target hardware.
+
+In order to allow user to use standard perf API to access these performance
+counters, driver creates a perf PMU, and related sysfs interfaces in
+/sys/bus/event_source/devices/dfl_fme* to describe available perf events and
+configuration options.
+
+The "format" directory describes the format of the config field of struct
+perf_event_attr. There are 3 bitfields for config: "evtype" defines which type
+the perf event belongs to; "event" is the identity of the event within its
+category; "portid" is introduced to decide counters set to monitor on FPGA
+overall data or a specific port.
+
+The "events" directory describes the configuration templates for all available
+events which can be used with perf tool directly. For example, fab_mmio_read
+has the configuration "event=0x06,evtype=0x02,portid=0xff", which shows this
+event belongs to fabric type (0x02), the local event id is 0x06 and it is for
+overall monitoring (portid=0xff).
+
+Example usage of perf::
+
+  $# perf list |grep dfl_fme
+
+  dfl_fme0/fab_mmio_read/                              [Kernel PMU event]
+  <...>
+  dfl_fme0/fab_port_mmio_read,portid=?/                [Kernel PMU event]
+  <...>
+
+  $# perf stat -a -e dfl_fme0/fab_mmio_read/ <command>
+  or
+  $# perf stat -a -e dfl_fme0/event=0x06,evtype=0x02,portid=0xff/ <command>
+  or
+  $# perf stat -a -e dfl_fme0/config=0xff2006/ <command>
+
+Another example, fab_port_mmio_read monitors mmio read of a specific port. So
+its configuration template is "event=0x06,evtype=0x01,portid=?". The portid
+should be explicitly set.
+
+Its usage of perf::
+
+  $# perf stat -a -e dfl_fme0/fab_port_mmio_read,portid=0x0/ <command>
+  or
+  $# perf stat -a -e dfl_fme0/event=0x06,evtype=0x02,portid=0x0/ <command>
+  or
+  $# perf stat -a -e dfl_fme0/config=0x2006/ <command>
+
+Please note for fabric counters, overall perf events (fab_*) and port perf
+events (fab_port_*) actually share one set of counters in hardware, so it can't
+monitor both at the same time. If this set of counters is configured to monitor
+overall data, then per port perf data is not supported. See below example::
+
+  $# perf stat -e dfl_fme0/fab_mmio_read/,dfl_fme0/fab_port_mmio_write,\
+                                                    portid=0/ sleep 1
+
+  Performance counter stats for 'system wide':
+
+                 3      dfl_fme0/fab_mmio_read/
+   <not supported>      dfl_fme0/fab_port_mmio_write,portid=0x0/
+
+       1.001750904 seconds time elapsed
+
+The driver also provides a "cpumask" sysfs attribute, which contains only one
+CPU id used to access these perf events. Counting on multiple CPU is not allowed
+since they are system-wide counters on FPGA device.
+
+The current driver does not support sampling. So "perf record" is unsupported.
+
+
 Add new FIUs support
 ====================
 It's possible that developers made some new function blocks (FIUs) under this
-- 
1.8.3.1

