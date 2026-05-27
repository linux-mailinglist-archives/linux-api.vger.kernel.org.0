Return-Path: <linux-api+bounces-6427-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDa8JpW4FmqLqAcAu9opvQ
	(envelope-from <linux-api+bounces-6427-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 11:25:41 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9275E1C2B
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 11:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9F33307F0E4
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 09:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE6E3E9C0F;
	Wed, 27 May 2026 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gby5aBUa"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D838369203
	for <linux-api@vger.kernel.org>; Wed, 27 May 2026 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779873529; cv=none; b=NFJs6YPIzgit2vEaBp+hdWxKfwCEr79UPaJlkgXNGj5QevLnvA6ACcN7cQZ005rTu8oD9CK7kkN5Wa4nBCmOSF8Nml6PYOOG+MFKRdNwB9rEuk5dkRavA1hJb3QI0e8xb/Vqi/YTBYlyBtIRtPyo+DydvIJyYOsH+fmm6pVzSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779873529; c=relaxed/simple;
	bh=hqlhFFjMJuWuM6S6vZ8SCY5V5cKRhZoHzm25OC+blk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFhVLT3uzHcI75UUzWz34ihgo5SOirnZZ1m5RKDtyKT8kSfuXrHkCdxVSh6AWk4gVyI13sab4QkeaWSdTrnPIUzuKW7f4kILiGoBPcBbMfMaXHxvHeTe9XcSsqgK5F3RoCMfPguJZ5nfaCp861T7VvxEwyeFQup8VXYNddzKCj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gby5aBUa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4904127c32cso33154025e9.2
        for <linux-api@vger.kernel.org>; Wed, 27 May 2026 02:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779873524; x=1780478324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqlhFFjMJuWuM6S6vZ8SCY5V5cKRhZoHzm25OC+blk0=;
        b=Gby5aBUaNneyv46GmPg5ehUw+x6e6nppJQ+uhvcmTYmy1B/dlMyBZqF0mBM+TfSguM
         HvziBBSIvGYGn4VuRaNk6wRnVuLp21Quv9c8jfJAW4M5CCL2m0Hs+yQvZ1xrW8lpyYA/
         9c0HsW1ihkQ7hmmnc0bCx9CRKavMRIkPII++83gAfNJRSIV8DoXxmWM/q8LeUd/Ls8Hf
         KifL1Z7LXBpHzL69rlo99O1foj0tDyujWJSBKt8Dbdfcjxa4deH/TIGhoecQv89xwNWb
         Ltp7nryEr9v7HnAsc7m5AKw6UIjRsywRMRA8jM/yASoOE3GXq00sCoX3UU4dKqQSWE9s
         25Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779873524; x=1780478324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hqlhFFjMJuWuM6S6vZ8SCY5V5cKRhZoHzm25OC+blk0=;
        b=tJ7XCQP9iVvXSYNcp5ywZI67/K5I1JUR3vAmYgvF9UWL+8hLH0qxlTjf22zyVmBOQw
         aVPYc2Aa3WQSc+AMsaSpgTQDyKkqGJbaams57uNYRkglfCCF2RAGmkpco8/wGVAvgQfs
         vKnmd4dBGUHJ3ZHS0KQY9RIEAMqGG0tjaz6lGB2e6sFyiWLlaCfrgw6ptOKC0aQ+tFpb
         cDEBwNd8iwPTzcpYH+aRJvw1H1u8+u5u5AH9R6lVrjc63Y9TsXxClQhpLOOeyBoNPz4p
         NAFLnc2kITC0UrJHWROm24+2YVg23xHqefZZlfzeWriDzfTQC6GaEkqSm4UB+VWXLmq7
         eY7g==
X-Forwarded-Encrypted: i=1; AFNElJ9Q8ntmi2iRakLJcdtoQlkVap8wQBFYoju/GHHz9sgsSSPvQu7bei2sJSjgzlswSM2kRLv2bgfIxgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPrZsTbv7LuuPNDPn1d2RoEZiXadWaBs8rIuM68CajEwpyl0dM
	E8VpbraEiYUwaEvieD2WQ21V5VaqIWP4S1D7a/ETqd+n4lZgdWYfsZ4m
X-Gm-Gg: Acq92OHCgIBBjBFWiSu3aYd/1u9RVx1D0l5vQSSCBI+cQrMPMrj0yh345gf9b4EUcvD
	ViGxUeE433HsIPqHGPl9tY/PuYjlhlctHxk+L7e1PNMhh/nPAKzGXBY68vCEFjOt9jlA7PvGpb8
	PxT6w0R+/0ExmKKWlDiq01TUj7PtFcAtyMMOpF9Vm8uv+AVNbEuf+N/XHUrlAHWNPg77a9gIWWM
	loa1HP+ZMKHpzE7zYfohnRLqDFs3LiOdWLQuGY7mFYBfFVBkw8KfKsQTVHikoITcFGueyh37Ecr
	jciW+bHLJzDCvC8hF5aePEYcS4TwmZfBxzADXJZFvG2aRBn7lOs5Kcu6KXHXRu71Y8GNIcOLUE4
	SVH+TSA9SIXUFrYpBVmLffxdytkiC6et1y/UZhD3MeBT4XUSq0MTJqHwA/N6NizwaNBOTb7UlUx
	rWkzFQA0rMKM1R8Pk0oRgBuN3qt0sP33DWd+FQEi3HZ0Em7eU3Yfm979sxSK6271r3DkkyvW3tE
	Ik=
X-Received: by 2002:a05:600c:4f8f:b0:490:7136:ad02 with SMTP id 5b1f17b1804b1-4907136ae51mr128868725e9.7.1779873523995;
        Wed, 27 May 2026 02:18:43 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4907eae9898sm18844735e9.4.2026.05.27.02.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:18:43 -0700 (PDT)
Date: Wed, 27 May 2026 10:18:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Christian Brauner <brauner@kernel.org>, Kees
 Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, willy@infradead.org,
 mathieu.desnoyers@efficios.com, Linus Torvalds
 <torvalds@linux-foundation.org>, akpm@linux-foundation.org, Yafang Shao
 <laoar.shao@gmail.com>, andrii.nakryiko@gmail.com, arnaldo.melo@gmail.com,
 Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, linux-mm@kvack.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 3/6] treewide: Replace memcpy(..., current->comm)
 with strscpy()
