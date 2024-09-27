Return-Path: <linux-api+bounces-2346-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A51987FF4
	for <lists+linux-api@lfdr.de>; Fri, 27 Sep 2024 10:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16C61C218C0
	for <lists+linux-api@lfdr.de>; Fri, 27 Sep 2024 08:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8076189518;
	Fri, 27 Sep 2024 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NH/4lZyo"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174D188A14;
	Fri, 27 Sep 2024 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424272; cv=none; b=BvE+FfAA9FWA/ZdBvhE9F1zqS3Yocqn2BvBDwab105oftJDi9LWMzgFCn5azuv3FFbv1A6CGIzYIKE0ducWreUQnKKFqIiZlS1jMHMtFjjFoPAqkPYxKRyzTlZK2uQWA7LCHnQFCgbV72soPU/n0sOjUQhkp02QThQiBRQWfslY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424272; c=relaxed/simple;
	bh=KRoK09mrYFt+ZHNObGEBtgUTdYCfNIO/7g2Oy/4Ww/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de5A7QhUOmPMbg8v+65g8hGRG4jxx6INTXbuAgseUy7ZJxYq6DNHH2iIyTRscvUFL/fiE00dNQ25xm1d064U+Pt5G8qMF6xDLgSG5zdF4Gi7xFMLnVFOLTr1ZiH6k1cGcNwbYIBEd6AnlJAOzlHo1y/cHMVX9DPZiVkO1vReF6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NH/4lZyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B31C4CEC4;
	Fri, 27 Sep 2024 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727424270;
	bh=KRoK09mrYFt+ZHNObGEBtgUTdYCfNIO/7g2Oy/4Ww/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NH/4lZyoobCtCmNARTQET5nKiKofDjaWwXU9zslg3Ltmmyu5f/kBXVPQV9L3DPpN4
	 HPI8Aghbow0U5EYY3Es/KQ2QV1CTSsoJ3C7c5koSPz6TRUTPEPNlG8bMyB1IIITZZV
	 nZ388LdNXktPxrCEi9kSLyOJi09kfAJGl9WwA7/l7JfRiE16cL2EdmsTbj65U9zENH
	 pvwFPqe+k4yMx6u51ThJFLUPIWoDrEz9TOZgsI4kuiK6sNrObATzCZbCaOOz5vODYD
	 fArfwxCf0KjTU2wCVkkpAwP9Cq8SalNI38nM2eBM6ioPtESgQxM76YZ/ffrVCzAuHg
	 EjklLXjhbhDxw==
Date: Fri, 27 Sep 2024 10:04:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>, pedro.falcato@gmail.com
Subject: Re: [PATCH v3] mm/madvise: unrestrict process_madvise() for current
 process
Message-ID: <20240927-holzlatten-karierte-2f1e5c0af19d@brauner>
References: <20240926151019.82902-1-lorenzo.stoakes@oracle.com>
 <xv5qg4hfqvqzooounx57hzl4jzmfefitf3qklcdqzz7a4dufxn@v3r47r7p6ono>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xv5qg4hfqvqzooounx57hzl4jzmfefitf3qklcdqzz7a4dufxn@v3r47r7p6ono>

On Thu, Sep 26, 2024 at 08:52:32AM GMT, Shakeel Butt wrote:
> On Thu, Sep 26, 2024 at 04:10:19PM GMT, Lorenzo Stoakes wrote:
> > The process_madvise() call was introduced in commit ecb8ac8b1f14
> > ("mm/madvise: introduce process_madvise() syscall: an external memory
> > hinting API") as a means of performing madvise() operations on another
> > process.
> > 
> > However, as it provides the means by which to perform multiple madvise()
> > operations in a batch via an iovec, it is useful to utilise the same
> > interface for performing operations on the current process rather than a
> > remote one.
> > 
> > Commit 22af8caff7d1 ("mm/madvise: process_madvise() drop capability check
> > if same mm") removed the need for a caller invoking process_madvise() on
> > its own pidfd to possess the CAP_SYS_NICE capability, however this leaves
> > the restrictions on operation in place.
> > 
> > Resolve this by only applying the restriction on operations when accessing
> > a remote process.
> > 
> > Moving forward we plan to implement a simpler means of specifying this
> > condition other than needing to establish a self pidfd, perhaps in the form
> > of a sentinel pidfd.
> > 
> > Also take the opportunity to refactor the system call implementation
> > abstracting the vectorised operation.
> > 
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> > ---
> > v3:
> > * Avoid introducing PR_MADV_SELF and defer a non-pidfd version until later.
> 
> Seems like a good plan to decouple this patch from PR_MADV_SELF vs
> PIDFD_SELF decision. I am hoping to see the follow up patch as well.

PIDFD_SELF should absolutely not be a per-system call thing. It should
be generic across all pidfd based system calls similar to AT_FDCWD.

IOW, that should be in:

include/uapi/linux/pidfd.h

#define PIDFD_SELF -200

