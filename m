Return-Path: <linux-api+bounces-6557-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xSC3JSf0ImrMfgEAu9opvQ
	(envelope-from <linux-api+bounces-6557-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 18:07:03 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DD364998B
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 18:07:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=NDV8lzCh;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6557-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6557-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A823A30D3543
	for <lists+linux-api@lfdr.de>; Fri,  5 Jun 2026 15:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E94B3E3D86;
	Fri,  5 Jun 2026 15:54:33 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A153E9C0B
	for <linux-api@vger.kernel.org>; Fri,  5 Jun 2026 15:54:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674872; cv=none; b=uzp7AV63B1Trz3e7EnRAKuvPiYMXILpTQMZZKwgpflSr9m9Knzr09UGAC3YyxkX1CVbdjF04V0Nff18pV69h6fsQqS0khJ1YME92ro/RAO47I8MqfGcG1PkQDrqX57DomFuvuRrlVkTtf0bF+VgIw4+Vgm6270FGJLqXPY1O6Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674872; c=relaxed/simple;
	bh=Fj3s5frbyB6TsqrxQjPY0GZVgFWhmiPiWsC9BqFUZ+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VK4upyzKEkkv1gR5Gsq4xZwgIKuOCdS4cNO/lpfL2fJcpcNjhUYWRSdQhms/ADQcZQXAjrMDX7SkPfrskFMcsX58HVrDE14Ddrf+6xn8qU1YHkEUPN0q4KZb0kXO+XUrrA1GVbmPsy2pPCJf9rVb8JmLb98zEIdEcOf1RK/XqYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NDV8lzCh; arc=none smtp.client-ip=209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68cc6c7df99so3013131a12.1
        for <linux-api@vger.kernel.org>; Fri, 05 Jun 2026 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780674866; x=1781279666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1hPSWEkREGIx4yoYWkytVFmLCkNUDGfpLW+35vC71FY=;
        b=NDV8lzChw4oKMyXkX9t5IqYYUJVCOTbJRWXrdeoBqfCJ9UZQyjtjuJtu9fzIq2hekM
         ljZQVDEd7BscYS+U2Wmt5ID50BZgMNpKiouciRCfcgMIaAnQ3+XVDDTzpIBlUXWpFBHc
         ECPsyTNrrD1IGyNRZsshdS1n9hzOF+PQcH4Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780674866; x=1781279666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hPSWEkREGIx4yoYWkytVFmLCkNUDGfpLW+35vC71FY=;
        b=pScrg1sojqQFD31f80fVbgRKyzjq8gdOX0pP16wUx0k97bG/pwrDVEyyx6MQMg443g
         NRAoTLUucteHW8ZSCp9i+TGUV7hLKYsFtoDSfL42MFKrnXF2hMWBqG+yLX3xDRy8gwWt
         N4momkwp0wEB3J2CWkErOKmBYYMifbT+I0M/s3k04qGZS938k6bd4gsQVv1jWx4g/GcH
         1N4PJB6o/a6wsLaLysJM23N5ZVGpLYslLw8NRSs6Q0WaHpWpeR/VBVO1+zKknKuc2RaD
         hnYmguSTUauKm/AeZK36lXPl0k07CdTcC0hx0ARFxmzJy6cZZwLuQoqJKFJySGloIB/f
         qseA==
X-Forwarded-Encrypted: i=1; AFNElJ+jPbVGpcXeHJLiDLpa7oO8GuiOWEVRe0Chx3dlFH+suzUzTLEdX+BFVcD0WJOt6NhgFkhkGBVLQy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL/r7uYuN9cAeWZ/2fFYtKHak6J7NLbHC2VPh9dmIvZxPHRdGW
	JtEf/0pkAheY6gNOeuHziuKetD51UIQ0qO803uxIua6djJg/PQpx4UuFxsoUbapJ00g7sq8yo3j
	+JBHPbITpXA==
X-Gm-Gg: Acq92OE1+ZcJyH845kqevap6RaZi1rOqKz9z6vURiIknNvho0aC3Idl7UOH8QX4MkxU
	hQrTqjArBeKLNPUeCr9FurPVpQLJCvA+xErRP/K6AA9607Cp4Jz8PAxbynpoFGMFfE/QsXVR1TG
	vsZ9e4wy40Lv8Y4Z68nsOSOK7t3sP8NUoVx3HmItaFFYBeB6Pz0rUHjz2+yascQsq5mMVSQ1Zru
	1zPZDZwDFnsh7Tc0LsPRGeF4RFklC52cQnqgX1ZtztAn3qdFcnimHHVpBl/kBPupw+JSP8FE6LK
	v6JJ3YJMqwySWIQAl0te5zuyppODZUVVvLeFnHejSlzoUzpqeNkgCsbvT4gID92w7eZKVzfX1tJ
	DbuyBLNLeBylMLKzYxQEYMy+jtVTzNo+WZLUU65czoTXlSkjMM1f0yWp/8Rezj6gO/IqB5edMDs
	Bcx7BNEmMe2QjryPy/oz1ZaWfwRlJ/WsffupbJkvxPvzwPs7PK0UbHFGOftvSb/7j4engT22BeP
	Cl/DRNdyQc=
X-Received: by 2002:a17:907:74a:b0:bde:a3cf:d268 with SMTP id a640c23a62f3a-bf370477d94mr241654266b.13.1780674866249;
        Fri, 05 Jun 2026 08:54:26 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf052097992sm500774566b.26.2026.06.05.08.54.25
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 08:54:25 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bebc80100efso232159866b.1
        for <linux-api@vger.kernel.org>; Fri, 05 Jun 2026 08:54:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9abfFX2vRHGn/UJCJpBryucR1LEY8Da4H/+HXC9yDnN7YCqWRUMShCkcJ3EGNyNTjve0/qoY8WxcU=@vger.kernel.org
X-Received: by 2002:a17:907:741:b0:bef:d760:93ea with SMTP id
 a640c23a62f3a-bf37234c965mr227182666b.30.1780674864895; Fri, 05 Jun 2026
 08:54:24 -0700 (PDT)
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
 <87se71jps4.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87se71jps4.fsf@oldenburg.str.redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jun 2026 08:54:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkZSAhxykvG6tQM5DnBoS30_XCKkYpCsQwEGcxJb=i3Q@mail.gmail.com>
X-Gm-Features: AVVi8CdvqDsmiM-EYrTUflKR5aYKg4JuQO6h_hoIzVtXJtUhEM3tfPOlti75Shw
Message-ID: <CAHk-=wjkZSAhxykvG6tQM5DnBoS30_XCKkYpCsQwEGcxJb=i3Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6557-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux-foundation.org:from_mime,linux-foundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08DD364998B

On Fri, 5 Jun 2026 at 02:33, Florian Weimer <fweimer@redhat.com> wrote:
>
> * Linus Torvalds:
>
> > x86 really doesn't *care*. If the caller zero-extends or leaves high
> > bits set randomly, according to the x86 ABI that's perfectly fine: the
> > callee will only care about the low 32 bits. So the high bits are
> > simply not relevant for the ABI.
>
> Please note that Clang does not implement the x86-64 ABI and requires
> zero extension.  We see increasing problems from that, now that we have
> more C code calling Rust code.

Uhhuh. But that is only specific to 'bool', right?

If it were to have the same issue that powerpc(*) had - that 'unsigned
int' has to be passed to functions with well-defined high bits - that
would be bad.

And I'm pretty sure that clang doesn't do that.

Anyway, for the kernel, this shouldn't be an issue simply because we
typically avoid 'bool' in arguments or structures that are exposed to
outside.

(I say 'typically' because I'm sure it happens in some broken UAPI
thing anyway).

                  Linus

(*) I may mis-remember. Maybe it was s390, not powerpc. The s390
compat layer independently had a similar issue wrt pointers, where bit
31 had to be cleared. s390 dropped the 31-bit code entirely fairly
recently, but it caused some "interesting" code in the already
disgusting syscall argument handling wrapper macros.