Message-ID: <20260527101842.376d567f@pumpkin>
In-Reply-To: <20260526190625.3f4aca0a@gandalf.local.home>
References: <20260524-tonyk-long_name-v2-0-332f6bd041c4@igalia.com>
	<20260524-tonyk-long_name-v2-3-332f6bd041c4@igalia.com>
	<20260526190625.3f4aca0a@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6427-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[igalia.com,infradead.org,redhat.com,linaro.org,kernel.org,efficios.com,linux-foundation.org,gmail.com,suse.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,goodmis.org:email,igalia.com:email]
X-Rspamd-Queue-Id: ED9275E1C2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 19:06:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 24 May 2026 19:38:53 -0300
> Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
>=20
> > In order to increase the size of current->comm[] and to avoid breaking =
any
> > existing code, replace memcpy() with strscpy(). The later function makes
> > sure that the copy is NUL terminated. This is crucial given that the
> > source buffer might be larger than the destination buffer and could
> > truncate the NUL character out of it.
...
> As tracing now slows it down by 3.9% which is a significant increase from=
 2.7%
>=20
> I really rather keep memcpy() here.

I suspect the copies could/should be replaced by a copy_task_comm()
function that can perform optimisations that strscpy[_pad]() can't
do because it can (for example) assume that the source is terminated.

When the src and dst are the same size it can also degenerate to
memcpy() - which should get inlined.
The cost of copying 64 bytes might still be rather more than copying
just 16.
A compromise of 32 may be better.

-- David

>=20
> -- Steve


