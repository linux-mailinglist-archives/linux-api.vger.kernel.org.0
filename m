Return-Path: <linux-api+bounces-3384-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0535A58C6A
	for <lists+linux-api@lfdr.de>; Mon, 10 Mar 2025 08:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1669B7A1D4D
	for <lists+linux-api@lfdr.de>; Mon, 10 Mar 2025 07:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731E51C9B62;
	Mon, 10 Mar 2025 07:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qx+lJhgs"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15AB1A9B29
	for <linux-api@vger.kernel.org>; Mon, 10 Mar 2025 07:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590171; cv=none; b=dWsLCIOBWqNo93kqfGXcfKnn5ROlNxd2w9Oc95+oZkLnWir25ep1+onaFZ0pxcooJRHobbwo7vLYH/0PSZFgkZcDCZ+6piWuZpGirIAVfexBCeGxToFvHhkMh1yn7tX36mD1PrwymeW4Ordh4ChQwr13Tq48yF9ek8yKqEmc6ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590171; c=relaxed/simple;
	bh=wsGKS3Fr04RmYigMGjKeDJiiOm55ccB7rp5ESNSHMtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlkCkTT5OZaDcLle7+QNWUuHKv0N0vxatjzQxlTNpcT1U7Cp23RsQQd2EJkLA2Hgmdoa2iSd/cIvXJ8HwNkUy4lsxZzNc3DQLG3CmBQQYHUurOP1x8sRZsPNkrRaFhUK2qYXrlNlXcY71giuFpXXW6dIoIXqNk+07iYRtXb0kJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qx+lJhgs; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47520132245so29600001cf.2
        for <linux-api@vger.kernel.org>; Mon, 10 Mar 2025 00:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741590169; x=1742194969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giaMGz9fAIj0nasLN8wHzPqrCDCPt7HgRY0B2DvcrSk=;
        b=qx+lJhgslFc2WODYs5vzHce2cRTGwDHeUsQpCGlklDx5G5JHZpRaj1+lDeO74Dis+p
         knH02NQyWU8pHnnecUVaEIDLgWWmfuD+EtpLBtLjv3/MnvHBF7q8BEfdWIkv3JkGVFZZ
         UJtgzOTDmc1gG0TsJetVrmqq09L/t8RzK7vEhUhsdvk6i3VcpJ7ungloDBbeeY4/k+JQ
         40GH4ah/5VpDdEJQflW/d1TpNzqt6J5hpEtMopePUHDg3zP1NP1Z091OIolE8uUQiKM8
         xS6l24YEOOkchcQ09w0hVA41loLegCnszWwPly1CYoiBReBbAd5DoUHOf0BVLXPt8Ko8
         Ln9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741590169; x=1742194969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giaMGz9fAIj0nasLN8wHzPqrCDCPt7HgRY0B2DvcrSk=;
        b=G1K9jQFI1Ipv0bMMXYJd+pSJ9CniF953/1fHekg4YpzYN3Orbs8b6qCqji4xvax2UW
         X0fmAo/YDL6Xxy0c2C/JMdZGS7Y42gOyXFVeIcBZ24jmIstFbuzl1hi8KA08rxWD5zQc
         FlfZcizcXuAc0S+7pKsTrRpzdrKcIyz/ZbBbhI+a1QzHVS7IDxiyLMnY58TKuu1aLu6N
         RxfyHzkDAU1prkvT8rduZwYF46mqPr/zZ0V5ktcYzV/DUPufwjE0QzNCYsrMuasLxn1z
         E+Cvls/8rhA42BRjUHYmmSsKUYtdnVmcoRMShlyKmm87DjJRP8fzy9jAV/6wXXI1qH7y
         1JWA==
X-Forwarded-Encrypted: i=1; AJvYcCV+Mwlats2/UW7zFol4LsB8noY+htn4Wfx08wzLzmFbuixDgM1SjwwIY+GREAR4grJFh1JHb15zSJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAB6YyJY2emp1UabkGXpSfxlmw+4eOSTUYddukU5Hw6mBupTBw
	dPo+batxLiZ9F9gB90HuiwDjjcRE3F9HcGnDr7ZuUHlgit5e4WnHc5ixjTMn1QfA2bHafakqIca
	vCi4QCKkKPvwiJrxjlnW+kpL/1g8SD+Xz5gbS
