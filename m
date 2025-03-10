Return-Path: <linux-api+bounces-3383-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 184E2A58B9B
	for <lists+linux-api@lfdr.de>; Mon, 10 Mar 2025 06:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5463ABD8B
	for <lists+linux-api@lfdr.de>; Mon, 10 Mar 2025 05:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923EF1BD9CE;
	Mon, 10 Mar 2025 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3b7+P4x"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89582F28;
	Mon, 10 Mar 2025 05:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741583887; cv=none; b=opj5bvRLXhus7gxglsjpDpoaI89+orFUQN+cTm3lMKhvzJU26r8OnwqjQ+cQN/0cG/1fqv747Z6SF3PXhss8lM+hxRlKeJ39kI/5IErww6V1vyp/BGuXws0MRh5wN3t4rHt7BQmokxriarjeRw900HlXTiUzmYu7QYRhd5NR2IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741583887; c=relaxed/simple;
	bh=Hr6dm8+vaqc3OqPrz1rHRqYhRKP7Pxqi/dGeBP+3CIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwezCNmAEVxTuLD13obInQfXMt+dxIUDxOAspmsPBzBEKKOznFlYugRKHBngHfms6QtcNf4bMqxS55GI3gq5mQRg1cdj8FS0nONjwyDiTpO9hQqdaG4JqYZVvjbrOOQCnIqOXBwSwIEn48Z58DitQrzSslz2mA9akeOk1ePJlX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3b7+P4x; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-851c4ee2a37so255511339f.3;
        Sun, 09 Mar 2025 22:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741583885; x=1742188685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnjrLHP+/mAR/fM/nAqiOmcoWWA8l8pmKRt+RSb9P44=;
        b=c3b7+P4xKXLeM7puh4xH3epGX6eTnxUXWNMX91tdBpL0kB+u+FcmI53czlix6q9A1r
         I+A4TDv0h/G+h7lWpVQgRj7UO3wK/fByGQOOkhJfBk7R/pXrB6ABTilAywvKIoo6n+2H
         /58uz0zEsFWkb7Ig2accTl2WZuIUydZoyNFvWoLslTY5ZXUVEp7edKuWCJH2BRZfB0Mk
         E4W4q69kGffN23ay2MuW17J787UNf0A1c517IHAkHq+GRwrDl4ZD0PnIi8XBSJ3Irfmu
         3hq/YrZy7kZVaNkXShFhPmFxNfPWdc7WDZjTNGRfOrO2oFk953BsQ/xzvrjLlsCNfkuF
         hsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741583885; x=1742188685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnjrLHP+/mAR/fM/nAqiOmcoWWA8l8pmKRt+RSb9P44=;
        b=tjUcUWbdRMXigSR9OMtkKwN8VWw/XvYtdcWJanCSHYfgib6jYNtZiPm8y5CCspQEG9
         n6zIv2BUg6OEDkT2lQnAPwUoThMoDh0Yq1ZX4h0O3CbmY7KF1MDJvEaRXOn1advtjK3A
         OM4V2zUDHpayMIOlZhoMrRqsGRGomna4cHdCZKZW4BhFwGAznJZuE8RgQ8GeK9JRceRr
         dZ6Q3tz1Agy9H1Xhx/rM+DXORfa1uzVDegBYC0+JLUBU3BfIGy/0gUHG52CxY2jOMi0A
         toQTdMKLz6P2/OvRdysFuqEfQkmfzQg+m6BlWM2wFbGipDJnwkyAVYYxJtk1drd4iYU7
         gsiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqGuPWXdv8/N5DDt1KwOH48PoO/5zHe5MvRDAC8kVhZo7Og0PqeURAnfA946vSVLvWiEyjthta@vger.kernel.org, AJvYcCXxUj1RwF92pVpGfh+OeaPrEkvQjIABfGKLmQyBURnhEUPDzGNG56+elhTy56SLWq5GtNWbeT0wmc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Mdkw/kPpCrQa/dRuS+EaMF8DJJWSNd9+X4ElwgiM/LvT7E5Z
	XWSjSaOxCFwCZbJ9td9G7971nCRz4N933uZwVJ9o6K2ch0KnObzIh3COjRHC4pmiD4Uj2wxS+fc
	TEzeCgVaaAFqp/faWtDhoqg1bma0=
