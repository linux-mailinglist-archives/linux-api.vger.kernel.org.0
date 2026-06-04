Return-Path: <linux-api+bounces-6544-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3UPvJ7nxIWogQwEAu9opvQ
	(envelope-from <linux-api+bounces-6544-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 23:44:25 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FD9643A9C
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 23:44:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=cGCqekVw;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6544-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6544-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F2F3306F606
	for <lists+linux-api@lfdr.de>; Thu,  4 Jun 2026 21:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5664DC520;
	Thu,  4 Jun 2026 21:43:13 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21833C343B
	for <linux-api@vger.kernel.org>; Thu,  4 Jun 2026 21:43:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609393; cv=none; b=u0BdJQnJ2ZeSBPCo446/JY97NZdmc4mK0xCNF69txNqZUG7EGG5gBt9xznmGKqab5g41dUm7bXLR9bH6Ewf7d/mI58GJnD1UxObwpr0DYV/Dl6g9E0zg6hGrWBA6r5UWyiid74ipQEpsT7rH5rDO1LufSTxeTpgK97Xp93MmQyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609393; c=relaxed/simple;
	bh=ZWDSpacEFEQZGnIVBEbJF0VYYuNfWke7vLWrwwZT/Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioOiKXiDDwzbc37jD9oAT/hPt8mS5jaAKy+22Cbd8WyMxk8ka6/uJR6+rpVV7Oq6BowvahM13BlVnZiH2pAmAVtcBmieHOt6j/C6Xxz34mRUsjoEa9C9yneNeVesIKKreIEEbRw5suMrUozqyrpBvvMAewnT3Zw5HHIq75KqYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cGCqekVw; arc=none smtp.client-ip=209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bf0170c80f7so221289866b.3
        for <linux-api@vger.kernel.org>; Thu, 04 Jun 2026 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780609390; x=1781214190; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C0rKRLQ7b0xQkDszK4kB86a8NKDdPGLBrBut9iuJxEs=;
        b=cGCqekVw78n5ZIPveO7LHJDqnrEPR21SeuXk7KlfXlBcUevB3eBj0OssT0LUPi0Ds1
         55s4r5GenpFBZnFRQYHrbhjdNcdlOKk3RVxjAXL4/1D7Vrntz4bvQi0Faai493uAlY2J
         5NvMqC/du8RbPgU6taIIAZbty6L4rCVStvKeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780609390; x=1781214190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0rKRLQ7b0xQkDszK4kB86a8NKDdPGLBrBut9iuJxEs=;
        b=LPXpBLKUXvU0vO3mS/sxRHzaaSsVLPqtn2tf3B9oDVIBaNaj4wc2j4Dlm7kOAKYsn0
         2AsAjBD6w+jY3XIvPtpESM8Pq8J2ejqINXuVBqVwErV5q5X2xqGupBoZxJXq47He1iOz
         08qucMxp+vgfD1pkjLi+3LE5fIAI2Fs0AnUReI8IM8Ik+T431PT9NXEJvWDajOxG6GMT
         Z+fVELAcUiryQ1oE+8zH0Qx5fNc7x2+bn6JiGv8fmfy7ldzwvup0lS6veTeJ4FwvamRY
         k5yMePhlYryAD1ITtULonMBjd1hyyB4xNiSqoFdb8ACDSzXe0/qMlznFJV4zkx3kiOIJ
         7PoA==
X-Forwarded-Encrypted: i=1; AFNElJ8eInls7Z+C2ZIXSpMcYSjUgr7mMiN/Nkf7JZW8izvA5DrxklyLcqA/OpcOj5XlMJ4+3irFz13vDI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMlqSk1ScsqqVr/g8JlUiZ4ClXeq0CviMI+nlLc6Kd7/fVZMjB
	RYtbInIif0z+1f0d0GXrnwjjqTc8OZp8T83084SEtN1ZsrxpNTYLfqh9EV8idqru0KHZ2SIIKu4
	yuRQKPE1cIg==
X-Gm-Gg: Acq92OGN9s9d/2JkO6W7WTZ2003hX87aaKxewWxMb9VtQy1+fU+ra43hYMdNIU2HT9p
	GajGC4cbBj6UTiE0LJr3EU6iFm+4EYvWf7SWFVXKiQoLwaNIM4k3hGTCcLjFD8CWCR7ghHLRmBQ
	HmLyeH8yaOsp9UsrCT30ddFYKNDTMhCBmdyI9dLiyLw3PbuTGlfRTxv9Q4BFulaLwrMXOWxTje/
	NQ5w95ijKA26agJeYL1s+VJ8EYz4ch0V1TEr5MH0I2/CVjPxGYDy0h8klGquOJXb7lmr2j/Ytap
	I48VE3vONRtykzuIv03VYPCuwWlVf0jN+hXzXxdrI7QhhCdPS0IUrkxaoORizweMtT4dKVcgcDv
	w0rxMCSahrqq7aWtwQD1cAA9LEs/ETwaxYz7sfajWrzTHUXKwYemfVoUkK07/nnnz2xoVT8jWc8
	G8HoCv8R4HT7MN79Z4TYE5qaZd17lNmv+Ima95kkJnWMBmK0nocb5bDXBcROgHyrHKVxS/xdkSB
	r34WuZIObE=
X-Received: by 2002:a17:907:3f14:b0:bed:a7d7:82c8 with SMTP id a640c23a62f3a-bf3737eebd6mr21900566b.37.1780609389940;
        Thu, 04 Jun 2026 14:43:09 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559f1ac0sm353454866b.62.2026.06.04.14.43.08
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 14:43:09 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bf1141c26ecso179340866b.0
        for <linux-api@vger.kernel.org>; Thu, 04 Jun 2026 14:43:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9mHtw40jqG0qyyl+ReNFP1clk7ZCmtdK2BegiGgWw7DMVYrYnF6p4/A377wEfcaTNKxfeSdC4r2EQ=@vger.kernel.org
X-Received: by 2002:a17:907:a03:b0:be2:dd37:facd with SMTP id
 a640c23a62f3a-bf370e6211cmr21551966b.20.1780609388179; Thu, 04 Jun 2026
 14:43:08 -0700 (PDT)
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
 <20260604223216.73468830@pumpkin>
In-Reply-To: <20260604223216.73468830@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jun 2026 14:42:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1Avi8FGbWkt9k0Z-KXWB0spo5mQyowO8PB2sJ3unbkw@mail.gmail.com>
X-Gm-Features: AVVi8CfSQTIVkCCY1e0qHuDIqCVA2aM8un_0a9-AOfB95snGVQXFlgTgq5lonE8
Message-ID: <CAHk-=wh1Avi8FGbWkt9k0Z-KXWB0spo5mQyowO8PB2sJ3unbkw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6544-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14FD9643A9C

On Thu, 4 Jun 2026 at 14:32, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think riscv might sign extend 32bit values in 64bit registers.
> x86 and arm both zero extend.

That's different.

x86 really doesn't *care*. If the caller zero-extends or leaves high
bits set randomly, according to the x86 ABI that's perfectly fine: the
callee will only care about the low 32 bits. So the high bits are
simply not relevant for the ABI.

The Powerpc ABI makes the the sign extension part of the calling conventions.

So if a caller doesn't sign extend a 32-bit value, the result is
random behavior - if you pass some function an 'int' argument, the
function may end up looking at bit 63 to see if it's negative (except
IBM calls it "bit 0" because they have to be different from everybody
else)

            Linus