X-Gm-Gg: ASbGncvm0m0nZCRg5rEwIEN3w3UbATDEFaexVg4miIjEdMwB7/j8Om9gAimQsabLE98
	J3aASICKGBDhG4RcebuZZQQ59KpY7mY17jvd1kXs2OvjxAwvy71wuKCtAOuI6yKfnnx/hBZQoYA
	NFvnBmmCuSEyHhR9Cgan3pyquxdg==
X-Google-Smtp-Source: AGHT+IFJOd4jBZTcTRTsGIyLvZXhWoVoSmhput8s2vumSWXEKK7hiyNdtl8nnfloxJ2B+Mtj2MRYgs2139AIqVtLxA8=
X-Received: by 2002:ac8:5f0f:0:b0:475:9b5:131d with SMTP id
 d75a77b69052e-4761097f7bamr167257151cf.12.1741590168320; Mon, 10 Mar 2025
 00:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FC9BF302-0724-49F3-AD7C-6761D65024A1@Easton24.com>
In-Reply-To: <FC9BF302-0724-49F3-AD7C-6761D65024A1@Easton24.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Mar 2025 08:02:37 +0100
X-Gm-Features: AQ5f1JrN8ZxP41V31M-8yqG6yQvKxQyjZqOPrl6XDCknts7GjzyDXy8V9AM6iwg
Message-ID: <CANn89iL1gca+f=3pJaNqnVk6yRd7q+8g-33NhfXbCzp9TLGLUw@mail.gmail.com>
Subject: Re: Add sysctl for tcp_delayed_ack
To: Andrew Easton <Andrew@easton24.com>
Cc: "David S. Miller" <davem@davemloft.net>, "David S. Ahern" <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Linux Kernel Mailing List, Network Subsystem" <netdev@vger.kernel.org>, 
	"Linux Kernel Mailing List, Sysctl API ABI" <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 2:20=E2=80=AFAM Andrew Easton <Andrew@easton24.com>=
 wrote:
>
> Subject: Add sysctl for tcp_delayed_ack
>
> Hi everyone,

Hi Andrew

>
> this is a proposed patch for adding a sysctl for
> disabling TCP delayed ACK (IETF RFC 1122)  without
> having to patch software to constantly poke sockets
> with TCP_QUICKACK which apparently resets on
> subsequent operations, see tcp(7).
>
> For my personal computer networks experimenting with
> globally disabling TCP delayed ACK across two other
> operating systems seems to have considerably improved
> congestion control.  (While I propose only anecdotal
> evidence, there is more to it.  Am open to the
> ensuing technical discussion, but only if that turns
> out to be a good use of other people's time.)
>
> This is my first proposed kernel patch and it is
> likely missing a whole bunch of details.  For
> example:
>
> 1. Where is the TCP ACK delay computed for IPv6?
> Could not identify this in file net/ipv6/tcp_ipv6.c .

No need to change tcp_ipv6.c

Generating ACK is generic, thus code is in net/ipv4

>
> 2. Perhaps, adding kernel configuration options for
> the ncurses interface is desireable.  What is a good
> example to learn from?

No need. per net-ns sysctl and/or per-socket options are far better
for this case.

>
> 3. Perhaps, setting constants in file
> include/uapi/linux/sysctl.h may be unnecessary, but I
> have not found any guidelines on when these CTL
> numbers are necessary.  Likely, because I did not
> read the documentation carefully enough.  Any
> pointers are appreciated.

sysctl.h is absolutely deprecated.
No need for NET_IPV4_TCP_DELAYED_ACK,
No ctl_name in 'struct ctl_table'

>
> 4. The default should probably be a value like
> net.ipv4.tcp_delayed_ack=3D1 that preserves the current
> behavior and hence is backwards compatible for user
> space.  A value of net.ipv4.tcp_delayed_ack=3D0 should
> globally (for IPv4) disable TCP delayed ACK.  Would
> also like to add the option for IPv6, but see point
> (1).
>
>
> In case a similar sysctl has already been proposed
> and rejected in the past, please point me to the
> mailing list archives, if that is not too
> inconvenient.
>
>
> Which questions have I failed to ask that I should
> have asked?
>
> Errors and lack of research are on me.
>

Make sure to compile/test your patch on top of net-next tree, and send
it inline,
not as an attachment, so that we can comment on it.

Also next time add benchmark results
like netperf -t TCP_RR (200 flows)
of netper/tcp_rr -F 1000

No delaying ACK for small RPC is essentially doubling the number of
packets to send and receive.

> Thank you for sharing your time.
>
> Andrew
>
>
>
>
>

