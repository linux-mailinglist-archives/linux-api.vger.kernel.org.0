Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22524326F8
	for <lists+linux-api@lfdr.de>; Mon, 18 Oct 2021 20:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJRTAS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 Oct 2021 15:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhJRTAS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 Oct 2021 15:00:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313FAC06161C
        for <linux-api@vger.kernel.org>; Mon, 18 Oct 2021 11:58:07 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id v8so11327655pfu.11
        for <linux-api@vger.kernel.org>; Mon, 18 Oct 2021 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XJpEWR9LdteKJ68LKGtld7IiMgguzW8FmAPi7xScjTE=;
        b=xyCleYXmJ7DWiTzzNyRVH0LfTyA2Lwwr86nudTgBV7LqFIih28aQ/A+xMDu9wGxiZJ
         etYHH5vusdEHCn3CmujBsBpYGisp43GlEKRlWZpFEZeGRCKDbifDE2OY/MBbtNdpN5ky
         8sJBwsCEbiOUry1way1OSWrGZxN55ZwcQW9s2jD8XoyuDdmYxg/Z3s/x139VKhmOmk8O
         9JPnvcY6YLSS7CFod18/zmmqf0Obh4DdZgjmZc+YnM8k9g+qrNAGu9494TkUgK9/Roiu
         q0Ttc33ZqQovbxum11nu0yEehxcPCjjZE0O/0rSOIXnznvpCynMQE6O9Y6JwBeXw/oCh
         suHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XJpEWR9LdteKJ68LKGtld7IiMgguzW8FmAPi7xScjTE=;
        b=v3NEzlhFylsUYYN//IBrzrdGvEosheSxp/VmCSLGrRJC6eySrenIZVyB38KiSAQXKv
         +GN3reS6oFMEcjmCiH5fV7o2Dfw1EjpzgNkwcsIdiNhczCXY1jFA1fV7Si2TwKMNi8oX
         g0kme6/RdYsTYdkv5XYMwHvZePzqQMO8EZRg0Hs1IfNFHxKR6dbDJd3DKHtHE43pcsGt
         rbg5e3h0dzoR1yUcYV5KJlVleOhj19n9lTueWsbd1UpLz2jubykQL8C5/gYBXmYh/UNU
         qFf+n5behV61KlFUOPrII/HE6PvhezgMvM2BNzFaNrLqhJfPzgT/wmngTUMo1QQhwUeT
         ekjA==
X-Gm-Message-State: AOAM532mvvIPHweMyUXKd1i7KxcnaBNJFP8YQVS8rbe5cJ4deao4HZDV
        OqEzOcAd34BiOs31LaAfjyWOFA==
X-Google-Smtp-Source: ABdhPJz+NIzvfQFRbVRY5oHKTtKd4bzz6stXXvGcyal03Xi8KLTTMyThoLxXbpxRzalcsDYH6reIGg==
X-Received: by 2002:a63:3c13:: with SMTP id j19mr7929172pga.13.1634583486557;
        Mon, 18 Oct 2021 11:58:06 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:b911])
        by smtp.gmail.com with ESMTPSA id t38sm10212995pfg.102.2021.10.18.11.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 11:58:05 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:58:04 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v11 10/14] btrfs: add send stream v2 definitions
Message-ID: <YW3DvJBzV1exIF6Q@relinquished.localdomain>
References: <cover.1630514529.git.osandov@fb.com>
 <ed4dc1c414a6662831e7443335065cb37dddad91.1630514529.git.osandov@fb.com>
 <f94e2e0d-0cf9-1c9d-0dfb-b21438fe852d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f94e2e0d-0cf9-1c9d-0dfb-b21438fe852d@suse.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 18, 2021 at 06:11:54PM +0300, Nikolay Borisov wrote:
