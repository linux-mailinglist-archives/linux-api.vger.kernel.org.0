Return-Path: <linux-api+bounces-6466-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCQqId98G2pNDgkAu9opvQ
	(envelope-from <linux-api+bounces-6466-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 02:12:15 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BFF613F81
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 02:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDD1A3016D29
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 00:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B78028DC4;
	Sun, 31 May 2026 00:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHOhsAuR"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF9DBA3D;
	Sun, 31 May 2026 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780186331; cv=none; b=hbn4LtaSe9Vg5wbkqcyAGq6g8tw/Y3dkuFE6EQdOcrs3in0enYVnGrwj4gRGmq5YiPv073W0Vq+ojCl/5DA6tQ6wyDEUrsvQngb7nAHlOl+SD0gk36ycCPy4JColNo7XGUCWlnC7NVXjbvEIPKv65imWBO6KwbQ6rJASEQiXJXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780186331; c=relaxed/simple;
	bh=CPxt0QJ8OFKTnFuP4ZoTYcb1fv7XiqHyOJlhasg85kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2iBuWoboIK4TpCwRVdMFvjyvPtr+LjcOQsTPa/kKC5qp/gRYE2sv9Ajy+Swjo2X1c3cmHGYsiy4kiP9PFceRqxvcUuhLL53gKhbK+PHAUNlkYyML3ZhplrqxTFIeDBVUpVBgLv+UXesb1X4FJ10DMo7ZvxxiaNnwsgOt79GgrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHOhsAuR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C321F00893;
	Sun, 31 May 2026 00:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780186329;
	bh=OYvRVj4ATb1VjPqyrKnbeBCWG0iaq3Bc8et+a/muwak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fHOhsAuR4ScpU7RKty78SP/q0nx98PvpFWPIMukzAHEP+/dxNLJI95BYxZOkZRH8b
	 0vvtGETBPj6snAsl5sZla2ANtjpOu4hsZ5T9xZfqKEMyFTJ+hOr94AJt2anvzGK+2I
	 UUkR+VjHrS2bRTK7MRYAYRcbwjVawM7kdJGKgjfyVuHrHvzAsPTa4LYjInu5Z7qURl
	 uNsap2grrmNTO60WkFlgwkIZCj4q1gkDfjY+QhvWLXJjz4UkmrfX7fYLTkcA4ucLZJ
	 K8wxewMF4nOOu52EePN9R+PXM0YUBOJ2WgVAEF3VTJ1jlevVgFJhgTDaF6fDHUvvrK
	 pcE0/tyMGqKtg==
Date: Sun, 31 May 2026 00:12:07 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Theodore Tso <tytso@mit.edu>,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
	Akilesh Kailash <akailash@google.com>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <aht812OhSPFqIBPK@google.com>
References: <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
 <f4e521ac-2381-49ca-8dcc-3cb3cf3ffaea@acm.org>
 <ahaPDHiXcJoVShPv@infradead.org>
 <ahcU5xbVy7xjps02@google.com>
 <ahkl52N3RDcusCNd@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahkl52N3RDcusCNd@infradead.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6466-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F1BFF613F81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/28, Christoph Hellwig wrote:
> On Wed, May 27, 2026 at 03:59:35PM +0000, Jaegeuk Kim wrote:
> > F2FS merges bios before submit_bio, regardless of small or large folios,
> > since the block addresses are consecutive. So, I think IO subsystem was
> > working in full speed.
> 
> As does every other remotely modern file system.  But that merging is
> surprisingly expensive, which is why using folios gets really major
> performance improvements.
> 
> For one doing these checks to merge touch quite a few cache lines.
> Second, devices are often a lot more efficient if they see fewer SGL
> entries.  I.e. having a 1MB bio a single SGL tends to work better than
> having 256 of them.
> The same is true in the kernel code itself, both in the submission path
> (dma mapping and co), and even more so in the page cache handling
> both before submitting and in the completion path.
> 
> See Bart's patch about how long the walk of the bio_vecs in the f2fs
> completion path can take.  We had similar issues in XFS even in the
> workqueue completion path due to lack of rescheduling, and these simply
> go away when you do the folio manipulation in larger chunks (LAZY_PREEMPT
> would avoid the need to explicit rescheduling these days, but that just
> papers over the symptoms in this case).
> 

I see. That's also super helpful. Let me kick off the large folio support asap.
Thanks.

