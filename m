Return-Path: <linux-api+bounces-1806-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDA091CF34
	for <lists+linux-api@lfdr.de>; Sat, 29 Jun 2024 23:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7767A1C20A7A
	for <lists+linux-api@lfdr.de>; Sat, 29 Jun 2024 21:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3DE136657;
	Sat, 29 Jun 2024 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="lIW00jCE"
X-Original-To: linux-api@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4288320F;
	Sat, 29 Jun 2024 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719696738; cv=none; b=eQZckZHZwdDBDmiCpD2Tdd3X6hzm9ASEjmoqkT3P74Q4rRVOC4kuCVrN+C4MOvfB+eYZt2ANXAQY11++5XmCF4dkt0UOoqcYxCaVvnKNAM+GeF3ieIb6E6HgrVZBQ7pLrkxwWslxk4WBaeq2TuXNL1ng6B2ze30VPaiF4gjv+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719696738; c=relaxed/simple;
	bh=wl4MR4fPe4TXQGxgnbj2K6s2iNtDcWwLhg0nPvCkUig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyVWkDb9mRtvFcYBBYoEIaf3dY3nebJtSnijY+X72usPQPjoB/b/H2YXcljr8MyxRxD7IxEy5fhOLDCILJZQDsV1V78rfCS5DyPjNqxh/ip4RxF9t6D85TS2XCq1vgZPOMr3pp8BysqgllTu57Z+376TcklYwncnfvsHBNZKjws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=lIW00jCE; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719696713; x=1720301513; i=deller@gmx.de;
	bh=Vs8+siwQ7YRYNcVl7ZAqgvB6Ka6/tuWhKQGnLfn1gT4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lIW00jCE6Dv22wuVLWPGDZNIwfbFM21jVdxta+Eyk8TflEpHWHU3jBSWRjJy7M78
	 /y9D5d0lZ9nF+Vs8yGweFj5avsZVVuT/UhXcZm6SJczey1Mnrf+6ddwPS+bP7D73A
	 r6DSzRnH5Ko0M05NjrMEqq1wJe1o1uEE7iDbr6R34tMqPDdRN758heDwAS8aENMUZ
	 Ut0TMaI3U5YMp1SH9zVlAbZL+SXOZgB6m3IzM4b1rUjcsgTgRkI1xXTF88fC1pvQG
	 eS3J44Y6x6fQHFIprJtaCth516h0kH5Jp9W/N3pR3WXlQz3K5PYvqknRY1kLl5N2S
	 Xx+QNK2oyebYPKWSKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.78]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UZ6-1sODu71O2k-00FQi2; Sat, 29
 Jun 2024 23:31:53 +0200