> 
> 
> On 1.09.21 г. 20:01, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This adds the definitions of the new commands for send stream version 2
> > and their respective attributes: fallocate, FS_IOC_SETFLAGS (a.k.a.
> > chattr), and encoded writes. It also documents two changes to the send
> > stream format in v2: the receiver shouldn't assume a maximum command
> > size, and the DATA attribute is encoded differently to allow for writes
> > larger than 64k. These will be implemented in subsequent changes, and
> > then the ioctl will accept the new flags.
> > 
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/btrfs/send.c            |  2 +-
> >  fs/btrfs/send.h            | 30 +++++++++++++++++++++++++++++-
> >  include/uapi/linux/btrfs.h | 13 +++++++++++++
> >  3 files changed, 43 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index afdcbe7844e0..2ec07943f173 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -7287,7 +7287,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
> >  
> >  	sctx->clone_roots_cnt = arg->clone_sources_count;
> >  
> > -	sctx->send_max_size = BTRFS_SEND_BUF_SIZE;
> > +	sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
> >  	sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
> >  	if (!sctx->send_buf) {
> >  		ret = -ENOMEM;
> > diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
> > index de91488b7cd0..9f4f7b96b1eb 100644
> > --- a/fs/btrfs/send.h
> > +++ b/fs/btrfs/send.h
> > @@ -12,7 +12,11 @@
> >  #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
> >  #define BTRFS_SEND_STREAM_VERSION 1
> >  
> > -#define BTRFS_SEND_BUF_SIZE SZ_64K
> > +/*
> > + * In send stream v1, no command is larger than 64k. In send stream v2, no limit
> > + * should be assumed.
> > + */
> > +#define BTRFS_SEND_BUF_SIZE_V1 SZ_64K
> >  
> >  enum btrfs_tlv_type {
> >  	BTRFS_TLV_U8,
> > @@ -76,6 +80,13 @@ enum btrfs_send_cmd {
> >  
> >  	BTRFS_SEND_C_END,
> >  	BTRFS_SEND_C_UPDATE_EXTENT,
> > +
> > +	/* The following commands were added in send stream v2. */
> > +
> > +	BTRFS_SEND_C_FALLOCATE,
> > +	BTRFS_SEND_C_SETFLAGS,
> > +	BTRFS_SEND_C_ENCODED_WRITE,
> > +
> >  	__BTRFS_SEND_C_MAX,
> >  };
> >  #define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1)
> > @@ -106,6 +117,11 @@ enum {
> >  	BTRFS_SEND_A_PATH_LINK,
> >  
> >  	BTRFS_SEND_A_FILE_OFFSET,
> > +	/*
> > +	 * In send stream v2, this attribute is special: it must be the last
> > +	 * attribute in a command, its header contains only the type, and its
> > +	 * length is implicitly the remaining length of the command.
> > +	 */
> >  	BTRFS_SEND_A_DATA,
> 
> Now that I think more about this, it would be best if this logic is
> actually codified in the code. I.e first set of SEND_A_DATA would set
> some bool/flag in the sctx and subsequent calls would be able to
> ASSERT/WARN ?

I suppose I could do something like this, is that what you had in mind?

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 90ca915fed78..46443d80b431 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -81,6 +81,7 @@ struct send_ctx {
 	char *send_buf;
 	u32 send_size;
 	u32 send_max_size;
+	bool put_data;
 	struct page **send_buf_pages;
 	u64 total_send_size;
 	u64 cmd_send_size[BTRFS_SEND_C_MAX + 1];
@@ -575,6 +576,9 @@ static int tlv_put(struct send_ctx *sctx, u16 attr, const void *data, int len)
 	int total_len = sizeof(*hdr) + len;
 	int left = sctx->send_max_size - sctx->send_size;
 
+	if (WARN_ON(sctx->put_data))
+		return -EINVAL;
+
 	if (unlikely(left < total_len))
 		return -EOVERFLOW;
 
@@ -718,6 +722,7 @@ static int send_cmd(struct send_ctx *sctx)
 	sctx->total_send_size += sctx->send_size;
 	sctx->cmd_send_size[get_unaligned_le16(&hdr->cmd)] += sctx->send_size;
 	sctx->send_size = 0;
+	sctx->put_data = false;
 
 	return ret;
 }
@@ -4913,6 +4918,9 @@ static inline u64 max_send_read_size(const struct send_ctx *sctx)
 
 static int put_data_header(struct send_ctx *sctx, u32 len)
 {
+	if (WARN_ON(sctx->put_data))
+		return -EINVAL;
+	sctx->put_data = true;
 	if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2) {
 		/*
 		 * In v2, the data attribute header doesn't include a length; it
@@ -5368,6 +5376,7 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 	sctx->cmd_send_size[le16_to_cpu(hdr->cmd)] +=
 		sctx->send_size + block_len;
 	sctx->send_size = 0;
+	sctx->put_data = false;
 
 tlv_put_failure:
 out:
