Return-Path: <linux-api+bounces-6525-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lIyXH42wIGrd6gAAu9opvQ
	(envelope-from <linux-api+bounces-6525-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 00:54:05 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DEC63BAD4
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 00:54:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=dE+umDdb;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6525-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6525-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B8DE3016820
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 22:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B53E3C48;
	Wed,  3 Jun 2026 22:53:59 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B07F3E2ABB
	for <linux-api@vger.kernel.org>; Wed,  3 Jun 2026 22:53:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527239; cv=none; b=SRXBNA/ajUR5OEWvDIaJVNt1JiY1qV5deP2SMn+vO0xtwzS7sVrwgjVF1liElSY4YCcXxJA9gN5tm6M/A3VR3+URdeuEqs4Xgbzl7J4MaGOa2K98aWU6JRvDl2WDB9DmK+9OQFVWCsZcgeYNb+mAux0yKhMASRMzzBsfVEym8MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527239; c=relaxed/simple;
	bh=R/zZG4ZyrvWUzuSIU5eJSLX1T5t0EJujPTyy2snq0VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d419+k1r6mc37ErMkudatDPN+sOZyyapYApkeGHJLRmxBH9DizcRiiDsuL+4keUylGC63PRp/W5XcE2gLlWA9FiIIEhR/U4IwEsfxWx9nQNeHVDnBmRe+3e15HO4U2L0gUrekom6pq7w4WOhaeAUEbe8hRTVpR+jX6yW7326Js0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dE+umDdb; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0bd02d97eso844105ad.2
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 15:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780527236; x=1781132036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d66PsLO70IOujHc9tD5MHey7l/21gIQRZ4eLyqG6j78=;
        b=dE+umDdbmLYSJP06t6FDre4rXB1MQi/ipNRAMF0gNP79dk+7Ep+xdrHGJjHtBnQPWz
         4qIcL/QR/oEhbTj9gZkM/vgrqepcTWNHjYl3s/0DvYujyIK1CiHLyXqYrNuwWHDlQTxW
         /qWd1eES/KmdJWsDu8Yiu6phCOMMITWFehz30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780527236; x=1781132036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d66PsLO70IOujHc9tD5MHey7l/21gIQRZ4eLyqG6j78=;
        b=cDwiMkrTUFmGDB8H7S4SjNPL6f2SDB/4eOwgLuB2ibr6xaQavVm69KmlKgkiIfHbBF
         aF0fezYNbYYOdESGE7mQokZz78z6Y9QHpNQZQJAOd+rRaSm4IxnwLhZT1lrt3ol+oHpT
         1BT78+xWpJxJNa48zVwrw4cYR9gY99qnORchp2jeu1TOMqDivUcAKrHiNXWYqZgnnhCv
         0DKJ1+8UCjmeqJERquUqDSWsc2/aitxLoZXvv/zcVSJMecSSuUSyDiFEA07H/nTpk48v
         XUn7jlk1U6/NnvLhqx2C7uToZspgmFoWNjvjGPrRGTwWA34/2jCyC5kGgv7oijvXiJpp
         Aa8A==
X-Forwarded-Encrypted: i=1; AFNElJ8fGTB3edA9EQpfoEt0c08gsS6XNR5raQYeATKUsrg8PxuX6q+cQUNThKjviGQIG3gvZPRQvXbqxNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFx75o419MdPgo0w/Y+9Nud8KIYPhgtaiHmaCfhuf6+5e7wyXb
	pOQT2/ds5/3tgmB/KGdDvIAvWorymeGC/RTBMg/p975wMBafD+w8mxh5VRz1w2BeqNRmcDZASMB
	uFjSjPdXWcg==
X-Gm-Gg: Acq92OHWV9SMETTpeAk2t9sEhiG+V11zb06ywNW2wzv01W/2B1IXSVBMmosGd5njD5U
	fAPrxHZskIY42hdc4ZjaZmSayItO0ndmS1K9jXNLSpxxxMAD1TSmL2GzCZLdwgNQ4zV7FTL9isz
	a3OIwjJic0u+hjhjZ4VYnkPFFFeRWsYkgkTXrtguc4z98gENaNLbGecaK8soE5NvynEQh4glVLH
	Lti/UnPtW0pS1FE5QR+9iwyBQiSVUJk54X3CyGVmpHzsOZB2FViENEpP5Hn+1To19zONLKHM1GD
	ZZMbzCa3SrBr8ve/2w+aG0PGDfl+BCAyz3ZQ0Uj7yvueV6eOaMVGpfE1RerQ8bt1fyC3W2qcA1F
	5QQ9wmZnz9SZ6NeEMGzaX6yLXh1dAlzhYjJ1kTy2L982RGSTmPmX4w9hgU10PyrLKo6ozbhPMz2
	5PNW7cIGkg+dDnXvl6J5EJTmbKCtBG+Qkz5YmMPGNy/hKtnoG95ekGxs6yVGhtHT/X3qIr0FXn0
	l4NB6YllFc=
X-Received: by 2002:a17:903:2b0d:b0:2c0:cf44:3b3b with SMTP id d9443c01a7336-2c163fa3a7fmr62872145ad.24.1780527235774;
        Wed, 03 Jun 2026 15:53:55 -0700 (PDT)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com. [209.85.216.45])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm37354895ad.1.2026.06.03.15.53.55
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 15:53:55 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso25731a91.3
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 15:53:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8KDiQhtIK35O/00Fs759kZc+0R1pl9WTzR86VeFVYuZoMsfu9nGPYxQRNiSraq/ZCk98VcizRMt40=@vger.kernel.org
X-Received: by 2002:a17:90b:4ac7:b0:36b:8873:d96d with SMTP id
 98e67ed59e1d1-36e32b3baefmr4916778a91.11.1780527234968; Wed, 03 Jun 2026
 15:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
 <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
 <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
 <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com> <CALCETrXpqPMS487Bm8f8mHe8hv9DzCqoaW4UdoHetzYBUAhYLw@mail.gmail.com>
