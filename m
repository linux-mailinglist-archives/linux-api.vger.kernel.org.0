Return-Path: <linux-api+bounces-1950-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF20992F006
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 21:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F8A2833F6
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 19:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E86919E827;
	Thu, 11 Jul 2024 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qptw++qi"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E5619E81F
	for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720727977; cv=none; b=Zi+SmBkZZX+TDlLf18rKhj5nwsUntJTlp0CB3H5GfuSwdDFKprW2SOyV47947rXo6wLZkzXkypMGXvhOk1+Wg244zJQYqImyTDlcaECOTM5lAuK8STKy4vGvkMxZl2sdgv3Vja4pi5HNccJ50JL9W+z8vdv8bR2ks/vkwLo8V/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720727977; c=relaxed/simple;
	bh=EwcI560szzXCbpyfgDyYof692YXwxRMkFI4AdQM+lcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiBiv3MAIxX4Zh5Itl+wyuObuCzJGVNuXkXa6JAnexhV5hrY1zo1SAMtuWozpyqOA1/uheGI4KNohZZQug6DoYZg28brfZUE8uo+bDV8Cfm+EvFywt6NaW2I/CzNvHb0GGsZLRs6lSrQAMZo1AVN84jQDeNa6XqwivLW1P/Ec4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qptw++qi; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44a8b140a1bso57121cf.0
        for <linux-api@vger.kernel.org>; Thu, 11 Jul 2024 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720727975; x=1721332775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usQgq2qcD076ORgLl9lg0b15V7evrXBpIxDm3sw86OY=;
        b=qptw++qixRwPsC5loItR03SgoDryBucQvldLH8j3mPnYCa8Jl8M3xp2NHqaIJCioDB
         B1d05m+xuXwQc29IaOwe1MvIxtyUmzeIe/ZsJbe22tAdezD8FdnXYz32lpCHKwnkdq9n
         ykah1rR7z3JUj8z3KXcnqtzTUpDtjXBHcIKL6nh5awf/Pg9Ut5+NulBBPsNCxFGmOIGL
         nDvVnNyNuicZ/lK2O5ZdcXh/UCQi6lNN3Gbi6E8p6tKKQN/M464qxYfoOc7HFM+cZxPp
         MhWyBLccduYxNp4FQvot/iwxDOkicyeW2xly7PAAKFW77W9ipQOp3iQzOhLnb8UvhdJ+
         uOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720727975; x=1721332775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usQgq2qcD076ORgLl9lg0b15V7evrXBpIxDm3sw86OY=;
        b=a7+oRbwDCBdvC7ZdqRAxX83PbYak20SL9WgnQtxvmikH/Kp1HY0qQuQnleXj2zQDaf
         9co4axKMt+iyfoBuRWSRdczZA/BeqEQ/SxgQbIckW/O1TQnYTn25TzcrsPdH7On5m8xl
         9ZpC0i0XfGZ5UyEc2BFa2emxVmMgDT0ZU3sfHnL9Cn0j8lP380V9AXUcKP96nj90hXqH
         J/DVUbYfCoO7AqZpkDiQa6m24DN61y7ab/ngilebg2RPdaYxmqXcMk1w96oZIAOKCU7o
         bL07HfyqX0MA+wyhDtcyYaLPMF//h1yTw+nVXFgYah2SI7EnfKo1cHkqA8oNnDL6SjLr
         HGyw==
X-Forwarded-Encrypted: i=1; AJvYcCVu4oBP0c12Eg7SCKhEJuwiAavu3ojPSGOjCvewNQuFGN8VQp12S+1MC5+jBSHTi2aNr25iQIpKPH/LF+mu1r/ixEwQPtRN26Qd
X-Gm-Message-State: AOJu0Yyh6iGGbpSGozuBS6+Zfvuktb1qLEcduXgDJDBsafL+eOBPAPmk
	LELJ2pZu6FihDb0kUeIG1AizYqx+yqNj8a1E6SBLJ1UDuIy1JUW4YCc76dUNm0pvoWVajNjQnXe
	98xbeDbGrAf7e6Ev7SV+7G8RIJFtVeCu+EhGz+58aNPQBb+YnS41s
X-Google-Smtp-Source: AGHT+IEM7irFssvF1uct5oQd7x7Vaba9daG5UqSQAd7zGLlxjvcWer92aqHngywJVogpDpoHiV+PdmFmORbjnMYXigE=
X-Received: by 2002:ac8:7193:0:b0:447:d555:7035 with SMTP id
 d75a77b69052e-44e793e6f9dmr475651cf.13.1720727974558; Thu, 11 Jul 2024
 12:59:34 -0700 (PDT)
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
 <CAOUHufYsxCb=taWWfUbuzi1Hmmug=ThQMoTjsxrtFkt=UXEu6w@mail.gmail.com> <da3ea234-d6dd-4809-b2f5-fbfedacb9748@redhat.com>
