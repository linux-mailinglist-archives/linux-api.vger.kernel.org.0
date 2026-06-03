Return-Path: <linux-api+bounces-6506-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 54z4DxL7H2pBtgAAu9opvQ
	(envelope-from <linux-api+bounces-6506-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 11:59:46 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D30C16365FB
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 11:59:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szeredi.hu header.s=google header.b=HkDLARZC;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6506-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6506-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szeredi.hu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40F2030E124D
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 09:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2935743D4E3;
	Wed,  3 Jun 2026 09:57:26 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D5344BC88
	for <linux-api@vger.kernel.org>; Wed,  3 Jun 2026 09:57:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480646; cv=pass; b=GnhNQjyvB6occC9GIp5tnnLktb+Thgend5GisfHz2IRVJRplD7ETXuTIRD/74r4uwIWpryBaAJoeZaycx4FGLsvX52532/TsKc4oStVnLJh4lJ63d0ahqIenqOwDUP/Aq61YAkPAWofn5kbO4vJoOdGi2HF7iSdQO8bArppBHtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480646; c=relaxed/simple;
	bh=ZCqrAxzAA1VkvSHMPbJW9yIvYLlRWu40qg6zjxtnKxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2aoGHBYX+ZT3U+MNA+y9fgXCQEPYB+OZLUpHwlFynueRRJPfEeVLLsRAtZXBExmrCnell9F1RDLm2yvycmzkWqhhCaeWUlC241EqBr/sYFtwjaXy7VqVJz5qDP5jooG3dZ7qr0ehrxXNYHhSZXy0UGYV1gkt+hp92H8qxSmc68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HkDLARZC; arc=pass smtp.client-ip=209.85.222.178
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91564c3a968so68389585a.1
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 02:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780480643; cv=none;
        d=google.com; s=arc-20240605;
        b=iMocK6Mv54uoCUxUQxvASKBduRD78IBTdNPNOqUdcvVMDjKG6kQvWbOy+Z9tBXlB4J
         5f8xzQsd+FYvWKs9q5323ssBsXDElrjfdr1IuNTZnbxHip42aIJ25sT6SdJpVWBtqjMj
         8jx5BHtbHeCYI100PSXkNXnFd/+AKS8NMuUKW+KPu0qHFhzxDaK4yHYYuNkR95B16G9K
         MaOIcOiPFCuETQ+p57Twb4Y5zj3C59Mi5Dym2gH1kRy48NP2q9iXZnvgbSMzptnOS6Pd
         fba8ofNvDOk7b72Ey6ynyt0lWtuLukC/Eo7eloKD6Pjf7hvPIiDsF3XYBdhqejs+qGza
         2FHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZCqrAxzAA1VkvSHMPbJW9yIvYLlRWu40qg6zjxtnKxA=;
        fh=MbJ7noXKFxJ7pa8f9tRqSFYepKfTgARbaUiz4jQYzQY=;
        b=O4lNIq1QpUWhv+0kCXzsKIPCt78AOUFw/7BALrNwOM33nWryTKpIIIW8kA4TfevNj7
         VwLgcqceOySzlmj8pVIOy1ac4zfzELlzHDx/49y9D292XceNurYWy/bwUQthd4eu4lLE
         DptxLPlFUIqn+RrAynRyLFzLOwhBnVUfFurTsWrzquA1G3DqrbyIWmhmr/5CzC53Hg+1
         YAmQcyyuH9GQV2YMDMR4qCt/z6ka1oP1ZIx0qS52047JbQTC9fqBEpuJrOUJxg3Bg0Eo
         UqWE40nXuUC5JUexuiGIPlPG8e0QasNIRXfDLNxn5zml6yli8LYAlbnwikcnkPfNjc9G
         ZHKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780480643; x=1781085443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCqrAxzAA1VkvSHMPbJW9yIvYLlRWu40qg6zjxtnKxA=;
        b=HkDLARZC/XPgnAkeNQ5n3MAM79d1kM1OOAeIKHRtNGpfkDXUv245i2yp+mD6JQPeUA
         64NZTw9EGfWhoENMoiIPb3oOJkXL+vE4E73fmxTFzb0nVraMC0mwLrTACZFwydQIAExR
         aNhk9bnGc++zz0NIEM1FWBwrjxTfiTh4xXjBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780480643; x=1781085443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCqrAxzAA1VkvSHMPbJW9yIvYLlRWu40qg6zjxtnKxA=;
        b=YpsRv6X6VbqKS/Pjbsaua9nWniE3NVLwXKUxZWJHDlv2LgLN5u4G2wNLGqlQB70DQR
         TE1gSLicq9+66tNw7DzUZk/9gzoL7KmnLA7+tB1mhx6xbXenNtSjsl0YZj9Hm4Y35ztl
         S/1QZUfU62lhRPSTyoLYIHReK6yGablzobMK5Oa7ebBYpj0uLe6sXtWSGy1Pt1Iqu7wK
         YcnFJpc/5mwrn/Qi6L7qdQt5NRPg5s47blU/DXolxbtv5uifc5PLedKCRAh2bvWHoZhk
         2o9YC+41jAGCe+oROFy/PDM1zC2B0NTL7GCY7Dle0Pf07Dl7rB2V2/BbTCSrnq7+b0cJ
         SRVw==
X-Forwarded-Encrypted: i=1; AFNElJ9eP3NdfY1zP/851NxhzIhefmYsiGrgrV1qMJuFXgQFAXmWtq3Aqui9bhSo0PuDsHpz2uPPk11vT04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGnmPcMcMhIQJ2oJFbt/Of9ybL4FzkX/exKoQQJ+eoGveiDOEI
	cyRY1AzNVa592ErXzVWUZseP63MPHOtPLVgyApD1vGJlcMaK6vhecMVXHc/LcBJOMJCLhpzsEO1
	nzwXLPrwKctMWVyQ1AdE30h28vK9vJyOp1SdasXXWIw==
X-Gm-Gg: Acq92OEIysa5PC4UuoZOwMd2mjybzeo93O6XEPIAuJqiSMf+MLMGBmfcEVm4aPtrzbM
	1iX2/BLX5gUYS5fFFQJCe/ABi47s2NXw9Oeh89rKJprIhE51sm+8AIMuBKs9fRtqOqePNirZOyD
	rh7VjcpJnaw4Qp7JxAsAaZOXAH3tMBXXvkfSaSJ+tbV1q2Kft2u7Y0px/uRnsQmdmL+HIwC447q
	MiPQCR4BmiY3z/Mc5oVhY2f2uh7IrxIsQQQy3PeEWd4MtlTYUNj1Y1EZWcBF3JBdhKXKGSmjHHy
	9jZg1kDXl15ddt240SRfSkqaT0OpC0wN1HMKPR9C8Hzz6wFsUVUqR/E5dg==
X-Received: by 2002:a05:620a:31a8:b0:915:422c:a0 with SMTP id
 af79cd13be357-9158b6e2074mr292177985a.22.1780480643420; Wed, 03 Jun 2026
 02:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com> <20260601173325.GH2636677@ZenIV>
In-Reply-To: <20260601173325.GH2636677@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 3 Jun 2026 11:57:11 +0200
X-Gm-Features: AVHnY4IqQCqMS4qklUMIqRUT1Fpv-SuCQDkhxYBkM9m1uTwHwBhUln17rZFWNU4
Message-ID: <CAJfpegtH-E79D-3UL=pPv-QqJk6C4ODXLLZSAjzQJwSSeqqS-A@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, patches@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, 
	Joanne Koong <joannelkoong@gmail.com>, fuse-devel <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:torvalds@linux-foundation.org,m:brauner@kernel.org,m:safinaskar@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:pfalcato@suse.de,m:patches@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:jack@suse.cz,m:rostedt@goodmis.org,m:joannelkoong@gmail.com,m:fuse-devel@lists.linux.dev,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6506-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[miklos@szeredi.hu,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,gmail.com,vger.kernel.org,kvack.org,infradead.org,kernel.dk,redhat.com,suse.de,lists.linux.dev,suse.cz,goodmis.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szeredi.hu:from_mime,szeredi.hu:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.org.uk:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D30C16365FB

On Mon, 1 Jun 2026 at 19:33, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Jun 01, 2026 at 10:17:23AM -0700, Linus Torvalds wrote:
>
> > TLDR: maybe we could ghet rid of "f_op->splice_read". *That* would be
> > a big simplification.
>
> FUSE might be interesting - fuse_dev_splice_read() and its ilk.
> Communications between the kernel and fuse server at least used to
> seriously want that, so that would be one place to look for unhappy
> userland...
>
> splice-related logics in fs/fuse/dev.c is interesting; another place
> like this is kernel/trace/, but I'm less familiar with that one.

[Cc: Joanne, fuse-devel]

I'd favor simplification, but care is needed to not regress performance.

Joanne might be in a better position to say something about relative
performance of various transport modes in fuse.

Thanks,
Miklos

