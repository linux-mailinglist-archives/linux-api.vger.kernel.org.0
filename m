Return-Path: <linux-api+bounces-6562-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s7DEKHP+ImrwgAEAu9opvQ
	(envelope-from <linux-api+bounces-6562-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 18:50:59 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D18649F08
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 18:50:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=DwNK8ZMR;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6562-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6562-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7871C305C5B8
	for <lists+linux-api@lfdr.de>; Fri,  5 Jun 2026 16:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952A432A3F3;
	Fri,  5 Jun 2026 16:34:05 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B30309EEC
	for <linux-api@vger.kernel.org>; Fri,  5 Jun 2026 16:34:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677245; cv=none; b=Fj8VtrLkZ0lJn263zTNPWmkE5jxfVFrrvo1pOoLXjyZ+wOrppUkjmgyGJyI2bEcizbYcATspvb6kVDJc588CsPwUx8aRxipfnPCvwnLCU+31qby+HvgNxV2+e2tfUPWC0Elf4GSgfivKqyUSNg5xVoat3yLwoNaZnyHIDDB8xlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677245; c=relaxed/simple;
	bh=xhA0BnyaS18CqnQuFNEb6UVKH5NtNpGJdPqoi2RFSA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhzPde7Zn/X+SgcEeRs1zGCDZrlVyVuc4EyEYkPKS/HsiEHtpN5VhSj9JMf+2P9Z62n/cTc9uhHxDggpNpWoXkp1St6d+fU4FfJypI2cVRCANyqiEk6yj0hqZjFm31E6JahYcIUMDpi5OMLu3Nvhznc4xK2VywqIRSUFe4CPKVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DwNK8ZMR; arc=none smtp.client-ip=209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bebde89cfd3so256386066b.2
        for <linux-api@vger.kernel.org>; Fri, 05 Jun 2026 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780677242; x=1781282042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2QDQNJjYqwPm+P0wBS/rB5uazpPW4+3idJB2lp6tmqM=;
        b=DwNK8ZMRGdzZRV/SR9zODSRP7dgcOd7WIB9wCtKjlggBlbQs2SoWz0odv51vw+lrXW
         v21hzFvS0C6Y47sHp6HvsK7Lvscuia8wYqMHsu7v8PoBz6sa53otBJj/a0sMjwSwkS7F
         Gg5aYj4rSYP5bmD48ESbIflRmcB833ZnDInsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677242; x=1781282042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QDQNJjYqwPm+P0wBS/rB5uazpPW4+3idJB2lp6tmqM=;
        b=g4sjTu5zRq0h+LJDv0Ls6sTXIcsSRDQbehc5IW8HmXBUblCJ1s/p/qh9M9cSmL/k4L
         qKr2ZY8taoYl9+xfHDk5yB3xNqtl94MCl1dbutHjaqOVPOZ336DfWnvUKyEQKM78Kbze
         3xBUj3mXckBKfjFlhBlLdxMzQaKVEzqprxMpRO+uiFJfXBGUYNFAX5Dr+VSdsfRaA7RA
         QW0CjMU769zDHUYZHcjg4GZLKwFGY40Y+6PLhNBD/kAYzszFrbCdqw67Gl4N/keWJiq6
         aSupF7du9XeHpqn5Ces3jEbamrS5zOfSucELXBPahl+8NwwHMxdAu69Exh50M4fzCcnj
         8J0w==
X-Forwarded-Encrypted: i=1; AFNElJ/LieqZUI4Y4cESPCIIt5fUcJQnSmrZlNPMTN0LRbp07VZmzXSN1Deqmgh8XLW1j2iBPFECdOxFcSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy19jtRtxj52vjGwURWpR6RVlpseR3VcpnZ3aBXI+bS1XuJA0tL
	ppD3K+ScLuzqePy1t+Wb/HgRP7kRj2ExB1CHZ4HMaGxC3ok0q6grMdj/7uqlX/7UWUdzmoLMpNg
	diaqUDGaSSw==
X-Gm-Gg: Acq92OFIg+u2qUVjGs2A7fJ4skH6hM6G/RBjwPBceAm6sgZ4NZ/lrC1PTU9S+34qhQi
	SpjV4DRmD3QQwK+rvWSh4oieF98FCZopk8i1yRN7DxgFhncajnFDVfnOGYNi0WxAjE5odiHW6MM
	Xn2h/tgXnG80uXjlwDymHuqDocUMGbs8hgXuDqjeiZuquMdUxLKfegPz9QMT+9qNjBcDl+9ecgG
	1sA0DCqT4YknFGGMHemOizlcWuR1ttf9zFtX/CSJ82yts06Y/6OING/Yrp3esVKcJU1NOzoZbp1
	KUO+5OK3NEqzcjnWh85Fa7MbjTbdJzPRTMEGFAE6DXOT96d+lT/4kZYP8heceIoXR0XIiuKlNN8
	sSTjXjtRsXZkDr4bXVPRhlxQAPjLdsV8Yzddg8mAvFZ4Lod4WeoEn1UEXpCuit9iv+cBILqOO1g
	VuFLJFNKELkw+wbX9bltv/HSzPzB7txSEE13dijlhQqWReVbcIinS1l/RMgZDkdqR8qcoF1e6eU
	/1n8IQSAx0=
X-Received: by 2002:a17:907:b582:b0:bed:4938:94dd with SMTP id a640c23a62f3a-bf372f20bcdmr165811666b.41.1780677242132;
        Fri, 05 Jun 2026 09:34:02 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055309368sm473456366b.49.2026.06.05.09.34.01
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 09:34:01 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68e5f7c1131so3931015a12.2
        for <linux-api@vger.kernel.org>; Fri, 05 Jun 2026 09:34:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9hoVF7YDAh0Y/WzrnCT7lrnE2rkNB+ayEcTn52GiN52gAmaVVSDGVpR3rnqqWljnK0rL7XNMQdPks=@vger.kernel.org
X-Received: by 2002:a17:906:4fca:b0:bec:5264:ee9b with SMTP id
 a640c23a62f3a-bf372c2dbabmr257257066b.36.1780676845718; Fri, 05 Jun 2026
 09:27:25 -0700 (PDT)
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
In-Reply-To: <CAHk-=wjkZSAhxykvG6tQM5DnBoS30_XCKkYpCsQwEGcxJb=i3Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jun 2026 09:27:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMTq8_2rpYoZgoxVCwj=LsvfzHzPuwo-NcizT7J24MPQ@mail.gmail.com>
X-Gm-Features: AVVi8CcJjF0IzkUXs5jB8j5aKjJm1d1LQ0EBlpf4RydnYVXz3zkkVCs-hralHh4
Message-ID: <CAHk-=whMTq8_2rpYoZgoxVCwj=LsvfzHzPuwo-NcizT7J24MPQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6562-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:dkim,linux-foundation.org:from_mime,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08D18649F08

On Fri, 5 Jun 2026 at 08:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If it were to have the same issue that powerpc(*) had - that 'unsigned
> int' has to be passed to functions with well-defined high bits - that
> would be bad.
>
> And I'm pretty sure that clang doesn't do that.

It's perhaps worth nothing *why* it's horribly bad and why I think the
powerpc ABI is nasty: it means that *some* things are done in 32 bits,
but other things then expect the upper bits to always match.

It caused security issues, where user space would (for example) pass
in a 'int fd' what was value in the low bits, and then had interesting
upper bits.

The range check in the kernel would then compare fd to max_fds - using
a 32-bit unsigned compare - and see that it is all in range.

Then it would use the *exact same fd variable* to index into the fd
array, but the compiler would use the full 64-bit value for that array
dereference - without having ever checked those upper bits. And it had
passed the unmodified full 64-bit value around the whole time, all the
way from untrusted user space, and the kernel code all looked
"obviously correct" and had all the proper checks in place.

If you want to bleed out of your eyes, take a look at the rather
horrendous macros in <linux/syscalls.h> (and the sometimes even more
horrendous arch 'syscall_wrappers.h' files).

They deal with issues like this - and others - with some truly
inscrutable code. You have to be super-human to be able to read it,
but those wrappers are why we can then just do things like

   SYSCALL_DEFINE2(setregid, gid_t, rgid, gid_t, egid)

and it will generate not only infrastructure for tracing etc, but also
the code necessary to force clean up the types for the architecture.

                    Linus

