Return-Path: <linux-api+bounces-2343-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD249876FA
	for <lists+linux-api@lfdr.de>; Thu, 26 Sep 2024 17:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECFB1B250AD
	for <lists+linux-api@lfdr.de>; Thu, 26 Sep 2024 15:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162BD158205;
	Thu, 26 Sep 2024 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rkdfqjfe"
X-Original-To: linux-api@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADF953368
	for <linux-api@vger.kernel.org>; Thu, 26 Sep 2024 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365967; cv=none; b=BMfMku7sFsm6VOaoaTyMeLaAy4qwjfduImJ/d4pTx1nc9ESRsTN+XuI4wO06LJDYihOY1XoBztI2kxqvNjmv50a//uukj9qymKni86Vo1cUXtAaC5b/HV4+9yQ3sFos1FA7S3D23WAsZojf6OxDRZmlrNdsP+m0HSTiGL7FpF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365967; c=relaxed/simple;
	bh=s0uXlTXXpIVJz43LXvYFbgNIaxkLq1605E1/EirRJyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+Uo2YQt4QQnmlI9i9Mo6/rpI9aOHhgNPDuj1CDlQtZeqCyiqvK3drl9Fil7THUjzRc0fkR1HSq4Y2idNlfb6ntEZZIn7b8Xcbd2GZgDgNrC0E2pU0J02bavaa78WHDZ9qTwLxf4dTCqkVLc/xddMKxkDPb47lXVElIQEEs0AMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rkdfqjfe; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 26 Sep 2024 08:52:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727365961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z7G9ApLodriz/3joeN5VC8yGsIyla+zmSVIF3RzVqW4=;
	b=rkdfqjfeLCjUwQkPZdp8SArzUM460wX8K2Vo4qtCeHBCFhILxoZJ9IlzIU8rLdiAn/0xd5
	/XTqIUPXHEhYZVCjCStxxhIr7+AVVfPkdMCjrl/VLQyU/bNSKnQ+xLb6xVRXiat2aH6v0a
	Uj1eNkSRLpopJkRxbNMYuGCCZHaLVFg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, pedro.falcato@gmail.com
Subject: Re: [PATCH v3] mm/madvise: unrestrict process_madvise() for current
 process
Message-ID: <xv5qg4hfqvqzooounx57hzl4jzmfefitf3qklcdqzz7a4dufxn@v3r47r7p6ono>
References: <20240926151019.82902-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926151019.82902-1-lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 26, 2024 at 04:10:19PM GMT, Lorenzo Stoakes wrote:
> The process_madvise() call was introduced in commit ecb8ac8b1f14
> ("mm/madvise: introduce process_madvise() syscall: an external memory
> hinting API") as a means of performing madvise() operations on another
> process.
> 
> However, as it provides the means by which to perform multiple madvise()
> operations in a batch via an iovec, it is useful to utilise the same
> interface for performing operations on the current process rather than a
> remote one.
> 
> Commit 22af8caff7d1 ("mm/madvise: process_madvise() drop capability check
> if same mm") removed the need for a caller invoking process_madvise() on
> its own pidfd to possess the CAP_SYS_NICE capability, however this leaves
> the restrictions on operation in place.
> 
> Resolve this by only applying the restriction on operations when accessing
> a remote process.
> 
> Moving forward we plan to implement a simpler means of specifying this
> condition other than needing to establish a self pidfd, perhaps in the form
> of a sentinel pidfd.
> 
> Also take the opportunity to refactor the system call implementation
> abstracting the vectorised operation.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

> ---
> v3:
> * Avoid introducing PR_MADV_SELF and defer a non-pidfd version until later.

Seems like a good plan to decouple this patch from PR_MADV_SELF vs
PIDFD_SELF decision. I am hoping to see the follow up patch as well.

thanks,
Shakeel


