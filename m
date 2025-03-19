Return-Path: <linux-api+bounces-3401-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8B7A69307
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 16:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE964174B18
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDFA17A30E;
	Wed, 19 Mar 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dusO7WpZ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D4815A85E
	for <linux-api@vger.kernel.org>; Wed, 19 Mar 2025 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396970; cv=none; b=g4+XwNs96C9EfS9uvnMbYiRRkHXQ7z618KX7XveGK2pUTKPUSINOG/X0g+zDTtJn6nalOAAlVL0HaOaiav+BK7JdfYHMrYmPmWA/6tIxOx7D6aZVddRx3rCP2mG5DrROXeBDNjEuC6vZVi32TbqxXdhokNlvF5y9rsXaNOVgiCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396970; c=relaxed/simple;
	bh=Z8DwlWLeaRzLilOyTh09RfziRSu+3ePODVOYkk6Kpm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsFDt28hvCu4bVDZF7IcEDFPlO2S0BR/A7kwb86/EaA5d6FSxBB5rauP1bZDfI2YEzZXITmG46wEDDgN/e/o0LnxsUinA6F4izbK6Z7wjG8bxCJpAWzwHbxge6Z1to091DtsTmO0k7mrRWSPEqp7VrmBP1QmcMYqH1esWtzz+ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dusO7WpZ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E41C73F2E7
	for <linux-api@vger.kernel.org>; Wed, 19 Mar 2025 15:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742396946;
	bh=8aBOIVOtwTJyDKkbjMF2Aak4oYSj8+ED8AjxSctFyBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=dusO7WpZJiHfQ9O/VwPr6BcIN1qqkKk37M6IL23f23N+Iq1zjISvmIZ/Xtci2rZrJ
	 x7GqIGZ/6RskHa2wTM9NIEcQUjVNoXyEY4FoxePI22kExZN95m9qvItG9gAYLZMuTW
	 1BmK6xpUnwKyphYOcxXkN+NW60dbAbGbUNmQ20l0u8YBUlts+T2QPNdcd5qWMcWZbR
	 kWVuahVtiGLvHjVOSZt1umCGY3HPwUzFiN+zGWUrXD/oWYjDxeTQ9RtDeDmpMAu8HJ
	 knHoZYJvY/zhoeJ2t1I7m7y6pDFClo2asKO3Hha8UGR8ZACLpeSLJ4pkgYq4Y1mFZp
	 KRAHnxr/DXiyg==
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5240ae97377so1349380e0c.2
        for <linux-api@vger.kernel.org>; Wed, 19 Mar 2025 08:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742396943; x=1743001743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aBOIVOtwTJyDKkbjMF2Aak4oYSj8+ED8AjxSctFyBo=;
        b=WrqdE18yqtgqXngHNl56e9dsRuQozdVkWwPLr45kuZXteiyv7P1KULIYaEg/8yo4bv
         0EpwVYeFehXWCLix0siCm+2McBH71nSYrdmII77pU7oj9s41K/mPjJBEiniMvrt+ibIN
         HaXb+eqpDovNLpSWoMf9LRaF4GBgB33EmTDVX/4CarOIcDXLnxb2fFIE2qj0bM7+GKJE
         5fuast3oBidc3dE6nalbMNPWTLLeopoCzDdx+23/sZReAeLiFN55t67H0s13Vw2tfVTT
         l5Bt0ZKyV0kdLW96zDtenfl6KL3gZR5vrMFZGx9wC79qX4XbBxQFFgOgCvWtxYm7kz4F
         cVCw==
X-Forwarded-Encrypted: i=1; AJvYcCVW2SIJW5udEjgwJfv//sxrznoFmp5kaRc5mRYPpjoE9opbXrdbgQz+LlfrZ7V5/qnf1BeChoLlrIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJSfIAuD51NFY77+g+ixdjfU9xb7eLG5QJt2EMzRrYTYOljCt9
	cq8gCsaV7+cOWJz9AALFF9ore5PcjWY1tWCBCs2wg1sX3kwGUXkxiNfScKuQlRMuYa8O+De4G/O
	qQ9ygjQvC9mSdRorb2I57PrUGVSE/Zhd7C8voWANPn8zp6vOHOmptY5crgByEzcjom9hojjQIuO
	S3m+67hNCPslb9UEbaRw3EGBfnYhgXMSQXt310Twzx/s32awjY
