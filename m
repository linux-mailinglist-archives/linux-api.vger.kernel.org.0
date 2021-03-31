Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436E5350301
	for <lists+linux-api@lfdr.de>; Wed, 31 Mar 2021 17:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbhCaPLy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Mar 2021 11:11:54 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:39001 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbhCaPLk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Mar 2021 11:11:40 -0400
Received: from [192.168.1.155] ([77.4.59.177]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N1OsF-1ldQAY0W9z-012smt; Wed, 31 Mar 2021 17:08:21 +0200
Subject: Re: [PATCH RFC 0/3] drivers/char: remove /dev/kmem for good
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        carnil@debian.org
Cc:     David Hildenbrand <david@redhat.com>,
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
 <CAHk-=wg1HTbXkjdMYA4zADEiE8HwpZ0=uWy0ujZTJYVT-KCehQ@mail.gmail.com>
 <20210319173334.pwkuj5np5ixwmtug@linutronix.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <dd297d94-8358-81b8-9a5b-0ebbfb5378d1@metux.net>
Date:   Wed, 31 Mar 2021 17:08:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210319173334.pwkuj5np5ixwmtug@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NovW3JxGTDnwNoX8z11i7Qai9NMNdLjbbHxHpmU3YZzCMtybqZd
 yLm4MZ7QANLpJ5UiTNQSzHFfCeioM6WJVyU7OZfjnpfvv1P5kDNWPKYM+yanZQI/xQk6pEz
 n5M1ef3viMmEZF8lRWCbzppAlaJdojVqJzjUoDYnsSuOtjGA+8AynOVWhdj7fiSC1pyonk1
 A1/b/YVuE+aw+MqjqKlFQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GVn3kEhfAUs=:scsDeyIwHfX6aX05tC1oKm
 cW6nGO6eITFlaj9OIXEB77gyjNq3cfB9zpf6Q4Vx8ThjYmSH52i1UoJ0XLjCZXA+DYHWJsIEM
 l9CjmHG1cmLhKLbCReyFzMVuQUpZkt0Z6wVXHU1zMAWdUNjTwuHa61gZImwoS1BwTCYGH1hPK
 XJ2eUjOo3PSQepLmOZg1FcvaJOliITh/TNU2vZriVTHJS/yWO1rsZFu0aZ78xRAK/Qv7pn1lh
 FcTwZXqNM47B5atRCP9cKZmB8qXydvA06AN4yeFvcEK967k3zYFPUxHFs0QGXNcVqytEmmqdr
 5Uy8Q5zZ8SZ7OrJjPOG3YKezsX3nKJjTSdFGSYbjqWjaGJJenXbbqcH8kzMlW1pyeNA3zheP8
 ovRQc96zO6LnD1cWsAUXFigjfIUwJotOGS55qjFUsHhS05Kx46dsDxX50yZe+OIJAS50uJ0Qh
 caURffhjxM7ob9kSOWVdZ/d1aSV6f4Yx7NdcOHP5s+PwgxHl5nji
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 19.03.21 18:33, Sebastian Andrzej Siewior wrote:
> On 2021-03-19 10:14:02 [-0700], Linus Torvalds wrote:
>> On Fri, Mar 19, 2021 at 7:35 AM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> Let's start a discussion if /dev/kmem is worth keeping around and
>>> fixing/maintaining or if we should just remove it now for good.
>>
>> I'll happily do this for the next merge window, but would really want
>> distros to confirm that they don't enable it.
>>
>> I can confirm that it's certainly not enabled on any of the machines I
>> have, but..
> 
> Debian has CONFIG_DEVKMEM disabled since 2.6.31.

SLES, too. (but no idea since when exactly)

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
