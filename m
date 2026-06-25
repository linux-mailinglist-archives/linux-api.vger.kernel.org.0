Return-Path: <linux-api+bounces-6705-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eVQfN9ZzPWpC3QgAu9opvQ
	(envelope-from <linux-api+bounces-6705-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 20:30:46 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DB76C8347
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 20:30:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=LeqTQAcp;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6705-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6705-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 686823003336
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 18:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322DD316192;
	Thu, 25 Jun 2026 18:29:24 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40442DC350;
	Thu, 25 Jun 2026 18:29:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412164; cv=none; b=jLRVa1V/TylV65luWTp8R8GxCPwbU1rPgN//1QCBAfGR6fpkLsWChLKP/SgU0+lJkzZ0I3R/REIR2qQYSelPAXek7whoWeUrMK8Tkg+GsAG1t6aAT6pohCt5jikE4QeEVZyzCu8/swyEHhaj11QLDixCH01iidVRGKbbDgxu8eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412164; c=relaxed/simple;
	bh=AxSREvOWEB5W1NWeqZN2hVKCno9mdks33VppHFPzea8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZ1ICQFsf1uTYR5v1cjZGf/n4dKOzewrokKws9obZf9CFQ0ekAHYgtSivnSVxGNkyB4UmWQ7hZEdGkXSOQC/GFPxXx5FFZjj4V2BcHpzd7dMEMxDUW720rAUqXI0TNFWDB02n3lhz5EUwYLV0amqr3JubuPmj9L2EkYx/KlaqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LeqTQAcp; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=EY4iW47JlK6yTM+x46WwGDHsCoKvVxVuF5bBEpnou6k=; b=LeqTQAcpHH1TNVBPy40pntPQwA
	WeTCKEqHsg4CU81Tlga6ft/KW45x3WI95xj92FURnyIe3DjuDOY9/AQ36LyNUhIAtHnvdTBjZZNqk
	s/IP2UMn5wxau59deABMOPqbENyiZJ4zcPXzkBx6sq20RNJVbCd1oqGuvYygfSD/T3k2buTa6j7si
	vsMbThJsK6LydkSBS31HM742LZ/22A9O8ZcJudbqPg/Q8zSCjQjmK2IWt5nKmNsiRAFN7Imz2gRTZ
	whdTiujYtpF5fd+V6CQmoj8gZ+9igLI1VDqHISLZkGN7cce9G38k9XEs2nDTgPTsS74yfB3U8BuKA
	rhT546hg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcop8-00000009gWu-0HVB;
	Thu, 25 Jun 2026 18:29:14 +0000
Message-ID: <60a7850d-1527-4517-aae8-cd5cbebcb9b5@infradead.org>
Date: Thu, 25 Jun 2026 11:29:12 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/19] Documentation: ioctl: add CMH ioctl documentation
 and register 'J'
To: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Alex Ousherovitch <aousherovitch@rambus.com>,
 Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jonathan Corbet <corbet@lwn.net>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 Rob Herring <robh@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org,
 Joel Wittenauer <Joel.Wittenauer@cryptography.com>,
 linux-api@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 Shuah Khan <skhan@linuxfoundation.org>, sipsupport@rambus.com,
 Thi Nguyen <thin@rambus.com>
References: <20260625173328.1140487-1-skrishnamoorthy@rambus.com>
 <20260625173328.1140487-18-skrishnamoorthy@rambus.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260625173328.1140487-18-skrishnamoorthy@rambus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6705-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:skrishnamoorthy@rambus.com,m:aou@eecs.berkeley.edu,m:aousherovitch@rambus.com,m:conor+dt@kernel.org,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:corbet@lwn.net,m:krzk+dt@kernel.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:robh@kernel.org,m:shuah@kernel.org,m:alex@ghiti.fr,m:devicetree@vger.kernel.org,m:Joel.Wittenauer@cryptography.com,m:linux-api@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:skhan@linuxfoundation.org,m:sipsupport@rambus.com,m:thin@rambus.com,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rdunlap@infradead.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,infradead.org:dkim,infradead.org:mid,infradead.org:from_mime,cryptography.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38DB76C8347



On 6/25/26 10:33 AM, Saravanakrishnan Krishnamoorthy wrote:
> From: Alex Ousherovitch <aousherovitch@rambus.com>
> 
> Add Documentation/userspace-api/ioctl/cmh_mgmt.rst documenting the
> ioctl commands on the /dev/cmh_mgmt misc device for the CRI
> CryptoManager Hub (CMH) hardware crypto accelerator driver.  Covers
> key management, KIC key derivation, PKE (RSA, ECDSA, ECDH, EdDSA),
> PQC (ML-KEM, ML-DSA, SLH-DSA), SM2, EAC, and DRBG.
> 
> Register ioctl magic number 'J' (0x4A) in ioctl-number.rst.  The
> driver uses ioctls 0x01-0x40.
> 
> Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
> Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
> Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
> Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
> Reviewed-by: Thi Nguyen <thin@rambus.com>
> ---
>  .../userspace-api/ioctl/cmh_mgmt.rst          | 941 ++++++++++++++++++
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  2 files changed, 942 insertions(+)
>  create mode 100644 Documentation/userspace-api/ioctl/cmh_mgmt.rst
> 

One docs build warning:

Documentation/userspace-api/ioctl/cmh_mgmt.rst: WARNING: document isn't included in any toctree [toc.not_included]


-- 
~Randy


