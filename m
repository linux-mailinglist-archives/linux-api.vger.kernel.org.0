Return-Path: <linux-api+bounces-6520-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E/7qLCCfIGqB5wAAu9opvQ
	(envelope-from <linux-api+bounces-6520-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 23:39:44 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1224C63B6B0
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 23:39:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=hOGAB54l;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6520-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6520-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 011C8302B081
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 21:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B6749551C;
	Wed,  3 Jun 2026 21:37:17 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7C3F9F50
	for <linux-api@vger.kernel.org>; Wed,  3 Jun 2026 21:37:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522637; cv=none; b=OOA06a5zDFx9C8M5icEtI1kvfmnwkFTFJh59JlLPiz2J1NJ840wkihwz1MYD2KrJ4KhJVW+3NiC2eXgYFi+82RhaMSeg0hy3zc+QKrvUQ8/B2F2cXv8KKD032R4/CXaoDBQd3oaNrHqkHSx3NPbHjGh99kHYzs5kRXd5nDLWVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522637; c=relaxed/simple;
	bh=G8aqlWT5bLZQV/uLuybjUVkjg96V4exbndaKeusMIxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpN1sfJEgiVuKvg/Oq/5atnnr7xi/tYRAhMkh/cNmyXs1/iQ22wAAIMlIHxSmGtXuj91R2rB/e21FO2+kiuScqyziTdyUqolsGGlAXPp/MAw4IS3N7fkANiCrbdOQ1XnhLdrKXx4fLHgs36t1At9A6b33lsEsuZH13a/ZMkbVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hOGAB54l; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-842307473b5so3524b3a.2
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 14:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780522635; x=1781127435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jlzwef06CJIrE3LIQnd2Z4dg96b07Ks4mMmqsV33wA0=;
        b=hOGAB54l+Ev4uS5dywooKcrHJZYkN0gbfOtysXN1XC7zpES0512jqzxelU6uuP9PkQ
         sNWfTnRtazYveVZjNnH3qXZufYCduuz+tlT70v5Sq9lqb8Nd0Iv7qk7Add5m2w+B1i5n
         w+5ynnbtGUn1KBMpzBTqWsvqJyQ57KW7ryMfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780522635; x=1781127435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jlzwef06CJIrE3LIQnd2Z4dg96b07Ks4mMmqsV33wA0=;
        b=pyVFgxWuLIY0HdEUtVKOo6VV6BfRmVUiGO5TWrRGY3EYqtK25eoc2Vo/ESNYbAp2km
         JYzqpdPC/2ifUIOxoEa2KQwRtIrdK5Qbuors+b1+EjGv8WMrU+OP6rQZfmJRKGRz7YDg
         GsA1sSOx/lvVnGqhW0UHRuDmlYkjDhp9rZYrfErl/o5sJyPrYm9DJba6Mq64F9PFcYV2
         +/pbbJzUCC9r4MGbuAslV0X0xD1RAp+dFsuEHFlD0o4XTbKsqSdjMsc7CYrwkfFOFpxg
         dZXzQvlB3u3igcvRx0xt8+TCauQ8oYEP91Cbvc1DzTNWwbAP3Za4Tq4zjUhxzXBnBYJ7
         MSuQ==
X-Forwarded-Encrypted: i=1; AFNElJ8wzOLHw3XjnuK3JXIPz417vaCQKfRkJ3HL/FfXzs2zqZraizNFlS9cdAJDNhSRgOL4KWjsc7HzrPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG9d2N+mDPB7QSUxvcjUHmzJfFTFde/Ijm9nDrNGii/jOaEjjS
	KlykxuwBpkvEcnFhXVIjv1JL50Cm3vvUy4N2mlWAJY+j8jj7G6zIVsz+hnIZKIpWoNWehkenqj2
	ayOEoIzHlqA==
X-Gm-Gg: Acq92OFFHo6k8VIqLGk9a38SaYb5C/fJBCLgIeaaDLOoOslva0y5czDH1C+jOmVgSlR
	OIQ3V2Q3thzMej6ldzxxD11TXzpZ3zIo/mQOjWv01MWmL0TU7HDWdp19HP+qygIC4qCsI7IE8l5
	9dkncRcfmm4qw1SoBlnfM/444vdeiIeazxpFd/Tay9X7HrA26is4/D5eUF8sLPmC6usY3vH4Mn1
	xzUNpNvI4dNvPZ5iNBwMcXGIEM+2ZXBUSw6zTazFAs8AQNsdNTM+0euHYd9pLQJQ9Lfq9fVfw7E
	7DPRi2gTMm6i/xHpsLL1N6hzinCoFuq4aj4HmV0JPK+LuVLd3sJQLu2u1UqoxmGwcyyh4W/J5Ef
	PzORrFp0INtz8PgllVj7yK+vLHEOWekZtil6uasN+214G3MmQLOTVIUoh3ECVmrCw4l021gfvuJ
	6RN53wzm8MdjLmY06IjX8w9QEUlB2ofTX7HTlTnrjnH3izJoG77zAhrIO9zXXb93mYGuQ0Vl2RK
	PyqJNeFHhsMbgU=
X-Received: by 2002:a05:6a00:883:b0:842:6ec3:2352 with SMTP id d2e1a72fcca58-84284dc02cfmr5033901b3a.18.1780522634935;
        Wed, 03 Jun 2026 14:37:14 -0700 (PDT)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com. [209.85.215.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221cc48sm4113062b3a.8.2026.06.03.14.37.13
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 14:37:13 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c85825bbc4fso15368a12.2
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 14:37:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ96q/ZFJJNSzJnLhG6idyFNsvaIaaFDZG4wJJO3HUYNpJ5h/eSj8ODbSJJUYR+C/bNxXw++M9lJZzg=@vger.kernel.org
X-Received: by 2002:a05:6a20:e196:b0:398:90e5:a9b9 with SMTP id
 adf61e73a8af0-3b4978a0b2amr4845639637.27.1780522633187; Wed, 03 Jun 2026
 14:37:13 -0700 (PDT)
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
 <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com> <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
In-Reply-To: <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 14:36:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
X-Gm-Features: AVHnY4JdHVy7zfm3YSY570fWNlTEBH8JxW4P9TvGYREa7sUrzYx92vQNA-k2Zxc
Message-ID: <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6520-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:from_mime,linux-foundation.org:dkim,amacapital.net:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1224C63B6B0

On Wed, 3 Jun 2026 at 14:31, Andy Lutomirski <luto@amacapital.net> wrote:
>
> I think I buried the lede too much and you're arguing against what I
> was trying not to say.
>
> Maybe we should keep an API that does an optimized copy, from one fd
> to another, that can send from a file to the network with at most ONE
> cpu-side copy.  Not aiming for zero like sendfile / splice.  Aiming
> for one.

Oh, absolutely - that's what my completely untested test patch  basically did.

The user space interface was still there.

And the networking side still continued to use the ->splice_write()
thing for writing to the socket.

It was just the filesystem side that basically now instead of exposing
the page cache directly (with filemap_splice_read) now only exposed a
*copy* of the page cache (with copy_splice_read).

                  Linus

