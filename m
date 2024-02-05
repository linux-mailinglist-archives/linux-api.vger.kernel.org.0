Return-Path: <linux-api+bounces-838-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E86184A238
	for <lists+linux-api@lfdr.de>; Mon,  5 Feb 2024 19:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A9E282253
	for <lists+linux-api@lfdr.de>; Mon,  5 Feb 2024 18:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D1D47F7F;
	Mon,  5 Feb 2024 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZEYJAhpS"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6390E481A3
	for <linux-api@vger.kernel.org>; Mon,  5 Feb 2024 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157561; cv=none; b=mQyew0EjEv7D2vFHsYr+bC4Q3HKy7qvwtltUWcm1DNvbFyY7DHhV7bH9Ym5Nokw438b1rcBmhiOs5Q2fV7TMIyity8hbTaDp0bGnaS68I/dpC29+ui2zrvuVfPfIhHZWKbhadLY8Yhn8rVWb6NrE+vWkXFh/3/gMZ3qHi504PYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157561; c=relaxed/simple;
	bh=OhVjfgQ6ypsXAl4aTp6y2RSd+qg4DOU5DAB4K9X8HUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2FFzBQsIsbiUw2H+KysS0pPTQFhg+ciTG/ummuI9M9lzatm1lViFmoL2AbxZlDuxsnU7OYgtxDdlk+6QXwajEKh7pXvMeH3O1NYoDHLC6k/qgD0L2e57Sxjyc4T//IuTxUGAaFj8xcF/JA18SR58bZjk9k7KvUia8NmTKrJuRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZEYJAhpS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d953fa3286so33269665ad.2
        for <linux-api@vger.kernel.org>; Mon, 05 Feb 2024 10:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707157559; x=1707762359; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YYhJmNwACs7xWzxaru2OLoYfAu9N74lwcPjzUDB+xg=;
        b=ZEYJAhpSf25DJNLMudbcAfzw1CZQMJLzK/SqywQ5irB9Sq2jplxCSBCbNAxBwS+Txn
         0L7nwuaesxFlBH0w6dg1Sgv904eVAU3pbZtPqeAE1fuHmxWkP4x3w9iC7mI7SgKqiL0P
         N1c+a55ibd5Orfi5+g50OkgB/c/mIxdCx5Ftg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157559; x=1707762359;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YYhJmNwACs7xWzxaru2OLoYfAu9N74lwcPjzUDB+xg=;
        b=t+pUvzYrITFNECpiRZz/e5WAkKq2AI3tYRVob84cLa/ruLqybFX1k45qM1bJSYgrfD
         6C86EH/aUMBR1XfdYFY+9K00Hvpf3eCNxOF31vt3YhIu4efzhYfFpRlMFv9vT0FZym2c
         HPAR8pc0q8opESTtKtcn2eS39BHo0PKBV77+HcXwF2fRa9W202D3VWD4xImSoirP4tC7
         nwMDGtkL0SWKos30pq19nLhIU8KlhR6GJLciCjaoH7JZLfs7/axJC3o5e7HTqLtrZPWD
         O0m03JCRXsEacHNHT1fuIxU/9d/1ILAI31G9wwT3356qkHwi+XTMamIhhlZyEiP8KPGZ
         uALw==
X-Gm-Message-State: AOJu0Yw7xWEjxGxrzuEYFVxEx0dE5gRwvSKvoFrbbzYdix+2kpF204rg
	7wba+77vSncKlSlPK5vVltmyhVJBjcy3bxZvXYgmgqGi0+ATomMndMTGKfJYe60uPHvbhr5m+QA
	t
X-Google-Smtp-Source: AGHT+IGZSu01SCfpuVAoKxEEGhseye5jcYZ2OTQbBwLSosCOhrRB2L0bvS8C7HVgC2MzoPFWHatu+Q==
X-Received: by 2002:a17:902:6f16:b0:1d9:742b:fedd with SMTP id w22-20020a1709026f1600b001d9742bfeddmr388747plk.34.1707157558764;
        Mon, 05 Feb 2024 10:25:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUbE7iGxVCPUBH4KvD0r1Rt49gMPSuQYHBQM6KluyR+1rAgHNElceTU1aObRosTlZRh1FwTv1OVSOIf5VGTjAwMhd8Xt2ohpeA+TlBhB25QhdhzTGBdE3ky5Ly2mQFPUURjnLLXpkP7V0yvChDB3MHjgqdb95/LIxNcHrt3OPWTXCSy1W8i1mP2JAETIcueqC1VCOhWPZUjKJlAfeYpMcsRgwqmeW/AIqBe2Ll/QP8ytuhKCvwSk8zJVNm2rMXjBS7v4r2WCPZw9dPf4XXIwg1wQHfPe1mozEAE1ZyTliyzm4tbIDfCZbZQZTYE/sDVy8ZcfcMOe5hCYpNtqjaK70F6w16d3Y1cQsjnGz7pwSTQS97sPVP9HJW5NbUIyIed5uExBAzifS8OSNOShYXISKThexfg5lqTXlALwMxkIgeZdFlfrI+YbM7GE3tE/EfeEvGkoKk4MIrk0dy+qxGTkwcIgG+b4mk0Qvjmwk1Ic/Ij1hLRr1BHlAs9hb4mBBJ3Gvd70gcpQehyK2WeY6yr/Veo52kvsaNLIvPGn2vG5EI=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id iy15-20020a170903130f00b001d8f3c7fb96sm170642plb.166.2024.02.05.10.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:25:58 -0800 (PST)
