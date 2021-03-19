Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1A0342001
	for <lists+linux-api@lfdr.de>; Fri, 19 Mar 2021 15:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhCSOqH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 19 Mar 2021 10:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230336AbhCSOps (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 19 Mar 2021 10:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616165146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8KGbLZQ7O+JfyAjTpujJt4QAW5NJjPJMsJ4wbUnlwTM=;
        b=am0tla4yt6NyH3/n0ysHeAFAxbHuD6Nghr/nrYZmETnzcsu4hAgRAoeusLCX95pqMElS4q
        YB/ZO+TNuwUM09n06K/3ObNQ6qkR7B03kEIKbzsPN7cuoiWTKLgUmLQy3kaevY5QZ3RSWQ
        Aa9/5QMw/ocE70P4XyGYdagXUD65Ndw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-XIN7XlhROw6nZkbmTGNd6A-1; Fri, 19 Mar 2021 10:45:45 -0400
X-MC-Unique: XIN7XlhROw6nZkbmTGNd6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21154801597;
        Fri, 19 Mar 2021 14:45:41 +0000 (UTC)
Received: from [10.36.112.11] (ovpn-112-11.ams2.redhat.com [10.36.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9858D6090F;
        Fri, 19 Mar 2021 14:45:26 +0000 (UTC)
Subject: Re: [PATCH RFC 0/3] drivers/char: remove /dev/kmem for good
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org,
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
References: <20210319143452.25948-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <39b945bc-003c-4fb3-17ad-3484b6196bd3@redhat.com>
Date:   Fri, 19 Mar 2021 15:45:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210319143452.25948-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 19.03.21 15:34, David Hildenbrand wrote:
> Let's start a discussion if /dev/kmem is worth keeping around and
> fixing/maintaining or if we should just remove it now for good.
> 
> More details / findings in patch #1. Patch #2 and #3 perform minor cleanups
> based on removed /dev/kmem support.

As some arch maintainers are only cced on patch #2 (grml), patch #1 is

https://lkml.kernel.org/r/20210319143452.25948-2-david@redhat.com

and the description is:

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
mistake?). All distributions I looked at disable it.

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

4) "Kernel Memory Editor" hasn't seen any updates since 2000 and seems
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

-- 
Thanks,

David / dhildenb

