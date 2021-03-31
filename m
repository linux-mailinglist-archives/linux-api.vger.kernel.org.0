Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83717350326
	for <lists+linux-api@lfdr.de>; Wed, 31 Mar 2021 17:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbhCaPTh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Mar 2021 11:19:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:56810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236256AbhCaPTL (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 31 Mar 2021 11:19:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617203949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p6Ufx+acUY8pZhy/92+xIrmM8aKDEPteIyaOrAwJ5Og=;
        b=GsCXeGFK5kIImf19mhwCwL/Xwmux98ybVuD6tWvR3u8+3C361FnJkHS1BCM5Uf0kBb65zA
        IBycCO7HgQTI8H6hAwJfgDztnumNe98AdbdlnEvg3mFmkHixGhfiHUG6oc4jJtGaQKyvRk
        hsYOcjnYDkhEr3IxqRioy9k3qJOodrE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97CBAB2FF;
        Wed, 31 Mar 2021 15:19:09 +0000 (UTC)
Date:   Wed, 31 Mar 2021 17:19:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        carnil@debian.org, David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
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
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jonas Bonn <jonas@southpole.se>,
        Jonathan Corbet <corbet@lwn.net>,
        Kairui Song <kasong@redhat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux API <linux-api@vger.kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: Re: [PATCH RFC 0/3] drivers/char: remove /dev/kmem for good
Message-ID: <YGSS54HiG0eFM0J0@dhcp22.suse.cz>
References: <20210319143452.25948-1-david@redhat.com>
 <CAHk-=wg1HTbXkjdMYA4zADEiE8HwpZ0=uWy0ujZTJYVT-KCehQ@mail.gmail.com>
 <20210319173334.pwkuj5np5ixwmtug@linutronix.de>
 <dd297d94-8358-81b8-9a5b-0ebbfb5378d1@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd297d94-8358-81b8-9a5b-0ebbfb5378d1@metux.net>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 31-03-21 17:08:03, Enrico Weigelt, metux IT consult wrote:
> On 19.03.21 18:33, Sebastian Andrzej Siewior wrote:
> > On 2021-03-19 10:14:02 [-0700], Linus Torvalds wrote:
> > > On Fri, Mar 19, 2021 at 7:35 AM David Hildenbrand <david@redhat.com> wrote:
> > > > 
> > > > Let's start a discussion if /dev/kmem is worth keeping around and
> > > > fixing/maintaining or if we should just remove it now for good.
> > > 
> > > I'll happily do this for the next merge window, but would really want
> > > distros to confirm that they don't enable it.
> > > 
> > > I can confirm that it's certainly not enabled on any of the machines I
> > > have, but..
> > 
> > Debian has CONFIG_DEVKMEM disabled since 2.6.31.
> 
> SLES, too. (but no idea since when exactly)

15-SP2 IIRC

-- 
Michal Hocko
SUSE Labs
