Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E839346007
	for <lists+linux-api@lfdr.de>; Tue, 23 Mar 2021 14:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhCWNp0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 Mar 2021 09:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231765AbhCWNpH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 23 Mar 2021 09:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616507106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u4IuFNs7G9eHpxIxEjFpymhZdMA5gfvx/fmGXZsBykM=;
        b=B6TeOPTnFxIiJ35lqXDYzRJxAY5wAkxTcPA6vDy1PHD5bs5DZrRYmNqfSW2Rb/S2IL6Z1Z
        L625vtSr9UEnr2bwhCzp64RY1n41KN6B/inL4kKr6XS1lT7nxnaiZlhdXNdxiX4ypmGTvn
        Yv7fJmi1o6BYb7DEzaco2/tnbXTtOj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-Q4IMCjb0N-aE0Tj3pSfG3Q-1; Tue, 23 Mar 2021 09:45:02 -0400
X-MC-Unique: Q4IMCjb0N-aE0Tj3pSfG3Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64D7857054;
        Tue, 23 Mar 2021 13:44:42 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AF1C86586;
        Tue, 23 Mar 2021 13:44:21 +0000 (UTC)
Subject: Re: [PATCH RFC 0/3] drivers/char: remove /dev/kmem for good
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
 <YFnqOgpoehAnxtKQ@kroah.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8bd3a6cc-02a9-38e7-ddd2-22f49c133e25@redhat.com>
Date:   Tue, 23 Mar 2021 14:44:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFnqOgpoehAnxtKQ@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 23.03.21 14:16, Greg Kroah-Hartman wrote:
> On Fri, Mar 19, 2021 at 03:34:49PM +0100, David Hildenbrand wrote:
>> Let's start a discussion if /dev/kmem is worth keeping around and
>> fixing/maintaining or if we should just remove it now for good.
>>
>> More details / findings in patch #1. Patch #2 and #3 perform minor cleanups
>> based on removed /dev/kmem support.
>>
>> Only compile-tested on x86-64 -- good enough for discussing the general
>> topic (RFC).
> 
> I'll gladly take this in my char/misc tree for now, to show up in
> linux-next to get some testing to see if anyone complains.
> 
> Let me know if that will help out.

Sure! I'll resend as v1 this week (also removing vwrite() from nommu 
code in patch #3).

Thanks

-- 
Thanks,

David / dhildenb

