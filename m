Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29BD1877F6
	for <lists+linux-api@lfdr.de>; Tue, 17 Mar 2020 04:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCQDFC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Mar 2020 23:05:02 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35805 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgCQDFC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Mar 2020 23:05:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id k8so18803531oik.2;
        Mon, 16 Mar 2020 20:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sbAutxY+MMd/SQjeY5/YKMt12lMLdCJAf1DdUAYR8Tg=;
        b=t2hO8/RpTKCYZNJeAmfbV2hv6YWpYYQLcETN7xVnmRBZuNenDPRZ8zi/otwjz1EMeo
         Ouyk940BY2UA0VIHU4DptOg2b7SVQII9MMCKJ1kgWJTDXBlN/S0Zy1ZAO5mXGfNcHV5t
         4L2x3oSTaoyEBWletjG0C+wXp6MNN4kOLVsox2Q8E4La8OsJpN8gAFZZ8KyATWsKNwDy
         8hGVamUUpsEo5d6+WskhntXJxD527QzZwTEQmUBPi6cPLZJCEDRQ7ZLJG3Lszs6h9vU2
         7PMu2q6McZSvSHQhdY6wMWTr02Mun6Ex8GRV56rZgORy/2IZcP5FhT438qYhEMqIUE/j
         CpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sbAutxY+MMd/SQjeY5/YKMt12lMLdCJAf1DdUAYR8Tg=;
        b=jMRnmyTnJGQZag7xMWie3cl5eZNWIPSm+P+GDVbBRUl403kYqlbix+Bsx/8hqRXbjF
         1kTE+rCImaipHt1oCPH8ga9xbSmftWGrZt+QxPEQX2N9fXUcNLIx/8OmLsGbijMnaWaa
         53aQXcWapjNhb/eqxjroIwIbS0ZXy/2pnTC19kLe2Qo/AseHzyf8XDXJjQl7fiGj7CIl
         nFm1WPQYn44qAvARvTofcMug5xiKcORqlz28GHaCprpexSTJ8sGJnd4t0Wz1tv8qbO4H
         fjSGVGKw4hEH1DzqAjl06M763go8TAFYHjdoYlpmmc1gvWcMaJ5UMRigcgPp/jLw/J6D
         SNCA==
X-Gm-Message-State: ANhLgQ2q8rvEErvVmVedzytlELbcI+nTnzsimCMvUdKfwKlKspTSPjSq
        tJErk34Q/socQuclvKJzgjFlzLURFoVNaPII0cMls9oKWt0=
X-Google-Smtp-Source: ADFU+vtjeeGC8+hlNw5uVS8yJznnDKurgL1PzzKIqIYqcStJ22twI296KX1QNxWNO3M+6DfYrLQpNvce7kc6+p5/U3M=
X-Received: by 2002:aca:54ca:: with SMTP id i193mr1945950oib.163.1584414301757;
 Mon, 16 Mar 2020 20:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200311034454epcas1p2ef0c0081971dd82282583559398e58b2@epcas1p2.samsung.com>
 <20200311034441.23243-1-jaewon31.kim@samsung.com> <af4ace34-0db2-dd17-351f-eaa806f0a6ac@suse.cz>
 <20200313174827.GA67638@unreal> <5E6EFB6C.7050105@samsung.com> <20200316083154.GF8510@unreal>
In-Reply-To: <20200316083154.GF8510@unreal>
From:   Jaewon Kim <jaewon31.kim@gmail.com>
Date:   Tue, 17 Mar 2020 12:04:46 +0900
Message-ID: <CAJrd-UvttDDSL=q1RXC6Z+jvZAGsN2iM8C8xOSrpJFdLb0e-3g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] meminfo: introduce extra meminfo
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>,
        Vlastimil Babka <vbabka@suse.cz>, adobriyan@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, minchan@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

