Return-Path: <linux-api+bounces-2767-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B329D2FEC
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2024 22:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E368AB222AB
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2024 21:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57F81D0E07;
	Tue, 19 Nov 2024 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="R7fTDWEh"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB5D1547FF
	for <linux-api@vger.kernel.org>; Tue, 19 Nov 2024 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732050855; cv=none; b=EZkvC7Zf+/CerLCecalDAtznKUGE/iY/iqam3GJu7a8SXzvmIKXoF5hllE9fxsnrCNg1a4I2FNC5ht9+zo3/XrUt1VziHPbHHJNkOLwNmpgxkQKkG05zdgVm8duSH9kmQ7AEj/G1lldADhe5NoKhAxQgtZmPAfzhSs97qrBsZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732050855; c=relaxed/simple;
	bh=vFK+7/PVzpZHRk2tpCqhhDOFwfZE7hAwKf6cKiwgtpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WssWAN9vTlvOXukuZNiN37AOi30rovrfqsWHvz56oGkNm6vqZQBTbS3z/rVTmtZ/Y5rIoyAGirxgBIgMg+TwiFZj2m1rIV8OFDflSjJEQRClkShi6lOxbW6upQ/oKEhvB4fpQ+E7J4pDKUTTaWTByMetu/icBBg4L4U5EewA5eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=R7fTDWEh; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vFK+7/PVzpZHRk2tpCqhhDOFwfZE7hAwKf6cKiwgtpM=; t=1732050854; x=1732914854; 
	b=R7fTDWEhxZoPR2hCeITUvn9cJLUIJD3NbDLoDYO9OWWuKqAGMcmg5xh8U090UPQCOaoubtnXRDh
	pik1SX0l3mKedKG76E4RC4A4or+nZEpdACMJa95XNClHarG1LE4ZKsUMi6g5y3K4r4+J+otIeNfZN
	3PO4fMCQpxB07pb7pvz/3h7sDinEgq8S5eJNsHeZ9F+/WxeXdVdydYPeG8zkxvL9zPVEoR1D8bSt2
	cQSOUl65aO0QElLrVyjFgA4cxZ/y9SHeeGMg9V5GvmZPCU0Iau6f/+dDEx3Rp7uKFMynGje2qws1V
	+aci1VkY8SYo9Iu7G6hONZYu6EtCpGt7+ivw==;
Received: from mail-ot1-f41.google.com ([209.85.210.41]:47344)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tDVY5-0005GG-0Q; Tue, 19 Nov 2024 13:14:13 -0800
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7187e0041d5so2358690a34.2;
        Tue, 19 Nov 2024 13:14:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXyVh4x8muPivgp6noUbHOsxb2lv8NmuB0gtUmpthwl6Vq9R2XASX81tnB/baPPxGzBaAWpqIsFJpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1TdGu9XNStelYOnsCHoXFhvNzNmZelNPjP/XgleFVoq+h0DM1
	N6ZrjKKT6/9QZEVMxJ40O1ZKt70IaCQ6ifHIYuokHY3E2xwh6852WuVTKaIHCAHJbI42XUqiKxk
	NPYXArTTADugFkYsjInVGW8AXDjM=
X-Google-Smtp-Source: AGHT+IHWnj3RHldzWNIuYSJl/BmHakR2cnVNB5sXmH1GaBfBV6J9TnCLNxowJfSKINCnhmyZLywl/FIhpG8Rrhtiluw=
X-Received: by 2002:a05:6830:18c2:b0:717:d2f8:6bb8 with SMTP id
 46e09a7af769-71ab3147a5cmr383435a34.12.1732050852408; Tue, 19 Nov 2024
 13:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111234006.5942-1-ouster@cs.stanford.edu> <ZzTcx8nmEKIJpaCR@pop-os.localdomain>
 <CAGXJAmyGTwjFo6fGoROY=hQFXbR5RdpmpkEc9Zm6DOoD2nbwNA@mail.gmail.com>
In-Reply-To: <CAGXJAmyGTwjFo6fGoROY=hQFXbR5RdpmpkEc9Zm6DOoD2nbwNA@mail.gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 19 Nov 2024 13:13:36 -0800
X-Gmail-Original-Message-ID: <CAGXJAmwr5u7Don-nKivvTuj6C9pGT2A5cAXvhKo6sAm_hHy72A@mail.gmail.com>
Message-ID: <CAGXJAmwr5u7Don-nKivvTuj6C9pGT2A5cAXvhKo6sAm_hHy72A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/12] Begin upstreaming Homa transport protocol
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: acf3039aa8d32d1ac60a71149e52b94c

On Thu, Nov 14, 2024 at 8:59=E2=80=AFAM John Ousterhout <ouster@cs.stanford=
.edu> wrote:
>
> On Wed, Nov 13, 2024 at 9:08=E2=80=AFAM Cong Wang <xiyou.wangcong@gmail.c=
om> wrote:
>
> > 2. Please consider adding socket diagnostics, see net/ipv4/inet_diag.c.
>
> I wasn't familiar with them before your email; I'll take a look.

I have taken a look at socket diagnostics, and I agree that Homa
should support them. However, this looks like a nontrivial task: there
appears to be a fair amount of complexity there, not much
documentation, and the current diagnostics appear pretty TCP-specific
so it may take some work (and advice) to figure out how to map them
onto Homa. Thus it feels like it will take a fair amount of
back-and-forth to get this right. I would prefer to defer this until
after the main body of Homa has been upstreamed, then have a patch
series that is dedicated to socket diagnostics support, rather than
lumping socket diagnostics into the current patch series. Is that OK
with you?

-John-

