Return-Path: <linux-api+bounces-2732-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586E29C7AEE
	for <lists+linux-api@lfdr.de>; Wed, 13 Nov 2024 19:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA7A1F20CE2
	for <lists+linux-api@lfdr.de>; Wed, 13 Nov 2024 18:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAA320125C;
	Wed, 13 Nov 2024 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="L2rlqAX9"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D159A33997
	for <linux-api@vger.kernel.org>; Wed, 13 Nov 2024 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521965; cv=none; b=kwq05f+ghuHNqmBlhUkiwRIsAMaMLsrMOdgZVOJBf/eeZc9iwd0KbcjJLuevDgjK/DRJwOGfz0q/TnGQGPcmPqez7ILxR5zrKDDQ5gYti5AAOkYFpVts26nyi+rEct7Uttpiq9lyWJ1ogJ9p0T3sk36veDSuHDPuSW+7TBFn3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521965; c=relaxed/simple;
	bh=wUFntQ5VTOfIhluwvaHf2X1W9flx8X7MOYtVV88XRU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TehKBMWZwq1WWgkbZXWM92V8OEtXza3NNDWOODaVHmp/kkP7gTPoH13ULDjKhUdeYw7NW31ecYIPlUZzsBbF6ZC61MFPI9qc18xP/f4EwRuxN7LG2abryeTsaJCm1FeodZ0qTC1UYcbz6+fNwN3Du+wjGgC9bSvW7O833nBqbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=L2rlqAX9; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wUFntQ5VTOfIhluwvaHf2X1W9flx8X7MOYtVV88XRU4=; t=1731521963; x=1732385963; 
	b=L2rlqAX9rw9br7yp+YKW8sQGdwiSEgUVFp8Q4H26aKC+94cPe6uD8EtujERPBMRLsuvPXjzfQ7a
	ZE+fyMshViPmgbLxdCQXL1DQK2BXP+HaI+SjVZo/pUUo6FPWggALWFKrUmBZCTGZw7X+ddJXWpBx8
	mbUl8VXRZPGxYmYiJ6zh6s+R/sEeKiN3RXWQwgAkEnaLJCdZFU7ZE2SDP40ojTPn6a1vimNtqy9Yg
	VshEJsJLKzWpnnwXbbadhfcUQV5j3Sc1eJ5/21vKVNCv6qdtl+pLU8NlAMA+vkGl1BCVFDSIiuIKr
	Wisj4EzmCZJPfaR1Pw33BwTmXLjPcPxzqEuA==;
Received: from mail-ot1-f54.google.com ([209.85.210.54]:49537)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tBHxV-0003Mm-2m; Wed, 13 Nov 2024 10:19:17 -0800
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71806621d42so3950739a34.3;
        Wed, 13 Nov 2024 10:19:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqCZbbiFPEp2Wwb45eYAfg4fcZXaxZa6eNnZ8xdJs5VoQf6P0cudsZJHrQR8Yd/vQOT5VO56Eg0xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkSystH9co5ZrMLCgALUlj6iLOYVpHztiSrlJy2tJ2eppfZNxx
	kaeUOK2XIS05g13DCIlOozqLdLw1ndWW0InAR5+pJNYlkkLR2KFI8Q9s8+khSiUZwpbxx9mtrvu
	EB6tJDSSE5mFbm/NiimqcbVQImZ4=
X-Google-Smtp-Source: AGHT+IHUkdY3c6EH87qpGKjX6N1/cCuu/5QlKEgrkRGTk1ynI8DIiCxQE3Ax203yy7PGaQDs6EW+ShWS74md9fudSfg=
X-Received: by 2002:a05:6830:3813:b0:718:2eb7:4ebe with SMTP id
 46e09a7af769-71a601fd3b9mr4749876a34.27.1731521956454; Wed, 13 Nov 2024
 10:19:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111234006.5942-1-ouster@cs.stanford.edu> <20241112174834.43231a32@kernel.org>
In-Reply-To: <20241112174834.43231a32@kernel.org>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 13 Nov 2024 10:18:39 -0800
X-Gmail-Original-Message-ID: <CAGXJAmy2LybL-2-JJy+FJ69gozJkqD7vBOCiNvpdYyAgWOXWzA@mail.gmail.com>
Message-ID: <CAGXJAmy2LybL-2-JJy+FJ69gozJkqD7vBOCiNvpdYyAgWOXWzA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/12] Begin upstreaming Homa transport protocol
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 0.8
X-Spam-Level: 
X-Scan-Signature: 5e15904e367bf57319d290d73554c551

On Tue, Nov 12, 2024 at 5:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 11 Nov 2024 15:39:53 -0800 John Ousterhout wrote:
> > This patch series begins the process of upstreaming the Homa transport
> > protocol. Homa is an alternative to TCP for use in datacenter
> > environments. It provides 10-100x reductions in tail latency for short
> > messages relative to TCP. Its benefits are greatest for mixed workloads
> > containing both short and long messages running under high network load=
s.
> > Homa is not API-compatible with TCP: it is connectionless and message-
> > oriented (but still reliable and flow-controlled). Homa's new API not
> > only contributes to its performance gains, but it also eliminates the
> > massive amount of connection state required by TCP for highly connected
> > datacenter workloads.
>
> Hi John!
>
> Thanks for pushing forward! I wanted to give you a heads up that we're
> operating at 50% maintainer capacity for the next 2 weeks so the
> reviews may be more muted than usual. Don't hesitate to post new
> versions (typically ~once a week) if you want to address any incoming
> feedback and/or the build issues.

Thanks for letting me know.

-John-

