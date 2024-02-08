Return-Path: <linux-api+bounces-894-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D8984E717
	for <lists+linux-api@lfdr.de>; Thu,  8 Feb 2024 18:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E29DAB2DF90
	for <lists+linux-api@lfdr.de>; Thu,  8 Feb 2024 17:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3BD85957;
	Thu,  8 Feb 2024 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KGxzMiEg"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA682D6E
	for <linux-api@vger.kernel.org>; Thu,  8 Feb 2024 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414403; cv=none; b=N/0f4Ey6gW3AZydD6tiQivh0q9TI3Pdk3QY4e7y/78k/ofuitEBizoOqP794FhhTrIAo3rZwvlXHKSZqrXaHnROmCV8tsnKtBHHuIufwVnZpBul5LGVUqKwBq+8x0QFt7FFnAtFcLFnNyr39qfa6MSAMV1ZilRJwRwjSEMobCGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414403; c=relaxed/simple;
	bh=Py7HRHhj455qxh4xU917gX3i4Zes8iTl5X/CYKhz3Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFnbl/BMRyN1W2oJTSvuSVSCsud4LHH1p4nO3tKWpwPgn3rFyRijyaysup6NL2dizQRy/OFnvRidIslv21jb5dh5F1soT8L9guohnw+KEIWp8N7adcT2yWojrvVvr0UYzMvC2ISdWBqXGTkC8a/LWYkg68bAL16vp9B5z8mVaNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KGxzMiEg; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so15607a12.0
        for <linux-api@vger.kernel.org>; Thu, 08 Feb 2024 09:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707414399; x=1708019199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PMPKc00NAmkRCWW/G7NSXKaTTIPMdRIWuUINZCSHhs=;
        b=KGxzMiEgJK3Y/1wq0ztF+wa8JHY1+EUn9EY5qgem/3l9CJxESsVFrUujph9/Q7rLU1
         IQZwC3c8QeaW1fmAS9A5KpM0n7RtEdd9w90wUDcVrwSrItd6Bs37oV8u9ylB7FR3U+uk
         Qaal4lK1oXEZV2OOMID6JVLvY6txnDKyXybV5Tzf5oesH1lMo3wEtd5d76neTwqefHMV
         SwuwEDCbMnTo2b+KwnR3XUhFitLvnkLvVXZcPoMdlE8wHsAM3iPKGtILGfAKL+CwzA6m
         hjzfebyNKZTlHhlMeOsjsC7CJqN9VrG+V2KnBrmO4ynMMKTZO7aDVy2Zh2qw/SukXXxh
         AJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414399; x=1708019199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PMPKc00NAmkRCWW/G7NSXKaTTIPMdRIWuUINZCSHhs=;
        b=mgKYDlrT1teU913VzM2Q+KeQDujEPnrnPb5Nfb2IJxWU8TGGTg9zQlZb9CfaVSzqNR
         XcvgKELxVClGgrBJ8wlZmJbz5O7S0LiaqngNHPRpjmNDYwwm5f9SGFNc5JFGVL3k3beU
         RV6+6uNME5iJpAImRTaCcE7sl2GH0dylXRtWauE96TrQ0BGXNCu/mkSwcoHhoUfj3GKB
         tfbcgBVyDYkkCa2ZgLCpfjer39DiPMKTXza5t2FAqlLE9FICM+za6iRIsINLJIPYuKZN
         C/dBs0aQvvjXHo0B9Vve/X8m3mmdQDkDqCHEmQlNN+ivmSCm0VVq4DaxXEHUOOHwlAwO
         cF5A==
X-Gm-Message-State: AOJu0Yx1APPf7Ntw/znHYluJCkspkhCukD+gpnvFEVgNi6XCLnYD4JRz
	suznNExgsTv/qf13TU0wnU0epdTULS/qmezrcfmhwWP7PhZdsc8esv2d9tsewPqg6H/F04ejhGV
	gxWqGBjgNf8+XPTYvVQvl2hu8ezDCK9Yy7zew
X-Google-Smtp-Source: AGHT+IFnWEmP2cAjSe8OwUBNcFTY0/8xMomPNIqEx1e98Fd8Thr/4b5QpKWTr8aqOxp6VVsMdu9GHnorfOjfze+cwKk=
X-Received: by 2002:a50:9fcf:0:b0:560:e397:6e79 with SMTP id
 c73-20020a509fcf000000b00560e3976e79mr258edf.2.1707414399065; Thu, 08 Feb
 2024 09:46:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205210453.11301-1-jdamato@fastly.com> <20240205210453.11301-2-jdamato@fastly.com>
