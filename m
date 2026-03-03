Return-Path: <linux-api+bounces-5898-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA6dD+lsp2nRhQAAu9opvQ
	(envelope-from <linux-api+bounces-5898-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 04 Mar 2026 00:21:13 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 413A21F8524
	for <lists+linux-api@lfdr.de>; Wed, 04 Mar 2026 00:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02900302511C
	for <lists+linux-api@lfdr.de>; Tue,  3 Mar 2026 23:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728463264FF;
	Tue,  3 Mar 2026 23:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BInh+0nV"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D93264CB;
	Tue,  3 Mar 2026 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580065; cv=none; b=nb/IUfNebhlK/faKhqCKTgA5WZkWFMBpxghfSvG/z2IvGAWM8ryNn+XXiedrtFKoraxtvsPefWJe4KSjWG5F5cgi1L6lQpklpzkV40E1vdvEN1z4mIIas8ZwGm0AviSENptNjrhrB4NvGINIruTdAH6tG41ptK1YVHivocXyucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580065; c=relaxed/simple;
	bh=z9miA0rsyB+WgQ/oRHOS5/bQukKeeiVmFL0wrdmxvvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7UIGOP7WzbTz2w7ad7aegBIyzZwlh9lzz/wW0r22q6qZaKma48Uhr8zAVdQacBDG6vS6F1jTDpK3Hvk5kLIwx5lqPJ3RsiAQKk6hVaYZlcci0x5gKSnj9XK1SVW0RGWkLlHYoiKrIyj8Qq2GJvYu3Zpu2uVuQHuEVsdHAw5zr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BInh+0nV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ayHSwzqaJiHYN3XMJxmPhSEL8WIs1aTm4xWDzxCaiLs=; b=BInh+0nVimbGHWPSnZdjKhZTbX
	c2qUdmBpaSbluIE+rS2mynQodaDWZ8xwxQtiYxFgEfFXMt4ij0X1D9blMr2sznP0We8RWPxuxqZfL
	qOALAi0UB34ZXKtk6Q0wVp6N6qjbqBwDXABJvDblz0Du/+E7PLIfbxl+UGKcp91wCxevV87k3q0gR
	KNz8ElhZBPseH3ENZAJdYaouFp/LPR/pjovIChhdImS5LTubyPOLWcJ841yv7sH0905iEc1eDHDN6
	BmesO3vL4BVAdY9PnbICxxBazQBuGIL1MxRex2U1vjdJe6tev5HszHBs+l9N1cSKgs3/HvniecV4s
	C3OJ5Wyw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxZ2z-0000000G5CK-0pWB;
	Tue, 03 Mar 2026 23:21:01 +0000
Message-ID: <452cad19-b5a3-4424-9fa9-85833a6a3d7a@infradead.org>
Date: Tue, 3 Mar 2026 15:20:59 -0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/deadline: document new sched_getattr() feature for
 retrieving current parameters for DEADLINE tasks
To: Tommaso Cucinotta <tommaso.cucinotta@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 linux-api@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shashank Balaji <shashank.mahadasyam@sony.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260303104215.1324243-1-tommaso.cucinotta@santannapisa.it>
 <20260303184313.1356499-1-tommaso.cucinotta@santannapisa.it>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260303184313.1356499-1-tommaso.cucinotta@santannapisa.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 413A21F8524
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5898-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[santannapisa.it:email,infradead.org:dkim,infradead.org:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

This patch should be marked as v2, with the differences between
v1 and v2 described.



On 3/3/26 10:42 AM, Tommaso Cucinotta wrote:
> Document in Documentation/sched/sched-deadline.rst the new capability of
> sched_getattr() to retrieve, for DEADLINE tasks, the runtime left and absolute
> deadline (setting the flags syscall parameter to 1), in addition to the static
> parameters (obtained with flags=0).
> 
> Signed-off-by: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
> Acked-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>  Documentation/scheduler/sched-deadline.rst | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
> index ec543a12..76fdf435 100644
> --- a/Documentation/scheduler/sched-deadline.rst
> +++ b/Documentation/scheduler/sched-deadline.rst
> @@ -628,10 +628,21 @@ Deadline Task Scheduling
>    * the new scheduling related syscalls that manipulate it, i.e.,
>      sched_setattr() and sched_getattr() are implemented.
>  
> - For debugging purposes, the leftover runtime and absolute deadline of a
> - SCHED_DEADLINE task can be retrieved through /proc/<pid>/sched (entries
> - dl.runtime and dl.deadline, both values in ns). A programmatic way to
> - retrieve these values from production code is under discussion.
> + The leftover runtime and absolute deadline of a SCHED_DEADLINE task can be
> + read using the sched_getattr() syscall, setting the last syscall parameter
> + flags to the SCHED_GETATTR_FLAG_DL_DYNAMIC=1 value. This updates the

About the build warning due to the use of  `flags':
If you want smart quotes, just use 'flags'.
If you want italics, use           `flags`.
If you want a code-look (monotype), use ``flags``.

> + runtime left, converts the absolute deadline in CLOCK_MONOTONIC reference,
> + then returns these parameters to user-space. The absolute deadline is
> + returned as the number of nanoseconds since the CLOCK_MONOTONIC time
> + reference (boot instant), as a u64 in the sched_deadline field of sched_attr,
> + which can represent nearly 585 years since boot time (calling sched_getattr()
> + with flags=0 causes retrieval of the static parameters instead).
> +
> + For debugging purposes, these parameters can also be retrieved through
> + /proc/<pid>/sched (entries dl.runtime and dl.deadline, both values in ns),
> + but: this is highly inefficient; the returned runtime left is not updated as
> + done by sched_getattr(); the deadline is provided in kernel rq_clock time
> + reference, that is not directly usable from user-space.
>  
>  
>  4.3 Default behavior
> 
> base-commit: f74d204baf9febf96237af6c1d7eff57fba7de36

-- 
~Randy


