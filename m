Return-Path: <linux-api+bounces-2139-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E50949A4B
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 23:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4B81F27578
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 21:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1086A16190C;
	Tue,  6 Aug 2024 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHtt3XHr"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945D14F9D7;
	Tue,  6 Aug 2024 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980242; cv=none; b=lCmSmd+YBMXaCsZ/KiGTIwZlnpQSGva9eaDf0xjkPQImp8AnH7Y8xAPHgF4fuF/6MN/sFyY3n1XtgOVwVs+Ib1xU2DBeJRN00RAfKT/j1znDnl4cPr1B8psmr2d8jdXZbgIxaxZccMiBi6QV/N0aloAfIYcnGnn2jvbS0NdTb7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980242; c=relaxed/simple;
	bh=8kHm+ac+kygNQxYV5Z1B1h2y1ADNWsDkiwXd93UvjBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBfMT3YfFk4XX8RdcIHi6Xdo2yZwK0untn2J94fFq2rhClsTV/5JfnNwqzNwt3PiKp6cCG55BbcBXQSBPOk2UP8kLgph7PM57SCBvMNuPpDMt3EsWiuD+2tOJAPDQAEg4Bi+7jDnz39HnWdMDYLcYyAlYFDqQ8YnJyxaRFbxb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHtt3XHr; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4f8b5e5671bso475558e0c.0;
        Tue, 06 Aug 2024 14:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722980240; x=1723585040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFsMpJ+I7X97hoFlRtZ+H2DXn3COcJ95N+qj7lA/TOQ=;
        b=MHtt3XHrmQfg/E2uIr1756uvqbVbGmPNOCpcLRoMzCmKNpYFQBzPFfTaSnmkM4Hee2
         wMhd2igiwxKMC+BAfEyIEFSSVMZhVttSC08Ucz+Aw3yUbuB0gtnBSEO81zPO9TuCZ2R5
         //3EBsExp06CJ16aNblX2rJffB18vkKjClYln0mCiUsTvJial6IrLqkD597zxCknhnre
         akvMAKWCVY7+2lYbQVxWfs/mErEFp3IsvhPvMSnQDejZI76VUFsLXP2Uhk9A4R5kw+Yf
         1tkf9MedoE38vl01D9/KBVcf7BL5skihtjswC7R9tFjAdJoMKnPnu/QuvSumaFRtO1pe
         KQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722980240; x=1723585040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFsMpJ+I7X97hoFlRtZ+H2DXn3COcJ95N+qj7lA/TOQ=;
        b=wmuQ+E5zz2TVfOHpynbrB1SCPh/cUUZobmYnnJSgF7pg6UtuQHqIjcNkO3C0sDr31b
         oGARr1i566DrB6BYXkIPJ7t3yDsOdtbe73xMSxOqwvSn+7WuSUPRnpGu7zHhiASgrZBJ
         Zbk1j1KZqj+aZ5FD8ESMCzCB4DubSNnfCQ/Pfevvgg1653M2T03c1aYksl/OIs4OeetC
         K6rPeCkuKPe7Kb1OwsoXDFZOrrrXr2eTkrOTlqLmdswRfsyf9ey5ys94xbkbKt3ZWYVR
         GrMu0SqJ4tpB3Vq2rofXAuc/rqQY0AQu+Edzv1qArjHygbhJlK9DmMUWLIQ1lO1aviCe
         arQw==
X-Forwarded-Encrypted: i=1; AJvYcCX/A6m4Yjjxdm6soTnisO6MuYWHe/A/xWAAvhJioqq2KCy+pQQs6zlT1/DL7gxxBd6Guyec07OQa2PsQVvtHEBbPHdUhyDkbkcYqXr39WjF007R/onsW1okfXHagX+qb6xF2uAhs4wS
X-Gm-Message-State: AOJu0YyS5zYXWmhRj+OWaNGqm/h63pTDtXairLh9yrRrvwh5xgVHtSom
	PwGuSlNUmiIoLUXtwBB0RHAGpEcFNykhPoiraJzgY9Uy8j9JVlxxrQxqiiPuVnbk2QEIKTSU7Ga
	d8Ow7KiXMTaGzzLqw2FFhBYynwJ4=
X-Google-Smtp-Source: AGHT+IFrQ8JTwjxVQvgV4t1UWu1mNosEjtPutyaa5+3W6qYS/JH+h8DUFz1dPxmoFFh/1Vhlg23Q+IHOeKLj0hAoGlA=
X-Received: by 2002:a05:6122:2191:b0:4f5:1b58:acd9 with SMTP id
 71dfb90a1353d-4f89ff4c58fmr14470832e0c.2.1722980240246; Tue, 06 Aug 2024
 14:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CAHk-=wgdTWpCqTMgM9SJxG2=oYwhAueU_fDHMPifjpH5eHG8qw@mail.gmail.com> <ZrG8+/1YjxN/Hsb7@xsang-OptiPlex-9020>
In-Reply-To: <ZrG8+/1YjxN/Hsb7@xsang-OptiPlex-9020>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Tue, 6 Aug 2024 22:37:08 +0100
Message-ID: <CAKbZUD1278Bq+5QwjH=LeYSgcugZ3JbvkLeoB3whei_gkEXV+w@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Oliver Sang <oliver.sang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Xu <jeffxu@google.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Jeff Xu <jeffxu@chromium.org>, 
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 7:05=E2=80=AFAM Oliver Sang <oliver.sang@intel.com> =
wrote:
>
> hi, Linus,
>
> On Mon, Aug 05, 2024 at 12:33:58PM -0700, Linus Torvalds wrote:
> > On Mon, 5 Aug 2024 at 11:55, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > So please consider this a "maybe something like this" patch, but that
> > > 'arch_unmap()' really is pretty nasty
> >
> > Actually, the whole powerpc vdso code confused me. It's not the vvar
> > thing that wants this close thing, it's the other ones that have the
> > remap thing.
> >
> > .. and there were two of those error cases that needed to reset the
> > vdso pointer.
> >
> > That all shows just how carefully I was reading this code.
> >
> > New version - still untested, but now I've read through it one more
> > time - attached.
>
> we tested this version by applying it directly upon 8be7258aad,  but seem=
s it
> have little impact to performance. still similar regression if comparing =
to
> ff388fe5c4.

Hi,

I've just sent out a patch set[1] that should alleviate (or hopefully
totally fix) these performance regressions. It'd be great if you could
test it.

For everyone: Apologies if you're in the CC list and I didn't CC you,
but I tried to keep my patch set's CC list relatively short and clean
(and I focused on the active participants).
Everyone's comments are very welcome.

[1]: https://lore.kernel.org/all/20240806212808.1885309-1-pedro.falcato@gma=
il.com/
--=20
Pedro

