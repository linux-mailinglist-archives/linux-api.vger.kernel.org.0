Return-Path: <linux-api+bounces-6089-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI3pAMjA32l7YgAAu9opvQ
	(envelope-from <linux-api+bounces-6089-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2026 18:46:00 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCCC40677F
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2026 18:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A186C3016EF1
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2026 16:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F7A3E4C63;
	Wed, 15 Apr 2026 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbPWbt6O"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B83E3DB5;
	Wed, 15 Apr 2026 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776271447; cv=none; b=Non59mOgs3eYFP+v4pPiLfeosPwu5MQCF5nYpFpVm+E0RJFpHrOUtM/3CGHZf9aNSgldn5My0mgKMDiYBNIh35qyE2JadOR0cb+MZdnSis/W8ck0tMQpa5i3l6PvHk4NzdMcTtGOBT5BCJbv1FpywCGOVBW3VnyejSY8l0pAL3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776271447; c=relaxed/simple;
	bh=2XzfifibjGLTjaTgfDTA+z/KHXzhehAjX1QCcM/h0KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ry6+WIKZ1wfkSnzr3KWlP5X4LhzrteEKmnKt1WE/VqGbwk8LW2oJ4MPHiyaDwNpSSb5N6BhIb4kWU/llpOAAyHNfzXBjQJwmhHsdNwJ4WhfDq7ATvipZFHgeVet4xrFAdMO3S8RlP2qB8JBfAyNwGcrou+Tesz2WQXMB/TDSbKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbPWbt6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEA3C19424;
	Wed, 15 Apr 2026 16:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776271446;
	bh=2XzfifibjGLTjaTgfDTA+z/KHXzhehAjX1QCcM/h0KE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbPWbt6OyaWAi9CXC7bhsK0GKQdJ23LbxAxGd56VF+vXifmLnZxT2cftnINp9l7XV
	 d3Lu/FxsuvVwmk8Miv3CHh4X/4/dZZXSITIIkdpRw230ah6yD6sLECUlQjWUzYuMRK
	 cJ8LggacmqB90gS/tHnOmc3RCsnk0A0tQufABU/aA2lZ+k08UmjMgOwfAJEHKOfsjG
	 qkMfDi0NSMS4ZE6Wtw5F4NvNsAQDBM3U6iH2acLvwrQX2hluD6sNm+g3iWErispTQT
	 tv4wEYoT/+siCHqi9dUAtkU6lgOC2n0F6qrGYiPIb2ZqujCEzc+hU+Lc2RqVV9ebyz
	 B4RkELkEdVk6Q==
Date: Wed, 15 Apr 2026 16:44:04 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Akilesh Kailash <akailash@google.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: another way to set large folio by remembering
 inode number
Message-ID: <ad_AVHe7RMnGrGTb@google.com>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com>
 <ad30g9xMs9wNJhFb@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad30g9xMs9wNJhFb@infradead.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6089-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CCCC40677F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/14, Christoph Hellwig wrote:
> Please add the relevant mailing lists when adding new user interfaces.
> 
> And I'm not sure hacks working around the proper large folio
> implementation are something that should be merged upstream.

Cc'ed linux-api and linux-fsdevel onto the patch thread with a proposal that
I'm not sure it's acceptable or not. 

> 
> On Fri, Apr 10, 2026 at 01:16:23AM +0000, Jaegeuk Kim wrote:
> > enum {
> >        F2FS_XATTR_FADV_LARGEFOLIO,
> > };
> > 
> > unsigned int value = BIT(F2FS_XATTR_FADV_LARGEFOLIO);
> > 
> > 1. setxattr(file, "user.fadvise", &value, sizeof(unsigned int), 0)
> >  -> register the inode number for large folio
> > 2. chmod(0400, file)
> >  -> make Read-Only
> > 3. fsync() && close() && open(READ)
> >  -> f2fs_iget() with large folio
> > 4. open(WRITE), mkwrite on mmap, chmod(WRITE)
> >  -> return error
> > 5. close() and open()
> >  -> goto #3
> > 6. unlink
> >  -> deregister the inode number
> > 
> > Suggested-by: Akilesh Kailash <akailash@google.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  
> >   Log from v1:
> >    - add a condition in f2fs_drop_inode
> >    - add Doc
> > 
> >  Documentation/filesystems/f2fs.rst | 41 ++++++++++++++++++++++++++----
> >  fs/f2fs/checkpoint.c               |  2 +-
> >  fs/f2fs/data.c                     |  2 +-
> >  fs/f2fs/f2fs.h                     |  1 +
> >  fs/f2fs/file.c                     | 11 ++++++--
> >  fs/f2fs/inode.c                    | 19 +++++++++++---
> >  fs/f2fs/super.c                    |  7 +++++
> >  fs/f2fs/xattr.c                    | 35 ++++++++++++++++++++++++-
> >  fs/f2fs/xattr.h                    |  6 +++++
> >  9 files changed, 111 insertions(+), 13 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> > index 7e4031631286..de899d0d3088 100644
> > --- a/Documentation/filesystems/f2fs.rst
> > +++ b/Documentation/filesystems/f2fs.rst
> > @@ -1044,11 +1044,14 @@ page allocation for significant performance gains. To minimize code complexity,
> >  this support is currently excluded from the write path, which requires handling
> >  complex optimizations such as compression and block allocation modes.
> >  
> > -This optional feature is triggered only when a file's immutable bit is set.
> > -Consequently, F2FS will return EOPNOTSUPP if a user attempts to open a cached
> > -file with write permissions, even immediately after clearing the bit. Write
> > -access is only restored once the cached inode is dropped. The usage flow is
> > -demonstrated below:
> > +This optional feature is triggered by two mechanisms: the file's immutable bit
> > +or a specific xattr flag. In both cases, F2FS ensures data integrity by
> > +restricting the file to a read-only state while large folios are active.
> > +
> > +1. Immutable Bit Approach:
> > +Triggered when the FS_IMMUTABLE_FL is set. This is a strict enforcement
> > +where the file cannot be modified at all until the bit is cleared and
> > +the cached inode is dropped.
> >  
> >  .. code-block::
> >  
> > @@ -1078,3 +1081,31 @@ demonstrated below:
> >     Written 4096 bytes with pattern = zero, total_time = 29 us, max_latency = 28 us
> >  
> >     # rm /data/testfile_read_seq
> > +
> > +2. XATTR fadvise Approach:
> > +A more flexible registration via extended attributes.
> > +
> > +.. code-block::
> > +
> > +    enum {
> > +        F2FS_XATTR_FADV_LARGEFOLIO,
> > +    };
> > +    unsigned int value = BIT(F2FS_XATTR_FADV_LARGEFOLIO);
> > +
> > +    /* Registers the inode number for large folio support in the subsystem.*/
> > +    # setxattr(file, "user.fadvise", &value, sizeof(unsigned int), 0)
> > +
> > +    /* The file must be made Read-Only to transition into the large folio path. */
> > +    # fchmod(0400, fd)
> > +
> > +    /* clean up dirty inode state. */
> > +    # fsync(fd)
> > +
> > +    /* Drop the inode cache.
> > +    # close(fd)
> > +
> > +    /* f2fs_iget() instantiates the inode with large folio support.*/
> > +    # open()
> > +
> > +    /* Returns -EOPNOTSUPP or error to protect the large folio cache.*/
> > +    # open(WRITE), mkwrite on mmap, or chmod(WRITE)
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 01e1ba77263e..fdd62ddc3ed6 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -778,7 +778,7 @@ void f2fs_remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
> >  	__remove_ino_entry(sbi, ino, type);
> >  }
> >  
> > -/* mode should be APPEND_INO, UPDATE_INO or TRANS_DIR_INO */
> > +/* mode should be APPEND_INO, UPDATE_INO, LARGE_FOLIO_IO, or TRANS_DIR_INO */
> >  bool f2fs_exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode)
> >  {
> >  	struct inode_management *im = &sbi->im[mode];
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 965d4e6443c6..5e46230398d7 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -2494,7 +2494,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
> >  	int ret = 0;
> >  	bool folio_in_bio;
> >  
> > -	if (!IS_IMMUTABLE(inode) || f2fs_compressed_file(inode)) {
> > +	if (f2fs_compressed_file(inode)) {
> >  		if (folio)
> >  			folio_unlock(folio);
> >  		return -EOPNOTSUPP;
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index e40b6b2784ee..02bc6eb96a59 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -381,6 +381,7 @@ enum {
> >  /* for the list of ino */
> >  enum {
> >  	ORPHAN_INO,		/* for orphan ino list */
> > +	LARGE_FOLIO_INO,	/* for large folio case */
> >  	APPEND_INO,		/* for append ino list */
> >  	UPDATE_INO,		/* for update ino list */
> >  	TRANS_DIR_INO,		/* for transactions dir ino list */
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index c0220cd7b332..64ba900410fc 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -2068,9 +2068,16 @@ static long f2fs_fallocate(struct file *file, int mode,
> >  
> >  static int f2fs_release_file(struct inode *inode, struct file *filp)
> >  {
> > -	if (atomic_dec_and_test(&F2FS_I(inode)->open_count))
> > +	if (atomic_dec_and_test(&F2FS_I(inode)->open_count)) {
> >  		f2fs_remove_donate_inode(inode);
> > -
> > +		/*
> > +		 * In order to get large folio as soon as possible, let's drop
> > +		 * inode cache asap. See also f2fs_drop_inode.
> > +		 */
> > +		if (f2fs_exist_written_data(F2FS_I_SB(inode),
> > +					    inode->i_ino, LARGE_FOLIO_INO))
> > +                       d_drop(filp->f_path.dentry);
> > +	}
> >  	/*
> >  	 * f2fs_release_file is called at every close calls. So we should
> >  	 * not drop any inmemory pages by close called by other process.
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index 89240be8cc59..e100bc5a378c 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -565,6 +565,20 @@ static bool is_meta_ino(struct f2fs_sb_info *sbi, unsigned int ino)
> >  		ino == F2FS_COMPRESS_INO(sbi);
> >  }
> >  
> > +static void f2fs_mapping_set_large_folio(struct inode *inode)
> > +{
> > +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> > +
> > +	if (f2fs_compressed_file(inode))
> > +		return;
> > +	if (f2fs_quota_file(sbi, inode->i_ino))
> > +		return;
> > +	if (IS_IMMUTABLE(inode) ||
> > +	    (f2fs_exist_written_data(sbi, inode->i_ino, LARGE_FOLIO_INO) &&
> > +	     !(inode->i_mode & S_IWUGO)))
> > +	    mapping_set_folio_min_order(inode->i_mapping, 0);
> > +}
> > +
> >  struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
> >  {
> >  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> > @@ -620,9 +634,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
> >  		inode->i_op = &f2fs_file_inode_operations;
> >  		inode->i_fop = &f2fs_file_operations;
> >  		inode->i_mapping->a_ops = &f2fs_dblock_aops;
> > -		if (IS_IMMUTABLE(inode) && !f2fs_compressed_file(inode) &&
> > -		    !f2fs_quota_file(sbi, inode->i_ino))
> > -			mapping_set_folio_min_order(inode->i_mapping, 0);
> > +		f2fs_mapping_set_large_folio(inode);
> >  	} else if (S_ISDIR(inode->i_mode)) {
> >  		inode->i_op = &f2fs_dir_inode_operations;
> >  		inode->i_fop = &f2fs_dir_operations;
> > @@ -895,6 +907,7 @@ void f2fs_evict_inode(struct inode *inode)
> >  	f2fs_remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
> >  	f2fs_remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
> >  	f2fs_remove_ino_entry(sbi, inode->i_ino, FLUSH_INO);
> > +	f2fs_remove_ino_entry(sbi, inode->i_ino, LARGE_FOLIO_INO);
> >  
> >  	if (!is_sbi_flag_set(sbi, SBI_IS_FREEZING)) {
> >  		sb_start_intwrite(inode->i_sb);
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index ccf806b676f5..11d1e0c99ac1 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1844,6 +1844,13 @@ static int f2fs_drop_inode(struct inode *inode)
> >  			return 1;
> >  		}
> >  	}
> > +	/*
> > +	 * In order to get large folio as soon as possible, let's drop
> > +	 * inode cache asap. See also f2fs_release_file.
> > +	 */
> > +	if (f2fs_exist_written_data(sbi, inode->i_ino, LARGE_FOLIO_INO) &&
> > +	    !is_inode_flag_set(inode, FI_DIRTY_INODE))
> > +		return 1;
> >  
> >  	/*
> >  	 * This is to avoid a deadlock condition like below.
> > diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> > index 941dc62a6d6f..0c0e44c2dcdd 100644
> > --- a/fs/f2fs/xattr.c
> > +++ b/fs/f2fs/xattr.c
> > @@ -44,6 +44,16 @@ static void xattr_free(struct f2fs_sb_info *sbi, void *xattr_addr,
> >  		kfree(xattr_addr);
> >  }
> >  
> > +static int f2fs_xattr_fadvise_get(struct inode *inode, void *buffer)
> > +{
> > +	if (!buffer)
> > +		goto out;
> > +	if (mapping_large_folio_support(inode->i_mapping))
> > +		*((unsigned int *)buffer) |= BIT(F2FS_XATTR_FADV_LARGEFOLIO);
> > +out:
> > +	return sizeof(unsigned int);
> > +}
> > +
> >  static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
> >  		struct dentry *unused, struct inode *inode,
> >  		const char *name, void *buffer, size_t size)
> > @@ -61,10 +71,29 @@ static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
> >  	default:
> >  		return -EINVAL;
> >  	}
> > +	if (handler->flags == F2FS_XATTR_INDEX_USER &&
> > +	    !strcmp(name, "fadvise"))
> > +		return f2fs_xattr_fadvise_get(inode, buffer);
> > +
> >  	return f2fs_getxattr(inode, handler->flags, name,
> >  			     buffer, size, NULL);
> >  }
> >  
> > +static int f2fs_xattr_fadvise_set(struct inode *inode, const void *value)
> > +{
> > +	unsigned int new_fadvise;
> > +
> > +	new_fadvise = *(unsigned int *)value;
> > +
> > +	if (new_fadvise & BIT(F2FS_XATTR_FADV_LARGEFOLIO))
> > +		f2fs_add_ino_entry(F2FS_I_SB(inode),
> > +				inode->i_ino, LARGE_FOLIO_INO);
> > +	else
> > +		f2fs_remove_ino_entry(F2FS_I_SB(inode),
> > +				inode->i_ino, LARGE_FOLIO_INO);
> > +	return 0;
> > +}
> > +
> >  static int f2fs_xattr_generic_set(const struct xattr_handler *handler,
> >  		struct mnt_idmap *idmap,
> >  		struct dentry *unused, struct inode *inode,
> > @@ -84,6 +113,10 @@ static int f2fs_xattr_generic_set(const struct xattr_handler *handler,
> >  	default:
> >  		return -EINVAL;
> >  	}
> > +	if (handler->flags == F2FS_XATTR_INDEX_USER &&
> > +	    !strcmp(name, "fadvise"))
> > +		return f2fs_xattr_fadvise_set(inode, value);
> > +
> >  	return f2fs_setxattr(inode, handler->flags, name,
> >  					value, size, NULL, flags);
> >  }
> > @@ -842,4 +875,4 @@ int __init f2fs_init_xattr_cache(void)
> >  void f2fs_destroy_xattr_cache(void)
> >  {
> >  	kmem_cache_destroy(inline_xattr_slab);
> > -}
> > \ No newline at end of file
> > +}
> > diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
> > index bce3d93e4755..455f460d014e 100644
> > --- a/fs/f2fs/xattr.h
> > +++ b/fs/f2fs/xattr.h
> > @@ -24,6 +24,7 @@
> >  #define F2FS_XATTR_REFCOUNT_MAX         1024
> >  
> >  /* Name indexes */
> > +#define F2FS_USER_FADVISE_NAME			"user.fadvise"
> >  #define F2FS_SYSTEM_ADVISE_NAME			"system.advise"
> >  #define F2FS_XATTR_INDEX_USER			1
> >  #define F2FS_XATTR_INDEX_POSIX_ACL_ACCESS	2
> > @@ -39,6 +40,11 @@
> >  #define F2FS_XATTR_NAME_ENCRYPTION_CONTEXT	"c"
> >  #define F2FS_XATTR_NAME_VERITY			"v"
> >  
> > +/* used for F2FS_USER_FADVISE_NAME */
> > +enum {
> > +	F2FS_XATTR_FADV_LARGEFOLIO,
> > +};
> > +
> >  struct f2fs_xattr_header {
> >  	__le32  h_magic;        /* magic number for identification */
> >  	__le32  h_refcount;     /* reference count */
> > -- 
> > 2.53.0.1213.gd9a14994de-goog
> > 
> > 
> ---end quoted text---

