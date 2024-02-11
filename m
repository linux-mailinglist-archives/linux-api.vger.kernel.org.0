Return-Path: <linux-api+bounces-938-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2355850855
	for <lists+linux-api@lfdr.de>; Sun, 11 Feb 2024 10:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BD40B2173F
	for <lists+linux-api@lfdr.de>; Sun, 11 Feb 2024 09:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F77A59B52;
	Sun, 11 Feb 2024 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4A4yBvs"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAE059162
	for <linux-api@vger.kernel.org>; Sun, 11 Feb 2024 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707644150; cv=none; b=MzSFpgChxPGmmmoLLLI7rIqMNYUk7z5dvylpQcmXQl8kJc5THvbpoziqqE0w8WvqHgokbazv+WRon0hLhKDR2x9z6388BHvvDk97jA7K1iCSaXiKJRQ0BTlaXgRVREvXO+RmXT+UY1oJhBFKXJCOnf7bSyirRVs+OPY2F6xNEik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707644150; c=relaxed/simple;
	bh=TH4wZS24qpSRB2owdnOAq4iTMgyZlVFrxUPzmwbgadQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiR2wzEgBM/DNn6eYDw8EKFWH6x2k7V1G1FvVpBJUVvNfjkf1oFxLfHtq8kPM+ZcMcUDiWUaK9BkfJWz01Et4k9jrp1xjTrfra69WUdMYSvRBBb2k4cqe/QodaDYjZn8E5E08nrUyj70/P9mHAbo3EZMi7P0/oQfS9GOpX+7QEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4A4yBvs; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5115f93fe57so7780e87.0
        for <linux-api@vger.kernel.org>; Sun, 11 Feb 2024 01:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707644145; x=1708248945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH4wZS24qpSRB2owdnOAq4iTMgyZlVFrxUPzmwbgadQ=;
        b=r4A4yBvsjLYgXqrUYk1g7+Hha9nknbmYFOOeXcOLFRvu6pS3mogduSNZrTOx180v3k
         +CBxzg5z0g72d/44Paf7+pkxBsWSxBoTSNTpcDDbMV4/hwiU6TkwnZMpTrueyki8l2/Y
         24tAV8zVFYRvhRkQmG2ZJpZDgAE9+MqhgwnQxex/awC8es1xGI5PEqLQeZVzIP2ZGt1e
         DGuaMMqcmnKrDl9Jn3G9cFa7+4G6R6ikmf/R6aQ6siv32eHTTb20w6NaQmDMAoBmQXmi
         6ixjUo/J9URQ/JtWis+tLl8OtME5CUGvWDAG5QH1HGBxMc5EgRAUWmK28pWWWhEu9C98
         hOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707644145; x=1708248945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TH4wZS24qpSRB2owdnOAq4iTMgyZlVFrxUPzmwbgadQ=;
        b=TtxHdz0I4c92WSL2DofQ9ToHvBN44RxqRV00m6gCj0gLcP1FPFs70zW9b3Tsy9kjK1
         qF7DEa5Z/hF8/xREK2+MIZhQrbN9t0GKURlb0MXZZkhjBNVuqQpf4ix7QeNSyQN0y7Jv
         25O13n0DNINYUtt4lNTnIGmo7EtXY6rhkvMU/zIG4QyvQi6WCElxt7FL9qI5d6q7rOIS
         Jer5/qyCPfJjxwG0TEuhuV2lQFV7QyIepOBzUW4MseHOL2Yb1MrRh3sm7YnMxk7zzodH
         mopVB6UgMofOoVwqClWXKgVCg6jkIJkcYR/nf+mESrPf86+/0ew1EZDkuYRX6Qr0D3t3
         66Hw==
X-Gm-Message-State: AOJu0YyNIoWCTx6FDhwd4MY2hebzvhXNi4RQ4U0aq/6UBS9GWrBr2QJP
	mCRzWEObIbraJuH9EhTnHvRPxjUPHoUEsw2dtZ0HFNpQgb9N5gVLrmMyLMrjtWvOt6nPwkBcYag
	3m47Q6jIbaHWUXKzZvkdyNc62sSVfFJs3B4bs
X-Google-Smtp-Source: AGHT+IH6GSO5X0Nc2TMuWJvjnMysLYSOkmwizWQnAr5k97RFt+AZfM1Nt+KJVr8tFK+KmAahy67pV89IjCQH61jhG4E=
X-Received: by 2002:ac2:5e8e:0:b0:511:7373:3ca8 with SMTP id
 b14-20020ac25e8e000000b0051173733ca8mr54923lfq.3.1707644144566; Sun, 11 Feb
 2024 01:35:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209211528.51234-1-jdamato@fastly.com> <20240209211528.51234-2-jdamato@fastly.com>
In-Reply-To: <20240209211528.51234-2-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 11 Feb 2024 10:35:31 +0100
Message-ID: <CANn89i+fBA1EQJdcgiwatcX4bdW0DXCEoHQC7ps-TboCt-p5hQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/4] eventpoll: support busy poll per epoll instance
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

On Fri, Feb 9, 2024 at 10:15=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Allow busy polling on a per-epoll context basis. The per-epoll context
> usec timeout value is preferred, but the pre-existing system wide sysctl
> value is still supported if it specified.
>
> busy_poll_usecs is a u32, but in a follow up patch the ioctl provided to
> the user only allows setting a value from 0 to S32_MAX.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Acked-by: Stanislav Fomichev <sdf@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

