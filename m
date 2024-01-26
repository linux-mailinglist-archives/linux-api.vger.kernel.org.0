Return-Path: <linux-api+bounces-671-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5733283D14E
	for <lists+linux-api@lfdr.de>; Fri, 26 Jan 2024 01:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD57E1F266C7
	for <lists+linux-api@lfdr.de>; Fri, 26 Jan 2024 00:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F331115;
	Fri, 26 Jan 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="t0aNJZ9U"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3351618D
	for <linux-api@vger.kernel.org>; Fri, 26 Jan 2024 00:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227649; cv=none; b=pgkw/2yP1Pg6P3OkNNBaE8oiSNpM4bc7MTmI3NDd6Yr5528rT8IucUzTmsZ7fWhcXqcGUgw+l/m5r/Nnia49VMl32ggUUvw4yARfwHPA88dZqU2x1rGfPESMVdGbJL9y1uKtPYmiSZOAK0r7Nomwobrlf1dRNC6SC1noKSqUrS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227649; c=relaxed/simple;
	bh=vq9nbJGBePtK3eacfuxeNYC4E2qxjWblECq4PVvE8mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7zlRN6b+Qd/Vcsqkfkad2GwIk/m1O8xg+9uoQkGcozauq5iXtxsjXzRJmI++cW+dIiQd+SWJVpM3qzM35gBCkLlI4ebyrLudgI31Igr8FLx42EYWxQYQNXP5zjN05QG9kslRa9oEJrAViMOkLSA19OeAwPePaYIvRA4dgqomg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=t0aNJZ9U; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso3929141a12.2
        for <linux-api@vger.kernel.org>; Thu, 25 Jan 2024 16:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706227645; x=1706832445; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a12bNs0iU2iFfUOFFry4nsUZa1RJ0J+PUSAWEsMV7ho=;
        b=t0aNJZ9UZA8LlDyDxPxvW0PVPRrVfL2Zcg6m8HI0WK+3sLXYZrMHdE9lZg5/mVNhyr
         0EbpjmNyWCo3uf5rYdsQ6MfpZS9BVH/ox47Agjx2rr3CNz/QcZRaOaOx3MvlrTghTEmH
         rpF4FbQrqDQHEcOJ1yEOhmvZTYS8EMzhHpspA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706227645; x=1706832445;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a12bNs0iU2iFfUOFFry4nsUZa1RJ0J+PUSAWEsMV7ho=;
        b=nMU4zSVL6ealT6p7xLr7DJyH/oV1JryFjkWMsAPkGHp050Gtx0OIoPXh9R5v9QPIyW
         vHQoxw6lHszzpkAYZyPwezp2QML5XDeBnX9E7Et59/uXDCDykEuIAND/N2zTFs49J2rx
         9Vyw9vw7fAJcfVsB5c4C4k2zkFY1vCdLCmsft1kl6FpQW3MuePIiSimEZsG3gFikhENG
         wWYmefQV9sEHZEt9lDVBztx8tA3VTkCrz2kT4sFsGDwUCrULXgox/1mSMup2VooWjYhD
         1w41xnXjEl6aAG5ohsRSMb3Zut42s6lPA2QvtXGvVw2EBK+UzTA+yvtMXhB+TwPOt6gA
         9tvw==
X-Gm-Message-State: AOJu0YyUZyB2bDWPWNxl4Ul9cKjpXze8o+tKDiqnBpr/qYGGWcZwIQLP
	Q/pZk7/7g1CNK6wuTHZQBlCGyXLcUisUk5X2wZr2jmnAZgv9bF4EtjKFcUKouGw=
X-Google-Smtp-Source: AGHT+IEQ7HAH1hxT9CkF89yW0eFlBtH4KC1ypA+keYgd+I+P7OPhNkK0nRSZyExwwZXa+s8eh8neuQ==
X-Received: by 2002:a05:6a20:47de:b0:19c:6877:9943 with SMTP id ey30-20020a056a2047de00b0019c68779943mr405451pzb.41.1706227645567;
        Thu, 25 Jan 2024 16:07:25 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b001c407fac227sm64439plh.41.2024.01.25.16.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2024 16:07:25 -0800 (PST)
Date: Thu, 25 Jan 2024 16:07:21 -0800
From: Joe Damato <jdamato@fastly.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, kuba@kernel.org,
	willemdebruijn.kernel@gmail.com, weiwan@google.com,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Thomas Huth <thuth@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <20240126000721.GB1987@fastly.com>
References: <20240125225704.12781-1-jdamato@fastly.com>
 <20240125225704.12781-4-jdamato@fastly.com>
 <2024012558-coasting-unlatch-9315@gregkh>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024012558-coasting-unlatch-9315@gregkh>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Thu, Jan 25, 2024 at 03:22:34PM -0800, Greg Kroah-Hartman wrote:
