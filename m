Return-Path: <linux-api+bounces-6655-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y2ZQM/YZPGqBjwgAu9opvQ
	(envelope-from <linux-api+bounces-6655-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 19:55:02 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F8E6C0859
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 19:55:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dpkHGD01;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6655-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6655-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52E8430DFF5F
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DF53DD84D;
	Wed, 24 Jun 2026 17:52:25 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036233DD867
	for <linux-api@vger.kernel.org>; Wed, 24 Jun 2026 17:52:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323545; cv=pass; b=t7XkDh/SxUUngS0DC+bLs/5DzRyZjb1lhQFZkjLD8H11qG36COgq/LMKAtDHH+V5MATnvlZTVYn4diys7rK4L5BesG/NCKbqo2LVqApBD8UDAcQYxakOXaxfkKfl2vzkBFzkUjcNYYZlI7J3MfAUZ8ha7GxDdihBmpaxFJbh2sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323545; c=relaxed/simple;
	bh=BUqTLbaqUYoKdg3iiW+mLowzEHeWjN5LiDlT2QPIVfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2K18MdEOYg2/mjMQiXEr0WlLEPX83UYr25K/hrozq6hbYro73+QC+Xk10tRQdDwChKE18umdaT1rgiQnOyXxEDDapcK5IbI3zmC//qa0e9ROzIppr4BugFVI8zxGyUGAx9JqZTVG+3H7yADw2XgN0Y+/zVk+Q4lHW2acmu/ILo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpkHGD01; arc=pass smtp.client-ip=209.85.161.42
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69d7e72b052so1191593eaf.2
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2026 10:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782323543; cv=none;
        d=google.com; s=arc-20240605;
        b=VnPIYQrvplKwZCZ0+KPewMEV3LVmSknIo9bl11vrwidv2SetOIKEU9MFm9GeRJvRki
         oRCqJzLxZhJ0L8sFfxQcBJRrK1DnIx3icGFA3UWcYpavLJ79TrYgc/h9p58EpDUj/V6M
         bpyddG6+9fwPry+MmybKXi1iM6pQUZyOhfRaryyLlUu3DFFoqwI1Ccn2YFiZpXE72r2t
         BSZv9tR3exaX4dd+LqUjWgMjqFNwBJ1mE0Cpo0ZkpcIfHAxBPtOVa63J0pPQLoQm60MV
         15OyrOpbrbSE2pJuYz7aKDeCaIIrux1BQkQEEL5FOYdAKGE3K3y1EiWlgcZBfEVikb7U
         uQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3yIQCK+bzs9AyvsQ75CttiaMe1DqI5YJnh3974Pl4HA=;
        fh=D1+4xSy7eTzU//8+T+VMa9xUKclJccTWdXzmNX77pqw=;
        b=krrueQ3wd3+9ybvp4spRg7ai55TycyXoLN1kkQ+xdkxTD0XVcK5+xo2+fC3xkdM/R1
         PQWn3VM9V1zF6gYFFAy0ig2eh+etY1hfM5QJr7GwD9OeEJiVyozuId70avi2a4Dh3nkZ
         SMFENvE0RGlEIy4QGZLHa9TH179xJ5790AOhmFfUKvt/eBz+tg3/xRux644ffz09P1xv
         ZFrDSapxE3R0wxOUdHofcD24X0KOcQRBG8OKB1LG9upeyEkcVD/cPo1PDXT/Rwz4/CYu
         eAha/2GtQY26NlwrRP/CXIL+NBG858jiXFHnKTEKYaXRKnOS8cB9PVN1i2AwiuWNVgvS
         GM3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782323543; x=1782928343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yIQCK+bzs9AyvsQ75CttiaMe1DqI5YJnh3974Pl4HA=;
        b=dpkHGD014kNzTRmym8Xmzhh8Uh3XEehN1LpWs11WjWLOwbVCSfy3LK4k12qPPzlUI8
         9i89Gf/7LdY5kOKX3E9NlLyV2BVEERCY3dARyBZQRO9GOh3T2jtI5mYBD/nZzIP5vR9u
         7G3nK9LtnnR+BtGBzQyuj+dDtwmlLx+HYSOClLHbyu4rV0nHz6aB/SOU1l5rVdMlryG1
         +5SRzsGt0xe4rKkknnnaypLkt63oIH3LQfmV+h57Kq7m/UYuq5qnHPbaxmg4/QPGi4YM
         5uOkKOahVS+/BHS9n1K4Q7yHOdaAZy0Bf7YACl2rlmQ0PmgaZIQL/GE1UBWyknVXIueL
         fEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782323543; x=1782928343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yIQCK+bzs9AyvsQ75CttiaMe1DqI5YJnh3974Pl4HA=;
        b=jxaswI9z5nvS0W4p9ioVNbWpGw68THe/N2TBwV0R2+9/u56qaaH+t0ApARPljQ4CBl
         O223BbgWgkmK4k6Y62oQY2pIsxxkEcyJu7EErDNVc+r9LaVfiV1CMfN6T7/YTscBtH6n
         uNRM2W2iNdC2ALPXxzzQi3tKzA8DOxQ7nrH9Y6XJhqNDqWrfFD0IIIXl53UEdqst2kYc
         uF46qvLaxPJpYmuyhGWcrmSib5VsXY9NVpToxx3nF3Gu2mwNZ+Cp/L5hPwtsm7hJ2fyK
         1IgSes9asuoHLf753d+geimxfNWWAQ9x+5NYU+7YP+q+0M7xGoteicaLEALRMCq2J9Sa
         metg==
X-Forwarded-Encrypted: i=1; AFNElJ9u4Z372f+TtPwLxZKO/joy8mlMVMmb+6CiZiltMyuA4lWEUlu4BD4bNc5BcttYaqJf0dgntGCH6w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYicKFRb85VrhP9QgcPIb+JPoyZN2Gl9Va2GmwNnHgju+NKgKQ
	qXlQQgs2gpU+ND5CrPTYkD0jrh4KX0pbuqRg4nKzQL2G/9YEPU7YXa/wdN0FlGAoA5CnkvvnEtH
	6AiRjfGpBLYax7JLqOM+DES5AVwXfmeA=
X-Gm-Gg: AfdE7cnA8fG6WVJirFw1F6TCTXs/S1duaPbiUWkldreQ+VCKFXYfLAvyvEQJuX3dPBt
	GVci1fuzgrn0ta20j7dnCONedY5dI8uek74+UtkJxO7HV/B3p5BLr1MAAiCSqcyeZq7OgTmS9Gf
	E7o7ztzr0E1OPdTzTZMfr8L4URSUCCpBhXsFNluBzXqkOoLTu+p6jSjmylnTixiSKEn8Xn4f1gp
	qypsTsR8KartPj3l49yt4hRsACK9S6vesD0M9GghUTuxrhO+ekMOpEU6a/vp5hwMVp7qcs=
X-Received: by 2002:a05:6820:4d03:b0:6a1:10da:ab9d with SMTP id
 006d021491bc7-6a123056b05mr2754013eaf.15.1782323542879; Wed, 24 Jun 2026
 10:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANaxB-zK5q=Xw6UZTmeFtXsDZjUsPkFk=p485m-wtNTBnf4hgg@mail.gmail.com>
 <20260624071226.2272209-1-safinaskar@gmail.com>
In-Reply-To: <20260624071226.2272209-1-safinaskar@gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 24 Jun 2026 10:52:10 -0700
X-Gm-Features: AVVi8CfO4ShP8XHn8pnL2N4gaP9BD3pzKdndivNRe-NdNvS8dpf9qzg05LfmNXE
Message-ID: <CANaxB-xUrLQYGiRJZc4Boi+KX=0TJSWymErNovANVko20fMDVA@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, alexander@mihalicyn.com, axboe@kernel.dk, 
	bernd@bsbernd.com, brauner@kernel.org, criu@lists.linux.dev, david@kernel.org, 
	dhowells@redhat.com, fuse-devel@lists.linux.dev, hch@infradead.org, 
	jack@suse.cz, joannelkoong@gmail.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, rostedt@goodmis.org, 
	torvalds@linux-foundation.org, val@packett.cool, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:alexander@mihalicyn.com,m:axboe@kernel.dk,m:bernd@bsbernd.com,m:brauner@kernel.org,m:criu@lists.linux.dev,m:david@kernel.org,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:joannelkoong@gmail.com,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:rostedt@goodmis.org,m:torvalds@linux-foundation.org,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[avagin@gmail.com,linux-api@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6655-lists,linux-api=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@gmail.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,mihalicyn.com,kernel.dk,bsbernd.com,kernel.org,lists.linux.dev,redhat.com,infradead.org,suse.cz,gmail.com,vger.kernel.org,kvack.org,szeredi.hu,suse.de,goodmis.org,packett.cool,zeniv.linux.org.uk];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51F8E6C0859

On Wed, Jun 24, 2026 at 12:12=E2=80=AFAM Askar Safin <safinaskar@gmail.com>=
 wrote:
>
> Andrei Vagin <avagin@gmail.com>:
> > The CRIU fifo test fails with this change. The problem is that vmsplice
> > with SPLICE_F_NONBLOCK to a fifo file descriptor fails with -EOPNOTSUPP=
.
> >
> > It seems we need a fix like this one:
> >
> > diff --git a/fs/pipe.c b/fs/pipe.c
> > index 429b0714ec57..6fc49e933727 100644
> > --- a/fs/pipe.c
> > +++ b/fs/pipe.c
> > @@ -1253,6 +1253,7 @@ static int fifo_open(struct inode *inode, struct
> > file *filp)
> >
> >         /* We can only do regular read/write on fifos */
> >         stream_open(inode, filp);
> > +       filp->f_mode |=3D FMODE_NOWAIT;
> >
> >         switch (filp->f_mode & (FMODE_READ | FMODE_WRITE)) {
> >         case FMODE_READ:
>
> Does CRIU actually rely on ability to do SPLICE_F_NONBLOCK vmsplice into
> named fifos? Or this is merely a test?

Yes, it does.

>
> If this is just a test, I think we need not to preserve this behavior.
>
> I did debian code search with regex "vmsplice.*SPLICE_F_NONBLOCK" and I
> found very few packages. And it seems all them use pipes, not named fifos=
.

In short, this isn't how such cases are handled in the kernel. The fix is
simple and should be applied to avoid breaking random software.

>
> (On speed: I still think that my vmsplice patches are good thing,
> despite performance regressions in CRIU.)

I already explained that this isn't just a perfomance degradation, it
actually breaks the pre-dump mechanism in CRIU. vmsplice is invoked from
our parasite code within the context of a user process, where execution
speed is critical. A heavy performance penalty completely invalidates
the pre-dump logic, making the feature useless.

Under normal circumstances, patches that cause this kind of breakage
would never be merged. However, since there are exceptions to every
rule, we should let the maintainers decide how to proceed here. In CRIU,
we have a backup plan to utilize process_vm_readv to dump process
memory. We already support this mode, but it isn't the default due to
performance concerns. If these patches are merged, it will be the
only option left for CRIU to implement pre-dumping.

However, we need to look at this case in a broader context. This is yet
another example where the change introduces a workflow breakage, meaning
there might be other workloads out there that could be broken by this
change.

At a minimum, we may need to consider a deprecation plan where vmsplice
with SPLICE_F_GIFT triggers a warning for a few releases before these
changes are applied. Alternatively, we could introduce the proposed
behavior alongside a sysctl to fall back to the old behavior and explicitly
state that this fallback path will be completely deprecated in a future ker=
nel
version.

Thanks,
Andrei