In-Reply-To: <da3ea234-d6dd-4809-b2f5-fbfedacb9748@redhat.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 11 Jul 2024 13:58:57 -0600
Message-ID: <CAOUHufZuMdN31WnbwctyFv+o8nAfVBaiHZa9Ud_cz6QAoNQHxw@mail.gmail.com>
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

On Thu, Jul 11, 2024 at 1:53=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 11.07.24 21:49, Yu Zhao wrote:
> > On Thu, Jul 11, 2024 at 1:20=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 11.07.24 21:18, David Hildenbrand wrote:
> >>> On 11.07.24 20:56, David Hildenbrand wrote:
> >>>> On 11.07.24 20:54, Jason A. Donenfeld wrote:
> >>>>> On Thu, Jul 11, 2024 at 08:24:07PM +0200, David Hildenbrand wrote:
> >>>>>>> And PG_large_rmappable seems to only be used for hugetlb branches=
.
> >>>>>>
> >>>>>> It should be set for THP/large folios.
> >>>>>
> >>>>> And it's tested too, apparently.
> >>>>>
> >>>>> Okay, well, how disappointing is this below? Because I'm running ou=
t of
> >>>>> tricks for flag reuse.
> >>>>>
> >>>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.=
h
> >>>>> index b9e914e1face..c1ea49a7f198 100644
> >>>>> --- a/include/linux/page-flags.h
> >>>>> +++ b/include/linux/page-flags.h
> >>>>> @@ -110,6 +110,7 @@ enum pageflags {
> >>>>>              PG_workingset,
> >>>>>              PG_error,
> >>>>>              PG_owner_priv_1,        /* Owner use. If pagecache, fs=
 may use*/
> >>>>> +   PG_owner_priv_2,
> >>>>
> >>>> Oh no, no new page flags please :)
> >>>>
> >>>> Maybe just follow what Linux suggested: pass vma to pte_dirty() and
> >>>> always return false for these special VMAs.
> >>>
> >>> ... or look into removing that one case that gives us headake.
> >>>
> >>> No idea what would happen if we do the following:
> >>>
> >>> CCing Yu Zhao.
> >>>
> >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>> index 0761f91b407f..d1dfbd4fd38d 100644
> >>> --- a/mm/vmscan.c
> >>> +++ b/mm/vmscan.c
> >>> @@ -4280,14 +4280,9 @@ static bool sort_folio(struct lruvec *lruvec, =
struct folio *folio, struct scan_c
> >>>                    return true;
> >>>            }
> >>>
> >>> -       /* dirty lazyfree */
> >>> -       if (type =3D=3D LRU_GEN_FILE && folio_test_anon(folio) && fol=
io_test_dirty(folio)) {
> >>> -               success =3D lru_gen_del_folio(lruvec, folio, true);
> >>> -               VM_WARN_ON_ONCE_FOLIO(!success, folio);
> >>> -               folio_set_swapbacked(folio);
> >>> -               lruvec_add_folio_tail(lruvec, folio);
> >>> -               return true;
> >>> -       }
> >>> +       /* lazyfree: we may not be allowed to set swapbacked: MAP_DRO=
PPABLE */
> >>> +       if (type =3D=3D LRU_GEN_FILE && folio_test_anon(folio) && fol=
io_test_dirty(folio))
> >>> +               return false;
> >
> > This is an optimization to avoid an unnecessary trip to
> > shrink_folio_list(), so it's safe to delete the entire 'if' block, and
> > that would be preferable than leaving a dangling 'if'.
>
> Great, thanks.
>
> >
> >> Note that something is unclear to me: are we maybe running into that
> >> code also if folio_set_swapbacked() is already set and we are not in t=
he
> >> lazyfree path (in contrast to what is documented)?
> >
> > Not sure what you mean: either rmap sees pte_dirty() and does
> > folio_mark_dirty() and then folio_set_swapbacked(); or MGLRU does the
> > same sequence, with the first two steps in walk_pte_range() and the
> > last one here.
>
> Let me rephrase:
>
> Checking for lazyfree is
>
> "folio_test_anon(folio) && !folio_test_swapbacked(folio)"
>
> Testing for dirtied lazyfree is
>
> "folio_test_anon(folio) && !folio_test_swapbacked(folio) &&
>   folio_test)dirty(folio)"
>
> So I'm wondering about the missing folio_test_swapbacked() test.

It's not missing: type =3D=3D LRU_GEN_FILE means folio_is_file_lru(),
which in turn means !folio_test_swapbacked().

