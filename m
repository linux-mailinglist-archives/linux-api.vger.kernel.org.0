Return-Path: <linux-api+bounces-3856-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 628E3AC8252
	for <lists+linux-api@lfdr.de>; Thu, 29 May 2025 20:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3851A234BD
	for <lists+linux-api@lfdr.de>; Thu, 29 May 2025 18:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353C1230D0E;
	Thu, 29 May 2025 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="PN2Ob3W2"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B781230BE0
	for <linux-api@vger.kernel.org>; Thu, 29 May 2025 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748544645; cv=none; b=ToAPz9KXj7g+JifAB97ojsufzgxaywSQSxWFTLyYli1+xeFtCXw3yBhVon89qmJ8WqCU9KI0BvFilpOkHKPtmYz7mhUAvE1wkXx0FwMv+t3DA8HjFkcVguzAHfOm8/ayeptnhc+ZogSfRoeIi0rLj5YYEVy7hoOSF1u5zBdXOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748544645; c=relaxed/simple;
	bh=wca2f04yGSNetikYQNq4fZhabQgWlYOojnVD8BcpKdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVCBSjR670pDzCmVRNpeX6uo64BdtMt2MKe1ddI5EPXnZxXilpAGeMDCTkBObAmN/GmIjTyHQ2BVgeaH062o2+E5YzIyDbqT+cUxjzLcJvvlYooMV4k3N83t/c4Kra0pNZflDyRJGMT8Dirl4vmofsNmyIGQD26O2NijPmRRvKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=PN2Ob3W2; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32a6a91f0easo4990371fa.0
        for <linux-api@vger.kernel.org>; Thu, 29 May 2025 11:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1748544641; x=1749149441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZR+bV/RpEv69QT29h8o3+icO6BNVEjRkOnd0TqgTeg=;
        b=PN2Ob3W269WV9lE5hwiaOHucANKYmYvgncgsi7P/AAMb+Zd9m/tLBDLqYzF2pABmSv
         TuOOon5OSbfLNwT3SE4arJhXnofJL9mqq1CXnvvVQKIiyi5SsW8qKx3HYxilQkF1gA3i
         7PTmZ7qLP+TeLyxC/qge7TaVP9oOpOkK8HlaVAMY1A9nyPM1dLNveaOX8UWNB8e662cQ
         sIhznuFtfse4c81pCj7Zj5PowvQSXD6asRk/DtT2F7Wo16w/ktw5qIFb1AFvvg1gptya
         ap4ZAjyZCzcQtoe7uTqfbSxAZ9S/ay4BWYuKTQbB8C1Bw10D/1HMuPiqGN4yUUucJUuu
         qI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748544641; x=1749149441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZR+bV/RpEv69QT29h8o3+icO6BNVEjRkOnd0TqgTeg=;
        b=sCilfx2Ye5oANbYKhNUpA0r7EjcosyYyPDXZPPPZ2G5l/ZsxH6aXJ4MZg+nSYlHASe
         LR7pxwkAyn8L9L0GXzJTsPCBveT1RQ3G4U23A0rXZxN5Xwf6vOwDVpQrqYwHeeoHR07r
         cwxZ8vKcbbBKgm3Ml/ktXtSYvWKL3NDk3JJMz5QBex0fWu5blApiiVbL9X9kNqPCtByd
         Y1PAXYCLNwCHR8OllfojAvdi2O3EXpYPSfPVkxeXbNhCrCjK5vu8Y4bhwwEPk66CeYFD
         CnVxglB+nFdR3gBhAsWhAwmvCP1CXnIEpNOUwbNEegT5zxKkfQeJ2O3xxNt40zOdtG3Q
         m3Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUNwrSQ8iObHH1MOlBCp+CgCC+wMYJgLW2mU9JiNlWOfat1FPaAHwHT64pLSOjlcJRXGPSI03oKGp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhaLS+nrM17/VjF872qx2tHf2+L/28ia0NavJx6GZssY5PHnCu
	C7+ptGownhTISoqn/7HCrxz96XVQLO4i3ugKD6eOrclEb9NqlZdB6qR1JQ+016GlU4URHdZyDEC
	X9SZwtPYN1AfrlC5C5NGKO1Rmt3LC2HfxGRmNLwmN
X-Gm-Gg: ASbGncup/quhzErfdGJzmv7GFC9NWuc8f8nG9NaSsP4SP2sd2kHSXwtF/8SYTvT03qw
	pZB0n6nqumz083CiNXTZzwRrzP4UNtS30kiksBKqZkoKkLZhdE31vMbyOzSzlPv6cEG3F0+5OC3
	Ct1xi21rVMN+XWvG6jNgLSI1zpluki6sCE2rTM6fPgYQ==
X-Google-Smtp-Source: AGHT+IHvzZNFmorgbMvPjPmVBKaNoD8JL8vbWNjA3kvxqIbWCqlAQjdL2EaLHdbNkYIonfwMKxJEVmqVJFx1wvfSHiQ=
X-Received: by 2002:a05:651c:3050:b0:32a:8631:c41b with SMTP id
 38308e7fff4ca-32a8ce7ff5cmr3131261fa.40.1748544641324; Thu, 29 May 2025
 11:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
In-Reply-To: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 29 May 2025 11:50:29 -0700
X-Gm-Features: AX0GCFspfSh1KbGnhihvv0QMDvvSEVkz0UOx1CDZtHwOavk_KVICQNzB6RwmT6E
Message-ID: <CALCETrUdgn=eXiGR4pH+EdCGb69bw7n21goJGQbt6mNh0mhTmw@mail.gmail.com>
Subject: Re: [DISCUSSION] proposed mctl() API
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>, 
	Mike Rapoport <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Barry Song <21cnbao@gmail.com>, 
	linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 7:44=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> The behaviour will be tailored to each action taken.
>
> To begin with, I propose a single flag:
>
> - MCTL_SET_DEFAULT_EXEC - Persists this behaviour across fork/exec.

It's hard to comment without a more complete proposal (*what* behavior
is persisted?), but off the top of my head, this isn't so great.

First, the name means nothing to me.  What's "default exec"?  Even
aside from that, why are fork and exec the same flag?

Beyond this, persisting anything across exec is a giant can of worms.
We have PR_SET_NO_NEW_PRIVS to make it less hazardous, but, in
general, it's risky and potentially quite confusing to do anything
that affects exec'd processes.

Oh, and this whole scheme is also potentially nasty for a different
reason: it's not thread safe.  If one thread wants to spawn a process,
it should not interfere with another thread doing something else.  So
making an mm flag that persists across close can interfere a bit, and
persisting it across clone + exec is even gnarlier.

For any of these, there should be matching query features -- CRIU,
debugging, etc should not be an afterthought.

