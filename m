Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A26A250AC6
	for <lists+linux-api@lfdr.de>; Mon, 24 Aug 2020 23:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgHXVX7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Aug 2020 17:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgHXVX6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Aug 2020 17:23:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CB5C0613ED
        for <linux-api@vger.kernel.org>; Mon, 24 Aug 2020 14:23:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id g6so110222pjl.0
        for <linux-api@vger.kernel.org>; Mon, 24 Aug 2020 14:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IxNFZGbMP0e2LbdpUcTQWzn/fqMoH/uxhT3spUb5ENo=;
        b=rjXK7sMoIgcBTMOHPX5hgH4irGelMJV5SharwMTjNO1uwRVkfNtXwkwo1QcKS4Jb9x
         BByaHf0VzBgSStST9rmKB1YKEQJwy9hqOCjAMlCpKfj3+wv45dK3OjXx5BthBKbrvOr1
         A29eL0fR8ykWlPd1zuK3I6ybaq/1WknOj/ACXDgLSpSH+xUsV4MviBUWKiKj8CUUMof4
         7EYBdJOUmenPr1ocOuQchSDqtnzfeJNpimJI4PbCXmNWu8m4I35ES9cPndOZIUmqyE//
         Sp9F8R754ex/Q1w8y0KGAfEzMNdOiZ5+D+2JXKYndOywW0Rbx39SSpr/lWpChyvkBlSv
         1oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IxNFZGbMP0e2LbdpUcTQWzn/fqMoH/uxhT3spUb5ENo=;
        b=VmbzqLvRWpB+SYo1LmNp8rox6rQet0fsGpgfQZJgKadJIcrtRYwM0aph2kVmUW1Xxa
         wW91oqNbNGvTlruTcxSC0uFMbpzydeuTVk3JBllA9eGB4SAPY0exdROKUDTv1/ngNOhP
         kwTazKF7E5/VLY6ocDB0i4bNPDtYwVE5wEtRDOUNuqW+ifLR3rZA8UytgFvkVzlFT0Dg
         sp69na++WXpXJWVIHbziJBJ4tiDEMlQa7UNSHxKbwVnal0DLcx+qdPMhDV7uYOR6ykKW
         xkNEhtd4Dbg6Wmms6o5Q1y+a5MydH0zp1tARw8Rb6k+FwXh27LOe/q5raqsWBSH5UYy+
         3ZpA==
X-Gm-Message-State: AOAM531+I2uE9TwRNhKTPMY0qH11T72mrjpjB73Rf8sULbrc/IODqGdn
        mH2apiDkz5E2Hv7NPQTJs2BEJw==
X-Google-Smtp-Source: ABdhPJxEqjUEiO+Us1f+7LgfMnpXxnYqsL76ZA4ttNM4PD7Bh3fUwXt2Fq8Fipj7Xg+oif+E5pgn9A==
X-Received: by 2002:a17:90a:ee08:: with SMTP id e8mr1005501pjy.86.1598304237760;
        Mon, 24 Aug 2020 14:23:57 -0700 (PDT)
Received: from exodia.localdomain ([2620:10d:c090:400::5:8d5d])
        by smtp.gmail.com with ESMTPSA id c20sm430683pjv.31.2020.08.24.14.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:23:56 -0700 (PDT)
Date:   Mon, 24 Aug 2020 14:23:55 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v5 8/9] btrfs: implement RWF_ENCODED reads
Message-ID: <20200824212355.GC197795@exodia.localdomain>
References: <cover.1597993855.git.osandov@osandov.com>
 <a52f9e7743bb924cdfa87906295e422bc48801c7.1597993855.git.osandov@osandov.com>
 <06545b90-976e-35a7-182d-8e005fc6b199@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06545b90-976e-35a7-182d-8e005fc6b199@toxicpanda.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Aug 24, 2020 at 03:54:29PM -0400, Josef Bacik wrote:
> On 8/21/20 3:38 AM, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > There are 4 main cases:
> > 
> > 1. Inline extents: we copy the data straight out of the extent buffer.
> > 2. Hole/preallocated extents: we fill in zeroes.
> > 3. Regular, uncompressed extents: we read the sectors we need directly
> >     from disk.
> > 4. Regular, compressed extents: we read the entire compressed extent
> >     from disk and indicate what subset of the decompressed extent is in
> >     the file.
> > 
> > This initial implementation simplifies a few things that can be improved
> > in the future:
> > 
> > - We hold the inode lock during the operation.
> > - Cases 1, 3, and 4 allocate temporary memory to read into before
> >    copying out to userspace.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> 
> <snip>
> 
> > +	tmp = kmalloc(count, GFP_NOFS);
> > +	if (!tmp) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +	read_extent_buffer(leaf, tmp, ptr, count);
> > +	btrfs_free_path(path);
> 
> Why not just btrfs_release_path(), you're freeing below anyway.

Oh that's nicer, fixed.

> Also a mention that we're explicitly not handling read repairs and backup
> copies would be good in the changelog as well.  Thanks,
> 
> Josef

Will do, thanks.
