Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF741341F8A
	for <lists+linux-api@lfdr.de>; Fri, 19 Mar 2021 15:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCSOfv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 19 Mar 2021 10:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230114AbhCSOfd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 19 Mar 2021 10:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616164532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HR6BlhRi10R2YkmIR68UtbTv/7nJrwXj0GX0OuoUYEI=;
        b=MK/OWFPd4T5dssg/KcoCiXpfswOI51gi44eATGI2ZyVvz1rQ/T/g2E5n7BgUeev+Zhczw6
        KxlCaLKRU+PtwsVjRudtEfWuQxUx3MjLBR/FZEVqsn3MSaDm9wy8Qi4FKorCWzNJhF7lcT
        Tj+lya80hX11RWCgyH9pB7gSpYsONBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-sIMVJReaOfexJV6rX5Pawg-1; Fri, 19 Mar 2021 10:35:28 -0400
X-MC-Unique: sIMVJReaOfexJV6rX5Pawg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3368B100945E;
        Fri, 19 Mar 2021 14:35:24 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-11.ams2.redhat.com [10.36.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CEE660C04;
        Fri, 19 Mar 2021 14:34:53 +0000 (UTC)
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
Subject: [PATCH RFC 0/3] drivers/char: remove /dev/kmem for good
Date:   Fri, 19 Mar 2021 15:34:49 +0100
Message-Id: <20210319143452.25948-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Let's start a discussion if /dev/kmem is worth keeping around and
fixing/maintaining or if we should just remove it now for good.

More details / findings in patch #1. Patch #2 and #3 perform minor cleanups
based on removed /dev/kmem support.

Only compile-tested on x86-64 -- good enough for discussing the general
topic (RFC).

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
 mm/vmalloc.c                              | 113 +----------
 41 files changed, 5 insertions(+), 455 deletions(-)

-- 
2.29.2

