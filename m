Return-Path: <linux-api+bounces-6264-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP00Ik7l+Gkt2wIAu9opvQ
	(envelope-from <linux-api+bounces-6264-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 04 May 2026 20:28:30 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 773854C2821
	for <lists+linux-api@lfdr.de>; Mon, 04 May 2026 20:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2B6A302743D
	for <lists+linux-api@lfdr.de>; Mon,  4 May 2026 18:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F713E5EF4;
	Mon,  4 May 2026 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/d6pBSY"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148EF3E5EDB;
	Mon,  4 May 2026 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919121; cv=none; b=gWInGo2xEwHYXJ1f4JzYAKz5xpxgDZBCsw7715VgcYXXrnEBu458aWdTLYuRz9dKWi6eFE0y1BvIhgbnNcLial3XwwrfJ+O1SLmYxNNWp/VfdZj1sgrsrd28MXTRb+4AZlMsQHe5uO5M4hJMXpuPVnpsNQ/neDLWdg1U9SJXTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919121; c=relaxed/simple;
	bh=Kb/NMNloL+Clwsy6e6Q4rr0m/L9z3Rfv+12Y23nYhOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLof7MWh+Fcif/m5YODkRJGwDdYTW7RhhYB2dlb7MUfbCqVKzJDiNElCHWVZtsmKWnFTlSkShclP90JNEx+5k8NYCYDTC0fVWby4dtIt0L1h373qmH4KVy5akxI76LVK12I8OcPKj76rvHTutpVtrT6qjuA06k/bd8RQPvqclzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/d6pBSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F6CC2BCFC;
	Mon,  4 May 2026 18:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777919120;
	bh=Kb/NMNloL+Clwsy6e6Q4rr0m/L9z3Rfv+12Y23nYhOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/d6pBSYEiFV0cwdmW5pkBnpqQSGJB/91CKxGokMkb2GKeGLkQXHCqxs7vpFifTFr
	 HHlRD3nm6tvXuh50cs29J9RmyJid5wqo7DCPUz0IlR7ZadcRTM7m5mqqIY40oa4ZL6
	 Vugkk/Ug/teUvByZSvLQ0dkOgkae8rr8OMjVIQys9bZyytHu4BsI7CNYIDs1MI3G4P
	 eL7JYtqgf/lCi8pnROuFbBb3gM3llKipRIeF4Ng+vrysXp4XujFmb9i5gRThcgqH8c
	 SBIrogtM80QueicHWhKCFmO6vXvgxUHYUXHdYysC0lt+2IedW5BZGpZpi7LDQORyxP
	 suK9JObx4OuAw==
Date: Mon, 4 May 2026 11:24:00 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jeff Barnes <jeffbarnes@linux.microsoft.com>
Cc: Jon Kohler <jon@nutanix.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
Message-ID: <20260504182400.GA5315@sol>
References: <20260504173952.GA2291@sol>
 <F100C726-F841-461B-BE2F-C2018C122426@getmailspring.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F100C726-F841-461B-BE2F-C2018C122426@getmailspring.com>
X-Rspamd-Queue-Id: 773854C2821
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6264-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]

On Mon, May 04, 2026 at 02:12:11PM -0400, Jeff Barnes wrote:
> A plain hash provides no protection against an attacker who can modify
> both the object and its reference hash.

Same with the HMAC, because in the FIPS integrity check the key isn't
secret.  You can find the key used by the sha512hmac binary here:
https://github.com/smuellerDD/libkcapi/blob/master/apps/kcapi-hasher.c#L125

- Eric

