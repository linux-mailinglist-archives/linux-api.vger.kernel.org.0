Return-Path: <linux-api+bounces-6513-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id acw2BklzIGqN3gAAu9opvQ
	(envelope-from <linux-api+bounces-6513-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 20:32:41 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 797C063A944
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 20:32:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=GMezNROI;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6513-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6513-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AB28309179D
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 18:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355B63EC2CD;
	Wed,  3 Jun 2026 18:29:01 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE753AC0FA
	for <linux-api@vger.kernel.org>; Wed,  3 Jun 2026 18:28:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511341; cv=none; b=bvOJWv+G6QPNnNvjH7FF8FdBffA2RgVAf3f76JeWxIMxl7/SMu5Wdavv1x6soKlJppJUKqNPKzgDDaqojDYKgCj82Ara7s1ba8GVsk3EG/vLxZ5iSqNZoj4r2vJkphXDXDMjQmIoM9fzzgBGam/DW2dQO18HRC7TcmQZ1GW2rJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511341; c=relaxed/simple;
	bh=GrDoA4gKT8W5olxXPEI9oGi6uCk0mHf0rlEhckvAfu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajVSyi98XsGVWkSoECX9S+W9QFt/fh0S+NL7eXpeMBGM76FXKjH1O5VIugvQ14wXDvLDjjCCwzmwdzvzL4N9dLqH1DwoiCDscK9i3F5lS3g0//SNLCO4IqA7NWPlLjw9itxiqyhXxnNGBLaz6IpsgprV5s0Kt/h4ov6hknfYLnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GMezNROI; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf237e1433so61432755ad.1
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780511339; x=1781116139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VYe+dW7ZDjb/fodoLbEwUxVzR4phhS+HhNp00MJ/BA=;
        b=GMezNROIFX1uIiIYotmtiB1yX6MaGT7jHa6XdElYfOJeMLmy1b+cS+XYSVIIDXih0Z
         KSOsotlHLmctWpfttFox387XsSeyNb2WeU0Ju3EhY/DExSX59vOI7gi7lSef9Q39nvJ5
         bHx2iWJ1EU18iD5dL6u2+PB1clej5NzXYpg6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780511339; x=1781116139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8VYe+dW7ZDjb/fodoLbEwUxVzR4phhS+HhNp00MJ/BA=;
        b=pL6HAy1t6TeCbWfQgqzsClt7pdFahyQAq7uYRvYuRC5KMKAKFpGdYqGFTcKd66PWuK
         1Q7UipkVTuxWL34/JipCxtlcpcwvXH+2De0jIqw0045vav6LkDIoeDNj/LrpG3wz7+p7
         +2ydF3AdVfGiHkoKmpEKjYSaVqG19sOR/EZboZ3BM47KiCDZ2t5qXjXeH82UKtjwTlq3
         zjH+B4V/Lz04W3hC+uITomgUNj7xCc1xQhajXdSxZgmYKWPWVuiebzmPwcr2voXO4rla
         moun+t2otmDGuBrwTRwGmywwkGJfMRJ1PQnr5fCRiJhrOmULCbKRjKmbrpt4j2llje6T
         bO1g==
X-Forwarded-Encrypted: i=1; AFNElJ/XCoNZ9FhXTljNL4c96PgiEHLLz4McE1kjgu6sJVvpCviPRsll8PWy8SfgLHaA+puMts6yG+T1xko=@vger.kernel.org
X-Gm-Message-State: AOJu0YynYyL1S+MK3iwGcAnoz74rEV2IZ8Rd2Tj62rY+NYt3uWDFmUqp
	163sE3mv8WLTIKW44rsfqKWHlaBTsLwAVMo9laZ3cJlyrREWG37b1Yp7+YH8J7fzExd4rwoZgac
	rYgxgtv3+Nw==
X-Gm-Gg: Acq92OFltG4nxoYhTm0G2QDhxVoz54SkLDn5AmU/2GEE/ECWImktnRKIyRxOMAegTeT
	zRC9sR5OrpwmlaF1VAoJtrupPiudaIJe1hWe0zEijJVQBcosjMqKnJVdm07bEhHoYkE4vOvXoLV
	LdDSMJkTT8tl6fzQ9ar0TIPEIxx9J8N/njmUmsuxTkBDxUROSKAl3PD49XP6oOcez+nZtheeWhg
	bxfEVMn9nG9R+D6jF1GX/b27wdnqwFIYdeU1xUCmAsh2D2rj4/5LQ/VuSTtBrIAYYUVvKQ/xsmq
	bJDIf3J8KVgcVFSsuSUYhEX/pXxAifErnmnWLIsmP2X+glMB/Sghvdhd59ivD/NRDymVnVJw/vU
	Ck8tFi3T+QNT68x3cfRf04R7Jl3R1TEilKrNkvtAFvSgp7rkNzM8tM8RBFjRNXvm3Xt24/F5+G6
	6LQxuvKKT5bE6mwqwSheEs6rjMBWrmsBEx1zipjSy47foX+8NJwQgQDCXXcD1fn8fLYG/ytVr2R
	AyXxkZe25QBBds=
X-Received: by 2002:a17:903:1209:b0:2c0:dd75:e834 with SMTP id d9443c01a7336-2c163a242e3mr45082895ad.5.1780511338992;
        Wed, 03 Jun 2026 11:28:58 -0700 (PDT)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com. [209.85.215.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c166391d53sm44524665ad.65.2026.06.03.11.28.58
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 11:28:58 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c858b392697so2297925a12.3
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 11:28:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8kHNINjPwQBNqZPzu70n54cR+4Xu7NMnOfC3ioJthp6gBvd+OlL6E0boXo/FiOGn7FesuAmMZYIX8=@vger.kernel.org
X-Received: by 2002:a05:6a21:50e:b0:3b4:736b:da61 with SMTP id
 adf61e73a8af0-3b49790c56cmr5052599637.35.1780511337548; Wed, 03 Jun 2026
 11:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com> <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
In-Reply-To: <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 11:28:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
X-Gm-Features: AVHnY4I2wCOVMf6tT9iCpMFfYRmksgwgXPr0UvzSy7WYplz1D2yZ52_F3Jv-p8Q
Message-ID: <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6513-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:luto@amacapital.net,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:from_mime,linux-foundation.org:dkim,amacapital.net:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 797C063A944

On Wed, 3 Jun 2026 at 11:10, Andy Lutomirski <luto@amacapital.net> wrote:
>
> So maybe we should make sure that, if we go down the route of
> disabling all the splice magic, that we leave an API, maybe the
> existing sendfile or maybe something else, that does an optimized copy
> from one fd to another and that is at least capable of sending from a
> file to the network with at most one CPU-side copy.

Why?

That is *LITERALLY* the attack surface - and the complexity - that we
should be removing.

sendfile() was a mistake. It is literally the "file->socket" thing
that has been buggy.

I absolutely refuse to get rid of splice code but keep the buggy sh*t
cases that caused all the problems in the first place.

Because *THAT* would just be completely insane and pointless.

> Even if we=E2=80=99re just doing that, I continue to find it strange that=
 we
> require that a pipe be involved. What=E2=80=99s so special about pipes

Again: it was never splice or the pipe that was the problem. Stop
barking up the wrong tree.

It was "file data to socket" that was the truly horrendous issue.

That said, to explain the pipe: The reason for the pipe is to act as
the kernel-side buffer.

Now, these days we have much more capable iov_iter interfaces than we
used to, and in that sense the "pipe as a buffer" is certainly not the
obvious choice now.

But even then you need to have a *handle* to the buffers for the
general case, and that's what the pipe fd ends up then still
effectively being.

It was also done to avoid the M:N translation problem, because people
wanted to do zero-copy between other things than just "file ->
socket".

But again: we're ABNSOLUTELY NOT keeping that "file -> socket" thing
and getting rid of splice.  That's literally keeping the bath-water
and throwing out the baby.

Splice is the *good* part (well, relatively - splice is bad too).

ile->socket needs to DIE IN A FIRE considering the security problems it has=
 had.

I hope Jakub is right that the problems have been all fixed, and this
is all theoretical, but having seen just *how* many there were, I'm a
bit sceptical.

Because if people think splice is complicated, you haven't looked at
the skb rules. They are completely arbitrary and complex and spread
all over the tree.

               Linus

