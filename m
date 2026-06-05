Return-Path: <linux-api+bounces-6563-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZCp1COADI2rAgQEAu9opvQ
	(envelope-from <linux-api+bounces-6563-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 19:14:08 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0BE64A086
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 19:14:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=Um1Ze3my;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6563-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6563-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21AEF300E023
	for <lists+linux-api@lfdr.de>; Fri,  5 Jun 2026 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A005E386568;
	Fri,  5 Jun 2026 17:12:28 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F15317144
	for <linux-api@vger.kernel.org>; Fri,  5 Jun 2026 17:12:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679548; cv=none; b=DT21DyVgCxLZFhtvdejRZRHoEiIYdZn4Ebla6Kn8dKp7a52NLHlvp5NahTa5rLKyApLUKk7/SmxB+VQNerOwwTx0qy/hplIgZOXocHAXfJ0jYlW7fYh6tkC+Sn63peJaX5h/v5IdC2zkm2TehfNQfTxtzMVeVAhz2/g1nPyGtPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679548; c=relaxed/simple;
	bh=cx8Rkcij++nIhZcQtMX+8UhBOPSebFuHtinR8U8Auj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I68Y+wYqGd3jB2Pav7bzVrks8t2koriBXgGGvtU/RMvtI7WkuxiSqMJcW35Ftg291GWTMlvU4/8DpN7J/o2yHnhTODuKBPlrzHfaY+zhIhwTJUk0p/wS+aZdHWKNVbpf4V+giGNs2jI0rEmWg8jdr0Huww5J9q0a1nnLkEnPX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Um1Ze3my; arc=none smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68cc6c7df99so3149015a12.1
        for <linux-api@vger.kernel.org>; Fri, 05 Jun 2026 10:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780679546; x=1781284346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zbDn0l7MCqGrATagRYR/CBho/Q+7UgNMgo5uDntFVrI=;
        b=Um1Ze3myot5JCz+v/t+Yqy5MGTMZtBdNC6B8JbfXMlQnQlSX2Y1vx2OvzxH3MXyeex
         PNDEv3ZvHTff+MFTRE6OQl/Vug/IhdUrV/Cm6g84do3rmWF0XE/9GyJ3ReVxTjFm1YNP
         cF1aOy6orjZHPx7vwk0Im+MYc6iYLjTcsoR2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679546; x=1781284346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbDn0l7MCqGrATagRYR/CBho/Q+7UgNMgo5uDntFVrI=;
        b=orVISzbtY/QUpcNldpOaSXIomThri0zDhk5ujNby6pD4C0590ETDkFzzKcMKWsRItb
         q+Nw83ZNMuQCPUws8sWwmJFzySTkQVxF3cABt9bu6UE2xSH6cxmXaJwpAkXvHfiMfUbx
         NDlPQrRqsMP7zRYvSFNMtcIyJ3UHyB2m9ry1zaixQ+jTSGrxZDGOYFZHfAJlNlQMU5WR
         eMQPswNhDOVLOoW8aDDwesaU8L3MQhLQO/ysUkkvRBdCewvVDta+LMo/6RVPxsThdESK
         tI2wQ9CiAdP7gipTLMTHSooA0pqnCJGW3YxiEaq+JEkL8Uj/5ui4uc5zcbyAGPkaoDNX
         /gKA==
X-Forwarded-Encrypted: i=1; AFNElJ+LQZMSS2GzUlOc9z+/ZydHXnrqfVvUrbhhFMlSQ6DtfBY79L5423sQ+CEkRvUCHNIj+AYPnH9uFNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmLTQLogMRhqcshcACmsV2ZFMr665wzLV7wanKaWIinDjDkB8H
	fCFM1vcpGX6z/hzVYsgLoaswiW1htmdy5kxv4EVFXFBbs5kkK1reMzEE0eL7fZctslto4smhHOp
	d8QsEpVesUQ==
X-Gm-Gg: Acq92OHQtd8b7PtysFYKiNVycxOiiudOcnjgTq2eWiWj/paRcm7cToVd5dM5Ij85DaX
	E+L34K/3Sbo+lf1Xf79BNCzM42xO0mcRVW/v24FG7O3Ko1x10FaRYUhP5TNIKt5MDo7o+PaF90o
	8jr3ixfApm4WDRJJZTtP2MAZjujRNHyhneXsfST5Z/gJZYZDKboE370I/7DkrDF0sm3/k12Pbaa
	kjt12eFxIKX9cG4IBcQcURdPo6kqYBG5aICLz3+Trtl54hyracImz/BpbMXNSwTeLrASiN3P5M+
	hhB0IzJFv1e9Ad1Q/LdlpoiaqjHXfc5D2NyL2Wm+nw7gqBUv6tBRPS/8wtj5riAms6mSn9Z2thZ
	8RTYSP9rZJEhMQIyeXVY5VewLliQizfNRMsMQeEF0Jbj3R+AYZWrPelO9OE62kNYUUJa0AauIFU
	vVxPmdrOFQHQ2eV6agjXHrC4uvuNP4XI8BBLG/JePAfujBnxJAmUuWdHUKlpOcCHgHSly9hIO2h
	qd9wqhhxUs=
X-Received: by 2002:a05:6402:4505:b0:68b:ba5c:4951 with SMTP id 4fb4d7f45d1cf-68fa5253b67mr2308984a12.23.1780679545738;
        Fri, 05 Jun 2026 10:12:25 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64c2f358sm4117199a12.6.2026.06.05.10.12.23
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 10:12:24 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bec3ffb95dbso354917166b.0
        for <linux-api@vger.kernel.org>; Fri, 05 Jun 2026 10:12:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+u/7A73N67Q9fUdJR4KIuTvAJTov0qKFucoo3ZT2EKKpf/esC3ZVRZKmaBuWfU6DUfVGSh6H2ufFk=@vger.kernel.org
X-Received: by 2002:a17:907:2d92:b0:bf0:59a2:4ccc with SMTP id
 a640c23a62f3a-bf36fd9bc68mr283989066b.3.1780679543586; Fri, 05 Jun 2026
 10:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
 <20260603211736.755139-1-safinaskar@gmail.com> <20260604100609.6b37f500@pumpkin>
 <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
 <20260604183829.63c35fd9@pumpkin> <CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
 <20260604223216.73468830@pumpkin> <CAHk-=wh1Avi8FGbWkt9k0Z-KXWB0spo5mQyowO8PB2sJ3unbkw@mail.gmail.com>
 <87se71jps4.fsf@oldenburg.str.redhat.com> <CAHk-=wjkZSAhxykvG6tQM5DnBoS30_XCKkYpCsQwEGcxJb=i3Q@mail.gmail.com>
 <87wlwdhrvr.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87wlwdhrvr.fsf@oldenburg.str.redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jun 2026 10:12:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTQr4YYYUH38srGvWAq3_UpDeAPR+qZWVyf-ZU7z8Hzw@mail.gmail.com>
X-Gm-Features: AVVi8CckZsnJXSGEqzilnfJFExIfoQ08Dq0LHvA2PxDFlkolpXQtrHtyU3UQHDE
Message-ID: <CAHk-=wiTQr4YYYUH38srGvWAq3_UpDeAPR+qZWVyf-ZU7z8Hzw@mail.gmail.com>
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Florian Weimer <fweimer@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, Askar Safin <safinaskar@gmail.com>, metze@samba.org, 
	akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6563-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:fweimer@redhat.com,m:david.laight.linux@gmail.com,m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,samba.org,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux-foundation.org:from_mime,linux-foundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE0BE64A086

On Fri, 5 Jun 2026 at 09:30, Florian Weimer <fweimer@redhat.com> wrote:
>
> > Uhhuh. But that is only specific to 'bool', right?
>
> Also char and short.

That sounds like a complete ABI violation as far as I can tell.

Scary. Because I would not be surprised if we have code that assumes otherwise.

Now, the kernel *seldom* uses char/short types, and since compilers
are typically at least self-consistent in those cases and we don't
interact directly with untrusted sources.

The system call interface is special, but we wrap that for other
reasons so deeply these days that we'd not be impacted.

But we also do have various assembler code, and I certainly wasn't
aware that apparently compilers have been walking away from the old
ABI rules.

I did find assembler code that clearly uses just 8-bit register
accesses and function calls, but it was all _entirely_ within
assembler. The low-level debug printing in

    arch/x86/kernel/relocate_kernel_64.S

puts the character values in %al and then calls pr_char_8250() or
pr_char_8250_mmio32() with it, but that is *all* in asm code.

I didn't find anything obvious that calls C code with that kind of
argument though (which makes sense - we typically call the other way:
C code calling into asm code, not the other way around).

So at a guess we're fine, but it's still somewhat unsettling.

And maybe others were aware of this, and it's just me that has old
32-bit x86 code in mind.

              Linus

