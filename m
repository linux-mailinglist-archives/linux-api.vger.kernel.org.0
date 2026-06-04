Return-Path: <linux-api+bounces-6528-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B+QLMGXAIGob7gAAu9opvQ
	(envelope-from <linux-api+bounces-6528-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 02:01:41 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCFD63BF46
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 02:01:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=Jvi5vxQ6;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6528-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6528-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E0373012B1C
	for <lists+linux-api@lfdr.de>; Thu,  4 Jun 2026 00:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53781E1C11;
	Thu,  4 Jun 2026 00:01:34 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3995745000
	for <linux-api@vger.kernel.org>; Thu,  4 Jun 2026 00:01:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531294; cv=none; b=earIxLtrW7zdwYdBM/x0Rut8BBYnWjjOW4ZSOoxRRt982f6tQCachSa0SaKovbPeOQgTocs0/ncGLHJBggJms0bOmkPCDtzzUZUBMlBb//xxGcPvip8u5ha4YKX2zSItlQ8ed9V/LbdUzRCQ9nIbhn4XyMEo7PQwOCEUoKI8taE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531294; c=relaxed/simple;
	bh=uQcJ3DbEdxsfH/k24j2l4FHVQEAFZdw9HA2H2VMaFx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnadVyQzOJhyu07kj8N5h0gHmSCgz1A+sb+j6Ti8Vs74/ucwzX4ghO5wcw405K2Y1GtUpvrZlkTuzDf3TlQjphRzy7zf+Yu5zs8S6vbHOM7MsDyqldkJ6nNIoN7LtaUF4+GaNrzeRC5D+KuW1aMpv6FIiyyOOx4IVu2sS9jm9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jvi5vxQ6; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0aa420401so748665ad.3
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 17:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780531292; x=1781136092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fmwtcO9oMtO4r20fiMVX6YvjF6Gi+HYM7qIN8rIiuJU=;
        b=Jvi5vxQ6oEhsK6xh8SeqMdqhVLWenFoXEzcD4gyNYZkh0XTt/lKVBsplsog4eQEKn8
         /zb7i0ENIdLvtMNQPSjM24e4VgKwmneJCrhVoVHCjHcAVEF4c6xB9zCnBuX0DI1RgEY3
         Y5zPwv9/n1eOzPocT10b66QMclGJIZAPIs4Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531292; x=1781136092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmwtcO9oMtO4r20fiMVX6YvjF6Gi+HYM7qIN8rIiuJU=;
        b=MUz8qYLpYsBimPztmIqi7YHEkbHTyxS/G7GUzokcoWyMhxu4tXAyGwp8KgrC6v1Hcv
         cqqpAIkh6+YKwARXrMos91H/iWUb1CYj5pR+FfVULbYJUSLQ4W6lJeo+NzQJxxzoCbwI
         C9849I9rxI4vkVAcbKG59KyJnsLDXDouq1D8d/cLjnDzTbRTnWJmaT94YyLzs6D6Cmk6
         kJixjGXOnBNnWsrx3CPyML2bWswn0bMkiFMQ4Vr9RamB3eEA4gWrNMPVJ0YgSfooXISP
         4yVOsQh6egaNxgh6h7/P7ABx2YhoFTTzHjtAsUqxFFhBRvFAyZ171tYRwl6JLd2t/ISR
         RJhA==
X-Forwarded-Encrypted: i=1; AFNElJ/m6KgYPJxiJDU+qB5WCoESzhud/uW88e7AKOhea7pxvnNXrT4SnbZMR6GnoMfDL+oyF/6irD34z84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjcpw8OiWr/ll2+upaksHOYuHYmgrq4ZR5eNkYdANU42/MsnRv
	RZhmBiDCSx7rQrJMd/pD2s55Qe5HGRDP9RW1urgH3yDBNbdFwIs/7naPy+XGEMtjLgproEnrUls
	Tg03Hd8WE4w==
X-Gm-Gg: Acq92OElH7iTdpqvN1q6h5rMDQeZ6RBsJ2o562gW/+fhsovM4HFn+90UUZepKy1s+Mz
	MGz8COd/hr7hAeZD/uDgh4Eiofbt4PeTylNtYDamWyri5S9DYM5JEBcd6Cm8u8PtNQTi0IYW+vR
	cUqRVPKQT1dQn7eTvMQROrv1ZRrUoAWK90+ozf+vo8CUdGp6ezZI9eEsvgpFlg4HDlrUra38L4I
	BNZ90teDTL64o+cL6olKvks29ohzy8jk5p9he8bXcz9BQYUNdF/c6WVLf6nCJ7OFaI7wMApNpEO
	z+yUIrqRWZl9C8tCF9+500i7o9GcH187CG5RrPL/XMzu9+xd6Hb9E6afEpFNFakTy/iEXyoSudN
	8IdCKLCHTx+RyMJ3zRF3GW+vgP7T6QDgfBf5tTW4DeWCGNEbyGmljfyaxpOh9cdLtWd/8rprsm9
	L6KLyCCOZYc9Oe7mbBkRrdXypH6gTLZM/0Ze4y/ul5LUXrD5gvdydVxTrLSbfmS+gj3Spr0GLTE
	w3gKAIH8zA=
X-Received: by 2002:a17:902:e5c5:b0:2c0:bcb3:862 with SMTP id d9443c01a7336-2c1644dc267mr54773185ad.40.1780531292465;
        Wed, 03 Jun 2026 17:01:32 -0700 (PDT)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com. [209.85.216.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609df79sm37154015ad.42.2026.06.03.17.01.31
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 17:01:31 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso37263a91.3
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 17:01:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/z+5Fx/0j7Rou3whCFp+9z1RfQLx/61DDPvSqLXJfUYSUV83RqhhO9znO/T2hW2xD8kn4TED9SVU4=@vger.kernel.org
X-Received: by 2002:a17:90b:2811:b0:36d:5dbe:2a0d with SMTP id
 98e67ed59e1d1-36e30c23af4mr5607319a91.7.1780531290626; Wed, 03 Jun 2026
 17:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrU94ja56CA5CRtXrm1v_7gBaPUNOHKQzS=JNF9JZ7Fznw@mail.gmail.com>
 <20260603230122.851517-1-safinaskar@gmail.com>
In-Reply-To: <20260603230122.851517-1-safinaskar@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 17:01:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjARJSHGWvZKJysvZOVEVi7bNL5x9K2X7ifhfLA9YK2sQ@mail.gmail.com>
X-Gm-Features: AVHnY4J3E2GAiTMiUKCy1DVjF0CiXaoh4gFXUo3phzZ8FQ9ufT44d-VKtd1uRR8
Message-ID: <CAHk-=wjARJSHGWvZKJysvZOVEVi7bNL5x9K2X7ifhfLA9YK2sQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: luto@amacapital.net, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:luto@amacapital.net,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-6528-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-foundation.org:from_mime,linux-foundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DCFD63BF46

On Wed, 3 Jun 2026 at 16:01, Askar Safin <safinaskar@gmail.com> wrote:
>
> So, if we remove tee(2), then we will probably need to remove all
> non-standard implementations of pipe_buf_operations.

I don't think tee matters.

Sure, it will share pages across pipes.

But if we make normal "splice to pipe" always copy from the page
cache, nobody cares.

You can corrupt the resulting pages as much as you want - through
multiple pipes if you use tee() to copy it - and it's all just
corrupting your private copy.

And yes, iSCSI and nvme might do their own splice-like thing, but
again, nobody really cares. When it's all kernel-internal, the attack
surface has gone away.

So that's why splice() (and vmsplice()) is special - not because it's
buggy, but because it's the user-facing attack surface to expose bugs
elsewhere.

             Linus

