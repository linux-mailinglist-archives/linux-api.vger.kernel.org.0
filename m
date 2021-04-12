Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F326A35D437
	for <lists+linux-api@lfdr.de>; Tue, 13 Apr 2021 01:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbhDLX6Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Apr 2021 19:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237748AbhDLX6Q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Apr 2021 19:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618271877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fk8f62xjqnl3mv3ljyxxc5ev3FlVYq11HMKlMY+I2mI=;
        b=bKMDXmtQUNLwEAPA+/Iw8zheAt0uvZRDnTX/sIbCVDPuh8U4KUWlL/VcaHpxW+UBw8wpIm
        IrEmpiat3SlzrUj8KxljfurZbZetD/jDX5p4D0xhaW4d6uCeFB9Io/WAlYwbh6wzCjDh+l
        DNYbIKDH4AAnJgxZVJIBvZYQ2eWtpYg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-_uKeVjwlOwq4IXGgtZcg8Q-1; Mon, 12 Apr 2021 19:57:55 -0400
X-MC-Unique: _uKeVjwlOwq4IXGgtZcg8Q-1
Received: by mail-qk1-f200.google.com with SMTP id j24so9422163qkg.7
        for <linux-api@vger.kernel.org>; Mon, 12 Apr 2021 16:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fk8f62xjqnl3mv3ljyxxc5ev3FlVYq11HMKlMY+I2mI=;
        b=UrleFWTf0tjTPQifbqcWv4R5BH5+BG1ZRNMHtOdeqWLz+IdHW/Z4MXb+HpF6moprMO
         7nP6Fl6C8+opavLnXaIS4aMJjeyWdSlLUJVpV4+7D+x368zluZ9AWpbwF9cx1Ce6XG1I
         jOZrHo1ho97z9ycOKBLD4CzIo/S8w2uB0l86PzuD247cYs3XreIUqx1yRoNCJ/JHW9b7
         hsdKR4ROn8b42wE1YAdpmVgfX/vuvDl6Q72Dnhn+whgJz9j4YRiRV3QPxPAoXg8i+tua
         NLXWuSNlsmo8mgysxRdOMBt0XhPuBTLFXvPu/Npgc9yvY+osvQka2EuT0+vIVjOykC4a
         rk/w==
X-Gm-Message-State: AOAM532byvTZrMe9yMFOVseGP1xmLbeUrnscFXjpOxZ3XxVXZDwL/33X
        ciLuHhLgh/mMlc5xrwHpkUGqEPAFZgxEElRFOHZ+fmzWxMCin9DKYbasKFtXUyGnZa6wftgNGOS
        A7vSVQksFJ5kvK14z7SQe
X-Received: by 2002:ac8:5bd0:: with SMTP id b16mr27256731qtb.265.1618271875250;
        Mon, 12 Apr 2021 16:57:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyINLu5vRRG0SiDZ5ReSE5VIP4sHwe9BnqH3/WUUNCWDJZ4MX4YNqZ5FmXfacMqWYulpB87ZQ==
X-Received: by 2002:ac8:5bd0:: with SMTP id b16mr27256724qtb.265.1618271875002;
        Mon, 12 Apr 2021 16:57:55 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id n6sm8421251qtx.22.2021.04.12.16.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 16:57:54 -0700 (PDT)
Date:   Mon, 12 Apr 2021 19:57:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 2/9] userfaultfd/shmem: combine
 shmem_{mcopy_atomic,mfill_zeropage}_pte
Message-ID: <20210412235752.GC1002612@xz-x1>
References: <20210408234327.624367-1-axelrasmussen@google.com>
 <20210408234327.624367-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210408234327.624367-3-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 08, 2021 at 04:43:20PM -0700, Axel Rasmussen wrote:
> Previously, we did a dance where we had one calling path in
> userfaultfd.c (mfill_atomic_pte), but then we split it into two in
> shmem_fs.h (shmem_{mcopy_atomic,mfill_zeropage}_pte), and then rejoined
> into a single shared function in shmem.c (shmem_mfill_atomic_pte).
> 
> This is all a bit overly complex. Just call the single combined shmem
> function directly, allowing us to clean up various branches,
> boilerplate, etc.
> 
> While we're touching this function, two other small cleanup changes:
> - offset is equivalent to pgoff, so we can get rid of offset entirely.
> - Split two VM_BUG_ON cases into two statements. This means the line
>   number reported when the BUG is hit specifies exactly which condition
>   was true.

(For my own preference, I'll avoid touching the latter one)

> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  include/linux/shmem_fs.h | 15 +++++-------
>  mm/shmem.c               | 52 +++++++++++++---------------------------
>  mm/userfaultfd.c         | 10 +++-----
>  3 files changed, 25 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index d82b6f396588..919e36671fe6 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -122,21 +122,18 @@ static inline bool shmem_file(struct file *file)
>  extern bool shmem_charge(struct inode *inode, long pages);
>  extern void shmem_uncharge(struct inode *inode, long pages);
>  
> +#ifdef CONFIG_USERFAULTFD
>  #ifdef CONFIG_SHMEM
>  extern int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  				  struct vm_area_struct *dst_vma,
>  				  unsigned long dst_addr,
>  				  unsigned long src_addr,

Not a problem of your patch, but it's just that we passed in odd src_addr
values into mfill_atomic_pte() for zeropage case because we loop on src_addr in
__mcopy_atomic()...  Then it'll further passed into shmem_mcopy_atomic_pte()
now after this patch (as shmem_mfill_zeropage_pte() probably only did one thing
good which is to clear src_addr).  Not a big deal, though.

All the rest looks sane to me.

Reviewed-by: Peter Xu <peterx@redhat.com>

I'll wait to look at the selftests since in all cases they should be prone to
rebase (either based on the v2 cleanup I posted, or you'd need to post without
err() - then I can rebase again), so I figured maybe I just read the new
version.

Thanks,

-- 
Peter Xu

