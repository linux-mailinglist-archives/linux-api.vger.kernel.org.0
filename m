Return-Path: <linux-api+bounces-6789-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FMKrHvBHTmpjKAIAu9opvQ
	(envelope-from <linux-api+bounces-6789-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 14:52:00 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 094D572676A
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 14:52:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QhaiwETO;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6789-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6789-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 253AC3020018
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 12:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93424508E9;
	Wed,  8 Jul 2026 12:51:47 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F4E44BCAA;
	Wed,  8 Jul 2026 12:51:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515107; cv=none; b=PV0ntNG+c+ajvvAV4U8ViR+gcgcA1raNxXlKG1fSUgGsETyyfxYa02W5+afH3wi2qrUs0g/V0YryDLdEvhfeNGhYcNohJrqdwo79t1KeKnPO7WUC9DLYOOLFO9GL6KBj3so6DTji9JXXy/e8x3H+dOsr4nB5p006p5xIxxjxBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515107; c=relaxed/simple;
	bh=nmTiZKwDs9TcQIa3cSAR/ovi0Xv61VJEXX+HvkwfSyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhT1Bstss3Jef5r0cXI62C8bWlik7yNiPmJP9ndBKTN6CAYK1c2Fr5tZBPhm9/KLpO3i+/tGI01w2Nk/kiU8Zsn2xL9Hp3wNkQdWEz0iS5l1hhdXCHk2RuIDSqSqefxJYhLeGktTLTTOBY8pyGyu/tCqmoVXk4Aa/1Ri7n8DOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhaiwETO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B7C1F000E9;
	Wed,  8 Jul 2026 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783515106;
	bh=QRPUyGPfTdccGwt58sEKWl+IWzR/UejjR9lig5WYGKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QhaiwETOGKXor5vMCHcRg2PzUbS8ZpsAphiuOu4hDThdjT4fkYeCvlap8//EIgiVH
	 JanpHZsLmY2raWY5Nng8QZbIDeFlHvgO2WySttV0Z1DJ8EScCuJdo423CUoVL1a2hA
	 fxio8IRXF24rCoVDe75y1CxkNdQnhbeLG/EG3vjwcXJt/7lAwOqA1Y4p7W6mbXWcKw
	 6eAxHFaynZd+dYfCtLkW8eHhzZg7cTdJ7bCnCFKW1pa3gIELxrLxt1HMgSo+dfgC1N
	 aNgKTnKqKR7mumD4Mnu0qh6/RXcFBy9ikq1wFu64TzzfO3MhGdwgT6sReiz30pSBI7
	 GQqm6ZmV41XBA==
Date: Wed, 8 Jul 2026 20:51:40 +0800
From: Gao Xiang <xiang@kernel.org>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 2/2] erofs: add ioctl to retrieve the backing source file
 descriptor
Message-ID: <ak5H3N5c0ccCwv6i@debian>
Mail-Followup-To: Giuseppe Scrivano <gscrivan@redhat.com>,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>
References: <20260708093446.3370200-1-gscrivan@redhat.com>
 <20260708093446.3370200-3-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708093446.3370200-3-gscrivan@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6789-lists,linux-api=lfdr.de];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 094D572676A

Hi Giuseppe,

On Wed, Jul 08, 2026 at 11:34:27AM +0200, Giuseppe Scrivano wrote:
> Add EROFS_IOC_GET_SOURCE_FD ioctl that returns a file descriptor to the
> backing image file for file-backed erofs mounts.
> 
> Returns -ENOENT for block-device-backed erofs mounts where there is no
> backing file.
> 
> The UAPI constant is defined in include/uapi/linux/erofs.h.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

Thanks for the patch!

The functionality is indeed useful to users, but similar to overlayfs
one, I'm not sure if the interface is the best way. Since after we add
this to EROFS, we will support this way forever.

I wonder if there could be a way as a common vfs uapi to get source
fds, but I don't have better ideas for now... (that is why I suggested
to Cc linux-api too..)

Thanks,
Gao Xiang