In-Reply-To: <CALCETrXpqPMS487Bm8f8mHe8hv9DzCqoaW4UdoHetzYBUAhYLw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 15:53:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5bFj1a7eaGp9sixDg3UXu7xUGfU=YJo+ckpGxGAyhXQ@mail.gmail.com>
X-Gm-Features: AVHnY4JfTnadgKQknxIsZL_Ab3vCkRcYm3kghJCvdkf-q8nXBlQAzmvvhTEK5F8
Message-ID: <CAHk-=wh5bFj1a7eaGp9sixDg3UXu7xUGfU=YJo+ckpGxGAyhXQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6525-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux-foundation.org:from_mime,linux-foundation.org:dkim,mail.gmail.com:mid,amacapital.net:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79DEC63BAD4

On Wed, 3 Jun 2026 at 15:23, Andy Lutomirski <luto@amacapital.net> wrote:
>
> So I'm suspicious that you've possibly make bugs much (MUCH) harder to
> exploit, but the underlying awful code and opportunity for bugs is
> still there.  MSG_SPLICE_PAGES is still around, and there is still
> (AFAICS) no actual coherent description of what it means.

I don't disagree. I've only looked at the filesystem side.

The networking side does some odd stuff too (and I did look at some of
that, and had to be edumacated by Jakub on some of the subtler rules
for what skb data sharing is ok and when it's not - really not my
area).

But at least MSG_SPLICE_PAGES should be kernel-internal only
interface, and once you don't share page cache pages with networking
code I think that kneecaps a lot of the attacks.

So that's really the aim here for me - at least _attempting_ to go
"maybe we can just limit splice enough that it doesn't even *matter*
when networking does something odd and questionable".

And it's entirely possible that the current zero-copy "networking gets
direct access to the page cache folios" is a huge and insurmountable
performance requirement for some loads. So the vmsplice patch - and
_particularly_ my suggested "let's try always copying" patch - may
simply be doomed.

But I'd rather try to simplify the splice code by removing complexity
- and possibly then failing and having to revert it and rethink things
- than not even trying.

Because I think splice() is a *cool* feature. It was always *clever*.
I just don't think it's worth the pain it has cause.

And it's been around for a long long time, and after more than two
decades it's still most definitely not _widely_ used.

So that makes it a failure in my book. Sometimes "clever" just isn't
the right thing.

               Linus

