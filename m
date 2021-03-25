Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93D0348950
	for <lists+linux-api@lfdr.de>; Thu, 25 Mar 2021 07:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCYGqw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Mar 2021 02:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhCYGqW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 25 Mar 2021 02:46:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 092D96196C;
        Thu, 25 Mar 2021 06:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616654781;
        bh=/bWXfIbKchosJuds3GtGSYe3Fmxl28hRKZ2NNwbgsZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LV0L2HrWiWFSQLHQ9K2y3ZiXOdKtS5f7XaIhNmZGREHfokELU4V3/XChxSfTzu8n+
         TQGKJ0OU/awi/NXK/7Iq+cyA3dBNW3dDeOOq5KE8YAWsINkQ1FN26ZKKxjo4aaNlVZ
         elF+ZLYttYpavKZffZAlo0a/8bAHO4qKFk7gLrcs=
Date:   Thu, 25 Mar 2021 07:46:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
        Gregory Clement <gregory.clement@bootlin.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Hillf Danton <hdanton@sina.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
Message-ID: <YFwxuRhZZ+U8lh8W@kroah.com>
References: <20210324102351.6932-1-david@redhat.com>
 <20210324122412.e77247e6d3259d5493951019@linux-foundation.org>
 <20210324225812.GM77072@balbir-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324225812.GM77072@balbir-desktop>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 25, 2021 at 09:58:12AM +1100, Balbir Singh wrote:
> On Wed, Mar 24, 2021 at 12:24:12PM -0700, Andrew Morton wrote:
> > 
> > > Let's remove /dev/kmem, which is unused and obsolete.
> > 
> > I grabbed these.  Silently - the cc list is amazing ;)
> > 
> > I was wondering if it would be better to permanently disable /dev/kmem
> > in Kconfig along with a comment "if you really want this thing then
> > email peeps@places with a very good reason why".  Let that ride for a
> > year or three then blam.
> > 
> > But this is so much more attractive, and it certainly sounds like it's
> > worth any damage it might cause.
> > 
> > We do tend to think about distros.  I bet there are a number of weird
> > embedded type systems using /dev/kmem - it's amazing what sorts of
> > hacks those people will put up with the get something out the door. 
> > But those systems tend to carry a lot of specialized changes anyway, so
> > they can just add "revert David's patch" to their pile.
> >
> 
> 
> I wonder if we should have the opposite of driver/staging and call it
> outgoing, with a big thank you to the users and developers and also
> to indicate this feature will be removed in the next (few) merge(s)
> cycles. I guess not all code can be accumulated under a single
> hierarchy. May not be worth the effort, just thinking out loud.

That is exactly what drivers/staging/ is being used for, for stuff on
the way out of the kernel.  wimax just left the kernel that way a week
or so ago, we've been doing this for many years now, the fact that no
one has noticed is good as that means that no one has needed the code
removed that way :)

thanks,

greg k-h
