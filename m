Return-Path: <linux-api+bounces-1947-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 509FD92EFF3
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 21:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DAFB21D53
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 19:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D70D19E81F;
	Thu, 11 Jul 2024 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1/uyU0Q"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF59F186E25
	for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720727423; cv=none; b=QhXY2WiHBr1i/+Ij7Rhv/SnbQdilibUaoZd9+c6thxpa3CzSxppSpkamMyRXdt+wZle2d4vhh6uS/NSxjCDys+gySSpuG5oQYaHvJFdEf2lhhK3bIKUWIhyoCuEjBGn64TmFvEAtRTZC1xwkqqawWCyP3BOjjsZnKeS+CCz6B8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720727423; c=relaxed/simple;
	bh=4diN8MrB3FHIACY8p3Y2UO40Jfz3e8/rTkgrXUMp9EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heomEEQ77DotQRovD0DIZIOBnKVmgHPrwPkqtuG+XQKDTGqTN70BA9W1HSKLwt6SJxbySGviQejIohKbJ8O6svvd/KHra2hLKDWuVc2crbO+aPv9nH+y92eimBd00b+yhM/+wuV9ODPULkEEjrR8hnIKJmLWs8gWdyAeE+7hEaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q1/uyU0Q; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44e534a1fbeso58901cf.1
        for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 12:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720727420; x=1721332220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6WD8uWdmw8Cbo4EjYtrrPSI26ltEqhqtj652OLG+Q4=;
        b=q1/uyU0QYfdbi19aKl/SahVVA8ovUU1SR37oDn/ZL+gsBdQIsepGXdWtb4rWf4we7n
         RFrDPJBLwYNw3QjU04i0vfN8cgm0ggF53QSDHZwdIdruXmcSLabkeLdRn+eViluuwG/G
         KsDkMqpB+RArjaxRFc4VmTwyJWS8ka9EXksfYUlUNIcvs2JiWmIkc+AEczOVjojtoFk9
         XKb0aY9TKosa4LJSqJXku16whSgZFEsy3feGSp8+jxfV9Qckw+IJASlQH0pow91U4AiR
         GFzpV9ZjIC3yW+pu+vyReoAe4j6zUWOTrnueHiExrjRAdwY8mi1C3V8jpHSU3RVU0SWC
         3uQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720727420; x=1721332220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6WD8uWdmw8Cbo4EjYtrrPSI26ltEqhqtj652OLG+Q4=;
        b=k77MuNm2Fd55wOw5sGH2UNE27t+5xJr8Tdq9VTqzrSgJJybrgW7uYN2iz4Rkxz80BI
         vtcvzL2ktc67Zh8VXjQNxM1rQ/YgNUEXSDh/QgTgmXG8+pzGIhAeFk0Msw98M0eczOUE
         now2H7Be+1fDOOomdwIeEFSFpTAWjojw3fBnuFDisVXLE8vcRuejxpUN3zcRguo8eG/M
         8KGF+veQKgjP4Qhnt+lk/mOXbvd5EmKyj/GbPpzWt0bKWPIyVuFpnelVBrSre5v/kI2k
         /r9/iy06QNzp4fA/HPzv1pCTyEXC7fcrevzsndzFl0ERBJz+z02rlmjSAZKXH19hxX5V
         u+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVimRuHI4vfeFja8zg0hHC5e5z4+P4VPqBTbLSPFBN0JE2tm/RlHrKZUO6zb8xv8Wt5Fo9rk4gUPyP48IFsT9Rs4wDDngpF+KOb
X-Gm-Message-State: AOJu0YykFiJLjTnW3ETrzrIcPvHeZg05ro3OdAD5U0M/1G3RUcwRR5Mm
	FjIR1YnV/Gmz6glP6isrO9XzJdkv7WwSViVA++6MQIPAzRjrwEWTXuLCSb5+voHsGHx9+2JRn+u
	HudGAJze4Q207QnP8nfUD75+rdjW2SfaLosrA
