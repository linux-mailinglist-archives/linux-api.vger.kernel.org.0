Return-Path: <linux-api+bounces-2186-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2943C954E3A
	for <lists+linux-api@lfdr.de>; Fri, 16 Aug 2024 17:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFA51F256B3
	for <lists+linux-api@lfdr.de>; Fri, 16 Aug 2024 15:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38FE1BE222;
	Fri, 16 Aug 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UkJYcD/B"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8451BDA94
	for <linux-api@vger.kernel.org>; Fri, 16 Aug 2024 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823582; cv=none; b=bePEE/3c2McIZI/OLR33RWBw7u5GPYOFfRTR75KAaqlTgCYxNODSfSz1SxDttgq6WDHjgbA3JVoIwIPZxj0KMKI+98iV97Ev+JE+QrGzZV/lHGg6JdBZSng6Z01HXk5SqZGGfFDSB3x4/o4dlKZUxjuZEKdyeDlSUDurinNNVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823582; c=relaxed/simple;
	bh=CvQRyWNvYCOzRkN+ELQPK4bCnaihpDrQkDNZmn0IFr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quTMWLWXw0aQJSHvhkFKu3vOr4tyUj+otf5eVbSsyYUgL7ota23u5fRd31LmakHqXPhKrZmP9UsNzl7Z3ZbZwz9QlakubR/6f4vT11E4yibEWALAAsmh0wQ/AKJI/ua7cLZyyksVOGVmaffRTZ5pn5gw5dKYzIahP3qCTXuNXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UkJYcD/B; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bebb241fddso6267a12.1
        for <linux-api@vger.kernel.org>; Fri, 16 Aug 2024 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723823579; x=1724428379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVyTWEE9ashdkfnF3JwqoAcqSiSflsAjDJX67zoGcUg=;
        b=UkJYcD/BF6D5+GtUUsahOA8fMXr5ub+vy3xFhE6uib3tpyXr8Qtr5qKklMjKBrqbec
         HKvws8FK8BGFq9QwTYKcLJamZRHv3nuUebjGpE+yW8COY/QEN/jxT7gOeZfVntD78rRv
         VaahQi75etYs+4gExEqGTS2c7CBebxkvE1X0bQBC/YRvwe7+SSxUxrtj9CzjRVyoZPq+
         XgwND/+83WSIXLLg88nV+WpjlMfMy/hFakaOVi55e/b8z+ATWcCDxoi6oRiLU/R5Y97Q
         2Zq+PISTtM8wMBH11BgkmjOD0RTIjLYR3L32NDB7KIoSs6y+BlYUEOXa02pkHS7x7Dbu
         AFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723823579; x=1724428379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVyTWEE9ashdkfnF3JwqoAcqSiSflsAjDJX67zoGcUg=;
        b=nL5ozcIjF3ehjYdyGtWoY+bHm5EenPRfELDovnTnOQGSqJwPl0dipsp31obws2qkYE
         57jPKUOb7OK0q7/nUKCK3O04vPoxcBFeJd7IE2himgnBLlQKFJydErq7TdNDIH9yhbCD
         SbM0DCsh12TjUUYJ/FscsKpIQjQSzmzryMnFD+GIGhBOcZ+w9C7FLqGoF/r/TdAY0WpN
         99bPlhSJX3EgsT37ugWs+5Om7bg/JmW/K4BpkImV2ay4s6AlLz2T6OqpoxTXP5Br9nh8
         +fIQBeIWZppsleLcGenypvob321Afvh8Khy4gk/VLIkkKZEneAfst/OnYXDyZQk3aEXk
         ut/w==
X-Forwarded-Encrypted: i=1; AJvYcCXqVrB4/wx5vdd/0dBgGZSrZZ25Rv/A5nYswYlCLfUN6Fvmx/l4qXdIcX2ceYXQc27h77I8/iG9/mXn408FBCwtbOchlSgiAK/r
X-Gm-Message-State: AOJu0YwrE6aiywz2eDa1BYTJAXRt2bQxIATlwH3DX8n1lI6lRCLalcjS
	Czmzcyn3Bi6qF9FyainLXzRS97q/e7PE4DJsAXR/zXILJBn4fCIyGVC9e1MFkfl3hHkPaxzBdGN
	344CENLDSMcqkjB+L9SRjkX21Y3fFhFw+dGYP
X-Google-Smtp-Source: AGHT+IGaN3ZrTPmlYfYmhDsPXbaJaHVO8v6Ph0X3pHb/fEYmuPf+xnkkij25NrlKAMK3pprdkyHc+Lk/J2/ckqDGdsI=
X-Received: by 2002:a05:6402:27ca:b0:57d:32ff:73ef with SMTP id
 4fb4d7f45d1cf-5becb5bc0acmr90045a12.6.1723823578489; Fri, 16 Aug 2024
 08:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
In-Reply-To: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 16 Aug 2024 17:52:20 +0200
Message-ID: <CAG48ez38VVj10fixN5FYo1qujHSH17bPGynzUQugqeBRYAOBRw@mail.gmail.com>
Subject: Re: [PATCH RFT v8 0/9] fork: Support shadow stacks in clone3()
To: Mark Brown <broonie@kernel.org>, brauner@kernel.org, Kees Cook <kees@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>, 
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 10:16=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
> Since clone3() is readily extensible let's add support for specifying a
> shadow stack when creating a new thread or process in a similar manner
> to how the normal stack is specified, keeping the current implicit
> allocation behaviour if one is not specified either with clone3() or
> through the use of clone().  The user must provide a shadow stack
> address and size, this must point to memory mapped for use as a shadow
> stackby map_shadow_stack() with a shadow stack token at the top of the
> stack.

As a heads-up so you don't get surprised by this in the future:

Because clone3() does not pass the flags in a register like clone()
does, it is not available in places like docker containers that use
the default Docker seccomp policy
(https://github.com/moby/moby/blob/master/profiles/seccomp/default.json).
Docker uses seccomp to filter clone() arguments (to prevent stuff like
namespace creation), and that's not possible with clone3(), so
clone3() is blocked.

The same thing applies to things like sandboxed renderer processes of
web browsers - they want to block anything other than creating normal
threads, so they use seccomp to block stuff like namespace creation
and creating new processes.

I briefly mentioned this here during clone3 development, though I
probably should have been more explicit about how it would be
beneficial for clone3 to pass flags in a register:
<https://lore.kernel.org/all/CAG48ez3q=3DBeNcuVTKBN79kJui4vC6nw0Bfq6xc-i0ne=
heT17TA@mail.gmail.com/>

So if you want your feature to be available in such contexts, you'll
probably have to either add a new syscall clone4() that passes the
flags in a register; or do the plumbing work required to make it
possible to seccomp-filter things other than register contexts (by
invoking seccomp again from the clone3 handler with some kinda
pseudo-syscall?); or change the signature of the existing syscall (but
that would require something like using the high bit of the size to
signal that there's a flags argument in another register, which is
probably more ugly than just adding a new syscall).

