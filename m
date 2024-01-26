Return-Path: <linux-api+bounces-692-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8906183E72F
	for <lists+linux-api@lfdr.de>; Sat, 27 Jan 2024 00:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34E51F2662B
	for <lists+linux-api@lfdr.de>; Fri, 26 Jan 2024 23:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388435914A;
	Fri, 26 Jan 2024 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SFp0xPCD"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790C5A79D
	for <linux-api@vger.kernel.org>; Fri, 26 Jan 2024 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312824; cv=none; b=fUe3rZYzEjuDGkCa7cOC5eTbpLtqJxuqs1CO/ZQK4GdbNhzxC+1DhyoiGm27zSEvhgqWbuvLFyoz+OegYVrfnYwz/ja2MLgiNJQp99xwEdZ8KTWd9nHuJF6KbyUUGCPS2HOrsQHXn6fjx/eo5/nUjeGodAwQYyjtcRY3c98nLTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312824; c=relaxed/simple;
	bh=Y8P+XJ/jMY+ZVg4eu/lKcHtx6J74L66cPCkyHQ3/Mik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lbde41wTvY1w+S0C3h2hEhvHD2B+Xtw4Lb0/CurCDMXXXMXEVFunF7AgTWLvnGWW8IUbacvf/ujawcfLzGIPAcyNvPJzXq9rdOAgDtsYuTwhtlIzG/DUSwwSMMtjamsCQGOjmb39WqACBwAWRHujLk8ip1l9J1QVpqGvVZ6O1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SFp0xPCD; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso5732a12.0
        for <linux-api@vger.kernel.org>; Fri, 26 Jan 2024 15:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706312819; x=1706917619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8P+XJ/jMY+ZVg4eu/lKcHtx6J74L66cPCkyHQ3/Mik=;
        b=SFp0xPCDZTekWEwg44GjejhwVmwhQa36y7biYg0bYpzsX/G5tpR62QdAX+VW5RR6O3
         3JC0WCTWQ5W5/C8wCLrXDNSXhz2i5CfmFhE4X59084PZkCHdefibEAJwKkFqvsRW7cfI
         SwMAXkWSmkwEq9u2bF7IcYx81yQZstbAlgKMML9oAUYFz/qNRdm/ol2GYGMQmDD1IRx7
         X+1beQ8GIAPQEbWs9JRjh1v/lYnnPgFKdTF/wzc11uokl0rpNI+nEw9ReBm2HREwKK4T
         UWf2z0Q9crnf4P1b5DZeUatDzejDegYhaCSTEVnnxfCX+BT28U3Z19t6SBPoACu/B8xE
         x9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706312819; x=1706917619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8P+XJ/jMY+ZVg4eu/lKcHtx6J74L66cPCkyHQ3/Mik=;
        b=OcWCHazi4ZFKzpcywZwCNM8WVVjyWYvVqK3aksWkOysvg62eVJx2KGS5YJvfQQHEiG
         bu5ajkoCu9TDeYGSzr07yZG8/VxCHeWYdAt7IgKwVuLp75Z+GJpqLz45jLbJ7uuEnH+m
         f2DteWL8PMjN0t9vtImmMHZCTLB2JPX8oZG/ikXiu4X9v/MeZeD9i5zV9HvhtEkB0yI+
         i7VO2bnSx4xYXTy3ArNHYLk/l16p5kbgrU+tJ+5PaZ3Ub/24vH0jcz41V+K9Tgoiv4e4
         eVoPVobRwu4RARSDCjU+Ya6y1ASVUmeQShvy9yWeKyD44DjvncwTZssQ0QrvbIaCBUQC
         lZSQ==
X-Gm-Message-State: AOJu0YwTZGgMEu0mry4IIICpDvBSXTYfUQwcBXkraM0iRWDn8LcTJflW
	wQ3mgeejkNxvJuJY5OYa0WLpR5Znkjk4m4iAP1o4xgOPCfZ2/Ggy/+bzhVcbK6HDu8MkN1NTPPp
	r8BZdmMBjDfu0kZl7EmYBVIb1CTdkG/QRY+DO
