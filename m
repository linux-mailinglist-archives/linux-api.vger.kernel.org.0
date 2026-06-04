Return-Path: <linux-api+bounces-6541-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hhvsFta6IWrmMgEAu9opvQ
	(envelope-from <linux-api+bounces-6541-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 19:50:14 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4E464267E
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 19:50:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jhkiLgO0;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6541-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6541-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8023130118E9
	for <lists+linux-api@lfdr.de>; Thu,  4 Jun 2026 17:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D394C6F0C;
	Thu,  4 Jun 2026 17:38:34 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19E4949EC
	for <linux-api@vger.kernel.org>; Thu,  4 Jun 2026 17:38:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594714; cv=none; b=I3hD/K7zFz5DA+7i2QdWecWV+ZzKHmdPxyHIGIJ8Ilnts5T3fsZVSugPnlMovYEYUl3WXVRoZ9Sg/Wxk9gfBwq7bdHe8ixpON6nwtau8Qw1MTSx7eUFHyI9E0sUm8IBvuVSkWYCgIPorQZFj+f36I4b7bderFenN09ekkEbFP20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594714; c=relaxed/simple;
	bh=v2KH0A+T/5unV0mAelk5zB+47zjGgz9MT7jM30vb1s0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWU9M70b7mEQBDT4xPiK/iHzHOdvscj+B9mYzLimHbWff5jxj1t7DMr6JrQTiTfoOFB1cAw2p65feNSdwn2etpCoW66rlqGC+HI4ibFmC3vQXJ5u9rE/gdz+xH+RH2Ua/2hiXoZNsYHmbbNVRfwuic5K6O/7JNy1xK5gdmfkg4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhkiLgO0; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490c1915793so354985e9.2
        for <linux-api@vger.kernel.org>; Thu, 04 Jun 2026 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780594711; x=1781199511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDxRgk4KLva6cv7jp07s/JuZGm0Suw+6/YbYX6FRPfQ=;
        b=jhkiLgO02xJY3jbGkLqf6yEze1IG/Ox2jCJZ1yITJxLGtM9U5+0C/k10tCut54S7kg
         CsAVN3snOFl9+cvyUyIBHJ8hDzhqYT3BOWKrygE95ThTXkwdNctJq9RjXSbVzN30eJ8o
         dHEB170KdTBrrqCpS1ehtBEXFNsGBvlFKB9RF6iU07j1Rwv/wvmygCq2COzvErF/p5Br
         mx6Sqt3WLy3dfZ7T61M+uMici202aefJ8L8GLQtOJHoTBem3cAWNWIvlDRwmKtlFP+2A
         0U5Zfi75t3LFjnLBh0BeDqWKOygVVWoQo8UGHWy6rg7/oXkTm2E+QN5eJqrjJ0Ep58Nl
         39WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780594711; x=1781199511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aDxRgk4KLva6cv7jp07s/JuZGm0Suw+6/YbYX6FRPfQ=;
        b=mnNTsLWsgWH0GQrMRCtwam/ktsLkKd7tCVsOrAeNZdnFYKyB7S9abkO/pq8sl9c7aL
         aqmqvjvAu+eW6qT97+GBbeqdQL+ONymr+Fdfwf7TIoKBMRpzNBhIiggg1YikkzJCpxgX
         qO1vUAmBY8O8VyaVPOUecGC9fDrC9SKzPu5s8miVB1l+fvPvC2M0WjOBQAqwzXTecgSv
         Jb2CMpa/DZ6E5ZILlpQPOriiz2Y/PmCYEsS/VxS2VSIin3i0O/Xd4dPi5pl0LJevIrAo
         81ZLoQ7XZTmTc1Vc+4r+7JKnMjAGwJyq6ssv8mmfujlkSNQCeGXJ08ucjrW8iO/ScaTn
         DAIA==
X-Forwarded-Encrypted: i=1; AFNElJ9SKhYW1cvOaKvUlJ1Qj+hAT9TkdiYPT6NOi8Ue+GQIgOYcnKm3v3UpArxHDb1h15cR/NKLO8Mun0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA/FuycedXPhq8JMekF2LrByQFYL3H5laOBnJ3tIa+cqvoaYyW
	8gCIE8YxetPHggBIyUD9P0cZNhyMDzq0izwrwCByuJJoFZ8ydut/jXA7
X-Gm-Gg: Acq92OHyjM+qtkobPDy0AdM29QcnF6BG1bsCKqucL4RJkCNzjYvlpcEkzQ2k5/qtm6B
	dTeB//ihAhVzGq4MPFymtBNNNrOW/yu4YGenGHKS1VqjGmzRpdodcvelw0sv/AI2YJe4ckkL2pN
	z7qKgyuH1Sal982q6hj4h7tseb6wMaJFP0AM5sf7M2cK64xlPGnyu92WFHL/qKIIj/29FFmTwot
	ToFS4f6UJIIwHF2fcxC/VZElNqtVcVWnWn5AFiJUEUtAe6qykTQ/M6pzMnZsoRWbE+WKK3Du9vp
	K7/MYdgVGOcc9XDEt9yTRJ/clDVJ3o237vWqIpaO2AMX9M6V03oD+rL6DaYyD0Uaj0dz3OlnOON
	JZrobSWGDBxeF9XGhJ1ixlTroxGJHVdMN6NtOnnwZydGhTTC0hA6hjDVH0CccT47KoGhpQ4nyB8
	1pKltr6BX7QGAtPU59T+GJrytw/j5d/xjFzZXUp4eBjRw7QiJHxKDv7yfHqV2OcI7ioBlXGeI=
X-Received: by 2002:a05:600c:1c13:b0:490:b642:ce29 with SMTP id 5b1f17b1804b1-490b642cea1mr153777325e9.8.1780594710934;
        Thu, 04 Jun 2026 10:38:30 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm105657875e9.9.2026.06.04.10.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:38:30 -0700 (PDT)
Date: Thu, 4 Jun 2026 18:38:29 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Askar Safin <safinaskar@gmail.com>, metze@samba.org,
 akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
 david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu,
 netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de,
 viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260604183829.63c35fd9@pumpkin>
In-Reply-To: <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
	<20260603211736.755139-1-safinaskar@gmail.com>
	<20260604100609.6b37f500@pumpkin>
	<CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6541-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,samba.org,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pumpkin:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B4E464267E

On Thu, 4 Jun 2026 07:17:10 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 4 Jun 2026 at 02:06, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > Something needs to ensure that the high 32bits of the fd get masked off
> > on 64bit systems.  
> 
> That something already exists: CLASS(fd, f)(fd);
> 
> It ignores the top bits, because 'fdget()' takes an 'unsigned int'.
> 
> We have been a bit random in how we declare the system calls in
> general, and we mix 'unsigned int' and 'int' and 'unsigned long'
> pretty much randomly when it comes to file descriptor arguments to
> system calls.
> 
> fs/read_write.c in particular uses all three cases with no real logic to it all:
> 
>   SYSCALL_DEFINE3(lseek, unsigned int, fd, ..
>   SYSCALL_DEFINE3(readv, unsigned long, fd, ..
>   SYSCALL_DEFINE4(sendfile, int, out_fd, ..
> 
> but then anything that uses fdget() (through one of the helper classes
> or not) will simply not care.
> 
> Does it make sense? Is it pretty? Nope. Does it matter? Also nope.

I know it has mattered elsewhere, and is easy to get wrong because
'mostly it works'.

At least u32/u64 is reasonably sane - the called function has to ignore
the high bits (at least on x86).

Bool is another matter entirely, (IIRC from a couple of weeks ago)
gcc will assume that the low 8 bits of the parameter register are
either 0 or 1 and clang assumes that the low 32 bits are 0 or 1.
You can't even check with 'if ((u32)bool_param > 1) error()' because
the compiler 'knows' it can't be false.
It all dumps you down one of the UB 'rabbit holes'.

-- David

> 
>                   Linus


