Return-Path: <linux-api+bounces-6649-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sjUFKWuDO2pDZAgAu9opvQ
	(envelope-from <linux-api+bounces-6649-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 09:12:43 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B74F36BC0DD
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 09:12:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NEk6jZgM;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6649-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6649-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 906BE3010221
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 07:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182DF38B146;
	Wed, 24 Jun 2026 07:12:36 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAEA38B7CD
	for <linux-api@vger.kernel.org>; Wed, 24 Jun 2026 07:12:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285156; cv=none; b=BsJDvoU3i4lxnIbGWDrs0RSlKXqqmq6Zxe60rCpbnGUdKIe9jCz3Ugl0uTW7sHfYcrB3SFp7xVUFbrwCdp6XJsoSMBiaAbcGe82XZd1YybCGnyFxmwggmThRj6b21Xn+TVLFMGMI7AsLZYaDiMOgd+ldgPgdafT/MuPwmbzG72M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285156; c=relaxed/simple;
	bh=T+oTEsZifQSSjkTTm8dieBj546vS01rprc6FRMPpgRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTxZFCjrnA21B3nZUVhz9O9ewUkswllHpKn5fPpY2l/j/ntlqKj2muXKkQ0ZujJGbd3dBnBEFPlpBgJBChNNSLiPNPsmSVgVKJv6v1fPYqRsTHcE8oKE831ikKfIcCghPLHijezIoYL3xG5wzRs6uhdm4tDTWzS48xVsDAyOCH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEk6jZgM; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-462bb734793so408525f8f.1
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2026 00:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782285153; x=1782889953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhG9FcF945Re4Q58PUpr7BwlsxWpmlT6fgah9/vT28s=;
        b=NEk6jZgMulgJqN17XPHyzxZWrjC3SRgX+YSWsZTjYh/fBnelCNZujLrpG/e+mFyoF7
         f1Gq3XqQrb60v77rGI8/iNo2sqx2/b7UaQAXvH3QITshpe3OUojUSyJlLvUAe2/GpKjU
         SE3hQWJrn17c9XTEnFuUX50Exw4ddu2TEcs+Jh3H2E1/KEmNBi8R2E1viN8X/RS/F8hf
         ArU9eVXTMzswldd/Um38NKIYizUTz23JNVE2PVtj38Gk/Zuo1ygshyyt6BVLAHby6pN0
         x3Dfz9pBCe5euKHjThKElffKbbO9TKgxcg8aVoI/xbwPxYjVbF266rAnHHl+iApuV2NX
         Ru3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782285153; x=1782889953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhG9FcF945Re4Q58PUpr7BwlsxWpmlT6fgah9/vT28s=;
        b=Ka8PElk3XzfaM+AJ/jOEWs6YGY3t1fWA5R4et+Goxj2n4KBcoR9G43itOI9sT3J/uf
         qINPyK20dMGxMB8sdUHdC0P/zyjAAf0u3r+sO1z0YTvzG0MMblsOWIjOpfAodaJ7T7K8
         MY6U7sXOZ+nHCbigcc1iDpClhWSTy/Yu7J5v12z8N4EZEGb2Aw0gDB8LbCMwehe9+MBG
         SvwVX3lxoY0YwL2Znmlz7D8y+JhLMecqmU/PWf9Fkxr3PytsO1frCBsreEYknTnWgnf6
         mbyNOnDAvSPFMeq9hzLuYGA7dsLiF9L7/dTKUTjWKt7Tajv0dT/Xa+DHHXv62xC3lJQc
         PsdQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNZ4kVfXqoiPQH2C6soOTgMI107eskFwNtufOLO78pJGT1ox4gQ2FPsSCk55nHmbzoMwXW1olTecA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyty8z92fJCPkv8b2LL5JIovFnErN1Pa7ZWGxO6J46/ypU9qfR
	jjoEWw0zGYjmHcjlTTHGHRPPUjXnOPBnsfxiH2NOw5ZYxx6gE5VlF7m2
X-Gm-Gg: AfdE7cn4yZDRehXz/FVCnGP79xp1xH0qS9ngLL1/OalkYrJHfDbb9dS4tf1VjUgEGQ6
	/uTJy1hWhnMQjO+YSrnsOMotwK76cS83SuBJZTt84rPwlLJTYFcjZEFPLwJcm/8iU9RydJyrW8Q
	+51cz5B433KGKBNGnALzu/RDk8cPGUe4XeshDuiU02sFFHtdyGklde7wMjfqkTUcR7MIUB0tmZ7
	alVx0h/d0rKKAhI6i+3OQFbs9eAiIpQ1FkT14n4pKdrO4NB/E9+qU0ol3/3Pqa7qba0q1fUoZFb
	r/TomghFA2U967J1p4LP1F4hb7wPLk9GyPifvMamgyKU2VNaDNI2HzszGodSBC0pvVkda2m4XOw
	K0U49Cr0FDU8XcpMnh+dbQJU15YD/660bR/DSwmRAw5GjqcWzqrIMenYzM0fA2v8cMg7cweI59g
	py0PPaEaVC
X-Received: by 2002:a05:6000:4683:b0:46a:1f35:113f with SMTP id ffacd0b85a97d-46a1f35172dmr8359155f8f.21.1782285152523;
        Wed, 24 Jun 2026 00:12:32 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c1ee0189esm4296531f8f.9.2026.06.24.00.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 00:12:32 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: avagin@gmail.com
Cc: akpm@linux-foundation.org,
	alexander@mihalicyn.com,
	axboe@kernel.dk,
	bernd@bsbernd.com,
	brauner@kernel.org,
	criu@lists.linux.dev,
	david@kernel.org,
	dhowells@redhat.com,
	fuse-devel@lists.linux.dev,
	hch@infradead.org,
	jack@suse.cz,
	joannelkoong@gmail.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	rostedt@goodmis.org,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	val@packett.cool,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Wed, 24 Jun 2026 10:12:26 +0300
Message-ID: <20260624071226.2272209-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANaxB-zK5q=Xw6UZTmeFtXsDZjUsPkFk=p485m-wtNTBnf4hgg@mail.gmail.com>
References: <CANaxB-zK5q=Xw6UZTmeFtXsDZjUsPkFk=p485m-wtNTBnf4hgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-6649-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,mihalicyn.com,kernel.dk,bsbernd.com,kernel.org,lists.linux.dev,redhat.com,infradead.org,suse.cz,gmail.com,vger.kernel.org,kvack.org,szeredi.hu,suse.de,goodmis.org,packett.cool,zeniv.linux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:avagin@gmail.com,m:akpm@linux-foundation.org,m:alexander@mihalicyn.com,m:axboe@kernel.dk,m:bernd@bsbernd.com,m:brauner@kernel.org,m:criu@lists.linux.dev,m:david@kernel.org,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:joannelkoong@gmail.com,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:rostedt@goodmis.org,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B74F36BC0DD

Andrei Vagin <avagin@gmail.com>:
> The CRIU fifo test fails with this change. The problem is that vmsplice
> with SPLICE_F_NONBLOCK to a fifo file descriptor fails with -EOPNOTSUPP.
> 
> It seems we need a fix like this one:
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 429b0714ec57..6fc49e933727 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -1253,6 +1253,7 @@ static int fifo_open(struct inode *inode, struct
> file *filp)
> 
>         /* We can only do regular read/write on fifos */
>         stream_open(inode, filp);
> +       filp->f_mode |= FMODE_NOWAIT;
> 
>         switch (filp->f_mode & (FMODE_READ | FMODE_WRITE)) {
>         case FMODE_READ:

Does CRIU actually rely on ability to do SPLICE_F_NONBLOCK vmsplice into
named fifos? Or this is merely a test?

If this is just a test, I think we need not to preserve this behavior.

I did debian code search with regex "vmsplice.*SPLICE_F_NONBLOCK" and I
found very few packages. And it seems all them use pipes, not named fifos.

(On speed: I still think that my vmsplice patches are good thing,
despite performance regressions in CRIU.)

-- 
Askar Safin

