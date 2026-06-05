Return-Path: <linux-api+bounces-6561-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jCmiFq/7ImpUgAEAu9opvQ
	(envelope-from <linux-api+bounces-6561-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 18:39:11 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E47649D96
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 18:39:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=NYhnnLKX;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6561-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6561-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B721306FD9F
	for <lists+linux-api@lfdr.de>; Fri,  5 Jun 2026 16:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FB935E1B5;
	Fri,  5 Jun 2026 16:30:42 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06642A82
	for <linux-api@vger.kernel.org>; Fri,  5 Jun 2026 16:30:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677041; cv=none; b=qmY0GOwSQYHvEmImogFhNw1RzjsnNxQmHlz5ic0Cn0BOn5N0SeHNsHH8RantzP2AEkDCM654hy+609djlpwMBDTk2XlPqXozBs0mynLuSBYe1TZsUAo8BTaYn9necAmUqZO21+sIGDh7sV1Iqk+dmupL1Oea6lzxNfpyowhgFQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677041; c=relaxed/simple;
	bh=GVKTJ1PUi145pODpne71tVTfx9y8nKFseHmwwZY5PTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kVppwRJXmoMxmokiNKQK6hR8haHdxKuSGFdhkF4T69TYIAyvhdiHmPAsefjHozadVg3YdyaVkCTs1Tv09BgGdqkBsMEPdfhs7mOYYXh/ifUBUK00QiU+8rcVUdeCtYehN31vYyHNNjFAxgsBZsySavo6dyYLGKCZT2gMmEG3/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYhnnLKX; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780677034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2WV80dwMeo/Oh+o/H20bt+QiS4rQvxiM6pL+lxNyrA4=;
	b=NYhnnLKX2dUjN7FB3r4kGqVwPGPp9CMm0ub2kyxKoBdsWlcxrJhkaRYh+pqnyMhUqOLxNf
	e4M/1wzr7WVBtDj4khJsXMrDPwkMxVvoNBssxv3FbJQbkL6CcHgZknbd+rRU8M/ORh414Z
	ERSTHHlIBJJ+balcfEfnYAIcHu6Yj7Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-g4IP06-0Mb-aHZMfCcNRyw-1; Fri,
 05 Jun 2026 12:30:30 -0400
X-MC-Unique: g4IP06-0Mb-aHZMfCcNRyw-1
X-Mimecast-MFC-AGG-ID: g4IP06-0Mb-aHZMfCcNRyw_1780677025
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DA421800370;
	Fri,  5 Jun 2026 16:30:24 +0000 (UTC)
Received: from oldenburg3.str.redhat.com (unknown [10.44.50.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEEB01800351;
	Fri,  5 Jun 2026 16:30:18 +0000 (UTC)
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
In-Reply-To: <CAHk-=wjkZSAhxykvG6tQM5DnBoS30_XCKkYpCsQwEGcxJb=i3Q@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 5 Jun 2026 08:54:07 -0700")
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
	<20260603211736.755139-1-safinaskar@gmail.com>
	<20260604100609.6b37f500@pumpkin>
	<CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
	<20260604183829.63c35fd9@pumpkin>
	<CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
	<20260604223216.73468830@pumpkin>
	<CAHk-=wh1Avi8FGbWkt9k0Z-KXWB0spo5mQyowO8PB2sJ3unbkw@mail.gmail.com>
	<87se71jps4.fsf@oldenburg.str.redhat.com>
	<CAHk-=wjkZSAhxykvG6tQM5DnBoS30_XCKkYpCsQwEGcxJb=i3Q@mail.gmail.com>
Date: Fri, 05 Jun 2026 18:30:16 +0200
Message-ID: <87wlwdhrvr.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-6561-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oldenburg.str.redhat.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9E47649D96

* Linus Torvalds:

> On Fri, 5 Jun 2026 at 02:33, Florian Weimer <fweimer@redhat.com> wrote:
>>
>> * Linus Torvalds:
>>
>> > x86 really doesn't *care*. If the caller zero-extends or leaves high
>> > bits set randomly, according to the x86 ABI that's perfectly fine: the
>> > callee will only care about the low 32 bits. So the high bits are
>> > simply not relevant for the ABI.
>>
>> Please note that Clang does not implement the x86-64 ABI and requires
>> zero extension.  We see increasing problems from that, now that we have
>> more C code calling Rust code.
>
> Uhhuh. But that is only specific to 'bool', right?

Also char and short.  This

extern int a[];
int
f (short i)
{
  return a[i];
}

gets turned into:

f:
	movslq	%edi, %rax
	movl	a(,%rax,4), %eax
	retq

This code assumes that the short value has been previously sign-extended
into %edi.

As I read the original psABI, this assumption was not valid, and the
extra bits were unspecified by omission.  And GCC tends to use shorter
instruction encodings without extension if that does not result in
partial register stalls.

> If it were to have the same issue that powerpc(*) had - that 'unsigned
> int' has to be passed to functions with well-defined high bits - that
> would be bad.

I would have to ask around.  It's hard to tell from experiments what the
expectations around int/unsigned arguments are.  Clang and LLVM treat
the upper bits from int/unsigned return values as undefined in some
cases.

> Anyway, for the kernel, this shouldn't be an issue simply because we
> typically avoid 'bool' in arguments or structures that are exposed to
> outside.

Right, but array indexing with u8/u16/s8/s16 function arguments is
impacted, too.

Thanks,
Florian


