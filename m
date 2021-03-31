Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808BB350328
	for <lists+linux-api@lfdr.de>; Wed, 31 Mar 2021 17:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbhCaPVP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Mar 2021 11:21:15 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:36397 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbhCaPVL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Mar 2021 11:21:11 -0400
Received: from [192.168.1.155] ([77.4.59.177]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N6KML-1lhFle26f3-016hMd; Wed, 31 Mar 2021 17:18:31 +0200
Subject: Re: [PATCH v1 0/3] drivers/char: remove /dev/kmem for good
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
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
References: <20210324102351.6932-1-david@redhat.com>
 <20210324122412.e77247e6d3259d5493951019@linux-foundation.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <96217148-3104-410f-a765-72565ec46c9f@metux.net>
Date:   Wed, 31 Mar 2021 17:18:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210324122412.e77247e6d3259d5493951019@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VfyGJx6Kl38NiTptnjW3K10nVzgYxIK8cs0hHkREs3FHQJsYUzp
 Wwx4CLOohzFUI1f1nKfkOSZwrXbXzZis2skwvyYhEeCHAspoX/OHyW23B058DaozKIutafE
 RSAL9geaw+/9+9vrkJIUdhjYie7dIhZTPjgXgqaRg2ssWV6pq8U4x9hDZGBnqFyEkV52hu3
 ZlT4oTDCAC9+DCSMSIg5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:npk68NHKQ78=:22Pdn/EmXUk4GSszcJcY8V
 ikE19qv26vOphPBgZhBKpWAZli3GdkyjclfZTMaekBwday1DA2ILKN8zX8jxNeCuqx+QSueBK
 QXXt9Gx9yQyTPoetkWN+5JSiNmgOd8lDN4AQqFGv7Qs04vQRyWJghIE54EkIGfAx602nqw+nI
 E3nB809vwyVp/T9Qb5Lv/ZgGQajrsWkgu+5OhKkH4EdKmNh3IGtyVUYHb+W7vQnAeSU372Lpf
 j9OvV49plSUMrRv5Oa0F4Eee90ponbTbIwsBmGaidcFGDB8TzIwZovV10mMFbeoCto2fwt25v
 vDT30jWTQ7gHhOWh0mq5iNkxXbbLkDxDC/TEGa9y2UMT9M+NKSLQtIMxlGfo0JyodIEBni+b2
 BQRDqz+iD+HGK440usz3MwcXRCJD1D1xI10bs628FA73DXT9jmVlOEdfhrfLVVDEfber0j9xA
 ydWMLwuQfCF5l9tzl0E0FdhrbQVQ/SPwcqPUVh9mlIvgam6WC/nf
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 24.03.21 20:24, Andrew Morton wrote:

> We do tend to think about distros.  I bet there are a number of weird
> embedded type systems using /dev/kmem - it's amazing what sorts of
> hacks those people will put up with the get something out the door.

There certainly are (seen lots of such crap), another good reason for
kicking it out asap.

> But those systems tend to carry a lot of specialized changes anyway, so
> they can just add "revert David's patch" to their pile.

Often those kind of people aren't capable of that. If anyone finds such
systems, report them to cert, bsi, fd, ...


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
