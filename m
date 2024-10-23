Return-Path: <linux-api+bounces-2528-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3322E9ABABF
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2024 02:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C471C212AB
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2024 00:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ECF224FD;
	Wed, 23 Oct 2024 00:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PQFr+82T"
X-Original-To: linux-api@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D30E1B813
	for <linux-api@vger.kernel.org>; Wed, 23 Oct 2024 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644797; cv=none; b=rXNdeMrh1uPTuXGWVayfzyNvnEMwemaV8vt/yAoiTtqRNRtMpdGtLwES9RzH1ObP2tzc20INI1gegY7tf6fBF4htWrmLealaGzLZqa6fBEHpo24Hlk04fbQiZKEV/ApLH1OAu+xWP7dBx0N4n21BBRKNFkm4vfRLknSpKSWH/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644797; c=relaxed/simple;
	bh=lIxKrnVZi4OzdtnAM6X5raOD38x0R+vhcvjiqMDjT78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKppCqONNjWZU53G2BBTAG0BX8Gai43/nfr7n5Vo0PZFCUXLPFQscQYxQ3iR9hTFnictpvDbd3QWLe8J8dk7dlC5gQALljkLZZnDhPl1VCPQCrrRvH7+meniLHXNRRDE4QCOyn+tS1huvb/2VEY2XPzSG1T5dhutbtAujUykT8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PQFr+82T; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Oct 2024 17:53:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729644789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6kCNsEXTfjhm2VD7RcuSJFj1WDFRY4+e/zOdiNTxOWg=;
	b=PQFr+82TnUdLaIYZFFzshQFVmAmk1Yd7+0V/csbKw1Q5g5ouUoT7Egf2+eOTF9SVzA6x3K
	XlThe6JZGnxty58saIYF+G6jJ8wg1xPOeZdmiXyXDSIfO6cjO9eniEPWJTBAIqbRCz/E+W
	cQWGDsXIMg4UcpTrpNJLEGFUKjgsf2U=
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
Message-ID: <fhy36lhgeedrdwoubuuxarownhji2k4avcherjnedtid35yael@jokjnyb6i66b>
References: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
 <3bf7f2d8efc768007b5de8122275405afc9942d4.1729198898.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bf7f2d8efc768007b5de8122275405afc9942d4.1729198898.git.lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 17, 2024 at 10:05:50PM GMT, Lorenzo Stoakes wrote:
> It is useful to be able to utilise the pidfd mechanism to reference the
> current thread or process (from a userland point of view - thread group
> leader from the kernel's point of view).
> 
> Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
> PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.
> 
> For convenience and to avoid confusion from userland's perspective we alias
> these:
> 
> * PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always what
>   the user will want to use, as they would find it surprising if for
>   instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
>   and that failed.
> 
> * PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
>   have no concept of thread groups or what a thread group leader is, and
>   from userland's perspective and nomenclature this is what userland
>   considers to be a process.

Should users use PIDFD_SELF_PROCESS in process_madvise() for self
madvise() (once the support is added)?

> 
[...]
>  
> +static struct pid *pidfd_get_pid_self(unsigned int pidfd, unsigned int *flags)
> +{
> +	bool is_thread = pidfd == PIDFD_SELF_THREAD;
> +	enum pid_type type = is_thread ? PIDTYPE_PID : PIDTYPE_TGID;
> +	struct pid *pid = *task_pid_ptr(current, type);
> +
> +	/* The caller expects an elevated reference count. */
> +	get_pid(pid);

Do you want this helper to work for scenarios where pid is used across
context? Otherwise can't we get rid of this get and later put for self?

> +	return pid;
> +}
> +

Overall looks good to me.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

