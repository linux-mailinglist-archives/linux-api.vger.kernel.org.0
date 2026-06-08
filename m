Return-Path: <linux-api+bounces-6580-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cdtJNqriJmqJmQIAu9opvQ
	(envelope-from <linux-api+bounces-6580-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 08 Jun 2026 17:41:30 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E9A65837B
	for <lists+linux-api@lfdr.de>; Mon, 08 Jun 2026 17:41:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=SN4g2w+7;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6580-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6580-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73FC03046DDC
	for <lists+linux-api@lfdr.de>; Mon,  8 Jun 2026 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C683DC4AB;
	Mon,  8 Jun 2026 15:02:50 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877D413238
	for <linux-api@vger.kernel.org>; Mon,  8 Jun 2026 15:02:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930969; cv=pass; b=gI1bH7F1ZtzAfhCAvudBhBtwvWaqHS6og1oFChyzm1gDesB2CFLyK5XNLBCXLAh5Swhcbe7FIstASkaNwhGt3dY51kUKQh/UA8gqR57BEkjUW1UffJkjBjj6cUHgeJV5uW/90+fSipMe/+lFCZZ9bppDEcogSBEsRZZ6Z6QWaM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930969; c=relaxed/simple;
	bh=g51x3Dke8m4hq5BD7mWP1JIENWwriEm4dzZwpkBeih4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aelOaSiFkcoC3GTzaqZnhb+gEPd6Qo41GGa+8MX06S/CRhYnr8a1h0jNfOTI92CEOqycWYJArdKemci3IvRuPzbkzPUwU3kTWST6gXi3ulEuTfWf1XMWd95k8LlRF8GkgUF7mAawFKOkJLvOLX2YWpot2IRkBF+yhwBI4AF6ilU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SN4g2w+7; arc=pass smtp.client-ip=209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68bd7ec2371so26896a12.1
        for <linux-api@vger.kernel.org>; Mon, 08 Jun 2026 08:02:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780930963; cv=none;
        d=google.com; s=arc-20240605;
        b=bdW1DD4VouMzUj6WUByQzjQHW5LS/buCZf0E6eb5NJ+ck1iDson+1sXkY0OcF7uTIC
         bAm0N+t64eBReXBvr4RGhoqnqrsVffU6Y+QSXpALVwIlNGQeJWAkEMb80CCQjarJbOUy
         HHTsrOkQatQoB2jdUhJVMn80Nd9le19GLL/R3jvx5bvLdir+DI+nBNNo+992Fems3m1O
         6CzKD4GMAlw+WXU2FCsP1qfW9/fGhA9v2D4AcQOJ4mDpgYhTR7C00Vg3kKZJsisje9nB
         zjq+j9DCcJnvJ6WKJsJAai2qsaENeMFXyNp0tlec77GHn6IRwH7CjKivrCaCeziWwAcF
         zYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g51x3Dke8m4hq5BD7mWP1JIENWwriEm4dzZwpkBeih4=;
        fh=oLd6W1GRhD5H0sYojh0vYn8G5BOGSaelOlESezSz9vk=;
        b=LzaTBaDEOmj8qK6FQ9IPhkq9blmrRqRep4bcYLkfiWEPR4R4eht/6POqU17/LEPT3C
         2WfbInvSsWgoc9gLecooJZBU3l0izKIiTZo+z+9gFs6dLqVoFZNt9Y1QP/8Crdl7Y4Hz
         LdHWPaHwTw6+x1IUtKbExZ+MTS3VBVZ6QnZwKRzKyE4ekAUUq5qiENfmGYEj4Quhihg9
         +YukFrHZQ0lwufPv1XvziJiF2xHk7podCK3+cxN6lgVOe/qfW4nNHbiOj/q6JvjKmYu8
         4O9/HObzj6bPiE4QWEAVv55s18lJrRaLyhUt2isLtcEtpULynfQIW+4tNBOus4yI38OP
         viQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780930963; x=1781535763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g51x3Dke8m4hq5BD7mWP1JIENWwriEm4dzZwpkBeih4=;
        b=SN4g2w+7L37u55NOHnH62hsXGmHRkvICDQ97Qol/4mqxJN6kaeE8TAGexGnPVk+0Sj
         vOwhOYMqgm/ZclL9AVkos/+Rx8n4xUQp6WI17G0GvGaF7oUhQmM6qa4pgZfpehiTajlm
         1SDyEkqnzK56xnyHFwufRSwSX0EjLVEUE9paFJ3tapzaLxxpDd9MLsnbyCvYHXQ8eyRx
         jqeFQF/H5AIlNqAkFEFS+VpK/60tXK9rrfMmWz4xC7aWMinwx328dqWwShlEraX65KC1
         MjGPFslpEltXzdQ+rgN6o+Eovk1f5szk3IXtjEeBQEUbHxqXHqaAtVntDNampvk7JuT5
         Eqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930963; x=1781535763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g51x3Dke8m4hq5BD7mWP1JIENWwriEm4dzZwpkBeih4=;
        b=NNRgG7qmUtciz8eyOcSNjILcpC3OUyjva3FLIS1mLs1IL6efBT397CwLbcUIE/G9sR
         lfbVs95Gs3UJiyk02CvNmgK68nfjjBNNp/ZFEm9fmBbfpOy3zCi9u9wUtiiKdez2OfvS
         MNuDQ0RAS6XbM3pXXAg8hwkzKMIdBO0Gy5MFIyJDlO12FV2HdZ+UIDQPWVIk9R/Atimv
         53nElAXyuBJbx86XrJ5caZ8pg6q7tLLh9QD5fS0U6Bq+msjwZcQiAqxbMbQXhxSaboTu
         MeWZsW+IJpWsCtdwquHyShThfaNh9IS5tx2ZT1WFRNxOw2C/BosNpvAxB9c9LwvEGyxL
         LqHA==
X-Forwarded-Encrypted: i=1; AFNElJ8Kj0PULK5jiYzqBMIdXDle2QnOKnf7x4748p8eDLnUf/GY1leuSjEbVqzkwEip9+l5Vql81XfBvJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKFPgWw65mevLJB2bFtSjU3Xfaqhxmzz4F9PdTd252en/ppvAP
	pSd9FVusolQfpwcBp6n1xIgQD1fsl+p19bHokQD7R8VrjKjX4mytIxsfnzHS7sUn/4n4XrygLuw
	dAYot2BQRE/SxsBjG7idETqW68JCxWDB3oE/0gTMB
X-Gm-Gg: Acq92OFdJ0TjbSf3rb4NeAnfxqql/h8b8a9N8SmietCqbisz+iaJ0rzmRIeG1BpPhGC
	jLexO4XEbTbRK/Vp5wiOSD70NIDoCE+N22x6vtu9iMnV1kTkpAzLtvTPdym/quuBX0sr1nP9/P5
	r8B7tDIBPbvkM5KApgNlO7JIEIwxhK9oHY5WswZljFVN6n3TjJtKmxZmG3RwI+0sNvp92yepTpK
	GrtiBROvAHg/jV+fxIZGRPmpTA4e9O/KJIYyUfjoJB5cnVX7QIJU+FtUklVbkwgFT7zcI5S55If
	cDZwZ12DKIDiKRnaruyaQpc/vJD6psKwUWFPes1CmIVyuv0W
X-Received: by 2002:aa7:d848:0:b0:68f:d41d:ca5d with SMTP id
 4fb4d7f45d1cf-68fe907ab8amr167661a12.11.1780930962621; Mon, 08 Jun 2026
 08:02:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528095235.2491226-1-me@linux.beauty> <vealb52tv5suireenkke4lul2l3wbnaul2rp3ea545ly5wa5ty@yk3aksvp7skt>
In-Reply-To: <vealb52tv5suireenkke4lul2l3wbnaul2rp3ea545ly5wa5ty@yk3aksvp7skt>
From: Jann Horn <jannh@google.com>
Date: Mon, 8 Jun 2026 17:02:06 +0200
X-Gm-Features: AVVi8CcAEOXMmuMTSZ94akkMqWU1PSwZDT3Kns1-hWwyFL18yvP1h0y8fjumjnQ
Message-ID: <CAG48ez38OEE8ZPLyU6nr9=cYx-hMsdoh5WRrv-GMZGMDKyyOTA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
To: Mateusz Guzik <mjguzik@gmail.com>, Christian Brauner <brauner@kernel.org>
Cc: Li Chen <me@linux.beauty>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mjguzik@gmail.com,m:brauner@kernel.org,m:me@linux.beauty,m:kees@kernel.org,m:viro@zeniv.linux.org.uk,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-arch@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:x86@kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jannh@google.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6580-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67E9A65837B

On Thu, May 28, 2026 at 2:55=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> This problem is dear to my heart and I have been pondering it on and off
> for some time now. The entire fork + exec idiom is terrible and needs to
> be retired.

It seems to me like vfork+exec is a decent UAPI building block, on
which you can build nice-looking userspace APIs, though I agree that
this is not an ideal direct interface for application code.

> Additionally there is a known problem where transiently copied file
> descriptors on fork + exec cause a headache in multithreaded programs
> doing something like this in parallel. I only did cursory reading, it
> seems your patchset keeps the same problem in place.

I think we almost have UAPI that would let you avoid this issue?
You can use clone() with CLONE_FILES, then unshare the FD table with
close_range(3, UINT_MAX, CLOSE_RANGE_UNSHARE). That is not currently
implemented to be atomic with stuff that happens on other threads, but
if we changed that, and it doesn't provide a good way to carry some
FDs across, but it feels to me like this could be fixed with a variant
of close_range() that removes O_CLOEXEC FDs except ones listed in an
array.

> There are numerous impactful ways to speed up execs both in terms of
> single-threaded cost and their multicore scalability, most of which
> would be immediately usable by all programs without an opt-in. imo these
> needs to be exhausted before something like a "template" can be
> considered.

(I think probably a large part of this would be stuff that happens in
userspace, like dynamic linking.)

> Per the above, the primary win would stem from *NOT* messing with mm.

As you write below, I think we have that with CLONE_MM? The C function
vfork() is kind of a terrible API because of its returns-twice
behavior, but I think if process cloning with CLONE_VM|CLONE_VFORK was
wrapped by libc in a way similar to clone() (with the child executing
a separate handler function), or if it was used in the implementation
of some higher-level process-spawning API, it would be a perfectly
fine API?

Or am I misunderstanding what you mean by "messing with mm"?

> As in, whatever the interface, it needs to create an "empty" target
> process (for lack of a better term).
>
> In terms of userspace-visible APIs, a clean solution escapes me.

I think we already have relatively good API for this - you can use
clone() to create something that initially shares almost all the state
that a thread would, and then incrementally unshare resources and go
through execve().

