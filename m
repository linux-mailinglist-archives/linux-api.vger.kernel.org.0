Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38EB344917
	for <lists+linux-api@lfdr.de>; Mon, 22 Mar 2021 16:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhCVPTG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Mar 2021 11:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231723AbhCVPSd (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 22 Mar 2021 11:18:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68ED96198E;
        Mon, 22 Mar 2021 15:18:25 +0000 (UTC)
Date:   Mon, 22 Mar 2021 11:18:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
        Sudeep Holla <sudeep.holla@arm.com>,
        Theodore Dubois <tblodt@icloud.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        William Cohen <wcohen@redhat.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH RFC 0/3] drivers/char: remove /dev/kmem for good
Message-ID: <20210322111824.59bac299@gandalf.local.home>
In-Reply-To: <be3e8470-a8a4-2111-5c5e-7a03c1f9ed16@redhat.com>
References: <20210319143452.25948-1-david@redhat.com>
        <20210319141018.5ee1a5ac@gandalf.local.home>
        <be3e8470-a8a4-2111-5c5e-7a03c1f9ed16@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 22 Mar 2021 11:08:47 +0100
David Hildenbrand <david@redhat.com> wrote:

> 
> Wonder if "echo c > /proc/sysrq-trigger" already existed and would have 
> worked back then. :)
> 
> 

Looks like sysrq-c was added in 2005:

commit 86b1ae38c0a62 ("kdump: sysrq trigger mechanism for kexec based crashdumps")

Thus the answer is "No, it would not have worked back then".

-- Steve