In-Reply-To: <20240205210453.11301-2-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Feb 2024 18:46:25 +0100
Message-ID: <CANn89iJY8mTn3PViBvTh_DewUKWjc0z3cvJvr8AcQgcbWC4G0Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/4] eventpoll: support busy poll per epoll instance
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org, 
	brauner@kernel.org, davem@davemloft.net, alexander.duyck@gmail.com, 
	sridhar.samudrala@intel.com, kuba@kernel.org, willemdebruijn.kernel@gmail.com, 
	weiwan@google.com, David.Laight@aculab.com, arnd@arndb.de, sdf@google.com, 
	amritha.nambiar@intel.com, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 10:05=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Allow busy polling on a per-epoll context basis. The per-epoll context
> usec timeout value is preferred, but the pre-existing system wide sysctl
> value is still supported if it specified.
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
>         /* used to track busy poll napi_id */
>         unsigned int napi_id;
> +       /* busy poll timeout */
> +       u64 busy_poll_usecs;
>  #endif
>
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> @@ -386,12 +388,44 @@ static inline int ep_events_available(struct eventp=
oll *ep)
>                 READ_ONCE(ep->ovflist) !=3D EP_UNACTIVE_PTR;
>  }
>
> +/**
> + * busy_loop_ep_timeout - check if busy poll has timed out. The timeout =
value
> + * from the epoll instance ep is preferred, but if it is not set fallbac=
k to
> + * the system-wide global via busy_loop_timeout.
> + *
> + * @start_time: The start time used to compute the remaining time until =
timeout.
> + * @ep: Pointer to the eventpoll context.
> + *
> + * Return: true if the timeout has expired, false otherwise.
> + */
> +static inline bool busy_loop_ep_timeout(unsigned long start_time, struct=
 eventpoll *ep)
> +{
> +#ifdef CONFIG_NET_RX_BUSY_POLL

It seems this local helper is only called from code compiled when
CONFIG_NET_RX_BUSY_POLL
is set.

Not sure why you need an #ifdef here.

> +       unsigned long bp_usec =3D READ_ONCE(ep->busy_poll_usecs);
> +
> +       if (bp_usec) {
> +               unsigned long end_time =3D start_time + bp_usec;
> +               unsigned long now =3D busy_loop_current_time();
> +
> +               return time_after(now, end_time);
> +       } else {
> +               return busy_loop_timeout(start_time);
> +       }
> +#endif
> +       return true;
> +}
> +
>  #ifdef CONFIG_NET_RX_BUSY_POLL
> +static bool ep_busy_loop_on(struct eventpoll *ep)
> +{
> +       return !!ep->busy_poll_usecs || net_busy_loop_on();
> +}
> +
>  static bool ep_busy_loop_end(void *p, unsigned long start_time)
>  {
>         struct eventpoll *ep =3D p;
>
> -       return ep_events_available(ep) || busy_loop_timeout(start_time);
> +       return ep_events_available(ep) || busy_loop_ep_timeout(start_time=
, ep);
>  }
>
>  /*
> @@ -404,7 +438,7 @@ static bool ep_busy_loop(struct eventpoll *ep, int no=
nblock)
>  {
>         unsigned int napi_id =3D READ_ONCE(ep->napi_id);
>
> -       if ((napi_id >=3D MIN_NAPI_ID) && net_busy_loop_on()) {
> +       if ((napi_id >=3D MIN_NAPI_ID) && ep_busy_loop_on(ep)) {
>                 napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_en=
d, ep, false,
>                                BUSY_POLL_BUDGET);
>                 if (ep_events_available(ep))
> @@ -430,7 +464,8 @@ static inline void ep_set_busy_poll_napi_id(struct ep=
item *epi)
>         struct socket *sock;
>         struct sock *sk;
>
> -       if (!net_busy_loop_on())
> +       ep =3D epi->ep;
> +       if (!ep_busy_loop_on(ep))
>                 return;
>
>         sock =3D sock_from_file(epi->ffd.file);
> @@ -442,7 +477,6 @@ static inline void ep_set_busy_poll_napi_id(struct ep=
item *epi)
>                 return;
>
>         napi_id =3D READ_ONCE(sk->sk_napi_id);
> -       ep =3D epi->ep;
>
>         /* Non-NAPI IDs can be rejected
>          *      or
> @@ -466,6 +500,10 @@ static inline void ep_set_busy_poll_napi_id(struct e=
pitem *epi)
>  {
>  }
>
> +static inline bool ep_busy_loop_on(struct eventpoll *ep)
> +{
> +       return false;
> +}
>  #endif /* CONFIG_NET_RX_BUSY_POLL */
>
>  /*
> @@ -2058,6 +2096,9 @@ static int do_epoll_create(int flags)
>                 error =3D PTR_ERR(file);
>                 goto out_free_fd;
>         }
> +#ifdef CONFIG_NET_RX_BUSY_POLL
> +       ep->busy_poll_usecs =3D 0;
> +#endif
>         ep->file =3D file;
>         fd_install(fd, file);
>         return fd;
> --
> 2.25.1
>

