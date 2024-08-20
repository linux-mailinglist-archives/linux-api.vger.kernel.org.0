Return-Path: <linux-api+bounces-2215-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2981958BF6
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 18:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 180B2B211D6
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 16:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8056F195FE5;
	Tue, 20 Aug 2024 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="notn2b06"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0B191F89;
	Tue, 20 Aug 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170200; cv=none; b=p+HY2+c1uhsZ7u0Km8vV1/2FB8dqUl4Ui1TPe3wL8XbXl5v2kNuAYI+ndeV8Q95D/dWrjxqYBHCNQAJlbQOeML3511rfX4XX4NsDHBXSgMzExjSDQ3b9aHx7Vs14z3snHzeK48m4lDjCAhq9lJsb1MQta9OVXcuHcYfJwVMvFfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170200; c=relaxed/simple;
	bh=76CU3DXa2htQCQYyYNMdPjM63LK5xgyJkPKcC8EhkC4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=o2J9YKTSTLyKXj1/R82GPlPBTEJcTKgG71aEA0HwB/feNfu2QyF8NHtBd5rovPlr7zyGPT0BDPj0Vi1Ics9I1vNQowBtCQCcwdxjeBsCA9TF9JrR3gFD9IT9WH3EVyyE6TdtlEiNEwOVZeSlwr7Y6UCrtbQoG2PSydngd6UgxP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=notn2b06; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3c99c5d69so938377a91.1;
        Tue, 20 Aug 2024 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724170198; x=1724774998; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76CU3DXa2htQCQYyYNMdPjM63LK5xgyJkPKcC8EhkC4=;
        b=notn2b06t2dyYnw6p1FDueaOoerDm0540EPjFHNt1N+c54NO0Bg3J24xihevXt1U/d
         ilfujE9E0XUg2K+GNWs+GKrEovaoimFjG/55+jBTzPbO05YwLXZFaDYbegybgjEnrAuM
         nswRrlfTbYQn2uGVYfisQiFRoET0zErR/6VkdXQpmPTJObBeYUo/MzVilcl6PdtM2tlU
         6ZyNHfcQW25S4RROqJOiQ+Vbl37Gq6PascGiOBHYYwLb0olPYwQQSnyokhyHHpmCOPO8
         e6uCTF2S9GhN4E9qkqXaldyJc0Q2/725FQPQZ7jL5YspfefS+HxyLe1IJWDsrtUD8AvR
         RRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724170198; x=1724774998;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76CU3DXa2htQCQYyYNMdPjM63LK5xgyJkPKcC8EhkC4=;
        b=Xy/a3gcuVuxfkzR+jpuLK9xjmMrp17erIfVvy5rXGAiiaO36LPhle7l3YOdDue8T3T
         4SqyeuAdrtHIhDobq28FVVPvRCLSVoqkCWr5YyBrXvte6RjL1Ba3vKc/j3fvcJRA1/65
         JsMthblbAHV2GtYCC7AfJnUJIkTDUn/RixQfmFl/ttmKkxN4HD03JmdbEcU3K5RgZlsR
         JNhAKJtj0QY33xh5IXL4BpQULoKyLryrC/OLkBiLUp0fTyFOHpPP2t1RP0uQWWsimbLz
         JLMILnPDsn+VyCdSArggi0Zf5Yux0Xpz1XO5OKO+S+jXYMTpU87R2ifmHQTDKcbBH5y1
         gFqg==
X-Forwarded-Encrypted: i=1; AJvYcCX9vDiToi/eqYK6mN4xHKzBm/2rH/rb56H/KciOkh0hmDKAlxmG2j79Gryz0Ugcznx4gCIDSG7WmQmuogihAwK2c/2Uawav+71pwK48D7KQLxQIbd276VWtZL31cu9KYM8s
X-Gm-Message-State: AOJu0Yx9ap+LI9t3iJ8PJ2GlqCLhN+8EzrMFmd3h+NTzZTuAJK+NOREa
	yEL7RgPhU8PAjnmVaml9iUi+zyCN8RlPur/shXhZ+676sZ+vgD8z