X-Google-Smtp-Source: AGHT+IGpmdrvQDq4WRf83ulNQxOn5H/FpoDx7dziJCeUqQjFVJywJeuANOjbk5DgM+2dAZd5lTCM3DOnXI68oquTL7o=
X-Received: by 2002:a05:6402:5d86:b0:55d:4375:c39c with SMTP id
 if6-20020a0564025d8600b0055d4375c39cmr170416edb.0.1706312818819; Fri, 26 Jan
 2024 15:46:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com> <CAK1f24=TfJvsDCEesaTa8rGP7ay62p6UiJem=XWnpFa9yfSA3A@mail.gmail.com>
 <CAK1f24nS8MEA3wcS4za-uSp7ZBxvd+xqMRf8-u=m5uCvTs8yJQ@mail.gmail.com>
 <CAK1f24kOYDOw26ov5TVpAyNP13hCjm=cDo4rooOTPDuv8L6Pnw@mail.gmail.com> <CAK1f24n0152CmPghBLQ7225=rwEuP6mMdBybWZz7heTLzemBqw@mail.gmail.com>
In-Reply-To: <CAK1f24n0152CmPghBLQ7225=rwEuP6mMdBybWZz7heTLzemBqw@mail.gmail.com>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Fri, 26 Jan 2024 15:46:21 -0800
Message-ID: <CAAa6QmRZP5pL_5O7BpfjQf5LZ_ADGqYF_xdAYEbKXkqMViAwLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>, 
	Yang Shi <shy828301@gmail.com>, David Hildenbrand <david@redhat.com>, songmuchun@bytedance.com, 
	peterx@redhat.com, mknyszek@google.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I=E2=80=99d like to add another real use case.
>
> In our company, we deploy applications using offline-online
> hybrid deployment. This approach leverages the distinctive
> resource utilization patterns of online services, utilizing idle
> resources during various time periods by filling them with
> offline jobs. This helps reduce the growing cost expenditures
> for the enterprise.
>
> Whether for online services or offline jobs, their requirements
> for THP can be roughly categorized into three types:
>
> * The first type aims to use huge pages as much as possible
> and tolerates unpredictable stalls caused by direct reclaim
> and/or compaction.
> * The second type attempts to use huge pages but is relatively
> latency-sensitive and cannot tolerate unpredictable stalls.
> * The third type prefers not to use huge pages at all and is
> extremely latency-sensitive.
>
> After careful consideration, we decided to prioritize the
> requirements of the first type and modify the THP settings
> as follows:
>
> echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
> echo defer >/sys/kernel/mm/transparent_hugepage/defrag
>
> With the introduction of MADV_COLLAPSE into the kernel,
> it is no longer dependent on any sysfs setting under
> /sys/kernel/mm/transparent_hugepage. MADV_COLLAPSE
> offers the potential for fine-grained synchronous control over
> the huge page allocation mechanism, marking a significant
> enhancement for THP.
>
> If the kernel supports a more relaxed (opportunistic)
> MADV_COLLAPSE, we will modify the THP settings as follows:
>
> echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
> echo madvise >/sys/kernel/mm/transparent_hugepage/defrag

[corrected, via 2 previous mails, to: echo madvise
>/sys/kernel/mm/transparent_hugepage/enabled
echo defer+madvise >/sys/kernel/mm/transparent_hugepage/defrag]


> Then, we will use process_madvise(MADV_COLLAPSE, xx_relaxed_flag)
> to address the requirements of the second type.
>
> Why don't we favor madvise(MADV_COLLAPSE) for the first type
> of requirements?
> The main reason is that these requirements are typically for offline
> jobs in the Hadoop ecosystem, such as MapReduce and Spark,
> which run primarily on the JVM. [..]

Hey Lance,

Thanks for proving this context, it's very helpful.

Though, couldn't you use enabled=3Dalways, defrag=3Ddefer+madvise, then
just use prctl(PR_SET_THP_DISABLE) on type-3 workloads to get the
behaviour you want? i.e.

type 1: apply MADV_HUGEPAGE -> sync defrag to get THP
type 2: don't apply MADV_HUGEPAGE -> use THP if available, kick
kswapd+kcompactd otherwise
type 3: use prctl(PR_SET_THP_DISABLE) (or MADV_NOHUGEPAGE) -> no THPs

Or am I missing something? It sounds like a confounding issue is that
these are external workloads, or you don't have ability to modify? But
that would preclude MADV_COLLAPSE (unless you're using
process_madvise()).

Appreciate the help understanding the use case. I'm not opposed to the
idea in general, but IMO would be great to have a clear need for it
(and right now, we don't currently have alignment with the original
motivating usecase (Go) in that regard w.r.t their plans).

Thanks,
Zach

