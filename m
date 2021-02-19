Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74ED131FCF9
	for <lists+linux-api@lfdr.de>; Fri, 19 Feb 2021 17:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBSQRA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 19 Feb 2021 11:17:00 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11656 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhBSQQv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 19 Feb 2021 11:16:51 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602fe4480001>; Fri, 19 Feb 2021 08:16:08 -0800
Received: from [10.2.58.214] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 19 Feb
 2021 16:16:04 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Rientjes <rientjes@google.com>
CC:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        "Hugh Dickins" <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Chris Kennelly <ckennelly@google.com>, <linux-mm@kvack.org>,
        <linux-api@vger.kernel.org>
Subject: Re: [RFC] Hugepage collapse in process context
Date:   Fri, 19 Feb 2021 11:16:01 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <DD01C0D8-AA9A-470F-A0C0-6F361A7C0F2D@nvidia.com>
In-Reply-To: <5127b9c-a147-8ef5-c942-ae8c755413d0@google.com>
References: <d098c392-273a-36a4-1a29-59731cdf5d3d@google.com>
 <YCzSDPbBsksCX5zP@dhcp22.suse.cz>
 <0b51a213-650e-7801-b6ed-9545466c15db@suse.cz>
 <600ee57f-d839-d402-fb0f-e9f350114dce@redhat.com>
 <5127b9c-a147-8ef5-c942-ae8c755413d0@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_82CCED33-B877-4432-B350-0259CD25D678_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613751368; bh=OLN1OsirW5UBXp7ykh74ftGBlidVbzKmB1bSd287tl8=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=kmJj2baFP6WTq5uoLGZ1xG6n2BpoI0OvmuvvIFoVDW183FwvN4rAkcEpleErChsIh
         8UyUv+E8MeYSALzM08Wgc5dhUjffrjGq3/bgpVsevF3+8uprYnaEEeYaMXfZb7xUNR
         ViPOEzaGkFlzHVKKWHm7l34lQ+NPX3QuWrEP7E78c4UU0h4U/j4JmVnG9FtqvoA6O1
         49VvhG9ipRiajzAqeO+lYwpiIohXpTkiaWIauccusfLFJhtTfi+n9dHYTPTCd2gc1e
         1h+X8iGG86Dd8SikOAfbUcaDhKbWtfzNmDnkfubcON0n+Es+k5GQX2et9S8uctHOwl
         h7BcPZcxl08Ng==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

--=_MailMate_82CCED33-B877-4432-B350-0259CD25D678_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 18 Feb 2021, at 17:34, David Rientjes wrote:

> On Thu, 18 Feb 2021, David Hildenbrand wrote:
>
>>>>> Hi everybody,
>>>>>
>>>>> Khugepaged is slow by default, it scans at most 4096 pages every 10=
s.
>>>>> That's normally fine as a system-wide setting, but some application=
s
>>>>> would
>>>>> benefit from a more aggressive approach (as long as they are willin=
g to
>>>>> pay for it).
>>>>>
>>>>> Instead of adding priorities for eligible ranges of memory to
>>>>> khugepaged,
>>>>> temporarily speeding khugepaged up for the whole system, or shardin=
g its
>>>>> work for memory belonging to a certain process, one approach would =
be to
>>>>> allow userspace to induce hugepage collapse.
>>>>>
>>>>> The benefit to this approach would be that this is done in process
>>>>> context
>>>>> so its cpu is charged to the process that is inducing the collapse.=

>>>>> Khugepaged is not involved.
>>>>
>>>> Yes, this makes a lot of sense to me.
>>>>
>>>>> Idea was to allow userspace to induce hugepage collapse through the=
 new
>>>>> process_madvise() call.  This allows us to collapse hugepages on be=
half
>>>>> of
>>>>> current or another process for a vectored set of ranges.
>>>>
>>>> Yes, madvise sounds like a good fit for the purpose.
>>>
>>> Agreed on both points.
>>>
>>>>> This could be done through a new process_madvise() mode *or* it cou=
ld be
>>>>> a
>>>>> flag to MADV_HUGEPAGE since process_madvise() allows for a flag
>>>>> parameter
>>>>> to be passed.  For example, MADV_F_SYNC.
>>>>
>>>> Would this MADV_F_SYNC be applicable to other madvise modes? Most
>>>> existing madvise modes do not seem to make much sense. We can argue =
that
>>>> MADV_PAGEOUT would guarantee the range was indeed reclaimed but I am=
 not
>>>> sure we want to provide such a strong semantic because it can limit
>>>> future reclaim optimizations.
>>>>
>>>> To me MADV_HUGEPAGE_COLLAPSE sounds like the easiest way forward.
>>>
>>> I guess in the old madvise(2) we could create a new combo of MADV_HUG=
EPAGE |
>>> MADV_WILLNEED with this semantic? But you are probably more intereste=
d in
>>> process_madvise() anyway. There the new flag would make more sense. B=
ut
>>> there's
>>> also David H.'s proposal for MADV_POPULATE and there might be benefit=
 in