Message-ID: <5affede5-7111-4eff-9019-abcbdac62228@gmx.de>
Date: Sat, 29 Jun 2024 23:31:51 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] syscalls: fix sys_fanotify_mark prototype
To: Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc <linux-parisc@vger.kernel.org>
References: <20240629210359.94426-1-arnd@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240629210359.94426-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YuFBkdMKhtABe1/aPj695y1WAGmtsiDjh7X1rDY5k+9zW5FaZ0i
 HE5LFufohO9jVXgG3P1ihWDCxIZgWET3WYSCcX03idlcEy3dZLn2Lood8JpkTL01OCxpWks
 OOKQUA61Mr/qycqwpjuj33O3z4Wsu7j7z7/Ppt3VeDThF5lhyqOBlEOKd5/iGyoh2VV2htt
 edLS8KbxT50OyGSmKnK0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R+7rKO6wNiQ=;Yr0IbvcdHgu1gHOJJvsUI5Cu/Zk
 LMhnG1SBSoTbQ9V70W999Q+0OO37zb6PxlISz3L61tulqJkDsb5pGgNcrXpSp9LglE5xl2REk
 RDNWTkct4yj+COg2KX+NJo4uHOrP3STbpCT9uA3X3OpzZk1GXxY/7dSKeqW1EiEQyIanM1uy/
 u5OSr8BSyB0Skl4BmywwONlvHrXn5DWiSsJvI/IZL7szxbQeyFrsYgdby4hSpJYUUpj/W/J0W
 vDszlyR/pnCr97LYbLXFdP681N7fnFq6U6BJrfXDnJ/PmlZYdsQmNjCuCH0QWhUED3S5bUf35
 vfKlQq/ElRmu8pL31gdpMLNHsgA+TQjR5Rk5Pc/Zj26vAKjnaL2aq0Yl8vgu285PsrSp1yiHO
 f9a93i8eU10rpnTAELRocAA8VAYwBpyxNEC7/PWx3sDy3HiSTQoI2lk984mzgWoAwqWpVwbQ5
 h7upAyMO7h1nSOfPAVpbRFO5853Vaf9snL1SEnc9hMFBpaaQeycLI3lNEpSEw7cIMuxM1o994
 wtmIExI5iy2eJzs1fURAQLuXVR2aYcqHlNr4xZfUq3exRcqtApgsDmV36yPu+go7z2RbXqbsY
 NEu3YJEEvFjOlosLffeMLQZl+q4tIBzpLAx9rDGjZpBM9kigB989HcjsQss10kMTppAVgam9i
 zYeOpfKLLp3Mfwg5wW9xyHaQ+utIpslm/3rT/WYsMKNzEuMGDLB7zuYmP74r4+3roz+HE7ng5
 f+trzFQ0+AddPFib4qbocIlKZyhnSOSal1eERLgFOyDSiN6XG6Xj9ei6gvECOhW6mP2WnDFr0
 MsNilpvMMnbHb+JYYcj4eIkv+fkY2JS+5xag1mo0ikVbw=

On 6/29/24 23:03, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> My earlier fix missed an incorrect function prototype that shows up on
> native 32-bit builds:
>
> In file included from fs/notify/fanotify/fanotify_user.c:14:
> include/linux/syscalls.h:248:25: error: conflicting types for 'sys_fanot=
ify_mark'; have 'long int(int,  unsigned int,  u32,  u32,  int,  const cha=
r *)' {aka 'long int(int,  unsigned int,  unsigned int,  unsigned int,  in=
t,  const char *)'}
>   1924 | SYSCALL32_DEFINE6(fanotify_mark,
>        | ^~~~~~~~~~~~~~~~~
> include/linux/syscalls.h:862:17: note: previous declaration of 'sys_fano=
tify_mark' with type 'long int(int,  unsigned int,  u64,  int, const char =
*)' {aka 'long int(int,  unsigned int,  long long unsigned int,  int,  con=
st char *)'}
>
> On x86 and powerpc, the prototype is also wrong but hidden in an #ifdef,
> so it never caused problems.
>
> Add another alternative declaration that matches the conditional functio=
n
> definition.
>
> Fixes: 403f17a33073 ("parisc: use generic sys_fanotify_mark implementati=
on")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Guenter, thanks for noticing!

Arnd, I can confirm this patch fixes the 32-bit build for hppa,
so you may add:
Tested-by: Helge Deller <deller@gmx.de>

Thank you!
Helge


> ---
> I've queued this fix in the asm-generic tree now
>
>   include/linux/syscalls.h | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 63424af87bba..fff820c3e93e 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -859,9 +859,15 @@ asmlinkage long sys_prlimit64(pid_t pid, unsigned i=
nt resource,
>   				const struct rlimit64 __user *new_rlim,
>   				struct rlimit64 __user *old_rlim);
>   asmlinkage long sys_fanotify_init(unsigned int flags, unsigned int eve=
nt_f_flags);
> +#if defined(CONFIG_ARCH_SPLIT_ARG64)
> +asmlinkage long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
> +                                unsigned int mask_1, unsigned int mask_=
2,
> +				int dfd, const char  __user * pathname);
> +#else
>   asmlinkage long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
>   				  u64 mask, int fd,
>   				  const char  __user *pathname);
> +#endif
>   asmlinkage long sys_name_to_handle_at(int dfd, const char __user *name=
,
>   				      struct file_handle __user *handle,
>   				      int __user *mnt_id, int flag);


