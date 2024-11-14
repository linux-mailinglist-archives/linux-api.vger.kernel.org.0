Return-Path: <linux-api+bounces-2734-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 275999C9063
	for <lists+linux-api@lfdr.de>; Thu, 14 Nov 2024 18:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EB4281E83
	for <lists+linux-api@lfdr.de>; Thu, 14 Nov 2024 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F04A188708;
	Thu, 14 Nov 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="C9qycNCE"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A975216DEA9
	for <linux-api@vger.kernel.org>; Thu, 14 Nov 2024 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603621; cv=none; b=CZx8zJO3Dz4iP2Kps/D3xYdeTiKSf0sMzG/rd1M0cM93q5rRCcO7Q8JFmzHUCRzT+xNrn+qr2MoEh9B+HWfXHy//Ph/8C0xpDq5skB4Af5DiUfnhEwqXLTx0OM3HhEJVtIGEXP1MFZYugvtQmRekPVuiM0uBtylqytPa6KzI3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603621; c=relaxed/simple;
	bh=gNdbtjYOIbL4byOoWeWw0bdmSpuN/bjlwdTle0aQPt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLlAkakrkOeNh98RHoOWBBLwQ7EL+8lEJ3GSfB8TOjiXgpgNTGRQZJXLASIYGwncSd/pNExmTb1A9HRUMvO/Zm0DSNtDQi+RMAoW94O9C2rf0FxF54d5Rpjq83G4zIcapAumQXmWmv3hDUh5p4U3HFRvomRxJ1/7NWuEsO3l38A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=C9qycNCE; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MdmuPaPfM/Nt2GlsRu+YhnmQG89vlwOzyxPnZ/8L4h8=; t=1731603618; x=1732467618; 
	b=C9qycNCE2YTtAAFK9twvWbmldWA8WSHtGimGLTB4JmJboCg+MWS8BmTirwH7wxqmB5cbnHMxjJg
	YV0dUSpTm6IzFK6kcX5Logfa3YnO0HM9itUTsSm5+qmFOHw5bAPlLpdicemlFl7ZawEvKU2or3lOA
	KivdE0HRiAjCcPHru9cJRFp3zzGTrZoJ8fDA+S0vYqoi8c6xa4ofXgX9S2Xzz4h7f0+5Hkhr658js
	Xt2AhtS0cTyDs6AkYzbPUpo8Nw66RHChnWvQKPqBjnmMRQ/I9rfRwTmhy/ml+/MkxNiyDthgtCl9f
	0tGipNt0IyA4LY8gQ0dMO2JxDbms2wD8KiaQ==;
Received: from mail-ot1-f53.google.com ([209.85.210.53]:54296)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tBdCb-0006xB-En; Thu, 14 Nov 2024 09:00:18 -0800
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71811c7eb8dso498062a34.0;
        Thu, 14 Nov 2024 09:00:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfQHDwBMr2xRa05MG4jKATCq2ZjvE1DKWPSAql2t2rbNS4Xd1xL/tG/SkfON5QTo5cjR51uHX+yyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaEcXA+fK+quuAo/H83DUQeFQ8ATBn7Y9eKV4wRrGAjL1QGh/n
	tsbqwZWzsxwExP0tcu+Dx5yZxv3csYG4ebnkb4JcUAHhO3Rvpu31lZZxfxiGG+bDwv9j7dF5+dp
	m+lTU/YAgxFTGMq6M1n7euQdK9UA=
X-Google-Smtp-Source: AGHT+IFwYYSGJfhpHtho34vGG/wv5gzaMoGxXz7IdhS16MM5ee3UBacX0nNLPMf1UvHxQHBmjX/lKX6Mjbhbl74y0kk=
X-Received: by 2002:a05:6830:6b0c:b0:718:9c32:9fbf with SMTP id
 46e09a7af769-71a6e5da9b8mr3053414a34.22.1731603616853; Thu, 14 Nov 2024
 09:00:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111234006.5942-1-ouster@cs.stanford.edu> <ZzTcx8nmEKIJpaCR@pop-os.localdomain>
In-Reply-To: <ZzTcx8nmEKIJpaCR@pop-os.localdomain>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Thu, 14 Nov 2024 08:59:40 -0800
X-Gmail-Original-Message-ID: <CAGXJAmyGTwjFo6fGoROY=hQFXbR5RdpmpkEc9Zm6DOoD2nbwNA@mail.gmail.com>
Message-ID: <CAGXJAmyGTwjFo6fGoROY=hQFXbR5RdpmpkEc9Zm6DOoD2nbwNA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/12] Begin upstreaming Homa transport protocol
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 06ac0f501ed97ee7d2a3c5af22b79f06

On Wed, Nov 13, 2024 at 9:08=E2=80=AFAM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Mon, Nov 11, 2024 at 03:39:53PM -0800, John Ousterhout wrote:
> >  MAINTAINERS               |    7 +
> >  include/uapi/linux/homa.h |  165 ++++++
> >  net/Kconfig               |    1 +
> >  net/Makefile              |    1 +
> >  net/homa/Kconfig          |   19 +
> >  net/homa/Makefile         |   14 +
> >  net/homa/homa_impl.h      |  767 ++++++++++++++++++++++++++
> >  net/homa/homa_incoming.c  | 1076 +++++++++++++++++++++++++++++++++++++
> >  net/homa/homa_outgoing.c  |  854 +++++++++++++++++++++++++++++
> >  net/homa/homa_peer.c      |  319 +++++++++++
> >  net/homa/homa_peer.h      |  234 ++++++++
> >  net/homa/homa_plumbing.c  |  965 +++++++++++++++++++++++++++++++++
> >  net/homa/homa_pool.c      |  420 +++++++++++++++
> >  net/homa/homa_pool.h      |  152 ++++++
> >  net/homa/homa_rpc.c       |  488 +++++++++++++++++
> >  net/homa/homa_rpc.h       |  446 +++++++++++++++
> >  net/homa/homa_sock.c      |  380 +++++++++++++
> >  net/homa/homa_sock.h      |  426 +++++++++++++++
> >  net/homa/homa_stub.h      |   80 +++
> >  net/homa/homa_timer.c     |  156 ++++++
> >  net/homa/homa_utils.c     |  150 ++++++
> >  net/homa/homa_wire.h      |  378 +++++++++++++
>
> Hi John,
>
> Thanks for your efforts to push them upstream!
>
> Just some very high-level comments:
>
> 1. Please run scripts/checkpatch.pl to make sure the coding style is
> aligned with upstream, since I noticed there are still some C++ style
> comments in your patchset.

I have been running checkpatch.pl, but it didn't complain about C++
style comments. Those comments really shouldn't be there, though: they
are for pieces of code I've temporarily commented out, and those
chunks shouldn't be in the upstream version of Homa. I'll fix things
so they don't appear in the future.

> 2. Please consider adding socket diagnostics, see net/ipv4/inet_diag.c.

I wasn't familiar with them before your email; I'll take a look.

> 3. Please consider adding test cases, you can pretty much follow
> tools/testing/vsock/vsock_test.c.

Homa has extensive unit tests in the GitHub repo, but I thought I'd
wait to try upstreaming them until all of Homa has been upstreamed
(they are based on a modified version of kselftest.h, so they may be a
bit controversial). One way or another, though, I'm committed to
having good unit tests for Homa.

Thank you for your feedback.

-John-