X-Gm-Gg: ASbGnctpDp88glimWfCdqKZ07MqPxM0nlMjOASNOFLj8r998QofVO6InxhP5EMSRsZu
	vFzajSpqnURESYkWMLEsK8ucrrH6Sj412MZbHIvhLTPk5SS3I3Y3hl3zgze8nV5MvnraBY6kM0A
	==
X-Received: by 2002:a05:6122:4710:b0:524:2fe2:46ba with SMTP id 71dfb90a1353d-5258929589emr2290076e0c.11.1742396943252;
        Wed, 19 Mar 2025 08:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZZ2JRERhNw6fQtgv1k3Uevcdo+N02hVl/dbQz5Ech6qMnUThFI0UpnwTJfu5OuJvFHJ0IevrcJdPwqxH/+ng=
X-Received: by 2002:a05:6122:4710:b0:524:2fe2:46ba with SMTP id
 71dfb90a1353d-5258929589emr2290011e0c.11.1742396942930; Wed, 19 Mar 2025
 08:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
 <zihwmp67m2lpuxbfktmztvjdyap7suzd75dowlw4eamu6bhjf3@6euydiqowc7h> <278393de-2729-4ed0-822c-87f33c7ce27e@redhat.com>
In-Reply-To: <278393de-2729-4ed0-822c-87f33c7ce27e@redhat.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Wed, 19 Mar 2025 16:08:51 +0100
X-Gm-Features: AQ5f1JrrL-o1nzunyhb4dVJT7qp6u8-CUZOYotSFXxMDYx9WLb26b0mVdqfOBmg
Message-ID: <CAEivzxf8jG3BVb9zdpVy+-q1DNZ1NBDbWUvOUkzni=B=Pvq4Ww@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] implement lightweight guard pages
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, James.Bottomley@hansenpartnership.com, 
	Liam.Howlett@oracle.com, akpm@linux-foundation.org, arnd@kernel.org, 
	brauner@kernel.org, chris@zankel.net, deller@gmx.de, hch@infradead.org, 
	jannh@google.com, jcmvbkbc@gmail.com, jeffxu@chromium.org, 
	jhubbard@nvidia.com, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mattst88@gmail.com, muchun.song@linux.dev, 
	paulmck@kernel.org, richard.henderson@linaro.org, shuah@kernel.org, 
	sidhartha.kumar@oracle.com, surenb@google.com, tsbogend@alpha.franken.de, 
	vbabka@suse.cz, willy@infradead.org, criu@lists.linux.dev, 
	Andrei Vagin <avagin@gmail.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 3:53=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 19.03.25 15:50, Alexander Mikhalitsyn wrote:
> > On Mon, Oct 28, 2024 at 02:13:26PM +0000, Lorenzo Stoakes wrote:
> >> Userland library functions such as allocators and threading implementa=
tions
> >> often require regions of memory to act as 'guard pages' - mappings whi=
ch,
> >> when accessed, result in a fatal signal being sent to the accessing
> >> process.
> >>
> >> The current means by which these are implemented is via a PROT_NONE mm=
ap()
> >> mapping, which provides the required semantics however incur an overhe=
ad of
> >> a VMA for each such region.
> >>
> >> With a great many processes and threads, this can rapidly add up and i=
ncur
> >> a significant memory penalty. It also has the added problem of prevent=
ing
> >> merges that might otherwise be permitted.
> >>
> >> This series takes a different approach - an idea suggested by Vlasimil
> >> Babka (and before him David Hildenbrand and Jann Horn - perhaps more -=
 the
> >> provenance becomes a little tricky to ascertain after this - please fo=
rgive
> >> any omissions!)  - rather than locating the guard pages at the VMA lay=
er,
> >> instead placing them in page tables mapping the required ranges.
> >>
> >> Early testing of the prototype version of this code suggests a 5 times
> >> speed up in memory mapping invocations (in conjunction with use of
> >> process_madvise()) and a 13% reduction in VMAs on an entirely idle and=
roid
> >> system and unoptimised code.
> >>
> >> We expect with optimisation and a loaded system with a larger number o=
f
> >> guard pages this could significantly increase, but in any case these
> >> numbers are encouraging.
> >>
> >> This way, rather than having separate VMAs specifying which parts of a
> >> range are guard pages, instead we have a VMA spanning the entire range=
 of