Date: Mon, 5 Feb 2024 10:25:55 -0800
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org,
	brauner@kernel.org, edumazet@google.com, davem@davemloft.net,
	alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
	kuba@kernel.org, willemdebruijn.kernel@gmail.com, weiwan@google.com,
	David.Laight@ACULAB.COM, arnd@arndb.de,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 1/3] eventpoll: support busy poll per epoll
 instance
Message-ID: <20240205182555.GA10463@fastly.com>
References: <20240131180811.23566-1-jdamato@fastly.com>
 <20240131180811.23566-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131180811.23566-2-jdamato@fastly.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Jan 31, 2024 at 06:08:03PM +0000, Joe Damato wrote:
> Allow busy polling on a per-epoll context basis. The per-epoll context
> usec timeout value is preferred, but the pre-existing system wide sysctl
> value is still supported if it specified.
> 
> Note that this change uses an xor: either per epoll instance busy polling
> is enabled on the epoll instance or system wide epoll is enabled. Enabling
> both is disallowed.

I just realized that I updated the code below to use a an or (||) instead
of xor (^), but forgot to update the commit message.

I can fix this and send a v6.

> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  fs/eventpoll.c | 49 +++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 3534d36a1474..ce75189d46df 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -227,6 +227,8 @@ struct eventpoll {
>  #ifdef CONFIG_NET_RX_BUSY_POLL
>  	/* used to track busy poll napi_id */
>  	unsigned int napi_id;
> +	/* busy poll timeout */
> +	u64 busy_poll_usecs;
>  #endif
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> @@ -386,12 +388,44 @@ static inline int ep_events_available(struct eventpoll *ep)
>  		READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;
>  }
>  
> +/**
> + * busy_loop_ep_timeout - check if busy poll has timed out. The timeout value
> + * from the epoll instance ep is preferred, but if it is not set fallback to
> + * the system-wide global via busy_loop_timeout.
> + *
> + * @start_time: The start time used to compute the remaining time until timeout.
> + * @ep: Pointer to the eventpoll context.
> + *
> + * Return: true if the timeout has expired, false otherwise.
> + */
> +static inline bool busy_loop_ep_timeout(unsigned long start_time, struct eventpoll *ep)
> +{
> +#ifdef CONFIG_NET_RX_BUSY_POLL
> +	unsigned long bp_usec = READ_ONCE(ep->busy_poll_usecs);
> +
> +	if (bp_usec) {
> +		unsigned long end_time = start_time + bp_usec;
> +		unsigned long now = busy_loop_current_time();
> +
> +		return time_after(now, end_time);
> +	} else {
> +		return busy_loop_timeout(start_time);
> +	}
> +#endif
> +	return true;
> +}
> +
>  #ifdef CONFIG_NET_RX_BUSY_POLL
> +static bool ep_busy_loop_on(struct eventpoll *ep)
> +{
> +	return !!ep->busy_poll_usecs || net_busy_loop_on();
> +}
> +
>  static bool ep_busy_loop_end(void *p, unsigned long start_time)
>  {
>  	struct eventpoll *ep = p;
>  
> -	return ep_events_available(ep) || busy_loop_timeout(start_time);
> +	return ep_events_available(ep) || busy_loop_ep_timeout(start_time, ep);
>  }
>  
>  /*
> @@ -404,7 +438,7 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
>  {
>  	unsigned int napi_id = READ_ONCE(ep->napi_id);
>  
> -	if ((napi_id >= MIN_NAPI_ID) && net_busy_loop_on()) {
> +	if ((napi_id >= MIN_NAPI_ID) && ep_busy_loop_on(ep)) {
>  		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
>  			       BUSY_POLL_BUDGET);
>  		if (ep_events_available(ep))
> @@ -430,7 +464,8 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
>  	struct socket *sock;
>  	struct sock *sk;
>  
> -	if (!net_busy_loop_on())
> +	ep = epi->ep;
> +	if (!ep_busy_loop_on(ep))
>  		return;
>  
>  	sock = sock_from_file(epi->ffd.file);
> @@ -442,7 +477,6 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
>  		return;
>  
>  	napi_id = READ_ONCE(sk->sk_napi_id);
> -	ep = epi->ep;
>  
>  	/* Non-NAPI IDs can be rejected
>  	 *	or
> @@ -466,6 +500,10 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
>  {
>  }
>  
> +static inline bool ep_busy_loop_on(struct eventpoll *ep)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_NET_RX_BUSY_POLL */
>  
>  /*
> @@ -2058,6 +2096,9 @@ static int do_epoll_create(int flags)
>  		error = PTR_ERR(file);
>  		goto out_free_fd;
>  	}
> +#ifdef CONFIG_NET_RX_BUSY_POLL
> +	ep->busy_poll_usecs = 0;
> +#endif
>  	ep->file = file;
>  	fd_install(fd, file);
>  	return fd;
> -- 
> 2.25.1
> 

