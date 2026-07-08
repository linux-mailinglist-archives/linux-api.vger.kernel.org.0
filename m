Return-Path: <linux-api+bounces-6788-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zo8GEqdHTmpUKAIAu9opvQ
	(envelope-from <linux-api+bounces-6788-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 14:50:47 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95599726741
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 14:50:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ViWKUrbP;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6788-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6788-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C3223051D21
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 12:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03542348C5E;
	Wed,  8 Jul 2026 12:45:59 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C532D2165EA;
	Wed,  8 Jul 2026 12:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514758; cv=none; b=EemElwR7SbMVwONGdYElz5WbMDLRLntes4hFq5pRfXSTx2n4huk1KsINt+KvNCMDkElniGvY2JmtDae+SBFTHy7ezaYyFPjs+abVX+wulDEX1HuoWshzxIUJ7WvYMQm1kPzQH+jjFMKdom2ZyFm2DQPK7Z2bVN6huK+7hny5Z7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514758; c=relaxed/simple;
	bh=oLSpzBYJpHdHYAY11GEM3dcyjXvMSzXfAlI85pZ5+jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtf/rz/Nm56kgA2IIbKPQEXgX83HIANG17bnJOeODAGYJM/sFILYcQD6dms3OyYAPuF2s01c6r9j4eRUNWMM8q3QD1xvH+dtVIn/tPm1VwpTQ4QDeGg7y14n8gxfHrhpRq9fQKvodiZNhkOMpRjBkarTVDqqeO1fjXjmNeStsEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViWKUrbP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC791F000E9;
	Wed,  8 Jul 2026 12:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783514757;
	bh=8gLUISXsEXXGsVU+VRbdg+Y0WurMokiwbBe+bVS6deY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ViWKUrbPIizs80Rz3N4C70+BqKOA2tb6XGtUwaY8ZH0W3n3U20OGv3MEBxzEu5xqc
	 wDSL61U4QmH8SglpVXRSqDp4hQlSRV4fMgojpRhwIgvfTKG8CCOctaNyMQwXnRoeDy
	 VorRkFO1g98HYMRA/fZ00+5HoR9BQHHvQ5+b73piIx3WericW+PvW6gaoqHvPIXxQ9
	 qatt15qsHuT7RzwAk6jVcPzaUukl6nxr1ve+d6m8n+sOY8EN0R0tzHBgDuNdqr2j/g
	 7tWCneeq8Bb6hPmmhbM9Rnpv4SxKIhgl15a3huxxyOdg/Q7aMYguxV2jaPElWsEbsh
	 9FEWQvrU1DpSA==
Date: Wed, 8 Jul 2026 20:45:50 +0800
From: Gao Xiang <xiang@kernel.org>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 1/2] erofs: accept source file descriptor via fsconfig
Message-ID: <ak5GfvVfWLJU1EwK@debian>
Mail-Followup-To: Giuseppe Scrivano <gscrivan@redhat.com>,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
References: <20260708093446.3370200-1-gscrivan@redhat.com>
 <20260708093446.3370200-2-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708093446.3370200-2-gscrivan@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6788-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95599726741

Hi Giuseppe,

On Wed, Jul 08, 2026 at 11:34:26AM +0200, Giuseppe Scrivano wrote:
> Add fsparam_fd("source") so that userspace can pass an already-opened
> file descriptor instead of a path string.  When the fd is provided via
> fsconfig(FSCONFIG_SET_FD, "source", NULL, fd), it is stored directly
> in sbi->dif0.file and erofs_fc_get_tree() skips the filp_open() call.
> 
> This is useful for mount namespaces where the backing file may not be
> reachable by path, and for tools that already hold an fd to the image
> (e.g. composefs reusing an erofs mount's backing file).
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
>  fs/erofs/super.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 86fa5c6a0c70..8ad1689f74b2 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -386,6 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>  enum {
>  	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>  	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
> +	Opt_source_fd,
>  };
>  
>  static const struct constant_table erofs_param_cache_strategy[] = {
> @@ -413,6 +414,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>  	fsparam_flag_no("directio",	Opt_directio),
>  	fsparam_u64("fsoffset",		Opt_fsoffset),
>  	fsparam_flag("inode_share",	Opt_inode_share),
> +	fsparam_fd("source",		Opt_source_fd),
>  	{}
>  };
>  
> @@ -524,6 +526,15 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>  		else
>  			set_opt(&sbi->opt, INODE_SHARE);
>  		break;
> +	case Opt_source_fd:
> +		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE)) {
> +			errorfc(fc, "source fd option not supported");

Thanks for the patch!
For this commit, it looks good to me overall, just some nits:

I guess we could just move this one into erofs_fc_get_tree(), see below.

> +			return -EINVAL;
> +		}
> +		if (sbi->dif0.file)

Do we need to allow multi-shot source_fd?

I guess we could just bail out directly instead.

> +			fput(sbi->dif0.file);
> +		sbi->dif0.file = get_file(param->file);
> +		break;
>  	}
>  	return 0;
>  }
> @@ -752,14 +763,18 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  static int erofs_fc_get_tree(struct fs_context *fc)
>  {
> -	int ret;
> +	struct erofs_sb_info *sbi = fc->s_fs_info;

Nit:

	struct file *file = sbi->dif0.file;

>  
> -	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
> -		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
> -			GET_TREE_BDEV_QUIET_LOOKUP : 0);
> -	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && ret == -ENOTBLK) {
> -		struct erofs_sb_info *sbi = fc->s_fs_info;
> +	if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) || !sbi->dif0.file) {

	if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) || !file) {

>  		struct file *file;
> +		int ret;
> +
> +		ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
> +			IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
> +				GET_TREE_BDEV_QUIET_LOOKUP : 0);
> +		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ||
> +		    ret != -ENOTBLK)
> +			return ret;
>  
>  		if (!fc->source)
>  			return invalf(fc, "No source specified");
> @@ -767,12 +782,11 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>  		if (IS_ERR(file))
>  			return PTR_ERR(file);
>  		sbi->dif0.file = file;
> -
> -		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
> -		    sbi->dif0.file->f_mapping->a_ops->read_folio)
> -			return get_tree_nodev(fc, erofs_fc_fill_super);
>  	}
> -	return ret;
> +	if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
> +	    sbi->dif0.file->f_mapping->a_ops->read_folio)
> +		return get_tree_nodev(fc, erofs_fc_fill_super);
> +	return -EINVAL;

Currently we don't support bdev-backed mounts for this, so I'm fine to
support file-backed mounts only for now.

So nit:

	if (!S_ISREG(file_inode(file)->i_mode) ||
	    !file->f_mapping->a_ops->read_folio) {
		errorfc(fc, "source is unsupported");
		return -EINVAL;
	}
	return get_tree_nodev(fc, erofs_fc_fill_super);

Thanks,
Gao Xiang

>  }
>  
>  static int erofs_fc_reconfigure(struct fs_context *fc)
> -- 
> 2.55.0
> 
> 

