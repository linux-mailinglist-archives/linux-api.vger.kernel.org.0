Return-Path: <linux-api+bounces-2548-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D4A9AD25D
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2024 19:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419F41C216FA
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2024 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B9A1CACD3;
	Wed, 23 Oct 2024 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ejRfu9sN"
X-Original-To: linux-api@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEBD12DD88
	for <linux-api@vger.kernel.org>; Wed, 23 Oct 2024 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703919; cv=none; b=Sd3KEvE6iUzyQz5g6uAWeK6ZCGyNrFJBSKPCfnCurgkk9IgnnWMtqydKpmGgH8/BcVZTW1HNAMPwVPMUzkSWj1jHbZQX87D2PajTQv3bLdP38YyOat3+41S3hvqii2xAdFvuXlgYETWcijvZSenqXMM/dMKpet0uJvguJU2LFbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703919; c=relaxed/simple;
	bh=3nAER65IxMAepLiq7RPSV+9zMwzFoC3EmZJNENmGC1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mt78wYdmyjUuv9W21yo42wQLqkXZntW8elvnLwpkqCoVarqJE9YzkWGfzm0QbcRNSmg3jrdizY41nmd49DBXCjS673bH/fmnt5ak0L4jti2R2fatNQkpFvq3UvSAsDrUHuqrjfxL+hcZRXdnEe6cwRn/UjVfj/mctLZHhe6G8eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ejRfu9sN; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Oct 2024 10:18:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729703916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnlqPphUlvB/1649QsAjYZZfPNSeq62kbrW+yz2Z4Os=;
	b=ejRfu9sN5leVVaRjsUR+02NiUcIiRhmvWNveczbcBA2SgGYzlxZPxcrQtRF9QURa9gTe5s
	lmHqN/bMSQ/XQxvNdqi/n5xFj4uzp90+nokWUytlht7dc5ZiE8LDccbpNyubfyGRIn55Md
	ZajitSJz4USnabBE9/WlmotgFPr0Zec=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Sang <oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 2/4] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <35ipnq7dik6skpgrsywtje734iam65h2zjsv7fv5ayzfwnjlph@odu2szclos5y>
References: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
 <3bf7f2d8efc768007b5de8122275405afc9942d4.1729198898.git.lorenzo.stoakes@oracle.com>
 <fhy36lhgeedrdwoubuuxarownhji2k4avcherjnedtid35yael@jokjnyb6i66b>
 <f6114921-d3c7-4092-b503-09f99d98ad83@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6114921-d3c7-4092-b503-09f99d98ad83@lucifer.local>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 23, 2024 at 08:18:35AM GMT, Lorenzo Stoakes wrote:
> On Tue, Oct 22, 2024 at 05:53:00PM -0700, Shakeel Butt wrote:
> > On Thu, Oct 17, 2024 at 10:05:50PM GMT, Lorenzo Stoakes wrote:
> > > It is useful to be able to utilise the pidfd mechanism to reference the
> > > current thread or process (from a userland point of view - thread group
> > > leader from the kernel's point of view).
> > >
> > > Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
> > > PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.
> > >
> > > For convenience and to avoid confusion from userland's perspective we alias
> > > these:
> > >
> > > * PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always what
> > >   the user will want to use, as they would find it surprising if for
> > >   instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
> > >   and that failed.
> > >
> > > * PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
> > >   have no concept of thread groups or what a thread group leader is, and
> > >   from userland's perspective and nomenclature this is what userland
> > >   considers to be a process.
> >
> > Should users use PIDFD_SELF_PROCESS in process_madvise() for self
> > madvise() (once the support is added)?
> 
> You can use either it will make no difference as both will get you to
> current->mm which has to be shared. So I'd go with PIDFD_SELF for brevity
> :)
> 
> This series and the prerequisites I already added to process_madvise()
> already provide support so with this in you can just use this for that.

Thanks a lot, this is awesome. Is the plan for this series to go through
mm-tree or through Christian?


