Return-Path: <linux-api+bounces-5685-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPXKN8Prb2m+UQAAu9opvQ
	(envelope-from <linux-api+bounces-5685-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 20 Jan 2026 21:55:31 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ADADE4BD1B
	for <lists+linux-api@lfdr.de>; Tue, 20 Jan 2026 21:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 009358C2D10
	for <lists+linux-api@lfdr.de>; Tue, 20 Jan 2026 18:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1F46AF25;
	Tue, 20 Jan 2026 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MZanTnHa"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1A451052;
	Tue, 20 Jan 2026 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935051; cv=none; b=GgC6SFqh3zQyINtJHc18nYJx+6D7O35GaRWT+rnJpAhW/0G3lwodmYGJKpQNp6hS1BirahJhnKu1k+7M3VpWjWdgCHTill0/Xi1BXxwlfNEtYVTpUbooOysrIplOHeeGKhNCh+Qg86HXK2oJ9g85Gr0mYwFEoeRTQL1k/0zrXzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935051; c=relaxed/simple;
	bh=etk7Sf1GNmHQHnzXx5rTjYzq4dzsBjv3mI/c+sRBXSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgRDQnP03FCGtvjgFTWXSsf8uEudmY4sXBwGCctX5TPuH4db7CmeGrb51woiCscC1b2PLP5Hh+WxQqZk/+bJaKX2VHpmczpp4cqPXR4aYK3mfTelwz2aY+F8TilQoDGtZ8am/RQYCFc2YnPBN6mNQ1vNAxpQFLSqMEJLYG4iy3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=MZanTnHa reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9483:12c5:bc8e:d949:3497] ([IPv6:2601:646:8081:9483:12c5:bc8e:d949:3497])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60KIoOQO3840577
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 20 Jan 2026 10:50:26 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60KIoOQO3840577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1768935028;
	bh=cwVFuDcMyEE2Oup/uCTxTEyXGhJgrINko83dAbUNoVg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MZanTnHaiUvzI2INFEL+c8Wlo2J99eSiz/ckHUyjfc1FrI6dQBVgoA9X4Vm08r6eW
	 ecFIQ8c5bhXgqrdRsIGaqVXDZFZ89kVlX04o4id7spo6xniTZgeFKF1mphZQvI6VNN
	 NDNWOXD/Arcr7ckX55vlNv+tk4DB3IpZ3J0E/k8MX/r19wTXAWCbJwH8WryMb4mBTP
	 5mi4FLbyAa1Us+rqqFEJIE2KtTccaXjYpjkPYOFFAEG2vLMzKBsWHOCTuL8KxwGB1P
	 l+szT73FYzq/GK+fxdzleGdEx+eQQo+X5tGrxtCHCI8OsZwSHH7hObATjovTdQARAz
	 FqgtvFzDUeIsg==
Message-ID: <0fc5b4ef-c468-416f-a065-f64989d75378@zytor.com>
Date: Tue, 20 Jan 2026 10:50:18 -0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [klibc] [PATCH net-next] net: uapi: Provide an UAPI definition of
 'struct sockaddr'
To: Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>, libc-alpha@sourceware.org,
        "Carlos O'Donell" <carlos@redhat.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Rich Felker <dalias@libc.org>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, klibc@zytor.com
References: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
 <934ca004-0aef-49a4-a4f1-3d39a2e71864@app.fastmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <934ca004-0aef-49a4-a4f1-3d39a2e71864@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	R_DKIM_REJECT(1.00)[zytor.com:s=2025122301];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[zytor.com : No valid SPF,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5685-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[zytor.com:-];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-api@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zytor.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: ADADE4BD1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-01-05 05:50, Arnd Bergmann wrote:
> 
> This looks like the right approach to me. I have previously
> tried to introduce a 'struct __kernel_sockaddr' structure and
> use that in uapi headers in place of the libc sockaddr, but
> that seemed worse in the end, and introduce the same problems
> as using the existing __kernel_sockaddr_storage.
> 

You say "the same problems". It's not clear to me what that means.

Based on my own libc experience, hacking both a minimal (klibc) and a
maximal (glibc) libc, there are a *lot* of advantages to having
__kernel_* definitions available, *regardless* of if they are exported
into the libc namespace at all.

Specifically:

1. When calling explicit kernel interfaces, like ioctl(), it is the
   kernel interfaces, not the libc interfaces, that needs to be
   used. However, the rest of the application may need to include the
   libc headers.

2. The libc *implementation* may need to have both the kernel and the
   libc interfaces available.

In the case of struct sockaddr et al, it probably matters less,
because it isn't practical for them to be different for other
reasons, but it has been a real problem for things like termios.

On the flipside, for things where the kernel interfaces are inherently
necessary, we really want the libc authors to be able to use the uapi
headers. However, they have to be concerned about things like
namespace restrictions.

So I have a very, very strong vote for using and even expanding the
use of __kernel_* in the uapi headers. In fact, it would even be nice
to have a variant of "make headers_install" that automatically
transmogrifies symbols; if it isn't doable with simple pattern
matching then perhaps using coccinelle.

Allowing the libc authors to modify those transmogrification rules
would definitely be better than having various kinds of header guards.

	-hpa

