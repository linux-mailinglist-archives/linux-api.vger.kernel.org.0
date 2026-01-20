Return-Path: <linux-api+bounces-5692-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJJjEMAAcGmUUgAAu9opvQ
	(envelope-from <linux-api+bounces-5692-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 20 Jan 2026 23:25:04 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 111864CECB
	for <lists+linux-api@lfdr.de>; Tue, 20 Jan 2026 23:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2D987EEABD
	for <lists+linux-api@lfdr.de>; Tue, 20 Jan 2026 21:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539A13D525A;
	Tue, 20 Jan 2026 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WcCwNIfl"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D8369231
	for <linux-api@vger.kernel.org>; Tue, 20 Jan 2026 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946114; cv=none; b=YB7GUERjXHmBs16H+2R+4/44mRVGfLMzRpFBGXgbCDBkB97RriC9p5wfrh+pKXIqiESCQwReieXOtUS0Z/6vKIRteuvnljbp9Pl4bSJyTOjouckUIcTVxLcyEaKAyh3saDbRvZeFY2gsApkX9/Lm+6B7gR1IcltAQ/U63P7ACH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946114; c=relaxed/simple;
	bh=AwHUD+rXuhKyKmXPrdQZrRAZDbCQlrWch9VuSW3eH3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8op/AmZ5zC1Ln25+c7qYd2jsBdF3xPQPydrzPSj2Xe+vke5i53F3Xb9CChnD36giTia02jv3XhtG1M4xu8Ls0P3CW6wEfObxMF+6Ci56cN9huQY7fYVGy0O8T38enACsi0JrXTjrhCgtCe6LERW24cTQFKi+IejjOZUrFs+dnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=WcCwNIfl; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dwgrd52Bmzg9t;
	Tue, 20 Jan 2026 22:46:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1768945601;
	bh=CUnC6gBg1b8DZjIFRJjoz21kw+O4IDvw1ZCQ7hb32w0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WcCwNIfltvas3I8WkaxOw4+8cb98Kkmo+ZF7qsZUr3tX3je8MAfeFMOjr92TJkrD7
	 XHcq1YNheRGDGLozfVE6lbHz+Sh1sEIyypT2HGH9iGOunB8tq0HyME1MLnr3r6W7tB
	 iUtAbnd0WOsULgDiW94Mr0CTZWRkmIpnuHhdLSR0=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dwgrb45vZzqrp;
	Tue, 20 Jan 2026 22:46:39 +0100 (CET)
Date: Tue, 20 Jan 2026 22:46:34 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kselftest@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	libc-alpha@sourceware.org, Carlos O'Donell <carlos@redhat.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Rich Felker <dalias@libc.org>, klibc@zytor.com, 
	Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH net-next v2 2/4] selftests/landlock: Move some UAPI
 header inclusions after libc ones
Message-ID: <20260120.ahGaepheZah8@digikod.net>
References: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
 <20260120-uapi-sockaddr-v2-2-63c319111cf6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120-uapi-sockaddr-v2-2-63c319111cf6@linutronix.de>
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5692-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[google.com,redhat.com,davemloft.net,kernel.org,iogearbox.net,gmail.com,fomichev.me,linux.dev,vger.kernel.org,arndb.de,lists.linux.dev,sourceware.org,linaro.org,libc.org,zytor.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linutronix.de:email,digikod.net:email,digikod.net:dkim,digikod.net:mid]
X-Rspamd-Queue-Id: 111864CECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 03:10:32PM +0100, Thomas Weißschuh wrote:
> Interleaving inclusions of UAPI headers and libc headers is problematic.
> Both sets of headers define conflicting symbols. To enable their
> coexistence a compatibility-mechanism is in place.
> 
> An upcoming change will define 'struct sockaddr' from linux/socket.h.
> However sys/socket.h from libc does not yet handle this case and a
> symbol conflict will arise.
> 
> Move the inclusion of all UAPI headers after the inclusion of the glibc
> ones, so the compatibility mechanism from the UAPI headers is used.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Mickaël Salaün <mic@digikod.net>

Thanks!

> ---
>  tools/testing/selftests/landlock/audit.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
> index 44eb433e9666..c12b16c690dc 100644
> --- a/tools/testing/selftests/landlock/audit.h
> +++ b/tools/testing/selftests/landlock/audit.h
> @@ -7,9 +7,6 @@
>  
>  #define _GNU_SOURCE
>  #include <errno.h>
> -#include <linux/audit.h>
> -#include <linux/limits.h>
> -#include <linux/netlink.h>
>  #include <regex.h>
>  #include <stdbool.h>
>  #include <stdint.h>
> @@ -20,6 +17,10 @@
>  #include <sys/time.h>
>  #include <unistd.h>
>  
> +#include <linux/audit.h>
> +#include <linux/limits.h>
> +#include <linux/netlink.h>
> +
>  #include "kselftest.h"
>  
>  #ifndef ARRAY_SIZE
> 
> -- 
> 2.52.0
> 
> 

