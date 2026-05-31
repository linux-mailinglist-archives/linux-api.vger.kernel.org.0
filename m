Return-Path: <linux-api+bounces-6472-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PxAF/zGG2q1GAkAu9opvQ
	(envelope-from <linux-api+bounces-6472-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 07:28:28 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F18906148FF
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 07:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A132301955D
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 05:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C40322DAF;
	Sun, 31 May 2026 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht9a6pvB"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63793093C1
	for <linux-api@vger.kernel.org>; Sun, 31 May 2026 05:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205296; cv=none; b=iypULhcrkHWwoo2ldIAZqf3I3zAu24NCIdTGS4cPmkS5OxyUHD4Wqn18+m3o7476W4StcI9Q3ARKoaIGMMmNZXtQeifalooMn31gGdVZZNw+CV1Ehvdi9vq2T5MlhTsSdjWqb0cJVRCxeQHzS2OCOdBeg+hHdjnP6YYCJwE0MFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205296; c=relaxed/simple;
	bh=PcGRTyI0YD3nD5yyzGACIg4uX8+OxWTAiQChs2DynvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ipi6o9GEQXUg1EcpqmLu68f7ZDTosrC0EEdpkgFcHrRb4A1W99CMwiSJUZz6V9YiLBpCM/R/FMbF8tf7M+/kBmU+X0S6xR2o9H5u6HlfHuNS7kk0uLiWc1a9RlraW8xNU6rnLeSXAyLT8+zjB0OEEI58me31X/lLdoya01S2LN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht9a6pvB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F031F0089E
	for <linux-api@vger.kernel.org>; Sun, 31 May 2026 05:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780205294;
	bh=oJpSbrXN0X73x5V9/u/EQv8cWOQ13cY7JpP2vdc74R4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ht9a6pvBxNc+0tlAIDDDR0zj4rcTGB+EDbqNi92eTgV740lT1WSQzZlB7vynOLMJA
	 AeUzHHhpvp8OD8VOanuLYl/0OdKkwbkUBqwMXAT5XObgLEVEddW5uiR+HUhZzrWtqw
	 NCDSuZeA+oD/9Q7IAsg6B3z/ILYzZ5tXutsM1NWCbkMigYwlBIjvBbijA7K4VRximM
	 tF3vv4S5aDKujJRaIXeOm8ndwcIjVz4lwRujQUJutXUQM10dWmXo8xJw9zIgZZ7Xq+
	 sYfindI5nPK9Q9IcUbwO4gmMRhIfXWcwYST/z1VkMmk2UL9F0ILGrv7kRg15ZjsGz5
	 s+boewmu2sbsA==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-91550eca866so49978485a.1
        for <linux-api@vger.kernel.org>; Sat, 30 May 2026 22:28:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8FOJzVOP0k0SV3W8mh/SxLWP1snvSpIV8seTYCxiaQxvzmvwFqvXOCTkVbwNtTZYMYasyIlde+UaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6oJ3uYqpXwsrXMgoIC5nMPw89QVAw1Arz9K+CQaiJGY4J1eNK
	oapOiF9bbHIVe9DHTnIcj2P+aZEq3ooYw+oW4H3RiALNx1m0EgODByUG4WZU6HoxWLLeMAkcn4h
	l1SiyVnlHyEfOBpQGhsGAKR3vDeCcnZk=
X-Received: by 2002:a05:620a:a2d1:10b0:911:9a7a:8076 with SMTP id
 af79cd13be357-9153d96b5edmr605566585a.8.1780205293922; Sat, 30 May 2026
 22:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ag_OVwPF49LSZ7rz@google.com> <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com> <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com> <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
 <f4e521ac-2381-49ca-8dcc-3cb3cf3ffaea@acm.org> <ahaPDHiXcJoVShPv@infradead.org>
 <ahcU5xbVy7xjps02@google.com> <ahkl52N3RDcusCNd@infradead.org> <aht812OhSPFqIBPK@google.com>
In-Reply-To: <aht812OhSPFqIBPK@google.com>
From: Barry Song <baohua@kernel.org>
Date: Sun, 31 May 2026 13:28:02 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yJihngSY0GNcc+MwPHJjpF1qCnS8-UE1GwYoNDtEm9mQ@mail.gmail.com>
X-Gm-Features: AVHnY4K7tD5FaTjYu7fBuez0V9tZrcHA503rjhBejqB5_6W7Gc8g8vahJmbPfLY
Message-ID: <CAGsJ_4yJihngSY0GNcc+MwPHJjpF1qCnS8-UE1GwYoNDtEm9mQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Bart Van Assche <bvanassche@acm.org>, Theodore Tso <tytso@mit.edu>, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net, 
	linux-mm@kvack.org, Akilesh Kailash <akailash@google.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6472-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baohua@kernel.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F18906148FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 8:12=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> On 05/28, Christoph Hellwig wrote:
> > On Wed, May 27, 2026 at 03:59:35PM +0000, Jaegeuk Kim wrote:
> > > F2FS merges bios before submit_bio, regardless of small or large foli=
os,
> > > since the block addresses are consecutive. So, I think IO subsystem w=
as
> > > working in full speed.
> >
> > As does every other remotely modern file system.  But that merging is
> > surprisingly expensive, which is why using folios gets really major
> > performance improvements.
> >
> > For one doing these checks to merge touch quite a few cache lines.
> > Second, devices are often a lot more efficient if they see fewer SGL
> > entries.  I.e. having a 1MB bio a single SGL tends to work better than
> > having 256 of them.
> > The same is true in the kernel code itself, both in the submission path
> > (dma mapping and co), and even more so in the page cache handling
> > both before submitting and in the completion path.
> >
> > See Bart's patch about how long the walk of the bio_vecs in the f2fs
> > completion path can take.  We had similar issues in XFS even in the
> > workqueue completion path due to lack of rescheduling, and these simply
> > go away when you do the folio manipulation in larger chunks (LAZY_PREEM=
PT
> > would avoid the need to explicit rescheduling these days, but that just
> > papers over the symptoms in this case).
> >
>
> I see. That's also super helpful. Let me kick off the large folio support=
 asap.
> Thanks.

Hi Jaegeuk,

Nanzhe has put significant effort into this work at Xiaomi over
the past several months. Large folios can now be supported on
non-immutable files.

He has conducted extensive testing on the Pixel 6 and fixed a
number of hangs discovered during development. He is still
benchmarking performance, but the implementation appears to be
reasonably stable at this point. We can run Android Monkey for
many hours without observing any hangs.

If you would like to see an RFC, I can ask Nanzhe to send one
as soon as possible after some cleanup and polishing.

Best regards,
Barry