>>> considering both at the same time? Should e.g. MADV_POPULATE with
>>> MADV_HUGEPAGE
>>> have the collapse semantics? But would MADV_POPULATE be added to
>>> process_madvise() as well? Just thinking out loud so we don't end up =
with
>>> more
>>> flags than necessary, it's already confusing enough as it is.
>>>
>>
>> Note that madvise() eats only a single value, not flags. Combinations =
as you
>> describe are not possible.
>>
>> Something MADV_HUGEPAGE_COLLAPSE make sense to me that does not need t=
he mmap
>> lock in write and does not modify the actual VMA, only a mapping.
>>
>
> Agreed, and happy to see that there's a general consensus for the
> direction.  Benefit of a new madvise mode is that it can be used for
> madvise() as well if you are interested in only a single range of your =
own
> memory and then it doesn't need to reconcile with any of the already
> overloaded semantics of MADV_HUGEPAGE.
>
> Otherwise, process_madvise() can be used for other processes and/or
> vectored ranges.
>
> Song's use case for this to prioritize thp usage is very important for =
us
> as well.  I hadn't thought of the madvise(MADV_HUGEPAGE) +
> madvise(MADV_HUGEPAGE_COLLAPSE) use case: I was anticipating the latter=

> would allocate the hugepage with khugepaged's gfp mask so it would alwa=
ys
> compact.  But it seems like this would actually be better to use the gf=
p
> mask that would be used at fault for the vma and left to userspace to
> determine whether that's MADV_HUGEPAGE or not.  Makes sense.
>
> (Userspace could even do madvise(MADV_NOHUGEPAGE) +
> madvise(MADV_HUGEPAGE_COLLAPSE) to do the synchronous collapse but
> otherwise exclude it from khugepaged's consideration if it were incline=
d.)
>
> Two other minor points:
>
>  - Currently, process_madvise() doesn't use the flags parameter at all =
so
>    there's the question of whether we need generalized flags that apply=
 to
>    most madvise modes or whether the flags can be specific to the mode
>    being used.  For example, a natural extension of this new mode would=
 be
>    to determine the hugepage size if we were ever to support synchronou=
s
>    collapse into a 1GB gigantic page on x86 (MADV_F_1GB? :)

I am very interested in adding support for sync collapse into 1GB THPs.
Here is my recent patches to support 1GB THP on x86: https://lwn.net/Arti=
cles/832881/.
Doing sync collapse might be the best way of getting 1GB THPs, when
bumping MAX_ORDER is not good for memory hotplug and getting 1GB pages
from CMA regions, which I proposed in my patchset, seems not to ideal.

>
>  - We haven't discussed the future of khugepaged with this new mode: it=

>    seems like we could simply implement khugepaged fully in userspace a=
nd
>    remove it from the kernel? :)

I guess the page collapse code from khugepaged can be preserved and reuse=
d
for this madvise hugepage collapse, just that we might not need to launch=

a kernel daemon to do the work.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_82CCED33-B877-4432-B350-0259CD25D678_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmAv5EIPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK0HgP/jRnWXyYsJJY5d0VMRDrS7/xXnfrres/qTPr
hM5M9JJDXaqND7YgvQA12sn793b3Gm2cQ9HvO+XwfcSNU1ybdoH4sq9u8tBDXqvq
+cxpkr0BGydHiPjfikP29JqpZpZ5E1NPccDQzzZdTbJR0cRSWwgs3W2lV9SkzgeA
5K8mOjZc61HwNRPiSYg0FYYOWcqXS/knKF36QY8lAya9ly7ZrRfLZ+CsIfdFnFvD
5XbbuXLXifqXio+kFruMP7aNiz79phYPo0O0jAgcsUeYPHwWVgn9/86cfg/aAxPy
D4XUtl+MjnlRpHD10y8AuXrVu6w3wcydgi9M1lo1rKIlOtGzGtlH86EYxUAJb4Cj
I1DFK6pzoBafymcATMb6vGgCx11x81wKVzmSdR6BZffpbqS2i9lPS8dAtvk5tXXS
H4Qn5NN5efojTJWXzDQsyvd2FKSjkeOfWuiGvPfwWg1FGmDyh3wnFVwonmZI0NR/
P7hHmncbL+fbnHQhhwXI8Pn78drElut9lq1Riwyfmt42pNMKjH7eDpDnwBC2lo+s
5Uxd7aGfU2KO6ns9CAZrrzLFSyDfFz5PTNXEgE5sIGhIlADeNA2p+z6t0kzNjjZh
BaXjWeuKs1kF9+5EC+Ia3U8pQE4C94fZK3Hg7+Ve0cdttb6oeBHeyzr4hfSuH6gk
Az48KFaB
=Xj+3
-----END PGP SIGNATURE-----

--=_MailMate_82CCED33-B877-4432-B350-0259CD25D678_=--
