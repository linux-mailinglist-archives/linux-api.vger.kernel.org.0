Return-Path: <linux-api+bounces-6029-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC/MI9AXwWm5QgQAu9opvQ
	(envelope-from <linux-api+bounces-6029-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 11:37:04 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B8F2F046C
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 11:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1C20306EE27
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 10:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7982B339705;
	Mon, 23 Mar 2026 10:31:09 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB20138AC96
	for <linux-api@vger.kernel.org>; Mon, 23 Mar 2026 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261869; cv=none; b=KdK64sZ/6OkUS0EpMgzEgIZlddK1a79LkvbyIPWf+y1GXEqN//f+AE5/FeDnSNRXSR5ADHAJuc9BeVbU2X27punGgugQq8bDoq/ULeTPhvVzHtzN2dwPum1P9Xf9pu8PBiVgTM0KWODeDmCHUeg2wrg6UGWHJinRkds9I5hwV48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261869; c=relaxed/simple;
	bh=nFdS1FHOzRATFSUtgN2rvWgpvz9y0bdFEBR0nJqmdHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGtydmJYojbxclgRxvBuh849fmH0116LNdYI9SkVLibRHeOgoybaNRKeQNHzlC/rd4R/Xzcjm2Jaa08+/p+Q3WYUp1ZnQnKA8GqRuLvDx26rVFDYQAVqdF2nb812twKxkrH1DQs84i9FM5bm2c/91l2cD9I+Lqy6KxzTDhy9alg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F8845BDB4;
	Mon, 23 Mar 2026 10:31:06 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65C044381A;
	Mon, 23 Mar 2026 10:31:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j7rTGGoWwWnAIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Mar 2026 10:31:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2EBF2A0B2E; Mon, 23 Mar 2026 11:31:06 +0100 (CET)
Date: Mon, 23 Mar 2026 11:31:06 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org
Subject: Re: [PATCH 3/3] fs: remove do_sys_truncate
Message-ID: <yggi6tpu3uptzwe4an55ufkqgrrxkhu6e3sftlmgmny74c5w2m@4hapz3ee6kqv>
References: <20260323070205.2939118-1-hch@lst.de>
 <20260323070205.2939118-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323070205.2939118-4-hch@lst.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-6029-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 23B8F2F046C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon 23-03-26 08:01:46, Christoph Hellwig wrote:
> do_sys_truncate ist only used to implement ksys_truncate and the native
> truncate syscalls.  Merge do_sys_truncate into ksys_truncate and return
> int from it as it only returns 0 or negative errnos.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/open.c                | 8 ++++----
>  include/linux/syscalls.h | 8 +-------
>  2 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 181c1597e73c..681d405bc61e 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -126,7 +126,7 @@ int vfs_truncate(const struct path *path, loff_t length)
>  }
>  EXPORT_SYMBOL_GPL(vfs_truncate);
>  
> -int do_sys_truncate(const char __user *pathname, loff_t length)
> +int ksys_truncate(const char __user *pathname, loff_t length)
>  {
>  	unsigned int lookup_flags = LOOKUP_FOLLOW;
>  	struct path path;
> @@ -151,13 +151,13 @@ int do_sys_truncate(const char __user *pathname, loff_t length)
>  
>  SYSCALL_DEFINE2(truncate, const char __user *, path, long, length)
>  {
> -	return do_sys_truncate(path, length);
> +	return ksys_truncate(path, length);
>  }
>  
>  #ifdef CONFIG_COMPAT
>  COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, compat_off_t, length)
>  {
> -	return do_sys_truncate(path, length);
> +	return ksys_truncate(path, length);
>  }
>  #endif
>  
> @@ -222,7 +222,7 @@ COMPAT_SYSCALL_DEFINE2(ftruncate, unsigned int, fd, compat_off_t, length)
>  #if BITS_PER_LONG == 32
>  SYSCALL_DEFINE2(truncate64, const char __user *, path, loff_t, length)
>  {
> -	return do_sys_truncate(path, length);
> +	return ksys_truncate(path, length);
>  }
>  
>  SYSCALL_DEFINE2(ftruncate64, unsigned int, fd, loff_t, length)
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 8787b3511c86..f5639d5ac331 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1285,13 +1285,7 @@ static inline long ksys_lchown(const char __user *filename, uid_t user,
>  
>  #define FTRUNCATE_LFS	(1u << 0)	/* allow truncating > 32-bit */
>  int ksys_ftruncate(unsigned int fd, loff_t length, unsigned int flags);
> -
> -int do_sys_truncate(const char __user *pathname, loff_t length);
> -
> -static inline long ksys_truncate(const char __user *pathname, loff_t length)
> -{
> -	return do_sys_truncate(pathname, length);
> -}
> +int ksys_truncate(const char __user *pathname, loff_t length);
>  
>  static inline unsigned int ksys_personality(unsigned int personality)
>  {
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

