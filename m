Return-Path: <linux-api+bounces-5695-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OMSAFkQcGlyUwAAu9opvQ
	(envelope-from <linux-api+bounces-5695-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 21 Jan 2026 00:31:37 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF3B4DD47
	for <lists+linux-api@lfdr.de>; Wed, 21 Jan 2026 00:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DECDB45739
	for <lists+linux-api@lfdr.de>; Tue, 20 Jan 2026 23:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E625A3D7D8C;
	Tue, 20 Jan 2026 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Xlz2cAjS"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268FD2DEA70;
	Tue, 20 Jan 2026 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768951264; cv=none; b=He/W7yvjDN1XIdFg7aCFJi1riDdua0FDaj/WQHQFrZ98Hk0vvkIXHewRcvEvV1sNWBk7JLsVYqQZJf0kMB8nNT5b/OYfqc36r6qPKIASIMDKbjLuQ2OE80vTBu4/iASX/W+U21wJ4o0K3uNnZE+HtL9MtT1eosPB+xVt96ZbN/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768951264; c=relaxed/simple;
	bh=EOo9r3TrGOlPCzXXLeiaU0t5lefaqILPEHn82lGwLHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iy6vrcFLT9wiODoXl51LaPE+LEWChbJbV7b94UVKYj03mquWhSTgWfR/fNKsVyPcEl3v378NPKSF8CGIX52ZmJgocfeol6772squPnaFf+TbSDwYlIG9gyiL6nRK8K1NYJsLXrtHdweqr5T7ljfrkp4OzZnWMMMvW+ApDOCZR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Xlz2cAjS reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9483:12c5:bc8e:d949:3497] ([IPv6:2601:646:8081:9483:12c5:bc8e:d949:3497])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60KNKNir080295
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 20 Jan 2026 15:20:40 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60KNKNir080295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1768951242;
	bh=TyVCzCgQKQUFRX26Pu8MkQHNVCDWfMBAt0MAhktz1fY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xlz2cAjSDtxaY6byoGvYUO33ZXBH7NnXU+2iqWNiJS9IsirvT7SMBT3VGjN8oFcYL
	 6L2mEsuCj23a69+jkcjgPRGYu3PKRnXVHIaxjakdow/dWFEMd8qyg7ocJKazCcQW+M
	 ceIzGwZpRU6ngPz6KPc5/IAbEtqWaBrXecbbxQlTatSfld9EGWMkBW0AYfz8lHO1xI
	 qs8M/o2UGdDrYA7rRx+t19PoGtsyM+2UMZde1KqwRieO2Qc6oTum4hqO7uUIWIWAMq
	 bFXerA9NJt6bwTWAcfMEEmSdPmxND85HZY+3Ixa8fLqZd4RMgM6HCfC/KCiRbeW+ss
	 yNBVAW8CylWJw==
Message-ID: <0f257cd0-27cf-4c11-b79c-724f4e22c4bf@zytor.com>
Date: Tue, 20 Jan 2026 15:20:18 -0800
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
        Willem de Bruijn <willemb@google.com>,
        Xi Ruoyao <libc-alpha@sourceware.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Rich Felker <dalias@libc.org>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, klibc@zytor.com
References: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
 <934ca004-0aef-49a4-a4f1-3d39a2e71864@app.fastmail.com>
 <0fc5b4ef-c468-416f-a065-f64989d75378@zytor.com>
 <212d2e51-abc1-47bb-8666-755917cad889@app.fastmail.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <212d2e51-abc1-47bb-8666-755917cad889@app.fastmail.com>
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
	TAGGED_FROM(0.00)[bounces-5695-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[zytor.com:-];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-api@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zytor.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9FF3B4DD47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-01-20 14:31, Arnd Bergmann wrote:
>> 
> I must have accidentally cut that from my reply, sorry.
> Looking at it again now, I think I ran into problems with the
> flexible array that was removed from the in-kernel sockaddr
> structure in commit 2b5e9f9b7e41 ("net: Convert struct sockaddr
> to fixed-size "sa_data[14]""), so there is a good chance it works
> now with the (once more) fixed-size version.
> 
> The other problem is that the structures that embed 'sockaddr'
> are used a lot inside of the kernel, in particular in 'ifreq',
> so changing the uapi sockaddr to __kernel_sockaddr requires
> additional changes wherever the struct members are passed
> by reference.
>

Well, the kernel should do what opting-in libcs do:

#define sockaddr __kernel_sockaddr

or

struct sockaddr { struct __kernel_sockaddr; };

... now when we have ms extensions turned on. Unfortunately gcc/clang don't
support them without the option even with __extension__, so user space is
limited to using macros.

	-hpa


