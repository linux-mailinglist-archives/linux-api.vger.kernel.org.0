Return-Path: <linux-api+bounces-6542-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id epSUMEvTIWrSPAEAu9opvQ
	(envelope-from <linux-api+bounces-6542-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 21:34:35 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4A2642ED0
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 21:34:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=GR92Uzgv;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6542-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6542-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7637330368A1
	for <lists+linux-api@lfdr.de>; Thu,  4 Jun 2026 19:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE313C2B82;
	Thu,  4 Jun 2026 19:30:52 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F7C3C343A
	for <linux-api@vger.kernel.org>; Thu,  4 Jun 2026 19:30:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601452; cv=none; b=ZVlDPsb+n38K6ixuIoXLYgiik/kFz5QbowHXOFtSx7VVhw8KmCaX0Doir8l/V5TlbPHrjYrywEZIbj9YA96n5STpvcvfmyYS2rXezMpQYy/qrTAPR45eE9Upb4FgNpYVDFCmnzVoEIs9YpsRHvnVTO4F6YdVXwonJXR/tocfnkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601452; c=relaxed/simple;
	bh=d97FFwmE32XoeNnLtg7CNSRYTgucvS3+TBVC4MKcTx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEikVtwotu1jAUn6elb+WszkAFnZ6VGkd2tAs4LIv5+G1hBqIAIjiHMc5i4m6rwPOWAWHkV2NqeFpb7b8Gao3jpj0Kx2PRVgWGoOFuIB1qZwDq2l4mR6MfdgbIJf1pU24TMW8+xQvVxF6WTS7NJWKaNCkhRyODvxTfHk8FGskJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GR92Uzgv; arc=none smtp.client-ip=209.85.208.50
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so1575834a12.2
        for <linux-api@vger.kernel.org>; Thu, 04 Jun 2026 12:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780601449; x=1781206249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/vRjXw0GxoiIE6driNbyJfpHo79+KlSJNRDFpalZAbE=;
        b=GR92UzgvWm1o9Cl1W4lYApCW4kRZdSPI2+je2Plk2a2L6+4wh0c5r6ZTMh/EQR0keY
         O+0fX0hMmKRqFKjQWx9fW3RwXDbfZ3k+ln966CoF8k/d3Ztg8v7MECAUuEp6T2y82Pd8
         mwEx1GaSvieL+CEczWpBGSizZsfQ8mtkKq0tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780601449; x=1781206249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vRjXw0GxoiIE6driNbyJfpHo79+KlSJNRDFpalZAbE=;
        b=P2SnZcCGjn4cCUupA6+jmU0rdqmZ10uZoLxOD6bMImciUqhPQDRYeWascyNftrQywG
         /BCl4gQP6BcyhuHpTB/jNM7ZokpFFUdndq2INXouWVTFGgFGtAvSiCzOa2LMn1FfUQUC
         sAyScAcJQBaACLXS+a7KvpG4mopvu5rm2hEWIMEJ+IGJ2Bfx+1ymEVFhqaYqifLe2LJ5
         +Jdu4fa9CgO80mlKx80TrwjKbKG/WM1rhuhow41iAfVhqPBXyexW3HsSYfLieL46IVa2
         ntrbv1L4oivyL3VgnvzV/VAL+J5uOEK05CJcFiN6CJfjU8DQnI8Qzoy6gzeW7j0JVAzO
         tjow==
X-Forwarded-Encrypted: i=1; AFNElJ9E6ym3T/Us/rBoPlrsy43Sff+fAjc2ruhWgCleYnTRJAvoZgGX1TEs7qqNy1x6Nw0VZh6M/ll4oBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTwp+fv1Q4TvPJlhNeA8VQlHu9n2Fq3pJSH8GJ5duWEurIO0Eo
	CllHj7llrcB3sGJ+41twchNZJWJNpKxVr1Qz7bT3ociTS+0OQe8esk7iwyh0tWBDPf7MclO+tZH
	7SKlMc9gmfA==
X-Gm-Gg: Acq92OEDfRT5GGdPhsDOdQTuob5AubJAfY1ljRK/zJMwGD6B1W+W9nwPNaClEUDumOg
	cK9aDWpIjTNJijnwuT3MvL8tQpc+5ZoQQrAvazYFlLpmmk5gzWO+fSGLalUGyIMSUfyXTchCNlF
	eQsC7h3CTrXriNpsE8fxn6cxcC5O/TG+MQmkcB3W16X5MBIU6gBktSrCs53jqh98IUJXepGPRur
	gCL3ev6AjXGZGl+6uT92epGbJ6vdsYYmhgfxR7ssUXlN003lfrxDFV1MRE6bP7GDZ8JtwOhmxSx
	YPe7EQWpNKA/gQHI1J1QyQrHnq7Kf2Yw27MqJ/coWJSs+s0CmHj8wuYnPpK+8kgaJD4cfK5WgzA
	frj0RwxVfkylK4IrLrx3TuGHhaQZ9V+VR2rBJx2wU3+JzqBf3gfsKKD2N/FK3rnX/YpYp4EXr87
	9LO+a2Zd3GTIyBdue4b749dY0Wk4R2WjnvjqDNFHBeJerDMZzJIP40G6oi/c0/Ze9UB224+zNVK
	3S4fItzELM=
X-Received: by 2002:a17:907:2855:b0:bf0:33f7:b0e8 with SMTP id a640c23a62f3a-bf370a667b7mr3566466b.17.1780601448791;
        Thu, 04 Jun 2026 12:30:48 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051d82a31sm353459766b.19.2026.06.04.12.30.47
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 12:30:47 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bec3ffb95dbso179896066b.0
        for <linux-api@vger.kernel.org>; Thu, 04 Jun 2026 12:30:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+DxBPnBVqGZ5WLFPuiNjhSCdpBQUfXnQicDG0JNPd8eHyjhlWQH5PpD+dNc23NbCsKoaLc9GLcMq8=@vger.kernel.org
X-Received: by 2002:a17:907:3e20:b0:bf3:fe:1d5d with SMTP id
 a640c23a62f3a-bf373306d04mr3098066b.43.1780601447577; Thu, 04 Jun 2026
 12:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
 <20260603211736.755139-1-safinaskar@gmail.com> <20260604100609.6b37f500@pumpkin>
 <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com> <20260604183829.63c35fd9@pumpkin>
In-Reply-To: <20260604183829.63c35fd9@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jun 2026 12:30:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
X-Gm-Features: AVVi8CdPQe90u6Sxnc7w9w1KvqakJpNEvGXvNsTMWUZWIferNC2FIUNZ3K7Amh0
Message-ID: <CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: David Laight <david.laight.linux@gmail.com>
Cc: Askar Safin <safinaskar@gmail.com>, metze@samba.org, akpm@linux-foundation.org, 
	axboe@kernel.dk, brauner@kernel.org, david@kernel.org, dhowells@redhat.com, 
	hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6542-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,samba.org,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:from_mime,linux-foundation.org:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB4A2642ED0

On Thu, 4 Jun 2026 at 10:38, David Laight <david.laight.linux@gmail.com> wrote:
>
> Bool is another matter entirely, (IIRC from a couple of weeks ago)
> gcc will assume that the low 8 bits of the parameter register are
> either 0 or 1 and clang assumes that the low 32 bits are 0 or 1.
> You can't even check with 'if ((u32)bool_param > 1) error()' because
> the compiler 'knows' it can't be false.

Nobody should ever use 'bool' as a system call argument. Anything that
takes a boolean should take a 'flags' field with bits.

But this is basically what a lot of the SYSCALL_DEFINEx() macros are
all about - sorting out ABI assumptions.

For example, on powerpc (iirc - maybe it was 390), a 32-bit argument
is always sign-extended by the ABI, and the compiler *depends* on
that. But at system call boundaries we can't trust that the user side
actually follows the ABI, so SYSCALL_DEFINEx() will actually take a
'unsigned long' and turn it into a 32-bit argument so that things like
this are well-defined and you can't fool the kernel by not following
the ABI rules.

The same would be the case if some system call actually takes bool
(but I don't think such garbage exists). The SYSCALL_DEFINE() macro
magic would take the full register content and *force* it to follow
the ABI conventions, whatever they are on that platform.

              Linus