X-Gm-Gg: ASbGncu+4idUJDghci6yY+pZO4mLoGf0fLLHD2lua2APr8Wq8IgyiEo1SZehMqTtjOv
	BfSPC/eU6SCC5E7qCGdASmmu5WjLXH+9UWlQysenrCMflKpT0zDyQAsTtNMSEE0Ngfvg2qv+WxF
	QcItlr643+yXR2ABYLZoe80M8l
X-Google-Smtp-Source: AGHT+IFP+n3sL1pJWnj8bm6Gk8h3kDSQpJ6gaLpfsSjtdIFOsfGnMHwOuEOqSD1UlAxSyQuCDHFxEmFe2SV3FKGCutQ=
X-Received: by 2002:a05:6e02:221c:b0:3d3:d965:62c3 with SMTP id
 e9e14a558f8ab-3d441943943mr160523555ab.15.1741583884941; Sun, 09 Mar 2025
 22:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FC9BF302-0724-49F3-AD7C-6761D65024A1@Easton24.com>
In-Reply-To: <FC9BF302-0724-49F3-AD7C-6761D65024A1@Easton24.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 10 Mar 2025 06:17:28 +0100
X-Gm-Features: AQ5f1Jph8R5O_2QQgzMO0MCThPMCP2F_G6ndzKT3w47zZAIVTe9_hYEncpdWV6o
Message-ID: <CAL+tcoB=4-dCWaEZL7HqLM+2j__iW+LrZANd+RAL4PkxE+kkCw@mail.gmail.com>
Subject: Re: Add sysctl for tcp_delayed_ack
To: Andrew Easton <Andrew@easton24.com>
Cc: "David S. Miller" <davem@davemloft.net>, "David S. Ahern" <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, 
	"Linux Kernel Mailing List, Network Subsystem" <netdev@vger.kernel.org>, 
	"Linux Kernel Mailing List, Sysctl API ABI" <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, Mar 10, 2025 at 2:33=E2=80=AFAM Andrew Easton <Andrew@easton24.com>=
 wrote:
>
> Subject: Add sysctl for tcp_delayed_ack
>
> Hi everyone,
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

Thanks for proposing this patch :)

As to the idea itself, my personal feelings are:
1) It might be suitable for local kernels instead of public kernels,
even though we internally have a similar patch a few years ago
already.
2) The reason why I hesitated to submit a patch like this before is it
may change/override the default socket behavior which may bring
unexpected impacts. It's a global knob...
3) To be frank, the delayed ack mechanism prevails for so many years
and truly solves too many pure ack packets on the wire issue. And I
believe only a minority of clients try to turn it off.
4) Recently, I was thinking of implementing a delayed ack max timeout
(which you can refer to tcp_delack_max() and see how it works). As I
mentioned, I also hesitate to do so.

Of course, no matter what my thoughts are, it finally depends on the
TCP maintainer's call :)

Thanks,
Jason

> likely missing a whole bunch of details.  For
> example:
>
> 1. Where is the TCP ACK delay computed for IPv6?
> Could not identify this in file net/ipv6/tcp_ipv6.c .
>
> 2. Perhaps, adding kernel configuration options for
> the ncurses interface is desireable.  What is a good
> example to learn from?
>
> 3. Perhaps, setting constants in file
> include/uapi/linux/sysctl.h may be unnecessary, but I
> have not found any guidelines on when these CTL
> numbers are necessary.  Likely, because I did not
> read the documentation carefully enough.  Any
> pointers are appreciated.
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
> Thank you for sharing your time.
>
> Andrew
>
>
>
>
>

