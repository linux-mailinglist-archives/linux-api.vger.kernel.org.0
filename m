Return-Path: <linux-api+bounces-6713-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sdMlHTpbPmroEQkAu9opvQ
	(envelope-from <linux-api+bounces-6713-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 26 Jun 2026 12:58:02 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3976CC3EA
	for <lists+linux-api@lfdr.de>; Fri, 26 Jun 2026 12:58:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="My/1BS+s";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6713-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6713-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C1B43010BCE
	for <lists+linux-api@lfdr.de>; Fri, 26 Jun 2026 10:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235F53EFFCD;
	Fri, 26 Jun 2026 10:58:00 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038373DB327;
	Fri, 26 Jun 2026 10:57:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782471480; cv=none; b=aBiQO54nPNZ/jeyVa4IMe8Yu/W76LfiWNpeSNnMXIb/FSomXmmV6p/G7OHYuXZoTIw2DXjlx5haI31uDAeyKZ+gnK43G43uEMwcZzZA2mjCIjXxhz04XK21xpZKWB47OtCnnZx0epMNDb+GKwPpdsgGVPu1AsjPSyg9wvtK6cR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782471480; c=relaxed/simple;
	bh=63xVF5ybA58lufS8+mQU0NJ6N2HaPImjxW3MDpTwDj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obBsLy2JHtCnpAnmFNdYHVA30E7n3DJ5v/TEVBahdP/wJ/egzVE7dtaDCHPCZHESEo8nuPY2NqXdbr2figB49XY4tdR/oNhPsdBwApk4JRtbYH73rsTxAhoRksgQQc+cwSTumirMKIzkvM/Njeso/SAoM6YE/23UZokEnYZ+KGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=My/1BS+s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7351B1F000E9;
	Fri, 26 Jun 2026 10:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782471478;
	bh=ZTRPyMyzXJJHzBuvJUIeax1xIMpUkC2R+b5TUXDfLVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=My/1BS+sODPPWkKG5n35GpohqpvIdqpVm5jWKuOA91DwPIV4FMBeiMnXbIOLzlSQX
	 G47l2zPc1OhCTSS+gMbjyDBTIqPNhR+h3fylG7wpAEzkqYXY1k3JGpwuA+cfUKGL8K
	 O8V74f1xsA5AlIQ4dL4Zj/JnGhrqZrAzg6PjJs7LSCaDKpIYpv4d0Rv9WMZCFZeeVv
	 ndbOcQwcAxzq8jMCpJrxBR9ciJB5fLX1K5wx8/gIzBlNn1nft373kMpl1AWTuSuSzx
	 bGHH6RvfFgYN/vXg7EBPy9oUGrL8QbN2JZaNW0QWj4N5GyvcYPa0WihXf86QgEnS2c
	 BZFMyOzA0vlPw==
Date: Fri, 26 Jun 2026 12:57:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, 
	Alex Ousherovitch <aousherovitch@rambus.com>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jonathan Corbet <corbet@lwn.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Rob Herring <robh@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org, 
	Joel Wittenauer <Joel.Wittenauer@cryptography.com>, linux-api@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Shuah Khan <skhan@linuxfoundation.org>, sipsupport@rambus.com, 
	Thi Nguyen <thin@rambus.com>
Subject: Re: [PATCH 19/19] MAINTAINERS: add Rambus CryptoManager Hub (CMH)
Message-ID: <20260626-lush-eel-of-election-5fcbde@quoll>
References: <20260625173328.1140487-1-skrishnamoorthy@rambus.com>
 <20260625173328.1140487-20-skrishnamoorthy@rambus.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260625173328.1140487-20-skrishnamoorthy@rambus.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[krzk@kernel.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:skrishnamoorthy@rambus.com,m:aou@eecs.berkeley.edu,m:aousherovitch@rambus.com,m:conor+dt@kernel.org,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:corbet@lwn.net,m:krzk+dt@kernel.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:robh@kernel.org,m:shuah@kernel.org,m:alex@ghiti.fr,m:devicetree@vger.kernel.org,m:Joel.Wittenauer@cryptography.com,m:linux-api@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:skhan@linuxfoundation.org,m:sipsupport@rambus.com,m:thin@rambus.com,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6713-lists,linux-api=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-api@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,rambus.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F3976CC3EA

On Thu, Jun 25, 2026 at 10:33:27AM -0700, Saravanakrishnan Krishnamoorthy wrote:
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

Are these people really provided you with Reviewer's statement of
oversight? Do they understand what does it mean?

> ---
>  MAINTAINERS | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90034eb7874e..ecb389795e3d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6797,6 +6797,25 @@ F:       kernel/cred.c
>  F:     rust/kernel/cred.rs
>  F:     Documentation/security/credentials.rst
> 
> +CRI CRYPTOMANAGER HUB (CMH) HARDWARE CRYPTO ACCELERATOR
> +M:     Alex Ousherovitch <aousherovitch@rambus.com>
> +M:     Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
> +R:     Joel Wittenauer <Joel.Wittenauer@cryptography.com>
> +R:     Thi Nguyen <thin@rambus.com>
> +L:     linux-crypto@vger.kernel.org
> +L:     sipsupport@rambus.com (moderated for non-subscribers)

NAK, drop. You are not allowed to add here internal moderated mailing
lists. We are not going to participate in your corporate dances.

> +S:     Maintained
> +T:     git https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git

Drop, you do not have commit rights there.

> +F:     Documentation/ABI/testing/cmh-mgmt
> +F:     Documentation/ABI/testing/debugfs-driver-cmh
> +F:     Documentation/ABI/testing/sysfs-driver-cmh
> +F:     Documentation/crypto/device_drivers/cmh.rst
> +F:     Documentation/devicetree/bindings/crypto/cri,cmh.yaml
> +F:     Documentation/userspace-api/ioctl/cmh_mgmt.rst
> +F:     drivers/crypto/cmh/
> +F:     include/uapi/linux/cmh_mgmt_ioctl.h
> +F:     tools/testing/selftests/drivers/crypto/cmh/
> +
>  INTEL CRPS COMMON REDUNDANT PSU DRIVER
>  M:     Ninad Palsule <ninad@linux.ibm.com>
>  L:     linux-hwmon@vger.kernel.org
> --
> 2.43.7
> 
> 
> ** This message and any attachments are for the sole use of the intended recipient(s). It may contain information that is confidential and privileged. If you are not the intended recipient of this message, you are prohibited from printing, copying, forwarding or saving it. Please delete the message and attachments and notify the sender immediately. **

Heh, I should have ignored your message...


Best regards,
Krzysztof


