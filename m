Return-Path: <linux-api+bounces-2812-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E15F9E0F6B
	for <lists+linux-api@lfdr.de>; Tue,  3 Dec 2024 00:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB19282FDD
	for <lists+linux-api@lfdr.de>; Mon,  2 Dec 2024 23:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26E11DFDB7;
	Mon,  2 Dec 2024 23:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="eSrZPkDy"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6096E1DFD84
	for <linux-api@vger.kernel.org>; Mon,  2 Dec 2024 23:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733183563; cv=none; b=cBvVca9N/TYp7RoTjvPix5Y7aA8cEXyfbVrQiXEMMizGQwHanwuRzEw1z31ANnqSaOl5FndG8og/Qkx3OfXVxZjVMPNXtV07XIa9ckkMrXjJlg5iRKUTM/iAEYTHUtqjvYfTFR33w6sElcqxCieNLEmSelqBg8MAmuPg/BMDWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733183563; c=relaxed/simple;
	bh=za2cz9ezczXWzWIsh7AglwUckecj/uWKxmHRIJ0+tOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2VJZwxJmX5fAPGyV1NJqZGdKcW0AL7zPuqdy4MHtlwq/aRQXrCvgbp5fcO+GmfNHKN96q8s4HeDSyC63qfDeafa049oGyoRAPm9Js7qM9QSRGF/i/1SyyTUiVEzIz7tsVvDqliq3DV5AvpVYstOY3cPTdTpxRDMZMqZmMvsBTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=eSrZPkDy; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=krcAhW83wyDKaQwmQqtFekl0xKkVchV+xRIcnVPYinA=; t=1733183562; x=1734047562; 
	b=eSrZPkDyvmXDOnOA+qzN9g+YI1qPSMuSO6R14pgfwr8f64FguM/L54sT2Cgc/FIEP18/+wB3Syn
	1+ZRkvuhbmdOcHqOs7wHsU6cmxapxQwhG4qgEU4dX2pv4kdw+tPytt6g4PEEhRcZ2adlzPgzHRNGn
	f4SkNng4PCViUzqELuIXcfUlWEb1wZnMp1AL6T9cO+8TlTD7vhAA5mHXm0DI9cl3GHJUOqCitUOEh
	B4Ft8kgDl97aZQPyV0ATPJ7ht0eUDEIMVClsn+zMzwXxbtUumGySE1cpnIrk9NLiF1NDyklhawzny
	3vyWEM3LGvUyTMNFX+XUjFp9A/ufU6q9rYew==;
Received: from mail-ot1-f45.google.com ([209.85.210.45]:61798)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tIFpJ-0008VJ-Fk; Mon, 02 Dec 2024 15:27:38 -0800
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71d40fdde2fso1777593a34.3;
        Mon, 02 Dec 2024 15:27:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWG6wB7Nh/aD+6/hk8r0Q38Od/7c20/ghHp8YQG4kePVHU+q05YUJuzw8farMxm1Tn1tzbjUO5jrOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsz1sYzKOvnHUDHr/ixDG39oOLu5BPO08EhxQ6ZS9dy9AJaaEt
	7ePIBD+5WnQB3F0ixdGmUqURRg4iap2bITCxMCbUf5BoiP2s2//xJavZFlupDVCdG+x7Qsxe6nq
	c/N8b5Phm5ENQBvifsC65vkmmk1I=
X-Google-Smtp-Source: AGHT+IEGY2/Wq4lbXpbFogvVpGkgWVw/q3JJZEXnB39V01T6YUbMSSjTPn5+KKB4HZ3rKrf5wjZkd2GjAoyZqCf5nqA=
X-Received: by 2002:a05:6830:7310:b0:717:f864:90cb with SMTP id
 46e09a7af769-71dad5ed63cmr660710a34.4.1733182056937; Mon, 02 Dec 2024
 15:27:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111234006.5942-1-ouster@cs.stanford.edu> <20241111234006.5942-13-ouster@cs.stanford.edu>
 <f81a78ac-b32a-44bf-9375-8ac380bbce74@linux.alibaba.com>
In-Reply-To: <f81a78ac-b32a-44bf-9375-8ac380bbce74@linux.alibaba.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 2 Dec 2024 15:27:01 -0800
X-Gmail-Original-Message-ID: <CAGXJAmzQ=xrpr46aF_qeU3mAwDdCaXWXnRKOc+hG8tyihCW9hw@mail.gmail.com>
Message-ID: <CAGXJAmzQ=xrpr46aF_qeU3mAwDdCaXWXnRKOc+hG8tyihCW9hw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 12/12] net: homa: create Makefile and Kconfig
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 5e15904e367bf57319d290d73554c551

On Mon, Nov 25, 2024 at 8:27=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
> On 11/12/24 7:40 AM, John Ousterhout wrote:
>
> A small formatting issue, perhaps you're using spaces?

Yep; I fixed the formatting in Kconfig based on input from Randy
Dunlap earlier in this message train.

> > +menuconfig HOMA
> > +     tristate "The Homa transport protocol"
> > +     depends on INET
> > +     depends on IPV6
>
> Can HOMA run in an environment without IPv6=EF=BC=88IPv4 only)? If so, de=
pends is not suitable here. Perhaps
> what you need is to implement different branches in the code using
>
> #if IS_ENABLED(CONFIG_IPV6)

No, Homa really can't run in environments without IPv6: internally,
Homa stores all addresses as IPv6 addresses, converting to/from IPv4
at the interfaces with other kernel functions. Hopefully that is not a
problem? And given that, "depends on IPV6" is OK, right?

-John-

