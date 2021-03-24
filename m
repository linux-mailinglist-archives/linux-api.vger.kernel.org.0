Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2DA3484F8
	for <lists+linux-api@lfdr.de>; Wed, 24 Mar 2021 23:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbhCXW6n (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Mar 2021 18:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238920AbhCXW6S (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Mar 2021 18:58:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E859C06174A;
        Wed, 24 Mar 2021 15:58:18 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g15so27674pfq.3;
        Wed, 24 Mar 2021 15:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vki3LQkenPNysugs1SxfO0nn8UpSoyiRVef2WWK+wIk=;
        b=LBqogV7X/ZOyISVSWNTq3UZ3nd3lzcoCkYC8xVy4/xr8YdD6/fTQBjP80U+sBXPhbg
         qBD6sz8VOuJ7Mw8/EetE+6RWMlQG0OzszCNDioQ6fNdo4DXct7g1tT1tEtolpugpHI9W
         XBtHb65QF4bJFPHQySPaJtayGDs72oJqgEO54GYLSkY1VbCQpTCd9g+py5qMVSojxp6d
         wT8SqdSJ3R88Nss3sWel8zium+yaQwlHbFePyE243sfSl4FCY5QZdE9EeWF5csp8cjTi
         Ls8KzY8FnnFNhIoetlmvuTVs6kSI6mIGjBqchRTzb5RiODUpzjR6pox9HHkrjA8UsmCa
         QDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vki3LQkenPNysugs1SxfO0nn8UpSoyiRVef2WWK+wIk=;
        b=R/mezQug0L0NzkGO3fwaAp45k24TedMPZJJQ5gHh1IilG/mlz8xyOuskdOs6cHi55m
         /oQ4J6q7RHuaVsjSsAG5sCzx1pQ10q+fIGgsZracQHaWjoYbmFlGI46xj7YpadtYDCNZ
         5vnr2jFj/RddkYqen9NOv2BfIoBtkaJYD9UP/2zx10/SMVDjGy9h7p/4LvJvS5GZWTJy
         V2/POXDmEHxdsbV/sdjCBM8/GPkVb8q1/iNDo4YxpOAJP1+BUfwzflbvCp/Y/RiRhj2L
         jOnzbuMitPR9bkSUpjttEP4Roup+3qmK0xTzTRMesHQ9SLEtpfqaiMeS++qmcA5YoFMA
         1T/w==
X-Gm-Message-State: AOAM533Lo5YsaabOeF54cxTYMhC7Z+UBoZ2aD+vkmYHTe+tW/TBSopW4
        XbdyeL0azk0GmoIt01r736Y=
X-Google-Smtp-Source: ABdhPJxTUxmNAADhq4dsE6st8mzUTROA/MwnDOh4zEKs3L65cDXc8+ri8Y9UTqX210Olfhr2EEPbNw==
X-Received: by 2002:a17:902:b68c:b029:e6:bb9f:7577 with SMTP id c12-20020a170902b68cb02900e6bb9f7577mr5999399pls.0.1616626697734;
        Wed, 24 Mar 2021 15:58:17 -0700 (PDT)
Received: from localhost (121-45-173-48.tpgi.com.au. [121.45.173.48])
        by smtp.gmail.com with ESMTPSA id z18sm3830927pfa.39.2021.03.24.15.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 15:58:15 -0700 (PDT)
Date:   Thu, 25 Mar 2021 09:58:12 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
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
Message-ID: <20210324225812.GM77072@balbir-desktop>
References: <20210324102351.6932-1-david@redhat.com>
 <20210324122412.e77247e6d3259d5493951019@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324122412.e77247e6d3259d5493951019@linux-foundation.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 24, 2021 at 12:24:12PM -0700, Andrew Morton wrote:
> 
> > Let's remove /dev/kmem, which is unused and obsolete.
> 
> I grabbed these.  Silently - the cc list is amazing ;)
> 
> I was wondering if it would be better to permanently disable /dev/kmem
> in Kconfig along with a comment "if you really want this thing then
> email peeps@places with a very good reason why".  Let that ride for a
> year or three then blam.
> 
> But this is so much more attractive, and it certainly sounds like it's
> worth any damage it might cause.
> 
> We do tend to think about distros.  I bet there are a number of weird
> embedded type systems using /dev/kmem - it's amazing what sorts of
> hacks those people will put up with the get something out the door. 
> But those systems tend to carry a lot of specialized changes anyway, so
> they can just add "revert David's patch" to their pile.
>


I wonder if we should have the opposite of driver/staging and call it
outgoing, with a big thank you to the users and developers and also
to indicate this feature will be removed in the next (few) merge(s)
cycles. I guess not all code can be accumulated under a single
hierarchy. May not be worth the effort, just thinking out loud.

Balbir Singh 
