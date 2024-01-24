Return-Path: <linux-api+bounces-611-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4511C83A3FE
	for <lists+linux-api@lfdr.de>; Wed, 24 Jan 2024 09:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A51BB26A97
	for <lists+linux-api@lfdr.de>; Wed, 24 Jan 2024 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D010117551;
	Wed, 24 Jan 2024 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6Sbw5ps"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0741F17552
	for <linux-api@vger.kernel.org>; Wed, 24 Jan 2024 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084427; cv=none; b=Q2B1Bf6Gkxkk5y63bO9KQiyAfcCC+Z4DR8vH04ZHUKwLal/r/RqQ7PlyoyT6LbCL3Y4YDuyKLOlCcntDTCfivoDrceyoPsoHgu3/37y6lMXCOsmOpOTkjROIR+fsRntjVKjk43NaKqnQvS3X5Qt0VLmqTfsjLNBTw/dCkUZxz6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084427; c=relaxed/simple;
	bh=V1slcYn21bNXk9V5C8Z6VKwUpsBDUlYBYxAW8Xe7/lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgajhIrMOEPTHkA557udPMJjOEiinfbPlgS5VqTpFC6bgtvyzJcjtbJGOe32IeArTYH721+2j7RybSScCf8cN6wvemRrsOQyzA9xW/1VvDXjlhsPJAOfGziL53O1Ga9bWvg9svB6b+o2AeEIbbNWTWvyDjOjHqhCKJKO5BZ4jyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X6Sbw5ps; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso11544a12.0
        for <linux-api@vger.kernel.org>; Wed, 24 Jan 2024 00:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706084424; x=1706689224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjsqHxMZBRtxTxUYbNLydDXP9JAwq1MY641LAHVQss8=;
        b=X6Sbw5psGSIi7KBm+5Eg/Z+CUy0Fs2MuiwTIpVYeULrq6lM8r7jsjeqSM7egImr6/g
         xdrz82Wq2fYHVgPEl6k7uSD1pD5SXkOLH1cRi4VbvkXqxZWGK5BE0l4Bk6U301/MZ4HQ
         a0JdIH6YfnhxMM8egUYWkrUOkoehh96lDs7/6pZrvV3zSgzuqWjXPXFYWbIoL3zMgZQW
         op8uW3+I+cp3587KOu89R1PZI2iIb9PqaPshNYwprgxopJO/nEUV69etYhNSFoIOxtei
         SBKavukmyrzQfU6yqa2e00s7jVLDoBb5KaO+VApSJFoJ4QJT/o0jnT4xIMqaCVYIQTc2
         cANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706084424; x=1706689224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjsqHxMZBRtxTxUYbNLydDXP9JAwq1MY641LAHVQss8=;
        b=DYjouD9L6Ne02Mx8EVwStBDCW0sOqDDBAqv/yQ7wHWdgW6gx+h9GYLYa7MxZDnjnJ1
         PEBEVYckQj4aWA42StDWgS0pbY1dWxCumDTx7qJHi7MoHzV0WT3kcSVnBUctoNE1E81d
         D2p5Wb6i/IG7ahlySG4TzCCUcTajQc0CK453Oy7inIUOjuXyZ2j4uOCj7utQEV4LREvX
         a906DzKNkUFPhMdFGpd1B+9bHy/tsbQf2uDq4IqDK2yV7VmjuMpBWhWKlc8FUzoEUrPE
         Zp9t1JlHdHfM3Ue+xRY2fDWLE77uK/Wp/rHldMp//T9dnjFXQ8rrf81qFLcTqFFvCk5Z
         qHxw==
X-Gm-Message-State: AOJu0Ywz0zHEi7aTiGZr13spqggZWUWPyyJDRhQMGrlU+efFmqqOJvK3
	DzCEzK7WUXwdbNJRyAq/Dz8U3glWcUNjhdjHQ1hBoDTcDHfHhD0mCQ7W8/ICgnlOjtjcOCp1SKv
	874tVLGmOq0G6shp2Ayv0BbVNTAFilLOMR3Mp
X-Google-Smtp-Source: AGHT+IHz4WfxrkWGJUNOWseJkH5AnLnDQaRvNbFcz/95E/NWPxNCQvP1kyyChOKaaGag+8A4H9iRGQ2u8INjs6UvIt4=
X-Received: by 2002:a05:6402:368:b0:55a:5fe0:87e4 with SMTP id
 s8-20020a056402036800b0055a5fe087e4mr64407edw.0.1706084423970; Wed, 24 Jan
 2024 00:20:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124025359.11419-1-jdamato@fastly.com>