X-Google-Smtp-Source: AGHT+IFJD/CxUVfTsobk3FcI3v/Qr6i/vGLQx4S4hkaUDHJhZiLKb22uVEB3WkdlfmQ+jEMEiJHYag==
X-Received: by 2002:a17:90a:ca08:b0:2c9:863c:604 with SMTP id 98e67ed59e1d1-2d3e1d654afmr9553761a91.3.1724170198028;
        Tue, 20 Aug 2024 09:09:58 -0700 (PDT)
Received: from smtpclient.apple (v133-130-115-230.a046.g.tyo1.static.cnode.io. [133.130.115.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c7502csm9592276a91.40.2024.08.20.09.09.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2024 09:09:57 -0700 (PDT)
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
In-Reply-To: <ZsSwnPfyOvdSBMOC@1wt.eu>
Date: Wed, 21 Aug 2024 00:09:41 +0800
Cc: Willy Tarreau <w@1wt.eu>,
 Xi Ruoyao <xry111@xry111.site>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Sasha Levin <sashal@kernel.org>,
 stable@vger.kernel.org,
 WANG Xuerui <kernel@xen0n.name>,
 linux-api@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <46C6EB05-1AA2-42BF-82BF-3B99CCA57439@gmail.com>
References: <DF762B6F-360A-4C0C-8C85-55686417209B@gmail.com>
 <2024082057-coherence-lethargy-3513@gregkh>
 <D19DB99F-B5D9-49A6-BCF8-A5980A9BC1A0@gmail.com>
 <2024082027-deskbound-rumbling-b96f@gregkh> <ZsSwnPfyOvdSBMOC@1wt.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3776.700.51)



> 2024=E5=B9=B48=E6=9C=8820=E6=97=A5 23:05=EF=BC=8CWilly Tarreau =
<w@1wt.eu> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Aug 20, 2024 at 10:00:35PM +0800, Greg Kroah-Hartman wrote:
>> On Tue, Aug 20, 2024 at 09:49:59PM +0800, Miao Wang wrote:
>>> Hi,
>>>=20
>>>> 2024?8?20? 21:36,Greg Kroah-Hartman <gregkh@linuxfoundation.org> =
??:
>>>>=20
>>>> On Tue, Aug 20, 2024 at 09:19:04PM +0800, Miao Wang wrote:
>>>>> Hi, Greg
>>>>>=20
>>>>> I saw you have included commit 7697a0fe0154 ("LoongArch: Define
>>>>> __ARCH_WANT_NEW_STAT in unistd.h") in your stable trees, which
>>>>> actually introduced new sys calls newfstatat and fstat to =
Loongarch.
>>>>=20
>>>> See the documentation in that commit for why it was done.
>>>=20
>>> Thanks for your explanation. I totally understand the necessity of
>>> re-introducing thees two syscalls. I just wonder whether there is =
any
>>> limitation on what can be included in to the stable trees. If there
>>> was no limitation, theoretically, I could also maintain a so-called
>>> stable tree by applying all the patches from torvalds' tree, except
>>> those that bumps the version number. Apparently such a "stable" tree
>>> is far from stable.
>>=20
>> Or you could do the opposite, something that I have seen vendors do, =
and
>> just bump the kernel version number to try to "claim" they updated =
their
>> kernel to a more secure one (i.e. one that fixed loads of known =
issues),
>> but they really didn't.
>=20
> Some of those who do that don't even notice what they're missing. I've
> seen some BSP kernels "forward-ported" by merging the next bunch of
> stable versions, trying to fix rejects by hand with the usual ratio of
> failures, but after that since that version is part of the history, =
it's
> impossible to figure what's really missing or not. Some people don't =
seem
> to realize that *merging* code can actually result in *removing* =
fixes.
> So they don't even need cheat on their versions, they're genuinely
> believing they're OK... which is worse!
>=20
> Willy

Thank you all for sharing experiences with vendors messing up kernel
version numbers.

However, my original question is whether it is expected to include new
syscalls in kernel stable tree. According to the document =
"stable-kernel-
rules", if I'm interpreting it correctly, I expect only bug fixes and =
small
driver enhancements from stable releases. I understand the patch in =
question
is actually introducing new syscalls, which is beyond my expectation. So =
I
wonder the consideration of including this patch in stable releases.

Cheers,

Miao Wang


