Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F2624A20C
	for <lists+linux-api@lfdr.de>; Wed, 19 Aug 2020 16:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgHSOwn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Aug 2020 10:52:43 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2667 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728477AbgHSOwm (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 19 Aug 2020 10:52:42 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 77FBE9E6FEB9C778C30B;
        Wed, 19 Aug 2020 15:52:39 +0100 (IST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 19 Aug 2020 15:52:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, <linuxarm@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Sean V Kelley <sean.v.kelley@linux.intel.com>,
        <linux-api@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v9 0/6] ACPI: Support Generic Initiator proximity domains
Date:   Wed, 19 Aug 2020 22:51:05 +0800
Message-ID: <20200819145111.1715026-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

It would be very nice to finally merge this support during this cycle,
so please take a look.

I think we need acks covering x86, ARM and ACPI.  Rafael took a look back
in November at v5 and was looking for x86 and ARM acks.  Whilst there is
no ARM specific code left we probably still need an Ack.

Introduces a new type of NUMA node for cases where we want to represent
the access characteristics of a non CPU initiator of memory requests,
as these differ from all those for existing nodes containing CPUs and/or
memory.

These Generic Initiators are presented by the node access0 class in
sysfs in the same way as a CPU.   It seems likely that there will be
usecases in which the best 'CPU' is desired and Generic Initiators
should be ignored.  The final few patches in this series introduced
access1 which is a new performance class in the sysfs node description
which presents only CPU to memory relationships.  Test cases for this
are described below.

Changes since v8:
* ifdef protections and stubs to avoid a build error on ia64. I'm assuming
  no one cares about Generic Initiators on IA64 (0-day)
* Update OSC code to ensure we don't claim to support GIs except on x86 and
  ARM64

Changes since V7:

* Now independent from
  [PATCH v3 0/6]  ACPI: Only create NUMA nodes from entries in SRAT or SRAT emulation
* Minor documentation tweak.
* Rebase on v5.9-rc1

Changes since V6:

* Rebase on 5.8-rc4 + Dependency as above.
* Drop the ARM64 specific code. No specific calls are needed on ARM64
  as the generic node init is done for all nodes, whether or not they
  have memory.  X86 does memoryless nodes separately from those with
  memory and hence needs to specifically intialize GI only nodes.
* Fix up an error in the docs reported by Brice Goglin who also did
  quite a bit of testing of v5. Thanks!
  
Changes since V5:

3 new patches:
* A fix for a subtlety in how ACPI 6.3 changed part of the HMAT table.
* Introduction of access1 class to represent characteristics between CPU
  and memory, ingnoring GIs unlike access0 which includes them.
* Docs to describe the new access0 class.

Note that I ran a number of test cases for the new class which are
described at the end of this email.

Changes since V4:

At Rafael's suggestion:

Rebase on top of Dan William's Specific Purpose Memory series as that
moves srat.c Original patches cherry-picked fine onto mmotm with Dan's
patches applied.

Applies to mmotm-2019-09-25 +
https://lore.kernel.org/linux-acpi/156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com/
[PATCH v4 00/10] EFI Specific Purpose Memory Support
(note there are some trivial conflicts to deal with when applying
the SPM series).

Change since V3.
* Rebase.

Changes since RFC V2.
* RFC dropped as now we have x86 support, so the lack of guards in in the
  ACPI code etc should now be fine.
  * Added x86 support.  Note this has only been tested on QEMU as I don't have
    a convenient x86 NUMA machine to play with.  Note that this fitted together
      rather differently from arm64 so I'm particularly interested in feedback
        on the two solutions.

Since RFC V1.
* Fix incorrect interpretation of the ACPI entry noted by Keith Busch
* Use the acpica headers definitions that are now in mmotm.

It's worth noting that, to safely put a given device in a GI node, may
require changes to the existing drivers as it's not unusual to assume
you have local memory or processor core. There may be further constraints
not yet covered by this patch.

Original cover letter...

ACPI 6.3 introduced a new entity that can be part of a NUMA proximity domain.
It may share such a domain with the existing options (memory, CPU etc) but it
may also exist on it's own.

The intent is to allow the description of the NUMA properties (particularly
via HMAT) of accelerators and other initiators of memory activity that are not
the host processor running the operating system.

This patch set introduces 'just enough' to make them work for arm64 and x86.
It should be trivial to support other architectures, I just don't suitable
NUMA systems readily available to test.

There are a few quirks that need to be considered.

1. Fall back nodes
******************

As pre ACPI 6.3 supporting operating systems do not have Generic Initiator
Proximity Domains it is possible to specify, via _PXM in DSDT that another
device is part of such a GI only node.  This currently blows up spectacularly.

Whilst we can obviously 'now' protect against such a situation (see the related
thread on PCI _PXM support and the  threadripper board identified there as
also falling into the  problem of using non existent nodes
https://patchwork.kernel.org/patch/10723311/ ), there is no way to  be sure
we will never have legacy OSes that are not protected  against this.  It would
also be 'non ideal' to fallback to  a default node as there may be a better
(non GI) node to pick  if GI nodes aren't available.

The work around is that we also have a new system wide OSC bit that allows
an operating system to 'announce' that it supports Generic Initiators.  This
allows, the firmware to us DSDT magic to 'move' devices between the nodes
dependent on whether our new nodes are there or not.

2. New ways of assigning a proximity domain for devices
*******************************************************

Until now, the only way firmware could indicate that a particular device
(outside the 'special' set of cpus etc) was to be found in a particular
Proximity Domain by the use of _PXM in DSDT.

That is equally valid with GI domains, but we have new options. The SRAT
affinity structure includes a handle (ACPI or PCI) to identify devices
with the system and specify their proximity domain that way.  If both _PXM
and this are provided, they should give the same answer.

For now this patch set completely ignores that feature as we don't need
it to start the discussion.  It will form a follow up set at some point
(if no one else fancies doing it).

Test cases for the access1 class
********************************

Test cases for Generic Initiator additions to HMAT.

Setup

PXM0 (node 0) - CPU0 CPU1, 2G memory
PXM1 (node 1) - CPU2 CPU3, 2G memory
PXM2 (node 2) - CPU4 CPU5, 2G memory
PXM3 (node 4) - 2G memory (GI in one case below)
PXM4 (node 3) - GI only.

Config 1:  GI in PXM4 nearer to memory in PXM 3 than CPUs, not direct attached

[    2.384064] acpi/hmat: HMAT: Locality: Flags:00 Type:Access Latency Initiator Domains:4 Target Domains:4 Base:256
[    2.384913] acpi/hmat:   Initiator-Target[0-0]:1 nsec
[    2.385190] acpi/hmat:   Initiator-Target[0-1]:9 nsec
[    2.385736] acpi/hmat:   Initiator-Target[0-2]:9 nsec
[    2.385984] acpi/hmat:   Initiator-Target[0-3]:9 nsec
[    2.386447] acpi/hmat:   Initiator-Target[1-0]:9 nsec
[    2.386740] acpi/hmat:   Initiator-Target[1-1]:1 nsec
[    2.386964] acpi/hmat:   Initiator-Target[1-2]:9 nsec
[    2.387174] acpi/hmat:   Initiator-Target[1-3]:9 nsec
[    2.387624] acpi/hmat:   Initiator-Target[2-0]:9 nsec
[    2.387953] acpi/hmat:   Initiator-Target[2-1]:9 nsec
[    2.388155] acpi/hmat:   Initiator-Target[2-2]:1 nsec
[    2.388607] acpi/hmat:   Initiator-Target[2-3]:9 nsec
[    2.388861] acpi/hmat:   Initiator-Target[4-0]:13 nsec
[    2.389126] acpi/hmat:   Initiator-Target[4-1]:13 nsec
[    2.389574] acpi/hmat:   Initiator-Target[4-2]:13 nsec
[    2.389805] acpi/hmat:   Initiator-Target[4-3]:5 nsec

# Sysfs reads the same for nodes 0-2 for access0 and access1 as no GI involved.

/sys/bus/node/devices/...
    node0 #1 and 2 similar.
        access0
            initiators
                node0
                read_bandwidth  0 #not specificed in hmat
                read_latency    1
                write_bandwidth 0
                write_latency   1
            power
            targets
                node0
            uevent
        access1
            initiators
                node0
                read_bandwidth  0
                read_latency    1
                write_bandwidth 0
                read_bandwidth  1   
            power
            targets
                node 0
            uevent
        compact
        cpu0
        cpu1
        ...
    node3 # Note PXM 4, contains GI only
        access0
            initiators
                *empty*
            power
            targets
                node4
            uevent
        compact
        ...
    node4
        access0
            initiators
                node3
                read_bandwidth  0
                read_latency    5
                write_bandwidth 0
                write_latency   5
            power
            targets
                *empty*
            uevent
        access1
            initiators
                node0
                node1
                node2
                read_bandwidth  0
                read_latency    9
                write_bandwidth 0
                write_latency   9
            power
            targets
                *empty*
            uevent
        compact
        ...

Config 2:  GI in PXM4 further to memory in PXM 3 than CPUs, not direct attached

[    4.073493] acpi/hmat: HMAT: Locality: Flags:00 Type:Access Latency Initiator Domains:4 Target Domains:4 Base:256
[    4.074785] acpi/hmat:   Initiator-Target[0-0]:1 nsec
[    4.075150] acpi/hmat:   Initiator-Target[0-1]:9 nsec
[    4.075423] acpi/hmat:   Initiator-Target[0-2]:9 nsec
[    4.076184] acpi/hmat:   Initiator-Target[0-3]:9 nsec
[    4.077116] acpi/hmat:   Initiator-Target[1-0]:9 nsec
[    4.077366] acpi/hmat:   Initiator-Target[1-1]:1 nsec
[    4.077640] acpi/hmat:   Initiator-Target[1-2]:9 nsec
[    4.078156] acpi/hmat:   Initiator-Target[1-3]:9 nsec
[    4.078471] acpi/hmat:   Initiator-Target[2-0]:9 nsec
[    4.078994] acpi/hmat:   Initiator-Target[2-1]:9 nsec
[    4.079277] acpi/hmat:   Initiator-Target[2-2]:1 nsec
[    4.079505] acpi/hmat:   Initiator-Target[2-3]:9 nsec
[    4.080126] acpi/hmat:   Initiator-Target[4-0]:13 nsec
[    4.080995] acpi/hmat:   Initiator-Target[4-1]:13 nsec
[    4.081351] acpi/hmat:   Initiator-Target[4-2]:13 nsec
[    4.082125] acpi/hmat:   Initiator-Target[4-3]:13 nsec

/sys/bus/node/devices/...
    node0 #1 and 2 similar.
        access0
            initiators
                node0
                read_bandwidth  0 #not specificed in hmat
                read_latency    1
                write_bandwidth 0
                write_latency   1
            power
            targets
                node0
                node4
            uevent
        access1
            initiators
                node0
                read_bandwidth  0
                read_latency    1
                write_bandwidth 0
                read_bandwidth  1   
            power
            targets
                node0
                node4
            uevent
        compact
        cpu0
        cpu1
        ...
    node3 # Note PXM 4, contains GI only
        #No accessX directories.
        compact
        ...
    node4
        access0
            initiators
                node0
                node1
                node2
                read_bandwidth  0
                read_latency    9
                write_bandwidth 0
                write_latency   9
            power
            targets
                *empty*
            uevent
        access1
            initiators
                node0
                node1
                node2
                read_bandwidth  0
                read_latency    9
                write_bandwidth 0
                write_latency   9
            power
            targets
                *empty*
            uevent
        compact
        ...


case 3 - as per case 2 but now the memory in node 3 is direct attached to the
GI but nearer the main nodes (not physically sensible :))

/sys/bus/node/devices/...
    node0 #1 and 2 similar.
        access0
            initiators
                node0
                read_bandwidth  0 #not specificed in hmat
                read_latency    1
                write_bandwidth 0
                write_latency   1
            power
            targets
                node0
                node4
            uevent
        access1
            initiators
                node0
                read_bandwidth  0
                read_latency    1
                write_bandwidth 0
                read_bandwidth  1   
            power
            targets
                node0
                node4
            uevent
        compact
        cpu0
        cpu1
        ...
    node3 # Note PXM 4, contains GI only
        access0
            initiators
                *empty*
            power
            targets
                node4
            uevent
        compact
        ...
    node4
        access0
            initiators
                node3
                read_bandwidth  0
                read_latency    13
                write_bandwidth 0
                write_latency   13
            power
            targets
                *empty*
            uevent
        access1
            initiators
                node0
                node1
                node2
                read_bandwidth  0
                read_latency    9
                write_bandwidth 0
                write_latency   9
            power
            targets
                *empty*
            uevent
        compact
        ...

Case 4 - nearer the GI, but direct attached to one of the CPUS.
# Another bonkers one.

/sys/bus/node/devices/...
    node0 #1 similar.
        access0
            initiators
                node0
                read_bandwidth  0 #not specificed in hmat
                read_latency    1
                write_bandwidth 0
                write_latency   1
            power
            targets
                node0
                node4
            uevent
        access1
            initiators
                node0
                read_bandwidth  0
                read_latency    1
                write_bandwidth 0
                read_bandwidth  1   
            power
            targets
                node0
            uevent
        compact
        cpu0
        cpu1
        ...
    node2 # Direct attached to memory in node 3
        access0
            initiators
                node2
                read_bandwidth  0 #not specificed in hmat
                read_latency    1
                write_bandwidth 0
                write_latency   1
            power
            targets
                node2
                node4 #direct attached
            uevent
        access1
            initiators
                node2
                read_bandwidth  0
                read_latency    1
                write_bandwidth 0
                read_bandwidth  1   
            power
            targets
                node2
                node4 #direct attached
            uevent
        compact
        cpu0
        cpu1
        ...

    node3 # Note PXM 4, contains GI only
        #No accessX directories.
        compact
        ...
    node4
        access0
            initiators
                node3
                read_bandwidth  0
                read_latency    13
                write_bandwidth 0
                write_latency   13
            power
            targets
                *empty*
            uevent
        access1
            initiators
                node0
                node1
                node2
                read_bandwidth  0
                read_latency    9
                write_bandwidth 0
                write_latency   9
            power
            targets
                *empty*
            uevent
        compact
        ...

case 5 memory and GI together in node 3 (added an extra GI to node 3)
Note hmat should also reflect this extra initiator domain.

/sys/bus/node/devices/...
    node0 #1 and 2 similar.
        access0
            initiators
                node0
                read_bandwidth  0 #not specificed in hmat
                read_latency    1
                write_bandwidth 0
                write_latency   1
            power
            targets
                node0
                node4
            uevent
        access1
            initiators
                node0
                read_bandwidth  0
                read_latency    1
                write_bandwidth 0
                read_bandwidth  1   
            power
            targets
                node0
            uevent
        compact
        cpu0
        cpu1
        ...
    node3 # Note PXM 3, contains GI only
        #No accessX directories.
        compact
        ...
    node4 # Now memory and GI.
        access0
            initiators
                node4
                read_bandwidth  0
                read_latency    1
                write_bandwidth 0
                write_latency   1
            power
            targets
                node4
            uevent
        access1
            initiators
                node0
                node1
                node2
                read_bandwidth  0
                read_latency    9
                write_bandwidth 0
                write_latency   9
            power
            targets
                *empty* # as expected GI doesn't paticipate in access 1.
            uevent
        compact
        ...
	
Jonathan Cameron (6):
  ACPI: Support Generic Initiator only domains
  x86: Support Generic Initiator only proximity domains
  ACPI: Let ACPI know we support Generic Initiator Affinity Structures
  ACPI: HMAT: Fix handling of changes from ACPI 6.2 to ACPI 6.3
  node: Add access1 class to represent CPU to memory characteristics
  docs: mm: numaperf.rst Add brief description for access class 1.

 Documentation/admin-guide/mm/numaperf.rst |  8 ++
 arch/x86/include/asm/numa.h               |  2 +
 arch/x86/kernel/setup.c                   |  1 +
 arch/x86/mm/numa.c                        | 14 ++++
 drivers/acpi/bus.c                        |  4 +
 drivers/acpi/numa/hmat.c                  | 89 ++++++++++++++++++-----
 drivers/acpi/numa/srat.c                  | 69 +++++++++++++++++-
 drivers/base/node.c                       |  3 +
 include/linux/acpi.h                      |  1 +
 include/linux/nodemask.h                  |  1 +
 10 files changed, 171 insertions(+), 21 deletions(-)

-- 
2.19.1