> On Thu, Jan 25, 2024 at 10:56:59PM +0000, Joe Damato wrote:
> > Add an ioctl for getting and setting epoll_params. User programs can use
> > this ioctl to get and set the busy poll usec time or packet budget
> > params for a specific epoll context.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  .../userspace-api/ioctl/ioctl-number.rst      |  1 +
> >  fs/eventpoll.c                                | 64 +++++++++++++++++++
> >  include/uapi/linux/eventpoll.h                | 12 ++++
> >  3 files changed, 77 insertions(+)
> > 
> > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > index 457e16f06e04..b33918232f78 100644
> > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > @@ -309,6 +309,7 @@ Code  Seq#    Include File                                           Comments
> >  0x89  0B-DF  linux/sockios.h
> >  0x89  E0-EF  linux/sockios.h                                         SIOCPROTOPRIVATE range
> >  0x89  F0-FF  linux/sockios.h                                         SIOCDEVPRIVATE range
> > +0x8A  00-1F  linux/eventpoll.h
> >  0x8B  all    linux/wireless.h
> >  0x8C  00-3F                                                          WiNRADiO driver
> >                                                                       <http://www.winradio.com.au/>
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 40bd97477b91..73ae886efb8a 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -6,6 +6,8 @@
> >   *  Davide Libenzi <davidel@xmailserver.org>
> >   */
> >  
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> >  #include <linux/sched/signal.h>
> > @@ -37,6 +39,7 @@
> >  #include <linux/seq_file.h>
> >  #include <linux/compat.h>
> >  #include <linux/rculist.h>
> > +#include <linux/capability.h>
> >  #include <net/busy_poll.h>
> >  
> >  /*
> > @@ -495,6 +498,39 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
> >  	ep->napi_id = napi_id;
> >  }
> >  
> > +static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
> > +				  unsigned long arg)
> > +{
> > +	struct eventpoll *ep;
> > +	struct epoll_params epoll_params;
> > +	void __user *uarg = (void __user *) arg;
> > +
> > +	ep = file->private_data;
> > +
> > +	switch (cmd) {
> > +	case EPIOCSPARAMS:
> > +		if (copy_from_user(&epoll_params, uarg, sizeof(epoll_params)))
> > +			return -EFAULT;
> > +
> > +		if (epoll_params.busy_poll_budget > NAPI_POLL_WEIGHT &&
> > +		    !capable(CAP_NET_ADMIN))
> > +			return -EPERM;
> > +
> > +		ep->busy_poll_usecs = epoll_params.busy_poll_usecs;
> > +		ep->busy_poll_budget = epoll_params.busy_poll_budget;
> > +		return 0;
> > +	case EPIOCGPARAMS:
> > +		memset(&epoll_params, 0, sizeof(epoll_params));
> > +		epoll_params.busy_poll_usecs = ep->busy_poll_usecs;
> > +		epoll_params.busy_poll_budget = ep->busy_poll_budget;
> > +		if (copy_to_user(uarg, &epoll_params, sizeof(epoll_params)))
> > +			return -EFAULT;
> > +		return 0;
> > +	default:
> > +		return -ENOIOCTLCMD;
> > +	}
> > +}
> > +
> >  #else
> >  
> >  static inline bool ep_busy_loop(struct eventpoll *ep, int nonblock)
> > @@ -510,6 +546,12 @@ static inline bool ep_busy_loop_on(struct eventpoll *ep)
> >  {
> >  	return false;
> >  }
> > +
> > +static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
> > +				  unsigned long arg)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> >  #endif /* CONFIG_NET_RX_BUSY_POLL */
> >  
> >  /*
> > @@ -869,6 +911,26 @@ static void ep_clear_and_put(struct eventpoll *ep)
> >  		ep_free(ep);
> >  }
> >  
> > +static long ep_eventpoll_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > +{
> > +	int ret;
> > +
> > +	if (!is_file_epoll(file))
> > +		return -EINVAL;
> > +
> > +	switch (cmd) {
> > +	case EPIOCSPARAMS:
> > +	case EPIOCGPARAMS:
> > +		ret = ep_eventpoll_bp_ioctl(file, cmd, arg);
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static int ep_eventpoll_release(struct inode *inode, struct file *file)
> >  {
> >  	struct eventpoll *ep = file->private_data;
> > @@ -975,6 +1037,8 @@ static const struct file_operations eventpoll_fops = {
> >  	.release	= ep_eventpoll_release,
> >  	.poll		= ep_eventpoll_poll,
> >  	.llseek		= noop_llseek,
> > +	.unlocked_ioctl	= ep_eventpoll_ioctl,
> > +	.compat_ioctl   = compat_ptr_ioctl,
> >  };
> >  
> >  /*
> > diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
> > index cfbcc4cc49ac..8eb0fdbce995 100644
> > --- a/include/uapi/linux/eventpoll.h
> > +++ b/include/uapi/linux/eventpoll.h
> > @@ -85,4 +85,16 @@ struct epoll_event {
> >  	__u64 data;
> >  } EPOLL_PACKED;
> >  
> > +struct epoll_params {
> > +	u64 busy_poll_usecs;
> > +	u16 busy_poll_budget;
> > +
> > +	/* for future fields */
> > +	u8 data[118];
> 
> You forgot to validate that "data" is set to 0, which means that this
> would be useless.  Why have this at all?

I included this because I (probably incorrectly) thought that there should
be some extra space in the struct for future additions if needed.

I am not sure if that is a recommended practice for this sort of thing or
not, but if it is I can add some validation.

Thanks for your time and effort in reviewing my code.

