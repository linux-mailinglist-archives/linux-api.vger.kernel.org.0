Return-Path: <linux-api+bounces-6549-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n5q1FEWaImoiawEAu9opvQ
	(envelope-from <linux-api+bounces-6549-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 11:43:33 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ADD646F8A
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 11:43:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=hUIDKwgK;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6549-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6549-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13F3F30BFD87
	for <lists+linux-api@lfdr.de>; Fri,  5 Jun 2026 09:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8B53B71BD;
	Fri,  5 Jun 2026 09:33:06 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C573CBE6B
	for <linux-api@vger.kernel.org>; Fri,  5 Jun 2026 09:33:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651985; cv=none; b=PSVYPU0Z0TW6XEHf0XmYhi/rKmYbQ2+bZEv51sw3SlZgQhD4KnUOPjZyTYQEB1gxK4xoOP94mdR/9v8u1Tv+nKCAk3CUq13hzUv0JEo4yUwOENs8k5P5VYKiv+jsmpVkyiQlxHRYGopT+vaKiFRMJRWrsMZ0pR+zOUD2iL9CO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651985; c=relaxed/simple;
	bh=zThWPMxmlIO7FwBAtHPdHCt4iP3Kn6Llw3/LtP9Fpxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tcYJPUk8iKo/+cROEbw5kxY+yvIFvTHmIo7JNIR7YxSjXj/NffbtDvVsV8LePyA9nmuo9nGeI42Jo05XHShuTXBBmC8HfKe7n+xKRNJJ7jzirzIklB2uGIix3pFeCoPR7baUjYhH5N55AAnX2BpjxV8Fvdb+DTZNq7kB5is+h6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUIDKwgK; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780651983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oH+D7ZeSOaE9PHP6jmKMDbjckrUXBE5O1ghWpaUmya0=;
	b=hUIDKwgK4pHVjrtErozPG608NCw5CFPoM1YRwz5X9ESb1YRoghQpg+ilp8zKtXFiZZHsJ3
	9/3zM+M2+O395sysIKq9ppoyY45CKJWeQXSz+TBO0C/LBbVilqZReKRJSwD9/Gxm+ZmFxh
	7OHl2HNUb+YVESTwQuCGwdtBPiBB7sY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-rjGcsIZmNDGiRIUyLqMLGA-1; Fri,
 05 Jun 2026 05:32:57 -0400
X-MC-Unique: rjGcsIZmNDGiRIUyLqMLGA-1
X-Mimecast-MFC-AGG-ID: rjGcsIZmNDGiRIUyLqMLGA_1780651974
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FDE91956080;
	Fri,  5 Jun 2026 09:32:53 +0000 (UTC)
Received: from oldenburg3.str.redhat.com (unknown [10.44.50.55])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CF111955BC0;
	Fri,  5 Jun 2026 09:32:45 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,  Askar Safin
 <safinaskar@gmail.com>,  metze@samba.org,  akpm@linux-foundation.org,
  axboe@kernel.dk,  brauner@kernel.org,  david@kernel.org,
  dhowells@redhat.com,  hch@infradead.org,  jack@suse.cz,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  miklos@szeredi.hu,
  netdev@vger.kernel.org,  patches@lists.linux.dev,  pfalcato@suse.de,
  viro@zeniv.linux.org.uk,  willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
In-Reply-To: <CAHk-=wh1Avi8FGbWkt9k0Z-KXWB0spo5mQyowO8PB2sJ3unbkw@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 4 Jun 2026 14:42:51 -0700")
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
	<20260603211736.755139-1-safinaskar@gmail.com>
	<20260604100609.6b37f500@pumpkin>
	<CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
	<20260604183829.63c35fd9@pumpkin>
	<CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
	<20260604223216.73468830@pumpkin>
	<CAHk-=wh1Avi8FGbWkt9k0Z-KXWB0spo5mQyowO8PB2sJ3unbkw@mail.gmail.com>
Date: Fri, 05 Jun 2026 11:32:43 +0200
Message-ID: <87se71jps4.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-6549-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[fweimer@redhat.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,samba.org,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:david.laight.linux@gmail.com,m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fweimer@redhat.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oldenburg.str.redhat.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3ADD646F8A

* Linus Torvalds:

> On Thu, 4 Jun 2026 at 14:32, David Laight <david.laight.linux@gmail.com> wrote:
>>
>> I think riscv might sign extend 32bit values in 64bit registers.
>> x86 and arm both zero extend.
>
> That's different.
>
> x86 really doesn't *care*. If the caller zero-extends or leaves high
> bits set randomly, according to the x86 ABI that's perfectly fine: the
> callee will only care about the low 32 bits. So the high bits are
> simply not relevant for the ABI.

Please note that Clang does not implement the x86-64 ABI and requires
zero extension.  We see increasing problems from that, now that we have
more C code calling Rust code.  (The other direction is generally fine.)
Unfortunately, it's difficult to fix in LLVM.

In the original x86-64 psABI, this was left unspecified by omission
except for the special case of _Bool.  However, Clang/LLVM gets the
_Bool case wrong as well, so it's not just a matter of an unclear
specification.

This isn't really specific to x86-64.  _Bool is simply not part of the
ABI that is stable across compilers, a bit like bitfields in structs
passed by value.

Thanks,
Florian


