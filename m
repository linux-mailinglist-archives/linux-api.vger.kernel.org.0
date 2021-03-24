Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D424F3475F2
	for <lists+linux-api@lfdr.de>; Wed, 24 Mar 2021 11:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhCXKYa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Mar 2021 06:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232973AbhCXKYV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Mar 2021 06:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616581460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QMLqwym9flE8lbkbE50aRSXeGQ8jV5p2RxKLL2xiNLM=;
        b=gszfKc7KCNEwx9TQ0HM/e+J8hQYXG7x4ApSiPEfUCdRc7c39/bJhe6DEwOn/iq0/cfL7Ck
        h+6Aq1JAAxowfjUFHsbPPe3mYUoBMVgoByMzBzDrWNgeBtXJ3Ojdmy/EpZTpSbUBl0dmJx
        bVQUR8AHUpZ9D3dwHYucqewHwjQmGNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-F0cqRh6aPYuHEv4XexPcpA-1; Wed, 24 Mar 2021 06:24:16 -0400
X-MC-Unique: F0cqRh6aPYuHEv4XexPcpA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E1D881746C;
        Wed, 24 Mar 2021 10:24:13 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-66.ams2.redhat.com [10.36.115.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EAF910013D7;
        Wed, 24 Mar 2021 10:23:52 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Chris Zankel <chris@zankel.net>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Hillf Danton <hdanton@sina.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        James Troup <james.troup@canonical.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jonas Bonn <jonas@southpole.se>,
        Jonathan Corbet <corbet@lwn.net>,
        Kairui Song <kasong@redhat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Mackerras <paulus@samba.org>,
        "Pavel Machek (CIP)" <pavel@denx.de>, Pavel Machek <pavel@ucw.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Rich Felker <dalias@libc.org>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Theodore Dubois <tblodt@icloud.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        William Cohen <wcohen@redhat.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v1 0/3] drivers/char: remove /dev/kmem for good
Date:   Wed, 24 Mar 2021 11:23:48 +0100
Message-Id: <20210324102351.6932-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Let's remove /dev/kmem, which is unused and obsolete. Description from
patch #1:

"
Exploring /dev/kmem and /dev/mem in the context of memory hot(un)plug and
memory ballooning, I started questioning the existance of /dev/kmem.

Comparing it with the /proc/kcore implementation, it does not seem to be
able to deal with things like
a) Pages unmapped from the direct mapping (e.g., to be used by secretmem)
  -> kern_addr_valid(). virt_addr_valid() is not sufficient.
b) Special cases like gart aperture memory that is not to be touched
  -> mem_pfn_is_ram()
Unless I am missing something, it's at least broken in some cases and might
fault/crash the machine.

Looks like its existance has been questioned before in 2005 and 2010
[1], after ~11 additional years, it might make sense to revive the
discussion.

CONFIG_DEVKMEM is only enabled in a single defconfig (on purpose or by
mistake?). All distributions disable it: in Ubuntu it has been disabled
for more than 10 years, in Debian since 2.6.31, in Fedora at least starting
with FC3, in RHEL starting with RHEL4, in SUSE starting from 15sp2, and
OpenSUSE has it disabled as well.

1) /dev/kmem was popular for rootkits [2] before it got disabled
   basically everywhere. Ubuntu documents [3] "There is no modern user of
   /dev/kmem any more beyond attackers using it to load kernel rootkits.".
   RHEL documents in a BZ [5] "it served no practical purpose other than to
   serve as a potential security problem or to enable binary module drivers
   to access structures/functions they shouldn't be touching"

2) /proc/kcore is a decent interface to have a controlled way to read
   kernel memory for debugging puposes. (will need some extensions to
   deal with memory offlining/unplug, memory ballooning, and poisoned
   pages, though)

3) It might be useful for corner case debugging [1]. KDB/KGDB might be a
   better fit, especially, to write random memory; harder to shoot
   yourself into the foot.

