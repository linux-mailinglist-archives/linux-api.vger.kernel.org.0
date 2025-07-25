Return-Path: <linux-api+bounces-4242-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD1BB122BE
	for <lists+linux-api@lfdr.de>; Fri, 25 Jul 2025 19:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C83D1CC6464
	for <lists+linux-api@lfdr.de>; Fri, 25 Jul 2025 17:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7022EF673;
	Fri, 25 Jul 2025 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9teVUjs"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725A2EF2B7
	for <linux-api@vger.kernel.org>; Fri, 25 Jul 2025 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463550; cv=none; b=NTBCxRHZCCMJCfXaianAIwTTCMjE/lElhYk87gVUZSrAil1FU0SNh4aHUoE7KXINTU1yl55jVWmHCm4uzD5yWHk/2aTmwHvt+Vj6KrypjRBqwsXjJLEevxFrWIRq2brKyfF2duc20cCRHxnUxl3BHJyELJrHfwicMyelOCVn5gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463550; c=relaxed/simple;
	bh=LR/1fr+927w5gHz+7V9YvJuD7wXmf2oW8T6mJhnxcas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/T8tDL3jDd0NKppd/bVznpF/iSAw8wHSHtstDcm3R6muzHdHRlznFfLuErqCAcmdxc6tmpObA+TGu33a7RnLd1EXem9juZsPfyZwTd0ohaurCtY5+sxR3VCT/ACV8XdPc4JVS+MoVFRSg+Zj/IjH7fC9DFsHu9AeTlvPpWd4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E9teVUjs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4561b43de62so4755e9.0
        for <linux-api@vger.kernel.org>; Fri, 25 Jul 2025 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753463547; x=1754068347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR/1fr+927w5gHz+7V9YvJuD7wXmf2oW8T6mJhnxcas=;
        b=E9teVUjspWShKsMgc1oLy+m9iwkIFL+C/fjG0YE/EIYK/XzXXxa23KCQz3naomeZi8
         Y8HxbHREoCTKbCdWMqpi2V+pL5yhNCwb3XjQOpjt6PtPOvZuTlPg7RcJAUwnhXriZhS/
         N99P2J2YKRZFR7pKAsOCoTwBmdLM5Jqj8qGv1XHcn5KjgQJYMYIbDlgWyHFUkRoYQF4y
         1j+lHWwY0JnAJesKI32cLe5FJ6iYckQpFND98nOQLNJL/+FOLyytMGPuyCrCj08wDxmy
         idRL64mD3bs2vITGHRXBzT4/FnvvsbQ94mIFPvde9MQ6j7mvhKRS8sEYdovkMvVIDRUV
         SbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753463547; x=1754068347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LR/1fr+927w5gHz+7V9YvJuD7wXmf2oW8T6mJhnxcas=;
        b=iM8f6inpT2fzNte0+51XUJDqxxD7WevqMQtFyK+EEoc+Ilyi8qqDY4Gx4jNuchwV8w
         1Xh/3Vxp/oRPncGypaJuOCq3FPwQRosoALEx2hm0jurZmfGLKdwAravRBlwnOM4kIchI
         C9qw6EZqEhwfrrC7J9UaUF5q1Xt8bll0QB9YO9a6x4gtCLgooiqwr8bbRidGHd1iZwqv
         uJ3TMmgLzYjNCPn+TWNREs1z5RMc9gcZkV/g/2UfOiqD0WGFoy61WPohaeOWR08Dt2Dp
         RW/6npDRazH09bWop3iyHb+F2OOFveqPZ3NRSkcEsvCRRVK+wFtQ8xc9so32D1J2wqsO
         nmkg==
X-Forwarded-Encrypted: i=1; AJvYcCVfpujt/OnOckINzz5Vm9wbBGV2hTHNG6petmrLd3DI+bs8qGTNHlycANo5BOj6mNfK6hjSYvBFZP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw88254NeMWwOJQ19QLdW8pg357Z580QTOP0fDcMFrb1+wCZgU8
	mJLD5Fz5FlSqCyJTh53RlmX4+9q+jSZt3gxOGd2CLmWtXd3DhpTX5jI3JeCAM3ZtNzGQwmSL8ZF
	UGrjQxe8GsbSAIKtv6in68n6YvoGdiFHJjdlozW4X
X-Gm-Gg: ASbGncs6SPFZ1xHHUH64A00/ri7NXrJasC+DHObdFtUpzfPh6HBWYrsw/TTtvMG+9Il
	bwPxc1SUoESWD34yAz/XtnjNA9FN3HVl7R3/NYLp3YJKt67jQ+9fr20huHp7NBHCqBnhq9yrtwF
	6tpjCdyav+bPcvAoiWsembM/2W23fVIn3+i1m0Rp4hbPizEpME9QARLi21gZQFJfGvjbmJopUcr
	Bm6lZpxcHL/4iQ1qSvcq7PrPIKJDAKMExwmOjQtFeZq1A==
X-Google-Smtp-Source: AGHT+IFhxhJzavWiG8TnAC5bSyEUCITgigk6eSOkbePzjanT6OdYE8Du+O+akeu9UoPZ+9VboPkoI9eK3HhR7G1bjjE=
X-Received: by 2002:a05:600c:1c86:b0:453:65f4:f4c8 with SMTP id
 5b1f17b1804b1-45874e2b93cmr1367085e9.3.1753463546532; Fri, 25 Jul 2025
 10:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com> <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 19:11:49 +0200
X-Gm-Features: Ac12FXz5v7hwHYZVZo-PcQftTdDT8-58CkHFg3QHIWJWk_i7JJUmY1B0j5KtsNs
Message-ID: <CAG48ez0KjHHAWsJo76GuuYYaFCH=3n7axN2ryxy7-Vabp5JA-Q@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] mm/mremap: permit mremap() move of multiple VMAs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:38=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> Note that any failures encountered will result in a partial move. Since a=
n
> mremap() can fail at any time, this might result in only some of the VMAs
> being moved.
>
> Note that failures are very rare and typically require an out of a memory
> condition or a mapping limit condition to be hit, assuming the VMAs being
> moved are valid.

Hrm. So if userspace tries to move a series of VMAs with mremap(), and
the operation fails, and userspace assumes the old syscall semantics,
userspace could assume that its memory is still at the old address,
when that's actually not true; and if userspace tries to access it
there, userspace UAF happens?

If we were explicitly killing the userspace process on this error
path, that'd be fine; but since we're just returning an error, we're
kind of making userspace believe that the move hasn't happened? (You
might notice that I'm generally in favor of killing userspace
processes when userspace does sufficiently weird things.)

I guess it's not going to happen particularly often since mremap()
with MREMAP_FIXED is a weirdly specific operation in the first place;
normal users of mremap() (like libc's realloc()) wouldn't have a
reason to use it...

