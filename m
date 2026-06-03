Return-Path: <linux-api+bounces-6517-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p9OwH1uVIGq05QAAu9opvQ
	(envelope-from <linux-api+bounces-6517-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 22:58:03 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C04B63B4C3
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 22:58:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samba.org header.s=42 header.b=IkdgwTOo;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6517-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6517-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=samba.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 866FA3007B2B
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 20:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F17F409109;
	Wed,  3 Jun 2026 20:57:13 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304F0406290;
	Wed,  3 Jun 2026 20:57:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780520233; cv=none; b=YFpF/rleYaIxWX5n11AVfeIm4kRJPLc1aXKvlx6yotQp50Sg+Bb//+mSA8kvduDihhUbHLqTs7dz4p53GpOe3ZoL96rSWwvnRP1rcnO4psdQDyfvErC9ZCpwShP1GNgWiVlAQsIDKhHtVIgsQARdDFDzhTpeivfwJC3iz4n0Dcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780520233; c=relaxed/simple;
	bh=V2fXSXVzTIh8my+gZteAmchKNpC3cbws67iXcxUG/DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NlqqvBqV+FHxJdNB8b9AkKjsEbfR5FaGuM9R+ANsUTiYayY/UJtIF14MgobWoNfSUR6F1xP5WbgBKTdvKediUQR7bL1y9NPFy3Sh4R0qah0TNAf+HDI4U048AOCAxyww+x26E9A98m1OasGQSh7ceSP40dr5rAJVxRCza0qgKlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=IkdgwTOo; arc=none smtp.client-ip=144.76.82.148
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=8BcJ1AYTFKicCZr4Jz0bUiyIXeLFCzsYHFc8JfDuOPI=; b=IkdgwTOofDKPbnSVfFpsvzvLwX
	eOoOzStETsZ3WEPO0WPXmqBwdzYWHPKtXsWUBnPrhS49AtanwdCw0YdlhOj8U+4uuX/Y+SfTGA994
	V7ALuQ7pbP0qgnPLvhDKoW4JaBX2kBwD+pPOmvpZsDURTw+GW7K1+NI24niCZg1RzD7JOHoHF0SmP
	hdcGlnB/fPmeokjhlU+8VVRBpZh+b/J1zE3upcIPtx9c6TbTI3ByJCL102NkFbqcHCTIoTCffGSni
	xtaEVXw+VwiZSATF2Xkm+AdCErd7J1WdkfDSXvkaDex04ioZI6pz8mSvaUmBgstMGtyOZlp3OjcJW
	P7D6uZnanayQ1fDHOYYKRvi4YPhXlXQZbFaku9paKoIFPTrOzvfo4fQ6ml8lPxemUdrPhChWMRMLB
	KbBvwt5/zIz36T+cmighMPqMSn7ZLdhtyimFeX+K5B0RraYwM92HQ/VTyeWryZpwntdJ1Vx0rG0ql
	oWA+ogV47gyUOm1BondGaIYR;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wUse3-0000000Dpix-3X3G;
	Wed, 03 Jun 2026 20:56:59 +0000
Message-ID: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
Date: Wed, 3 Jun 2026 22:56:58 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-api@vger.kernel.org, netdev@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>,
 Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260531010107.1953702-3-safinaskar@gmail.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260531010107.1953702-3-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:torvalds@linux-foundation.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:patches@lists.linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[metze@samba.org,linux-api@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6517-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[samba.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:mid,samba.org:from_mime,samba.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C04B63B4C3

Hi Askar,

> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index f5639d5ac331..a86a88207956 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -514,8 +514,8 @@ asmlinkage long sys_ppoll_time32(struct pollfd __user *, unsigned int,
>   			  struct old_timespec32 __user *, const sigset_t __user *,
>   			  size_t);
>   asmlinkage long sys_signalfd4(int ufd, sigset_t __user *user_mask, size_t sizemask, int flags);
> -asmlinkage long sys_vmsplice(int fd, const struct iovec __user *iov,
> -			     unsigned long nr_segs, unsigned int flags);
> +asmlinkage long sys_vmsplice(unsigned long fd, const struct iovec __user *vec,
> +			     unsigned long vlen, unsigned int flags);

Why is 'int fd' changed to 'unsigned long fd'?
Should that be its own commit if the change is desired?

metze

