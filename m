Return-Path: <linux-api+bounces-4283-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7FCB192E8
	for <lists+linux-api@lfdr.de>; Sun,  3 Aug 2025 08:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5741898271
	for <lists+linux-api@lfdr.de>; Sun,  3 Aug 2025 06:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8E7218ADE;
	Sun,  3 Aug 2025 06:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sulPqGIQ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F0163;
	Sun,  3 Aug 2025 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203656; cv=none; b=fvu7F2hIElU3sy6BOU4cFQygjhB48yRCT2yuhdgxIDmSfNIol0WiqpLBXqbYehOcZdUGfJE3WL6AijzjeqtWn5lPe3Z5kMNm+++HNvd5FIu39Zrmaa2QSdsiCImxp9qwgnPOcyvxDNx2yJhglW+TfgASRgVup8me/cmhQZAcXdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203656; c=relaxed/simple;
	bh=d1CztXE2nxIStxY5iQfmoDrEvdtgUVV7MjZV4daxJbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StuB7lM1w/hzVmkUr9pFu8NNecUGWKVdTzuErKAcpEnL7dPaC8admYSTECqcaTII5ZZpm6wkkAxY+mBbEUpxyWoPcaBO6Dl/LQvIlSAwVVqhkFT4WnjA5G2019AKj21UKZOM86dwgCfpETPqJjkXOzSbzx8y1wIOxmbgSud7fVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sulPqGIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6938AC4CEEB;
	Sun,  3 Aug 2025 06:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754203654;
	bh=d1CztXE2nxIStxY5iQfmoDrEvdtgUVV7MjZV4daxJbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sulPqGIQZvDPo/kxDy94EVz3bSUYuxoGHoJokqpytgVkXzoxIQg7kB+hrUBncxzO3
	 RlVDThUlgZIkWbzcxYS5LqCJPnjwFFsbnJVq6D8iBq4mxSxs63f2KmDWR4xRdKm8iZ
	 hbcR+TtWwM5JKECVUz75ery9pguse69UYjJNpV3hEjn28sFBtNua2Vj7iHhT7IJYe9
	 +VSOwl20lS/yq62OpyLVLd60JQh+ZrYpC5mHFEWsm6txGt3xitn0yot6UGjInmENBw
	 rSNQ1Ck68OommRgaaY4xvpXNN9qL2FEZV3qDtQzktOvCdd8YJe5UoGdTeyaGIQibM2
	 Jy8oEGQPdYEXA==
Date: Sun, 3 Aug 2025 08:47:28 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 1/2] man/man2/mremap.2: describe multiple mapping move
Message-ID: <ngytuoex4uvu5epsdqhvhypnhqidkr7cpwmmcxrml6kpftgusb@jo5ql6eko2ir>
References: <cover.1753795807.git.lorenzo.stoakes@oracle.com>
 <1fd0223a6f903ffdd8ba644d0b67820b1921671f.1753795807.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1fd0223a6f903ffdd8ba644d0b67820b1921671f.1753795807.git.lorenzo.stoakes@oracle.com>

Hi Lorenzo,

On Tue, Jul 29, 2025 at 02:47:35PM +0100, Lorenzo Stoakes wrote:
> Document the new behaviour introduced in Linux 6.17 whereby it is now
> possible to move multiple mappings in a single operation, as long as the
> operation is simply an MREMAP_FIXED move - that is old_size is equal to
> new_size and MREMAP_FIXED is specified.
> 
> To make things clearer, also describe this kind of move operation, before
> expanding upon it to describe the newly introduced behaviour.
> 
> This change also explains the limitations of of this method and the
> possibility of partial failure.
> 
> Finally, we pluralise language where it makes sense to do so such that the
> documentation does not contradict either this new capability nor the
> pre-existing edge case.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Would it be possible to write a small C program that uses this new
feature?


Cheers,
Alex

