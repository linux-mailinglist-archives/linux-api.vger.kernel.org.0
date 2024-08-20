Return-Path: <linux-api+bounces-2217-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B3E958E97
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 21:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2132849E1
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 19:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1323319478;
	Tue, 20 Aug 2024 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPwP4lr0"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46861586D0;
	Tue, 20 Aug 2024 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724181879; cv=none; b=UAX251At3Emuler2C112rp02FjgPG+9LYRmgiE0+CgTi90he3wa719L/BvMMeg2sCXdi1Zm+8K/DC5+s5EwVbnD4d0WLWefhiOIV0mcC1qHiVlCXljOo+6K8Yi3sUkLXFrvQ6EE2m9NZfOq0nFR/P7hnKx9w7KI3S5k14bfItNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724181879; c=relaxed/simple;
	bh=4bfIMgpJwUN9el8i9XHzhs2svCvajb2m8PRxmIeFH8o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VkYg7M7krqpwySC5D4vLAV9dWv+BNLOQH3QdUpeuOJxMiOXyh1/fTT8l0iIWthmP0tbGhEHkOQTsP1eiJny0x+BIEFQMqkjIAm2+QR/HiRjVGFvv1D/vQIGKlolMYLE+Q4covnjCUTHoxlhvtoZK0m+xQI7CPAlC+fF2DX6UpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPwP4lr0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3bc9405c2so744894a91.2;
        Tue, 20 Aug 2024 12:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724181877; x=1724786677; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bfIMgpJwUN9el8i9XHzhs2svCvajb2m8PRxmIeFH8o=;
        b=WPwP4lr0D7WnTBH8SLAo8tTt+Tqg19FoA9NLBAwGYiI5mYWmKAjOJGyqyMZL3q81m6
         0mtQGdehGdbpelMOewObXbmBiXDUk9Z8ff9MXrYPI+yIRRpz7z05sBQmmnK8rb2kPPpm
         gSKisrmQHRE0oLSWconuoT72wkn6dzBEtKHAhcB2fL/0bIJGUmdy8wVF1ca01djGzvL/
         rsOH1Z78Q9NXNLNxQ4qUDNWuUiUUFRUT9/7PfclcLXXFMnl8RWoKHgHAa3dQy6Ih0kis
         2EX8+IR9aQmwKDBJbKcJBGPJV4uXqtUpiBEWZ9Cw0Rf8emXJwhs8DaoM9aWS8PJuqsV6
         0T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724181877; x=1724786677;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bfIMgpJwUN9el8i9XHzhs2svCvajb2m8PRxmIeFH8o=;
        b=cXlnrOCFzKDPNfUb2BHWmlkueHX0oLNAUuQYFrvUuzFu1ru3nf7ii9wcxiaA1AANoS
         aAZq1um4OudvFM32NfoZ8rwFn4/e7AKK4jC5rsKWHn1vO/WPx2RPrL9k7z4gZeTE7tSV
         JDb5lt4oVbcPDxxoD+7xErQFbkvJisBF6+AyshWnYbR4FbjhOPPiLLr9WO22buMFWf+h
         +YFGzRlJp1KGo+1G1sKdURMWu9PmNFvOUMVMcm+mZMlFv3QkfzSqiEIWCt2Y+5ews72+
         c9Fac/Bl7vKra0VWmGmGaiqmwdE5XFrFk65GFFGIXVrWA6B28kJMl5GZsS2BQVMxcHzd
         6AUg==
X-Forwarded-Encrypted: i=1; AJvYcCVVY6+bIOB5j0x+WCXizPvRtPkrdJ/kodRrAmvMHRlyFrWZaUcoC2jHK3f7KdfkKQyHKvvUQ+jQ@vger.kernel.org, AJvYcCXPNHr0emkvaaZyUayWdOQFv96cYWuOlnGZTy8EH2+tuzFAW/w39Mr8fPG9krarSIrH8v7EhRGzTnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeORdutyei25ENyJLgmU0yNXACDMkJKySxQ1GUO3U/AS/+4/VD
	X4gVsY+SA04LpnkKR2E0ED4ji7jsAxudaMInJxBgJusLuqgaTAHn
X-Google-Smtp-Source: AGHT+IEoRfGjjZJh3l/s5wOxl5IFeYiNBBI63m5S1vxD5J/TuosUjuf//avNRbiV5EqQVZwPCxchZQ==
X-Received: by 2002:a17:90a:bc8a:b0:2c8:e8ed:8a33 with SMTP id 98e67ed59e1d1-2d3e1121bbdmr10169636a91.4.1724181876716;
        Tue, 20 Aug 2024 12:24:36 -0700 (PDT)
Received: from smtpclient.apple (v133-130-115-230.a046.g.tyo1.static.cnode.io. [133.130.115.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2330f26sm9853110a91.0.2024.08.20.12.24.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2024 12:24:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: It is correct to introduce new sys calls to stable versions?
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <ZsTgxUndhb04snd6@1wt.eu>
Date: Wed, 21 Aug 2024 03:24:19 +0800
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Xi Ruoyao <xry111@xry111.site>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Sasha Levin <sashal@kernel.org>,
 stable@vger.kernel.org,
 WANG Xuerui <kernel@xen0n.name>,
 linux-api@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <17D9A385-5149-4BED-94B8-82E43309484D@gmail.com>
References: <DF762B6F-360A-4C0C-8C85-55686417209B@gmail.com>
 <2024082057-coherence-lethargy-3513@gregkh>
 <D19DB99F-B5D9-49A6-BCF8-A5980A9BC1A0@gmail.com>
 <2024082027-deskbound-rumbling-b96f@gregkh> <ZsSwnPfyOvdSBMOC@1wt.eu>
 <46C6EB05-1AA2-42BF-82BF-3B99CCA57439@gmail.com> <ZsTgxUndhb04snd6@1wt.eu>
To: Willy Tarreau <w@1wt.eu>
X-Mailer: Apple Mail (2.3776.700.51)



> 2024=E5=B9=B48=E6=9C=8821=E6=97=A5 02:30=EF=BC=8CWilly Tarreau =
<w@1wt.eu> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Aug 21, 2024 at 12:09:41AM +0800, Miao Wang wrote:
>> However, my original question is whether it is expected to include =
new
>> syscalls in kernel stable tree. According to the document =
"stable-kernel-
>> rules", if I'm interpreting it correctly, I expect only bug fixes and =
small
>> driver enhancements from stable releases. I understand the patch in =
question
>> is actually introducing new syscalls, which is beyond my expectation. =
So I
>> wonder the consideration of including this patch in stable releases.
>=20
> When you maintain stable software you quickly realize that everything
> is not just pure white or black but a shade of gray and that if it can
> be considered as a bug to miss a syscall in certain environments for
> example, then it can become a valid fix to add it. I don't have any
> opinion on this particular one, but since your question is broader I'm
> trying to explain.
>=20
> Different people have different expectations about what needs to be
> fixed, that's even why some people will choose a distro over another
> one (prefer to fix only critical bugs over fixing all bugs for =
example),
> but there's no point restarting a philosophical on this topic which =
has
> already been rehashed too many times in the past.
>=20
> As a rule of thumb, just keep in mind that anything that needs to get
> fix will eventually be fixed.

Many thanks for your explanation!

Cheers,

Miao Wang

>=20
> Thanks,
> Willy


