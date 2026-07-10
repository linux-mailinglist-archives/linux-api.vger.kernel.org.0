Return-Path: <linux-api+bounces-6827-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zjGJN0FFUGp3vwIAu9opvQ
	(envelope-from <linux-api+bounces-6827-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 10 Jul 2026 03:05:05 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8275A736758
	for <lists+linux-api@lfdr.de>; Fri, 10 Jul 2026 03:05:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=cIf5N81i;
	dmarc=pass (policy=none) header.from=infradead.org;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6827-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6827-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6F1D3008274
	for <lists+linux-api@lfdr.de>; Fri, 10 Jul 2026 01:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47AD1A680E;
	Fri, 10 Jul 2026 01:05:01 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3228B6FC3;
	Fri, 10 Jul 2026 01:04:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783645501; cv=none; b=oMxzKt/nDwmHmpf9QvlAYGbpDEk9nMeT/h9jJ4dj5BJastGx8UbkvX6/tq6NxQMTURA4a5FZlP5dv97vppLh0c2Nh7B//tqlPXjRMLVvw/eok5XoemxuhBYCU8pba9WdH13uMLOl54ue5eSfdWQffb6i+iHGSNsPV7gxMQ+ghQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783645501; c=relaxed/simple;
	bh=vSI/6JH46QRuCk7VHxcBTsb2eFB7aXDQvaCGhbXab18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpBN+UmhsI1xY9kwVSgXxgP+xGnH7T8borEPrcPM/RN9iydKb9OJnZ9zfPbUdbONDcICtejWecM8XNmTqrYEkXmS6HMncnkRay2ReTq8x90blNizWWgGricFioxGjk42YLj7GlEYgG5Z5GAM8f0uJp+PI51RMdTyZIXuaSreZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cIf5N81i; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=r0em5pMNZ4xKYprueCCCRKfXhTmoQMeSgXfGFULzODo=; b=cIf5N81iy//LNUKpfZ2HOlkcRK
	8OA05pKoaYtr720datPqjB+ls/s6YXte8CR6FvzePOyuSql/y1U92bp9Zn9poUR7eI0yKf4A/uQ0I
	hkjv2Imdk+fudyI10U2oGtPa3UmTH6nJkGysIaDAMApxxBgdJrgw4weijDwKSIJXAqHLLNe/5XV9/
	jvJeiYV7eolYFfISs+gD4ExEIMRKxBm+nUuLrFZPCrW7xP3yCmzZegIS7YN7dymDA2f4vgFum/r9U
	qb24QdtoSndJpEyVbn1AkRvXkc0ZDH3CUMiwexB/Gmg5VGI1fmsmk2KSuxeILXjEAr2W9e3K/ojoP
	7o/eTqcg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whzfe-00000003twW-1ujf;
	Fri, 10 Jul 2026 01:04:50 +0000
Message-ID: <fd2e3b89-339a-4964-9b0c-e24ed7f7b31f@infradead.org>
Date: Thu, 9 Jul 2026 18:04:49 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/19] MAINTAINERS: add Rambus CryptoManager Hub (CMH)
To: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Alex Ousherovitch <aousherovitch@rambus.com>,
 Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jonathan Corbet <corbet@lwn.net>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 Rob Herring <robh@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Ninad Palsule <ninad@linux.ibm.com>, linux-hwmon@vger.kernel.org
Cc: Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org,
 Joel Wittenauer <Joel.Wittenauer@cryptography.com>,
 linux-api@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Shuah Khan <skhan@linuxfoundation.org>, Thi Nguyen <thin@rambus.com>
References: <20260709203037.1884436-1-skrishnamoorthy@rambus.com>
 <20260709203037.1884436-20-skrishnamoorthy@rambus.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260709203037.1884436-20-skrishnamoorthy@rambus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6827-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:skrishnamoorthy@rambus.com,m:aou@eecs.berkeley.edu,m:aousherovitch@rambus.com,m:conor+dt@kernel.org,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:corbet@lwn.net,m:krzk+dt@kernel.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:robh@kernel.org,m:shuah@kernel.org,m:ninad@linux.ibm.com,m:linux-hwmon@vger.kernel.org,m:alex@ghiti.fr,m:devicetree@vger.kernel.org,m:Joel.Wittenauer@cryptography.com,m:linux-api@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:skhan@linuxfoundation.org,m:thin@rambus.com,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rdunlap@infradead.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:from_mime,infradead.org:dkim,infradead.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,cryptography.com:email,rambus.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8275A736758



On 7/9/26 1:30 PM, Saravanakrishnan Krishnamoorthy wrote:
> From: Alex Ousherovitch <aousherovitch@rambus.com>
> 
> Add MAINTAINERS entry for the CRI CryptoManager Hub (CMH) hardware
> crypto accelerator driver under drivers/crypto/cmh/.
> 
> Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
> Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
> Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
> Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
> Reviewed-by: Thi Nguyen <thin@rambus.com>
> ---
>  MAINTAINERS | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1dbf2f07104..1c153a84f70f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6891,6 +6891,23 @@ F:	kernel/cred.c
>  F:	rust/kernel/cred.rs
>  F:	Documentation/security/credentials.rst
>  
> +CRI CRYPTOMANAGER HUB (CMH) HARDWARE CRYPTO ACCELERATOR
> +M:	Alex Ousherovitch <aousherovitch@rambus.com>
> +M:	Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
> +R:	Joel Wittenauer <Joel.Wittenauer@cryptography.com>
> +R:	Thi Nguyen <thin@rambus.com>
> +L:	linux-crypto@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/ABI/testing/cmh-mgmt
> +F:	Documentation/ABI/testing/debugfs-driver-cmh
> +F:	Documentation/ABI/testing/sysfs-driver-cmh
> +F:	Documentation/crypto/device_drivers/cmh.rst
> +F:	Documentation/devicetree/bindings/crypto/cri,cmh.yaml
> +F:	Documentation/userspace-api/ioctl/cmh_mgmt.rst
> +F:	drivers/crypto/cmh/
> +F:	include/uapi/linux/cmh_mgmt_ioctl.h
> +F:	tools/testing/selftests/drivers/crypto/cmh/
> +

Hm, I thought for a moment there that this new CRI entry was out of
place (alphabetically). No, it's the next entry that is so far
out of place. :(

>  INTEL CRPS COMMON REDUNDANT PSU DRIVER
>  M:	Ninad Palsule <ninad@linux.ibm.com>
>  L:	linux-hwmon@vger.kernel.org

-- 
~Randy


