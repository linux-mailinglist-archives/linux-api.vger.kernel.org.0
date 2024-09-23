Return-Path: <linux-api+bounces-2321-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B6197F0E4
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2024 20:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077DD1F22853
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2024 18:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F245E19F105;
	Mon, 23 Sep 2024 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Us/sNnd+"
X-Original-To: linux-api@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7168B2556F
	for <linux-api@vger.kernel.org>; Mon, 23 Sep 2024 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117777; cv=none; b=rczYTOYVQYNP39n6niPku3OR/vQAYKKga1HjXZRFyOs5WbTbj0Ha/3LGA5EoPBBwtMty5J41hUHdEbjUXtQSI+T6ygaSegEgbFWBeI0psl6ThFburZmBZvd61UesRacNrNxvK2/+7DqEj4pf6ICmr5aXRGvlFqHmyz4dO8c/Hok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117777; c=relaxed/simple;
	bh=cELG/tsZ3O9mcCRYxj/TMchW1JFS28iZ7rTgdNVclEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pq4NRuV6Vf8DC9ypBBFeDj2UCBvZHiyUfdkQ5OzTu0/PlJO5s7d+h+onxmqg2bugxZkDZJMybtJ8y0g48hOXyFHOjOvrNtW6o8EdDSp9qe20o2IXHRgHu738lpHxY9F99kHMopJ3T7QieJKV+QrOLdzuQ/92GCUT/GaRVZ4Kdlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Us/sNnd+; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 23 Sep 2024 11:56:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727117772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e0rykSYoDaIuOPwn4/o1I+eteK3LgCREKD5/olJ0XU4=;
	b=Us/sNnd+Bd3xmbugsQQtl/AKwtxjIlrdgh4Ju4wLuxPWyRCZhlx/eyHEOWYF6v+4rgcO62
	w0Vkn/8J9uCPjaFqFqfF4UNlEDq+7BRYWJO32OrYpAjfdv7s3j1MZkuTxpq7ybWd/pYlKU
	U3hQHkQwI49zrfYUg8wEPhiPn0xTEtk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 1/2] mm/madvise: introduce PR_MADV_SELF flag to
 process_madvise()
Message-ID: <njjxbroy5nvn2gxmvsvk7m23rrsoyih24nhmbmf7lpd5yzwwk7@ijudgtbiwyq6>
References: <cover.1727106751.git.lorenzo.stoakes@oracle.com>
 <077be0d59cb1047870a84c87c62e7b027af1c75d.1727106751.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <077be0d59cb1047870a84c87c62e7b027af1c75d.1727106751.git.lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 23, 2024 at 05:03:56PM GMT, Lorenzo Stoakes wrote:
[...]
>  SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>  		size_t, vlen, int, behavior, unsigned int, flags)
>  {
> @@ -1486,10 +1509,9 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>  	struct iov_iter iter;
>  	struct task_struct *task;
>  	struct mm_struct *mm;
> -	size_t total_len;
>  	unsigned int f_flags;
>  
> -	if (flags != 0) {
> +	if (flags & ~PR_MADV_SELF) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -1498,13 +1520,26 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>  	if (ret < 0)
>  		goto out;
>  
> +	/*
> +	 * Perform an madvise operation on the current process. No restrictions
> +	 * need be applied, nor do we need to pin the task or mm_struct.
> +	 */
> +	if (flags & PR_MADV_SELF) {
> +		ret = vector_madvise(current->mm, &iter, behavior);
> +		goto free_iov;
> +	}
> +
>  	task = pidfd_get_task(pidfd, &f_flags);
>  	if (IS_ERR(task)) {
>  		ret = PTR_ERR(task);
>  		goto free_iov;
>  	}
>  
> -	if (!process_madvise_behavior_valid(behavior)) {
> +	/*
> +	 * We need only perform this check if we are attempting to manipulate a
> +	 * remote process's address space.
> +	 */
> +	if (mm != current->mm && !process_madvise_remote_valid(behavior)) {

Move the above check after mm is initialized i.e. mm = mm_access().

Shakeel