In-Reply-To: <20240124025359.11419-1-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jan 2024 09:20:09 +0100
Message-ID: <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
Subject: Re: [net-next 0/3] Per epoll context busy poll support
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org, 
	brauner@kernel.org, davem@davemloft.net, alexander.duyck@gmail.com, 
	sridhar.samudrala@intel.com, kuba@kernel.org, Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 3:54=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Greetings:
>
> TL;DR This builds on commit bf3b9f6372c4 ("epoll: Add busy poll support t=
o
> epoll with socket fds.") by allowing user applications to enable
> epoll-based busy polling and set a busy poll packet budget on a per epoll
> context basis.
>
> To allow for this, two ioctls have been added for epoll contexts for
> getting and setting a new struct, struct epoll_params.
>
> This makes epoll-based busy polling much more usable for user
> applications than the current system-wide sysctl and hardcoded budget.
>
> Longer explanation:
>
> Presently epoll has support for a very useful form of busy poll based on
> the incoming NAPI ID (see also: SO_INCOMING_NAPI_ID [1]).
>
> This form of busy poll allows epoll_wait to drive NAPI packet processing
> which allows for a few interesting user application designs which can
> reduce latency and also potentially improve L2/L3 cache hit rates by
> deferring NAPI until userland has finished its work.
>
> The documentation available on this is, IMHO, a bit confusing so please
> allow me to explain how one might use this:
>
> 1. Ensure each application thread has its own epoll instance mapping
> 1-to-1 with NIC RX queues. An n-tuple filter would likely be used to
> direct connections with specific dest ports to these queues.
>
> 2. Optionally: Setup IRQ coalescing for the NIC RX queues where busy
> polling will occur. This can help avoid the userland app from being
> pre-empted by a hard IRQ while userland is running. Note this means that
> userland must take care to call epoll_wait and not take too long in
> userland since it now drives NAPI via epoll_wait.
>
> 3. Ensure that all incoming connections added to an epoll instance
> have the same NAPI ID. This can be done with a BPF filter when
> SO_REUSEPORT is used or getsockopt + SO_INCOMING_NAPI_ID when a single
> accept thread is used which dispatches incoming connections to threads.
>
> 4. Lastly, busy poll must be enabled via a sysctl
> (/proc/sys/net/core/busy_poll).
>
> The unfortunate part about step 4 above is that this enables busy poll
> system-wide which affects all user applications on the system,
> including epoll-based network applications which were not intended to
> be used this way or applications where increased CPU usage for lower
> latency network processing is unnecessary or not desirable.
>
> If the user wants to run one low latency epoll-based server application
> with epoll-based busy poll, but would like to run the rest of the
> applications on the system (which may also use epoll) without busy poll,
> this system-wide sysctl presents a significant problem.
>
> This change preserves the system-wide sysctl, but adds a mechanism (via
> ioctl) to enable or disable busy poll for epoll contexts as needed by
> individual applications, making epoll-based busy poll more usable.
>

I think this description missed the napi_defer_hard_irqs and
gro_flush_timeout settings ?

I would think that if an application really wants to make sure its
thread is the only one
eventually calling napi->poll(), we must make sure NIC interrupts stay mask=
ed.

Current implementations of busy poll always release NAPI_STATE_SCHED bit wh=
en
returning to user space.

It seems you want to make sure the application and only the
application calls the napi->poll()
at chosen times.

Some kind of contract is needed, and the presence of the hrtimer
(currently only driven from dev->@gro_flush_timeout)
would allow to do that correctly.

Whenever we 'trust' user space to perform the napi->poll shortly, we
also want to arm the hrtimer to eventually detect
the application took too long, to restart the other mechanisms (NIC irq bas=
ed)

Note that we added the kthread based napi polling, and we are working
to add a busy polling feature to these kthreads.
allowing to completely mask NIC interrupts and further reduce latencies.

Thank you

> Thanks,
> Joe
>
> [1]: https://lore.kernel.org/lkml/20170324170836.15226.87178.stgit@localh=
ost.localdomain/
>
> Joe Damato (3):
>   eventpoll: support busy poll per epoll instance
>   eventpoll: Add per-epoll busy poll packet budget
>   eventpoll: Add epoll ioctl for epoll_params
>
>  .../userspace-api/ioctl/ioctl-number.rst      |  1 +
>  fs/eventpoll.c                                | 99 ++++++++++++++++++-
>  include/uapi/linux/eventpoll.h                | 12 +++
>  3 files changed, 107 insertions(+), 5 deletions(-)
>
> --
> 2.25.1
>