4) "Kernel Memory Editor" [4] hasn't seen any updates since 2000 and seems
   to be incompatible with 64bit [1]. For educational purposes,
   /proc/kcore might be used to monitor value updates -- or older
   kernels can be used.

5) It's broken on arm64, and therefore, completely disabled there.

Looks like it's essentially unused and has been replaced by better
suited interfaces for individual tasks (/proc/kcore, KDB/KGDB). Let's
just remove it.

[1] https://lwn.net/Articles/147901/
[2] https://www.linuxjournal.com/article/10505
[3] https://wiki.ubuntu.com/Security/Features#A.2Fdev.2Fkmem_disabled
[4] https://sourceforge.net/projects/kme/
[5] https://bugzilla.redhat.com/show_bug.cgi?id=154796
"

RFC -> v1:
- "drivers/char: remove /dev/kmem for good"
-- Add more details to patch description regarding distributions
- "mm/vmalloc: remove vwrite()"
-- Also remove the nommu variant
- Compile-tested on more archs/configs

David Hildenbrand (3):
  drivers/char: remove /dev/kmem for good
  mm: remove xlate_dev_kmem_ptr()
  mm/vmalloc: remove vwrite()

 Documentation/admin-guide/devices.txt     |   2 +-
 arch/alpha/include/asm/io.h               |   5 -
 arch/arm/configs/dove_defconfig           |   1 -
 arch/arm/configs/magician_defconfig       |   1 -
 arch/arm/configs/moxart_defconfig         |   1 -
 arch/arm/configs/mps2_defconfig           |   1 -
 arch/arm/configs/mvebu_v5_defconfig       |   1 -
 arch/arm/configs/xcep_defconfig           |   1 -
 arch/arm/include/asm/io.h                 |   5 -
 arch/h8300/configs/edosk2674_defconfig    |   1 -
 arch/h8300/configs/h8300h-sim_defconfig   |   1 -
 arch/h8300/configs/h8s-sim_defconfig      |   1 -
 arch/hexagon/configs/comet_defconfig      |   1 -
 arch/hexagon/include/asm/io.h             |   1 -
 arch/ia64/include/asm/io.h                |   1 -
 arch/ia64/include/asm/uaccess.h           |  18 --
 arch/m68k/configs/amcore_defconfig        |   1 -
 arch/m68k/include/asm/io_mm.h             |   5 -
 arch/mips/include/asm/io.h                |   5 -
 arch/openrisc/configs/or1ksim_defconfig   |   1 -
 arch/parisc/include/asm/io.h              |   5 -
 arch/powerpc/include/asm/io.h             |   5 -
 arch/s390/include/asm/io.h                |   5 -
 arch/sh/configs/edosk7705_defconfig       |   1 -
 arch/sh/configs/se7206_defconfig          |   1 -
 arch/sh/configs/sh2007_defconfig          |   1 -
 arch/sh/configs/sh7724_generic_defconfig  |   1 -
 arch/sh/configs/sh7770_generic_defconfig  |   1 -
 arch/sh/configs/sh7785lcr_32bit_defconfig |   1 -
 arch/sh/include/asm/io.h                  |   5 -
 arch/sparc/configs/sparc64_defconfig      |   1 -
 arch/sparc/include/asm/io_64.h            |   5 -
 arch/xtensa/configs/xip_kc705_defconfig   |   1 -
 drivers/char/Kconfig                      |  10 -
 drivers/char/mem.c                        | 231 ----------------------
 include/asm-generic/io.h                  |  11 --
 include/linux/fs.h                        |   2 +-
 include/linux/vmalloc.h                   |   3 +-
 kernel/configs/android-base.config        |   1 -
 mm/ksm.c                                  |   2 +-
 mm/nommu.c                                |  10 -
 mm/vmalloc.c                              | 118 +----------
 42 files changed, 6 insertions(+), 469 deletions(-)


base-commit: 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b
-- 
2.29.2