> >> memory a user is permitted to access and including ranges which are to=
 be
> >> 'guarded'.
> >>
> >> After mapping this, a user can specify which parts of the range should
> >> result in a fatal signal when accessed.
> >>
> >> By restricting the ability to specify guard pages to memory mapped by
> >> existing VMAs, we can rely on the mappings being torn down when the
> >> mappings are ultimately unmapped and everything works simply as if the
> >> memory were not faulted in, from the point of view of the containing V=
MAs.
> >>
> >> This mechanism in effect poisons memory ranges similar to hardware mem=
ory
> >> poisoning, only it is an entirely software-controlled form of poisonin=
g.
> >>
> >> The mechanism is implemented via madvise() behaviour - MADV_GUARD_INST=
ALL
> >> which installs page table-level guard page markers - and
> >> MADV_GUARD_REMOVE - which clears them.
> >>
> >> Guard markers can be installed across multiple VMAs and any existing
> >> mappings will be cleared, that is zapped, before installing the guard =
page
> >> markers in the page tables.
> >>
> >> There is no concept of 'nested' guard markers, multiple attempts to in=
stall
> >> guard markers in a range will, after the first attempt, have no effect=
.
> >>
> >> Importantly, removing guard markers over a range that contains both gu=
ard
> >> markers and ordinary backed memory has no effect on anything but the g=
uard
> >> markers (including leaving huge pages un-split), so a user can safely
> >> remove guard markers over a range of memory leaving the rest intact.
> >>
> >> The actual mechanism by which the page table entries are specified mak=
es
> >> use of existing logic - PTE markers, which are used for the userfaultf=
d
> >> UFFDIO_POISON mechanism.
> >>
> >> Unfortunately PTE_MARKER_POISONED is not suited for the guard page
> >> mechanism as it results in VM_FAULT_HWPOISON semantics in the fault
> >> handler, so we add our own specific PTE_MARKER_GUARD and adapt existin=
g
> >> logic to handle it.
> >>
> >> We also extend the generic page walk mechanism to allow for installati=
on of
> >> PTEs (carefully restricted to memory management logic only to prevent
> >> unwanted abuse).
> >>
> >> We ensure that zapping performed by MADV_DONTNEED and MADV_FREE do not
> >> remove guard markers, nor does forking (except when VM_WIPEONFORK is
> >> specified for a VMA which implies a total removal of memory
> >> characteristics).
> >>
> >> It's important to note that the guard page implementation is emphatica=
lly
> >> NOT a security feature, so a user can remove the markers if they wish.=
 We
> >> simply implement it in such a way as to provide the least surprising
> >> behaviour.
> >>
> >> An extensive set of self-tests are provided which ensure behaviour is =
as
> >> expected and additionally self-documents expected behaviour of guard
> >> ranges.
> >
> > Dear Lorenzo,
> > Dear colleagues,
> >
> > sorry about raising an old thread.
> >
> > It looks like this feature is now used in glibc [1]. And we noticed fai=
lures in CRIU [2]
> > CI on Fedora Rawhide userspace. Now a question is how we can properly d=
etect such
> > "guarded" pages from user space. As I can see from MADV_GUARD_INSTALL i=
mplementation,
> > it does not modify VMA flags anyhow, but only page tables. It means tha=
t /proc/<pid>/maps
> > and /proc/<pid>/smaps interfaces are useless in this case. (Please, cor=
rect me if I'm missing
> > anything here.)
> >
> > I wonder if you have any ideas / suggestions regarding Checkpoint/Resto=
re here. We (CRIU devs) are happy
> > to develop some patches to bring some uAPI to expose MADV_GUARDs, but b=
efore going into this we decided
> > to raise this question in LKML.
>
>
> See [1] and [2]

Hi David,

Huge thanks for such a fast and helpful reply ;)

>
> [1]
> https://lkml.kernel.org/r/cover.1740139449.git.lorenzo.stoakes@oracle.com
> [2] https://lwn.net/Articles/1011366/
>
>
> --
> Cheers,
>
> David / dhildenb

Kind regards,
Alex

>