X-Google-Smtp-Source: AGHT+IENr3A77Xgxppnz3neQHMLruOsrOFPG5UHll8ma7WhGXms3uuMDcSKNpckxI36I3OJ7mkiV/BUN34ZoGEJxGdg=
X-Received: by 2002:ac8:710d:0:b0:444:97b7:e3b1 with SMTP id
 d75a77b69052e-44e79101746mr496381cf.13.1720727419548; Thu, 11 Jul 2024
 12:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
 <ZpAR0CgLc28gEkV3@zx2c4.com> <ZpATx21F_01SBRnO@zx2c4.com> <98798483-dfcd-451e-94bb-57d830bf68d8@redhat.com>
 <54b6de32-f127-4928-9f4a-acb8653e5c81@redhat.com> <ZpAcWvij59AzUD9u@zx2c4.com>
 <ZpAc118_U7p3u2gZ@zx2c4.com> <ZpAfigBHfHdVeyNO@zx2c4.com> <8586b19c-2e14-4164-888f-8c3b86f3f963@redhat.com>
 <ZpAqbh3TnB9hIRRh@zx2c4.com> <443146f4-9db8-4a19-91f1-b6822fad8ce8@redhat.com>
 <1c8632b4-06a5-49da-be0c-6fc7ac2b3257@redhat.com> <2c464271-1c61-4cd8-bd4e-4bd8aa01fa00@redhat.com>
In-Reply-To: <2c464271-1c61-4cd8-bd4e-4bd8aa01fa00@redhat.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 11 Jul 2024 13:49:42 -0600
Message-ID: <CAOUHufYsxCb=taWWfUbuzi1Hmmug=ThQMoTjsxrtFkt=UXEu6w@mail.gmail.com>
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
To: David Hildenbrand <david@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de, 
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 1:20=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 11.07.24 21:18, David Hildenbrand wrote:
> > On 11.07.24 20:56, David Hildenbrand wrote:
> >> On 11.07.24 20:54, Jason A. Donenfeld wrote:
> >>> On Thu, Jul 11, 2024 at 08:24:07PM +0200, David Hildenbrand wrote:
> >>>>> And PG_large_rmappable seems to only be used for hugetlb branches.
> >>>>
> >>>> It should be set for THP/large folios.
> >>>
> >>> And it's tested too, apparently.
> >>>
> >>> Okay, well, how disappointing is this below? Because I'm running out =
of
> >>> tricks for flag reuse.
> >>>
> >>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> >>> index b9e914e1face..c1ea49a7f198 100644
> >>> --- a/include/linux/page-flags.h
> >>> +++ b/include/linux/page-flags.h
> >>> @@ -110,6 +110,7 @@ enum pageflags {
> >>>             PG_workingset,
> >>>             PG_error,
> >>>             PG_owner_priv_1,        /* Owner use. If pagecache, fs ma=
y use*/
> >>> +   PG_owner_priv_2,
> >>
> >> Oh no, no new page flags please :)
> >>
> >> Maybe just follow what Linux suggested: pass vma to pte_dirty() and
> >> always return false for these special VMAs.
> >
> > ... or look into removing that one case that gives us headake.
> >
> > No idea what would happen if we do the following:
> >
> > CCing Yu Zhao.
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 0761f91b407f..d1dfbd4fd38d 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4280,14 +4280,9 @@ static bool sort_folio(struct lruvec *lruvec, st=
ruct folio *folio, struct scan_c
> >                   return true;
> >           }
> >
> > -       /* dirty lazyfree */
> > -       if (type =3D=3D LRU_GEN_FILE && folio_test_anon(folio) && folio=
_test_dirty(folio)) {
> > -               success =3D lru_gen_del_folio(lruvec, folio, true);
> > -               VM_WARN_ON_ONCE_FOLIO(!success, folio);
> > -               folio_set_swapbacked(folio);
> > -               lruvec_add_folio_tail(lruvec, folio);
> > -               return true;
> > -       }
> > +       /* lazyfree: we may not be allowed to set swapbacked: MAP_DROPP=
ABLE */
> > +       if (type =3D=3D LRU_GEN_FILE && folio_test_anon(folio) && folio=
_test_dirty(folio))
> > +               return false;

This is an optimization to avoid an unnecessary trip to
shrink_folio_list(), so it's safe to delete the entire 'if' block, and
that would be preferable than leaving a dangling 'if'.

> Note that something is unclear to me: are we maybe running into that
> code also if folio_set_swapbacked() is already set and we are not in the
> lazyfree path (in contrast to what is documented)?

Not sure what you mean: either rmap sees pte_dirty() and does
folio_mark_dirty() and then folio_set_swapbacked(); or MGLRU does the
same sequence, with the first two steps in walk_pte_range() and the
last one here.