2020=EB=85=84 3=EC=9B=94 16=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 5:32, L=
eon Romanovsky <leon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Mar 16, 2020 at 01:07:08PM +0900, Jaewon Kim wrote:
> >
> >
> > On 2020=EB=85=84 03=EC=9B=94 14=EC=9D=BC 02:48, Leon Romanovsky wrote:
> > > On Fri, Mar 13, 2020 at 04:19:36PM +0100, Vlastimil Babka wrote:
> > >> +CC linux-api, please include in future versions as well
> > >>
> > >> On 3/11/20 4:44 AM, Jaewon Kim wrote:
> > >>> /proc/meminfo or show_free_areas does not show full system wide mem=
ory
> > >>> usage status. There seems to be huge hidden memory especially on
> > >>> embedded Android system. Because it usually have some HW IP which d=
o not
> > >>> have internal memory and use common DRAM memory.
> > >>>
> > >>> In Android system, most of those hidden memory seems to be vmalloc =
pages
> > >>> , ion system heap memory, graphics memory, and memory for DRAM base=
d
> > >>> compressed swap storage. They may be shown in other node but it see=
ms to
> > >>> useful if /proc/meminfo shows all those extra memory information. A=
nd
> > >>> show_mem also need to print the info in oom situation.
> > >>>
> > >>> Fortunately vmalloc pages is alread shown by commit 97105f0ab7b8
> > >>> ("mm: vmalloc: show number of vmalloc pages in /proc/meminfo"). Swa=
p
> > >>> memory using zsmalloc can be seen through vmstat by commit 91537fee=
0013
> > >>> ("mm: add NR_ZSMALLOC to vmstat") but not on /proc/meminfo.
> > >>>
> > >>> Memory usage of specific driver can be various so that showing the =
usage
> > >>> through upstream meminfo.c is not easy. To print the extra memory u=
sage
> > >>> of a driver, introduce following APIs. Each driver needs to count a=
s
> > >>> atomic_long_t.
> > >>>
> > >>> int register_extra_meminfo(atomic_long_t *val, int shift,
> > >>>                      const char *name);
> > >>> int unregister_extra_meminfo(atomic_long_t *val);
> > >>>
> > >>> Currently register ION system heap allocator and zsmalloc pages.
> > >>> Additionally tested on local graphics driver.
> > >>>
> > >>> i.e) cat /proc/meminfo | tail -3
> > >>> IonSystemHeap:    242620 kB
> > >>> ZsPages:          203860 kB
> > >>> GraphicDriver:    196576 kB
> > >>>
> > >>> i.e.) show_mem on oom
> > >>> <6>[  420.856428]  Mem-Info:
> > >>> <6>[  420.856433]  IonSystemHeap:32813kB ZsPages:44114kB GraphicDri=
ver::13091kB
> > >>> <6>[  420.856450]  active_anon:957205 inactive_anon:159383 isolated=
_anon:0
> > >> I like the idea and the dynamic nature of this, so that drivers not =
present
> > >> wouldn't add lots of useless zeroes to the output.
> > >> It also makes simpler the decisions of "what is important enough to =
need its own
> > >> meminfo entry".
> > >>
> > >> The suggestion for hunting per-driver /sys files would only work if =
there was a
> > >> common name to such files so once can find(1) them easily.
> > >> It also doesn't work for the oom/failed alloc warning output.
> > > Of course there is a need to have a stable name for such an output, t=
his
> > > is why driver/core should be responsible for that and not drivers aut=
hors.
> > >
> > > The use case which I had in mind slightly different than to look afte=
r OOM.
> > >
> > > I'm interested to optimize our drivers in their memory footprint to
> > > allow better scale in SR-IOV mode where one device creates many separ=
ate
> > > copies of itself. Those copies easily can take gigabytes of RAM due t=
o
> > > the need to optimize for high-performance networking. Sometimes the
> > > amount of memory and not HW is actually limits the scale factor.
> > >
> > > So I would imagine this feature being used as an aid for the driver
> > > developers and not for the runtime decisions.
> > >
> > > My 2-cents.
> > >
> > > Thanks
> > >
> > >
> > Thank you for your comment.
> > My idea, I think, may be able to help each driver developer to see thei=
r memory usage.
> > But I'd like to see overall memory usage through the one node.
>
> It is more than enough :).
>
> >
> > Let me know if you have more comment.
> > I am planning to move my logic to be shown on a new node, /proc/meminfo=
_extra at v2.
>
> Can you please help me to understand how that file will look like once
> many drivers will start to use this interface? Will I see multiple
> lines?
>
> Something like:
> driver1 ....
> driver2 ....
> driver3 ....
> ...
> driver1000 ....
>
> How can we extend it to support subsystems core code?

I do not have a plan to support subsystem core.

I just want the /proc/meminfo_extra to show size of alloc_pages APIs
rather than slub size. It is to show hidden huge memory.
I think most of drivers do not need to register its size to
/proc/meminfo_extra because
drivers usually use slub APIs and rather than alloc_pages APIs.
/proc/slabinfo helps for slub size in detail.

As a candidate of /proc/meminfo_extra, I hope only few drivers using
huge memory like over 100 MB got from alloc_pages APIs.

As you say, if there is a static node on /sys for each driver, it may
be used for all the drivers.
I think sysfs class way may be better to show categorized sum size.
But /proc/meminfo_extra can be another way to show those hidden huge memory=
.
I mean your idea and my idea is not exclusive.

Thank you
>
> Thanks
>
> >
> > Thank you
> > Jaewon Kim
