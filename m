Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D533481D7
	for <lists+linux-api@lfdr.de>; Wed, 24 Mar 2021 20:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbhCXTY1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Mar 2021 15:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237780AbhCXTYQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 24 Mar 2021 15:24:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 441EB61962;
        Wed, 24 Mar 2021 19:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1616613855;
        bh=k3KeOvY/gY++1wYNecE8Vi7uDBnm7jr2w4YKjm0PyhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sprd/8YQn6NWR53KSXnTHGGl8JK7/S2Rt6SQn4o9f98SYsIQcYR4gjkZRnazDs6IE
         uGVYuCaxdW4Ed0O5cStGnsibK/KvJDIFOnfkvtgnS05HNSBtRQ/WOidStla0oN/Y1k
         eZ/WJc0DuVozgFEJyQNHpZ47dHHRnRreqXDrz6as=
Date:   Wed, 24 Mar 2021 12:24:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
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
        Yoshinori Sato <ysato@users.osdn.me>
Subject: Re: [PATCH v1 0/3] drivers/char: remove /dev/kmem for good
Message-Id: <20210324122412.e77247e6d3259d5493951019@linux-foundation.org>
In-Reply-To: <20210324102351.6932-1-david@redhat.com>
References: <20210324102351.6932-1-david@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


> Let's remove /dev/kmem, which is unused and obsolete.

I grabbed these.  Silently - the cc list is amazing ;)

I was wondering if it would be better to permanently disable /dev/kmem
in Kconfig along with a comment "if you really want this thing then
email peeps@places with a very good reason why".  Let that ride for a
year or three then blam.

But this is so much more attractive, and it certainly sounds like it's
worth any damage it might cause.

We do tend to think about distros.  I bet there are a number of weird
embedded type systems using /dev/kmem - it's amazing what sorts of
hacks those people will put up with the get something out the door. 
But those systems tend to carry a lot of specialized changes anyway, so
they can just add "revert David's patch" to their pile.


