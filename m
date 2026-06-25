Return-Path: <linux-api+bounces-6703-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fX5HAgVuPWpW3AgAu9opvQ
	(envelope-from <linux-api+bounces-6703-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 20:05:57 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ED86C816F
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 20:05:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Y0Dulsv+;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6703-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6703-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3001C30297BA
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 18:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BAC3002DC;
	Thu, 25 Jun 2026 18:05:52 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7052F8E99;
	Thu, 25 Jun 2026 18:05:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410752; cv=none; b=XdnBo5gTro3OpIFjYr9FEQ6xhvthNJyV+ukyncnoz9ub2N0hjTu5A1VAHYNuqVcuLs5hL90ccc4SgS3pEi80yLM87aoOzr/6FaX2NrViIlvUZM0tjtpW3bN7nBBmju4KmBr7DnjTpMN7oIPD17wETecTYy67zbJlgormXWnmwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410752; c=relaxed/simple;
	bh=GPj509ZMrtTNp459KDd1Tt1hl7NhkDgoFuECeU/F1ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHK4qXxgub1xh/NIBo7C+/htg8XFGXFQwgTAFWcbI/kmOvTLZ1WkPdL23mMf024Woexx9WkI8XpFmfE6drJKC7Wz93v6GoLOe7fj0X357/9doQDcqspt+GBqmo6+biHi9IdCTpn//9cQ4h/nu1ej0g+DgKL2B/+kbBUbB191hOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0Dulsv+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517B11F000E9;
	Thu, 25 Jun 2026 18:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782410751;
	bh=GPj509ZMrtTNp459KDd1Tt1hl7NhkDgoFuECeU/F1ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y0Dulsv+tq6dpOQYJPHD9uJzO92mLf7cUS1Y7MmHCGqrbzdASqZgDnkOi574uebM3
	 XRAiX4p8OnoRELCT3ZgT88aEJyHyeNtQ39O+JZJosNmw1YKYYr0coSKuR5qlkFgjjv
	 Nj5xn9GYkKUOTjrqTfgPZoOFhZoqMp2VaG52/9Lj5dMqKy5yTejWIIDHymKkROHO4f
	 mTLjEYe/qJURoam9/rbWSgdhkPIOizYT20Ol0bsuOi7d3mEuvrxzdEpVRZCRFl17zL
	 /7mfG+3C93DaNWt3rt5cwwMXKvSCbLHogRpIqCc+kUpTW8H9uXSV4YAIbFK1hqKxEV
	 en578ajw1UoYw==
Date: Thu, 25 Jun 2026 11:05:44 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alex Ousherovitch <aousherovitch@rambus.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Rob Herring <robh@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org,
	Joel Wittenauer <Joel.Wittenauer@cryptography.com>,
	linux-api@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	Shuah Khan <skhan@linuxfoundation.org>, sipsupport@rambus.com,
	Thi Nguyen <thin@rambus.com>
Subject: Re: [PATCH 00/19] crypto: cmh - add CRI CryptoManager Hub driver
Message-ID: <20260625180544.GB2514@quark>
References: <20260625173328.1140487-1-skrishnamoorthy@rambus.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625173328.1140487-1-skrishnamoorthy@rambus.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:skrishnamoorthy@rambus.com,m:aou@eecs.berkeley.edu,m:aousherovitch@rambus.com,m:conor+dt@kernel.org,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:corbet@lwn.net,m:krzk+dt@kernel.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:robh@kernel.org,m:shuah@kernel.org,m:alex@ghiti.fr,m:devicetree@vger.kernel.org,m:Joel.Wittenauer@cryptography.com,m:linux-api@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:skhan@linuxfoundation.org,m:sipsupport@rambus.com,m:thin@rambus.com,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6703-lists,linux-api=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-api@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,quark:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94ED86C816F

On Thu, Jun 25, 2026 at 10:33:08AM -0700, Saravanakrishnan Krishnamoorthy wrote:
> ** This message and any attachments are for the sole use of the
> intended recipient(s). It may contain information that is confidential
> and privileged. If you are not the intended recipient of this message,
> you are prohibited from printing, copying, forwarding or saving it.
> Please delete the message and attachments and notify the sender
> immediately. **

Okay, I deleted it.

- Eric

