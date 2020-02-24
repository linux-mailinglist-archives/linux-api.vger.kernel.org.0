Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABD3B169B4A
	for <lists+linux-api@lfdr.de>; Mon, 24 Feb 2020 01:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgBXAm5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 23 Feb 2020 19:42:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:23673 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgBXAm5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 23 Feb 2020 19:42:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 16:42:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,478,1574150400"; 
   d="scan'208";a="349809816"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2020 16:42:54 -0800
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, will@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, atull@kernel.org, yilun.xu@intel.com,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v8 1/2] Documentation: fpga: dfl: add description for performance reporting support
Date:   Mon, 24 Feb 2020 08:21:46 +0800
Message-Id: <1582503707-10737-2-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582503707-10737-1-git-send-email-hao.wu@intel.com>
References: <1582503707-10737-1-git-send-email-hao.wu@intel.com>
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
v5: rebase due to format change (txt->rst).
v8: rename pmu "fmeX" to "dfl-fmeX".
    update cpumask sysfs description.
---
 Documentation/fpga/dfl.rst | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 094fc8a..6ccaf77 100644
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
+Different FPGA devices may have different counter sets, it depends on hardware
+implementation. e.g. some discrete FPGA cards don't have any cache. User could
+use "perf list" to check which perf events are supported by target hardware.
+
+In order to allow user to use standard perf API to access these performance
+counters, driver creates a perf PMU, and related sysfs interfaces in
+/sys/bus/event_source/devices/dfl_fme* to describe available perf events and
+configuration options.
+
+The "format" directory describes the format of the config field of struct
+perf_event_attr. There are 3 bitfields for config, "evtype" defines which type
+the perf event belongs to. "event" is the identity of the event within its
+category. "portid" is introduced to decide counters set to monitor on FPGA
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
+cpu id used to access these perf events. Counting on multiple CPUs is not
+allowed since they are system-wide counters on FPGA device.
+
+The current driver does not support sampling. So "perf record" is unsupported.
+
+
 Add new FIUs support
 ====================
 It's possible that developers made some new function blocks (FIUs) under this
-- 
1.8.3.1