> ---
>  man/man2/mremap.2 | 84 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 73 insertions(+), 11 deletions(-)
> 
> diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
> index 2168ca728..6ba51310c 100644
> --- a/man/man2/mremap.2
> +++ b/man/man2/mremap.2
> @@ -25,18 +25,47 @@ moving it at the same time (controlled by the
>  argument and
>  the available virtual address space).
>  .P
> +Mappings can also simply be moved
> +(without any resizing)
> +by specifying equal
> +.I old_size
> +and
> +.I new_size
> +and using the
> +.B MREMAP_FIXED
> +flag
> +(see below).
> +Since Linux 6.17,
> +while
> +.I old_address
> +must reside within a mapping,
> +.I old_size
> +may span multiple mappings
> +which do not have to be
> +adjacent to one another when
> +performing a move like this.
> +The
> +.B MREMAP_DONTUNMAP
> +flag may be specified.
> +.P
> +If the operation is not
> +simply moving mappings,
> +then
> +.I old_size
> +must span only a single mapping.
> +.P
>  .I old_address
> -is the old address of the virtual memory block that you
> -want to expand (or shrink).
> +is the old address of the first virtual memory block that you
> +want to expand, shrink, and/or move.
>  Note that
>  .I old_address
>  has to be page aligned.
>  .I old_size
> -is the old size of the
> -virtual memory block.
> +is the size of the range containing
> +virtual memory blocks to be manipulated.
>  .I new_size
>  is the requested size of the
> -virtual memory block after the resize.
> +virtual memory blocks after the resize.
>  An optional fifth argument,
>  .IR new_address ,
>  may be provided; see the description of
> @@ -105,13 +134,43 @@ If
>  is specified, then
>  .B MREMAP_MAYMOVE
>  must also be specified.
> +.IP
> +Since Linux 6.17,
> +if
> +.I old_size
> +is equal to
> +.I new_size
> +and
> +.B MREMAP_FIXED
> +is specified, then
> +.I old_size
> +may span beyond the mapping in which
> +.I old_address
> +resides.
> +In this case,
> +gaps between mappings in the original range
> +are maintained in the new range.
> +The whole operation is performed atomically
> +unless an error arises,
> +in which case the operation may be partially
> +completed,
> +that is,
> +some mappings may be moved and others not.
> +.IP
> +
> +Moving multiple mappings is not permitted if
> +any of those mappings have either
> +been registered with
> +.BR userfaultfd (2) ,
> +or map drivers that
> +specify their own custom address mapping logic.
>  .TP
>  .BR MREMAP_DONTUNMAP " (since Linux 5.7)"
>  .\" commit e346b3813067d4b17383f975f197a9aa28a3b077
>  This flag, which must be used in conjunction with
>  .BR MREMAP_MAYMOVE ,
> -remaps a mapping to a new address but does not unmap the mapping at
> -.IR old_address .
> +remaps mappings to a new address but does not unmap them
> +from their original address.
>  .IP
>  The
>  .B MREMAP_DONTUNMAP
> @@ -149,13 +208,13 @@ mapped.
>  See NOTES for some possible applications of
>  .BR MREMAP_DONTUNMAP .
>  .P
> -If the memory segment specified by
> +If the memory segments specified by
>  .I old_address
>  and
>  .I old_size
> -is locked (using
> +are locked (using
>  .BR mlock (2)
> -or similar), then this lock is maintained when the segment is
> +or similar), then this lock is maintained when the segments are
>  resized and/or relocated.
>  As a consequence, the amount of memory locked by the process may change.
>  .SH RETURN VALUE
> @@ -188,7 +247,10 @@ virtual memory address for this process.
>  You can also get
>  .B EFAULT
>  even if there exist mappings that cover the
> -whole address space requested, but those mappings are of different types.
> +whole address space requested, but those mappings are of different types,
> +and the
> +.BR mremap ()
> +operation being performed does not support this.
>  .TP
>  .B EINVAL
>  An invalid argument was given.
> --
> 2.50.1

-- 
<https://www.alejandro-colomar.es/>

