Return-Path: <linux-api+bounces-6028-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALjhBrUXwWn5QQQAu9opvQ
	(envelope-from <linux-api+bounces-6028-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 11:36:37 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 529B92F037D
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 11:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12A533001F9E
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 10:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CF138AC9C;
	Mon, 23 Mar 2026 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lpONrdMy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FJJXGn4w";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zKbNlz/j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wBA7ZXfc"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2537BE66
	for <linux-api@vger.kernel.org>; Mon, 23 Mar 2026 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261744; cv=none; b=ccd3jPpGofLBKudLNMRnOmmSVsmM9qxjXhHtPOR6W1iLTa3g5Cq4eg3QtpPfz37yAxojET4XzeDKFkaVpV5Ach//7iZCy01mvWxXHV2Bo42/V50Bx7vNPNkatUsdatR/6UcJF23epHq3P67FrRbdCQ+M4OtOzU2Cwph/QCNSlQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261744; c=relaxed/simple;
	bh=kg7WeEM1R2O9sFRY2GL0Me5mE8px56wXeelYmZ/CIzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCvfdhclwRWAddYz7a7NFN1v0l3DTmFZ8aA2Kr1zQn4RgB6xrT6uYsNcQHmipvca5t7ez+fMs8V9DOhYNj868n+B889QVnzGi4GCPYbwrkEuOa3U8UQ+BFsTpIacMa/2T1HAJbRvIm6BO2uCojxbpkn7n6I61I9Cg4hk4vAfgfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lpONrdMy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FJJXGn4w; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zKbNlz/j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wBA7ZXfc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 421645BDC8;
	Mon, 23 Mar 2026 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774261741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ab1W5iDfJ5ZhI+KleEyBGCm8hMtIT7U/8ivEBr2rmg=;
	b=lpONrdMyQqW/R8+PKsRCthVwMwzNBq0RFoEGUDoladnMqzPdKfhiuB5QEYRGHFXsoqZbvX
	t5UREbiTDzejJVl5hepGOtE14DerQXoIlpksctRWAKCjKAqhUlLRaCqZHyXpizWn727r89
	+ctnvO7HDGmHbMNoD3oDF7eDOd7iO1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774261741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ab1W5iDfJ5ZhI+KleEyBGCm8hMtIT7U/8ivEBr2rmg=;
	b=FJJXGn4wtBLaGaEBPArhMiYcy5645dhR2+Zssii/2y20lGOHIceoY1P+OJxsRJ7yCBEQX/
	MjrZpGILZ/Iv4YCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="zKbNlz/j";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wBA7ZXfc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774261740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ab1W5iDfJ5ZhI+KleEyBGCm8hMtIT7U/8ivEBr2rmg=;
	b=zKbNlz/jq0hoa1hKAraTGS755e9ZPFHqqoJEQKYHCNRzLU5h9CdZbMrBHvg88k9UJIIdkQ
	JFhEuWzEaNN1FR/575NeCdfGRQAQL26W3pQ2FgCtHKlGkyyQ8EZ/jsODANadEdrObJYZRq
	lAYt4//pu/HeGemwLk0iftltMfgEzuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774261740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ab1W5iDfJ5ZhI+KleEyBGCm8hMtIT7U/8ivEBr2rmg=;
	b=wBA7ZXfcM52/N2RW1VdFyUDx3NUsGkGwfXzalxvRw7P1fPmUrDin9nkJFhInK1OnZOTmov
	P2q8k7ZNlZUniuAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38D9B4381A;
	Mon, 23 Mar 2026 10:29:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bj7dDewVwWlaIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Mar 2026 10:29:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EDAD2A0B2E; Mon, 23 Mar 2026 11:28:59 +0100 (CET)
Date: Mon, 23 Mar 2026 11:28:59 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org
Subject: Re: [PATCH 2/3] fs: pass on FTRUNCATE_* flags to do_truncate
Message-ID: <xyngoavkugrr3iib3se7pkd4h72tu6iwhmr37ro63qnytlr7s7@g6mspo2kgwzp>
References: <20260323070205.2939118-1-hch@lst.de>
 <20260323070205.2939118-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323070205.2939118-3-hch@lst.de>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.cz:dkim,suse.cz:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6028-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 529B92F037D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon 23-03-26 08:01:45, Christoph Hellwig wrote:
> Pass the flags one level down to replace the somewhat confusing small
> argument, and clean up do_truncate as a result.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/internal.h       |  2 +-
>  fs/open.c           | 22 ++++++++++------------
>  io_uring/truncate.c |  2 +-
>  3 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index 2663823e273a..52e4c354e7a4 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -198,7 +198,7 @@ extern struct open_how build_open_how(int flags, umode_t mode);
>  extern int build_open_flags(const struct open_how *how, struct open_flags *op);
>  struct file *file_close_fd_locked(struct files_struct *files, unsigned fd);
>  
> -int do_ftruncate(struct file *file, loff_t length, int small);
> +int do_ftruncate(struct file *file, loff_t length, unsigned int flags);
>  int chmod_common(const struct path *path, umode_t mode);
>  int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
>  		int flag);
> diff --git a/fs/open.c b/fs/open.c
> index 412d0d6fbaa7..181c1597e73c 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -161,23 +161,21 @@ COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, compat_off_t, length
>  }
>  #endif
>  
> -int do_ftruncate(struct file *file, loff_t length, int small)
> +int do_ftruncate(struct file *file, loff_t length, unsigned int flags)
>  {
> -	struct inode *inode;
> -	struct dentry *dentry;
> +	struct dentry *dentry = file->f_path.dentry;
> +	struct inode *inode = dentry->d_inode;
>  	int error;
>  
> -	/* explicitly opened as large or we are on 64-bit box */
> -	if (file->f_flags & O_LARGEFILE)
> -		small = 0;
> -
> -	dentry = file->f_path.dentry;
> -	inode = dentry->d_inode;
>  	if (!S_ISREG(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
>  		return -EINVAL;
>  
> -	/* Cannot ftruncate over 2^31 bytes without large file support */
> -	if (small && length > MAX_NON_LFS)
> +	/*
> +	 * Cannot ftruncate over 2^31 bytes without large file support, either
> +	 * through opening with O_LARGEFILE or by using ftruncate64().
> +	 */
> +	if (length > MAX_NON_LFS &&
> +	    !(file->f_flags & O_LARGEFILE) && !(flags & FTRUNCATE_LFS))
>  		return -EINVAL;
>  
>  	/* Check IS_APPEND on real upper inode */
> @@ -205,7 +203,7 @@ int ksys_ftruncate(unsigned int fd, loff_t length, unsigned int flags)
>  	if (fd_empty(f))
>  		return -EBADF;
>  
> -	return do_ftruncate(fd_file(f), length, !(flags & FTRUNCATE_LFS));
> +	return do_ftruncate(fd_file(f), length, flags);
>  }
>  
>  SYSCALL_DEFINE2(ftruncate, unsigned int, fd, off_t, length)
> diff --git a/io_uring/truncate.c b/io_uring/truncate.c
> index 487baf23b44e..c88d8bd8d20e 100644
> --- a/io_uring/truncate.c
> +++ b/io_uring/truncate.c
> @@ -41,7 +41,7 @@ int io_ftruncate(struct io_kiocb *req, unsigned int issue_flags)
>  
>  	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
>  
> -	ret = do_ftruncate(req->file, ft->len, 1);
> +	ret = do_ftruncate(req->file, ft->len, 0);
>  
>  	io_req_set_res(req, ret, 0);
>  	return IOU_COMPLETE;
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

