Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B0C34231E
	for <lists+linux-api@lfdr.de>; Fri, 19 Mar 2021 18:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhCSRXR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 19 Mar 2021 13:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCSRWp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 19 Mar 2021 13:22:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AF9C06174A
        for <linux-api@vger.kernel.org>; Fri, 19 Mar 2021 10:22:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b83so11146828lfd.11
        for <linux-api@vger.kernel.org>; Fri, 19 Mar 2021 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BkRxICNeg5DYscXEGEcqd4ui8J4BudI3HPDlVjLS4/s=;
        b=guKEZmHG3VKWVbRkUkqS326KvwlSHdPvZzHa/1CkYDmr54RI3pXNEHVpEPJmaS3N3X
         /EqoPZGZMmv2p3unSm6MlDxz3VPHiDwoeGwoZtelQwb4N/q+by09AHLgY2aoyEtt8Far
         xcfp/7lRvIBDpORnuuQP/pZlLNDFxgj3WXCjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BkRxICNeg5DYscXEGEcqd4ui8J4BudI3HPDlVjLS4/s=;
        b=hgYk/HFeZ90KSJTMJKGxRjfEsVnmNzpS9hjFnl6vlqCp/UdvY5CfR4r8FUQ8XKY6Ih
         9hksmwNhEy4jbzHjyTjR30VpryErnEp+lD7J2uCmfYnkQD9iPPD+iClx90wOmPWhDe+a
         wi8zJhHSXmTRRPZ0XAKN3MMBVL6kJRXEpGMFtalpOqdnt1jl8Tb3nTzjZKMzirCA4OM7
         Gxu6l16fuqnxWoatH+lxjEk+OHuezU3rBZz7dMHk+gRUnsGw1usuoK0PpNT6a7tX5AGm
         7Fl5Vf6toscQyTG/2WXa2wQ1ZXkCcT0QIFUzaFygb76bf4Xn/GuLvNi+cD8APg3CkumG
         NciA==
X-Gm-Message-State: AOAM5338hL73zoR+lH+jdzfEJBezzdQ69IZfdSMaNWgG/x6b3l817313
        ZhzJK3tusQbDTmO7WPnp2R3ykjtfDNQEWw==
X-Google-Smtp-Source: ABdhPJxAhSw1zD0TsomfWcQmJ9Eykk8TeV/yR/L1Dm/mfH0xHF3zGsxPw6s1ckkbEdqv3D8mDTji9A==
X-Received: by 2002:ac2:4254:: with SMTP id m20mr1417299lfl.474.1616174563504;
        Fri, 19 Mar 2021 10:22:43 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id l29sm693781lfp.63.2021.03.19.10.22.43
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 10:22:43 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id o10so11149845lfb.9
        for <linux-api@vger.kernel.org>; Fri, 19 Mar 2021 10:22:43 -0700 (PDT)
X-Received: by 2002:a05:6512:3ba9:: with SMTP id g41mr1318559lfv.421.1616174058718;
 Fri, 19 Mar 2021 10:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210319143452.25948-1-david@redhat.com>
In-Reply-To: <20210319143452.25948-1-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Mar 2021 10:14:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1HTbXkjdMYA4zADEiE8HwpZ0=uWy0ujZTJYVT-KCehQ@mail.gmail.com>
Message-ID: <CAHk-=wg1HTbXkjdMYA4zADEiE8HwpZ0=uWy0ujZTJYVT-KCehQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] drivers/char: remove /dev/kmem for good
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 19, 2021 at 7:35 AM David Hildenbrand <david@redhat.com> wrote:
>
> Let's start a discussion if /dev/kmem is worth keeping around and
> fixing/maintaining or if we should just remove it now for good.

I'll happily do this for the next merge window, but would really want
distros to confirm that they don't enable it.

I can confirm that it's certainly not enabled on any of the machines I
have, but..

             Linus
